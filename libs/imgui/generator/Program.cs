using System;
using System.IO;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Generator
{
    class Program
    {
        static void Main(string[] args)
        {
            HandleStructsAndEnums();
            HandleDefinitions();
        }

        static void HandleStructsAndEnums()
        {
            var json = File.ReadAllText("cimgui/generator/output/structs_and_enums.json");
            var enums = JsonConvert.DeserializeObject<StructsAndEnums>(json);

            Console.WriteLine("--- enums ---");
            foreach (var kvPair in enums.enums)
            {
                Console.WriteLine($"-- {kvPair.Key}");
            }

            Console.WriteLine("\n--- structs ---");
            foreach (var kvPair in enums.structs)
            {
                Console.WriteLine($"-- {kvPair.Key}");

            }
        }

        static void HandleDefinitions()
        {
            var uniqueTypes = new HashSet<string>();

            var json = File.ReadAllText("cimgui/generator/output/definitions.json");
            var defs = JsonConvert.DeserializeObject<Dictionary<string, List<Definition>>>(json);

            Console.WriteLine("--- definitions ---");
            foreach (var kvPair in defs)
            {
                Console.WriteLine($"-- {kvPair.Key}");
                foreach (var def in kvPair.Value)
                {
                    Console.WriteLine($"{def.args}");
                    foreach (var arg in def.argsT)
                    {
                        uniqueTypes.Add(arg.type);
                        Console.WriteLine($"\t{arg.type} {arg.name}");
                    }
                }
            }

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
