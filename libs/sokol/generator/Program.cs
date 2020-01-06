using System;
using System.IO;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Generator
{
    class Program
    {
		static string RootDir
		{
			get
			{
				var dllPath = System.Reflection.Assembly.GetAssembly(typeof(Program)).Location;
				return Directory.GetParent(Path.GetDirectoryName(dllPath)).Parent.Parent.Parent.FullName;
			}
		}

        static void Main(string[] args)
        {
            Environment.CurrentDirectory =  Path.Combine(RootDir, "cimgui_git/generator/output");

            // HandleStructsAndEnums();
            HandleDefinitions();
        }

        static void HandleStructsAndEnums()
        {
            var json = File.ReadAllText("structs_and_enums.json");
            var enums = JsonConvert.DeserializeObject<StructsAndEnums>(json);

            Console.WriteLine("--- enums ---");
            foreach (var kvPair in enums.enums)
            {
                if (kvPair.Key.StartsWith("ImGuiKey"))
                {}

                Console.WriteLine("");
                Console.WriteLine($"pub enum {kvPair.Key.Substring(0, kvPair.Key.Length - 1)} {{");
                foreach (var val in kvPair.Value)
                {
                    var name = val.name.Replace(kvPair.Key, "");
                    name = Statics.ToSnakeCase(name);
                    Console.WriteLine($"\t{name} = {val.calc_value}");
                }
                Console.WriteLine("}");
            }

            Console.WriteLine("\n--- structs ---");
            foreach (var kvPair in enums.structs)
            {
                if (kvPair.Key == "ImGuiIO")
                {}

                Console.WriteLine("");
                Console.WriteLine($"pub struct C.{kvPair.Key} {{");
                Console.WriteLine("pub mut:");
                foreach (var t in kvPair.Value) {
                    var (typ, typeFound) = Statics.GetVTypeForCType(t.type);
                    var name = Statics.EscapeReservedWordsForVarName(t.name);

                    if (!typeFound)
                    {
                        if (enums.structs.ContainsKey(typ))
                        {}
                        else if (enums.enums.ContainsKey(typ))
                        {}
                        else // prolly has a template type, ie Vec4_Range
                        {}
                    }

                    // handle arrays separately
                    var openBracketIndex = name.IndexOf("[");
                    if (openBracketIndex > 0)
                    {
                        name = name.Insert(openBracketIndex, " ");
                        Console.WriteLine($"\t{name}{typ}");
                    }
                    else
                    {
                        Console.WriteLine($"\t{name} {typ}");
                    }
                }
                Console.WriteLine("}");
            }
        }

        static void HandleDefinitions()
        {
            var uniqueTypes = new HashSet<string>();

            var json = File.ReadAllText("definitions.json");
            var defs = JsonConvert.DeserializeObject<Dictionary<string, List<Definition>>>(json);

            Console.WriteLine("\n--- definitions ---");
            foreach (var kvPair in defs)
            {
                foreach (var def in kvPair.Value)
                {
                    if (kvPair.Key == "igColorConvertHSVtoRGB")
                    {}

                    Console.Write($"fn C.{kvPair.Key}(");
                    for (var i = 0; i < def.argsT.Count; i++)
                    {
                        var arg = def.argsT[i];
                        var isLastArg = i == def.argsT.Count - 1;

                        uniqueTypes.Add(arg.type);
                        var (type, _) = Statics.GetVTypeForCType(arg.type);
                        if (type.Contains("(") || type == "va_list")
                            type = $"voidptr /*{type}*/";

                        Console.Write($"{arg.name} {type}");

                        if (i < def.argsT.Count - 1)
                            Console.Write(", ");
                    }

                    if (!string.IsNullOrEmpty(def.ret) && def.ret != "void")
                    {
                        var (type, _) = Statics.GetVTypeForCType(def.ret);
                        Console.Write($") {type}");
                    }
                    else
                    {
                        Console.Write(")");
                    }

                    Console.WriteLine();
                    break;
                }
                Console.WriteLine();
            }

            return;
            Console.WriteLine("\n\n--- Unique Types ---");
            foreach (var t in uniqueTypes)
            {
                Console.WriteLine(t);
            }
        }
    }

    class StructsAndEnums
    {
        public Dictionary<string,List<Enums>> enums = new Dictionary<string,List<Enums>>();
        public Dictionary<string,List<Structs>> structs = new Dictionary<string,List<Structs>>();
    }

    class Enums
    {
        public int calc_value;
        public string name;
        public string value;
    }

    class Structs
    {
        public string name;
        public string template_type;
        public string type;
    }


    class Definition
    {
        public string args;
        public List<Args> argsT;
        public string argsoriginal;
        public string call_args;
        public string cimguiname;
        public dynamic defaults; // could be empty array or dictionary of values
        public string funcname;
        public bool destructor;
        public string isvararg;
        public string ov_cimguiname;
        public string ret;
        public string signature;
        public string stname;
    }

    class Args
    {
        public string name, type;
    }
}
