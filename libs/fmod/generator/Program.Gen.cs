using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Generator
{
    partial class Program
    {
        // a StartsWith on the method name is used to filter if we will include or comment out the method
        static string[] AllowedMethodsWithCallbacks = new string[] {"FMOD_System_SetFile"};

        static bool ShouldIncludeMethod(string name)
        {
            foreach (var prefix in AllowedMethodsWithCallbacks)
            {
                if (name.StartsWith(prefix))
                    return true;
            }
            return false;
        }

        static void WriteMethodBagToFile(StreamWriter writer, MethodBag methods, string module)
        {
            writer.WriteLine($"module {module}");
            writer.WriteLine();

            foreach (var kvPair in methods)
            {
                writer.WriteLine($"// {kvPair.Key}");
                WriteMethodsToFile(writer, kvPair.Value);
                writer.WriteLine();
            }
        }

        static void WriteMethodsToFile(StreamWriter writer, List<Method> methods)
        {
            foreach (var m in methods)
            {
                if (!ShouldIncludeMethod(m.Name))
                {
                    foreach (var p in m.Parameters)
                    {
                        if (p.Type.Contains("_CALLBACK") || p.Type.Contains("GEOMETRY"))
                        {
                            writer.Write("// ");
                            break;
                        }
                    }
                }
                writer.Write($"fn C.{m.Name}(");

                for (var i = 0; i < m.Parameters.Count; i++)
                {
                    var p = m.Parameters[i];
                    var typePrefix = p.HasPtr ? "&" : "";
                    writer.Write($"{p.Name} {typePrefix}{Statics.GetVTypeForCType(p.Type)}");

                    if (i < m.Parameters.Count - 1)
                        writer.Write(", ");
                }

                writer.WriteLine($") {Statics.GetVTypeForCType(m.ReturnType)}");
            }
        }

        static void WriteTypesToFile(StreamWriter writer, StreamWriter vWriter, StructsAndTypes types, string module, string vModule)
        {
            writer.WriteLine($"module {module}");
            writer.WriteLine();

            vWriter.WriteLine($"module {vModule}");
            vWriter.WriteLine();

            // writer.WriteLine("pub const (");
            foreach (var c in types.Consts)
            {
                // Console.WriteLine($"skipping const: {c.Name}");
                // writer.WriteLine($"\t{c.Name} = {c.Value}");
            }
            // writer.WriteLine(")");

            // writer.WriteLine();

            foreach (var t in types.TypeDefs)
            {
                // dont write typedefs. it dupes them.
                //writer.WriteLine($"type {t.FMODType} {Statics.GetVTypeForCType(t.Type)}");
            }

            writer.WriteLine();

            foreach (var s in types.Structs)
            {
                if (s.Parameters.Count == 0)
                {
                    writer.WriteLine($"pub struct C.{s.Name} {{}}");
                    continue;
                }
                writer.WriteLine();
            }

            writer.WriteLine();

            foreach (var e in types.Enums)
            {
                if (e.HasNegativeValues)
                {
                    Console.WriteLine($"skipping enum with negative values: {e.Name}");
                    continue;
                }

                // we strip this prefix from the enum values
                var enumPrefix = e.Name + "_";
                if (e.Name == "FMOD_RESULT")
                    enumPrefix = "FMOD_";

                var enumName = GetVEnumName(e.Name);

                vWriter.WriteLine($"pub enum {enumName} {{");
                foreach (var name in e.Enums)
                {
                    var newName = EscapeReservedWords(name.Replace(enumPrefix, "").ToLower());
                    if (char.IsDigit(newName[0]))
                        newName = "_" + newName;
                    vWriter.WriteLine($"\t{newName}");
                }
                vWriter.WriteLine("}");
                vWriter.WriteLine();
            }
        }

        public static string GetVEnumName(string name)
        {
            name = name.Replace("FMOD_", "");
            name = name[0] + name.Substring(1).ToLower();

            var sb = new StringBuilder();
            var nextCharToUpper = false;
            foreach (var ch in name)
            {
                if (ch == '_')
                {
                    nextCharToUpper = true;
                    continue;
                }

                if (nextCharToUpper)
                    sb.Append(char.ToUpper(ch));
                else
                    sb.Append(ch);
                nextCharToUpper = false;
            }

            name = sb.ToString();
            if (name.EndsWith("type"))
                name = name.Replace("type", "Type");
            if (name.EndsWith("state"))
                name = name.Replace("state", "State");
            if (name.EndsWith("mode"))
                name = name.Replace("mode", "Mode");

            if (name.Contains("connection"))
                name = name.Replace("connection", "Connection");
            if (name.Contains("group"))
                name = name.Replace("group", "Group");
            if (name.Contains("control"))
                name = name.Replace("control", "Control");
            if (name.Contains("callback"))
                name = name.Replace("callback", "Callback");

            if (name.Contains("reverb"))
                name = name.Replace("reverb", "Reverb");

            if (name.Contains("cancel"))
                name = name.Replace("cancel", "Cancel");

            return name;
        }

		static string EscapeReservedWords(string name)
		{
			if (name == "map")
				return "map";
			if (name == "string")
				return "str";
            if (name == "type")
                return "typ";
            if (name == "none")
                return "non";
            if (name == "return")
                return "returned";
			return name;
		}
    }
}