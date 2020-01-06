using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;

namespace Generator
{
	#region Helper Types

	class MethodBag : Dictionary<string, List<Method>>
	{
		public void AddMethod(string lastComment, Method m)
		{
			if (!this.TryGetValue(lastComment, out var list))
			{
				list = new List<Method>();
				Add(lastComment, list);
			}
			list.Add(m);
		}
	}

	class Method
	{
		public string Name;
		public string ReturnType;
		public List<Parameter> Parameters = new List<Parameter>();
	}

	class Parameter
	{
		public string Name;
		public string Type;
		public bool IsConst;
		public bool HasPtr;
        public bool HasDoublePtr;
	}

	class StructsAndTypes
	{
		public List<Struct> Structs = new List<Struct>();
		public List<Const> Consts = new List<Const>();
		public List<TypeDef> TypeDefs = new List<TypeDef>();
        public List<Enum> Enums = new List<Enum>();
	}

	public class Const
	{
		public string Name, Value;
	}

	class Struct
	{
		public string Name;
		public List<Parameter> Parameters = new List<Parameter>();
	}

    class Enum
    {
        public string Name;
        public List<string> Enums = new List<string>();
		public bool HasNegativeValues;
    }

	public class TypeDef
	{
		public string Type, FMODType;
	}

	#endregion

	partial class Program
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
			var sourceDir = Path.Combine(RootDir, "thirdparty");
			ProcessCore(sourceDir, Path.Combine(RootDir, "core"));
			ProcessStudio(sourceDir, Path.Combine(RootDir, "studio"));
		}

		static void ProcessCore(string sourceDir, string destDir)
		{
			var vDestDir = destDir;
			destDir = Path.Combine(destDir, "c");
			Directory.CreateDirectory(destDir);


			var methods = ExtractMethods(Path.Combine(sourceDir, "core/fmod.h"));
			using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "fmod_gen.v"), FileMode.Create)))
				WriteMethodBagToFile(writer, methods, "c");

			var types = ExtractStructsAndTypes(Path.Combine(sourceDir, "core/fmod_common.h"));
			using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "common_gen.v"), FileMode.Create)))
			using (var vWriter = new StreamWriter(File.Open(Path.Combine(vDestDir, "common_enums_gen.v"), FileMode.Create)))
                WriteTypesToFile(writer, vWriter, types, "c", "core");

			types = ExtractStructsAndTypes(Path.Combine(sourceDir, "core/fmod_dsp_effects.h"));
			using (var writer = StreamWriter.Null) // only enums in there so no need to generate anything else
            using (var vWriter = new StreamWriter(File.Open(Path.Combine(vDestDir, "dsp_enums_gen.v"), FileMode.Create)))
				WriteTypesToFile(writer, vWriter, types, "c", "core");

			// these are for plugins so we dont bother generating them
			// types = ExtractStructsAndTypes(Path.Combine(sourceDir, "core/fmod_dsp.h"));
			// using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "dsp_gen.v"), System.IO.FileMode.Create)))
			// 	WriteTypesToFile(writer, types, , "c", "core");

			// types = ExtractStructsAndTypes(Path.Combine(sourceDir, "core/fmod_codec.h"));
			// using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "codec_gen.v"), System.IO.FileMode.Create)))
			// 	WriteTypesToFile(writer, types, , "c", "core");

			// types = ExtractStructsAndTypes(Path.Combine(sourceDir, "core/fmod_output.h"));
			// using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "output_gen.v"), System.IO.FileMode.Create)))
			// 	WriteTypesToFile(writer, types, , "c", "core");
		}

		static void ProcessStudio(string sourceDir, string destDir)
		{
			var vDestDir = destDir;
			destDir = Path.Combine(destDir, "c");
			Directory.CreateDirectory(destDir);

			var methods = ExtractMethods(Path.Combine(sourceDir, "studio/fmod_studio.h"));
			using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "studio_gen.v"), FileMode.Create)))
				WriteMethodBagToFile(writer, methods, "c");

			var types = ExtractStructsAndTypes(Path.Combine(sourceDir, "studio/fmod_studio_common.h"));
			using (var writer = new StreamWriter(File.Open(Path.Combine(destDir, "common_gen.v"), FileMode.Create)))
            using (var vWriter = new StreamWriter(File.Open(Path.Combine(vDestDir, "studio_common_enums_gen.v"), FileMode.Create)))
				WriteTypesToFile(writer, vWriter, types, "c", "studio");
		}

		#region Methods

		static MethodBag ExtractMethods(string src)
		{
			var methods = new MethodBag();
			var lastLineWithMethod = 0;
			string lastComment = null;

			var lines = File.ReadAllLines(src);
			for (var i = 0; i < lines.Length; i++)
			{
				var line = lines[i];
				if (line.StartsWith("FMOD_RESULT F_API") || line.StartsWith("FMOD_BOOL "))
				{
					// was our last line a method as well? If not, we can find a comment above us
					if (lastLineWithMethod != i - 1)
					{
						lastComment = ExtractLastComment(lines, i - 1);
					}

					lastLineWithMethod = i;
					line = line.Replace("F_API", "");
					methods.AddMethod(lastComment, ParseMethod(line));
				}
			}

			return methods;
		}

		static string ExtractLastComment(string[] lines, int i)
		{
			while (!lines[i].Contains("/*"))
				i--;

			// if the entire line is just the comment delimiter, we want the next line
			if (lines[i].Length == 2)
			{
				i++;
				return lines[i].Trim();
			}
			else
			{
				var line = lines[i].Trim('/', '*', '\\').Trim();
				return line;
			}
		}

		static Method ParseMethod(string line)
		{
			var method = new Method();

			// find return type and name
			var parts = line.Substring(0, line.IndexOf("(")).Split(' ', StringSplitOptions.RemoveEmptyEntries);
			method.Name = parts[1];
			method.ReturnType = parts[0];

			var paramChunk = line.Substring(line.IndexOf("(") + 1).TrimEnd(';', ')', ' ');
			var paramParts = paramChunk.Split(", ", StringSplitOptions.RemoveEmptyEntries);

			foreach (var part in paramParts)
			{
				if (part.Contains("&"))
				{
					throw new Exception("hi");
				}

				var typeName = part.Replace("*", "").Replace("const", "").Replace("unsigned ", "unsigned").Trim().Split(' ');
				var hasPtr = part.Contains('*');
                var hasDoublePtr = part.Contains("**");
				var isConst = part.Contains("const");
				if (hasPtr && typeName[0] == "void")
				{
					hasPtr = false;
					typeName[0] = hasDoublePtr ? "void**" : "void*";
				}
				else if (hasDoublePtr)
				{
					typeName[0] += "**";
				}

				if (part.Contains("const char *"))
				{
					typeName[0] = "const char *";
					hasPtr = false;
					isConst = false;
				}

				method.Parameters.Add(new Parameter
				{
					Name = EscapeReservedWords(typeName[1].Trim()),
					Type = typeName[0].Trim(),
					IsConst = isConst,
					HasPtr = hasPtr,
                    HasDoublePtr = hasDoublePtr
				});

				if (typeName[0].Trim().Length == 0)
				{

				}
			}

			return method;
		}

		#endregion

		#region Types

		static StructsAndTypes ExtractStructsAndTypes(string src)
		{
			var types = new StructsAndTypes();

			var lines = File.ReadAllLines(src);
			for (var i = 0; i < lines.Length; i++)
			{
				var line = lines[i];

				if (line.StartsWith("typedef struct"))
				{
					if (line.EndsWith(";"))
					{
						types.Structs.Add(new Struct
						{
							Name = Regex.Match(line, @"([A-Z0-9_]+);$").Groups[1].Value
						});
					}
                    else
                    {
                        types.Structs.Add(ExtractStruct(lines, ref i));
                    }
				}
				else if (line.StartsWith("typedef enum"))
				{
                    types.Enums.Add(ExtractEnum(lines, ref i));
				}
				else if (line.StartsWith("#define"))
				{
					var parts = line.Replace("#define ", "").Split(' ', StringSplitOptions.RemoveEmptyEntries);
					if (parts.Length == 2 && parts[1].StartsWith("0x"))
					{
						types.Consts.Add(new Const
						{
							Name = EscapeReservedWords(parts[0]),
							Value = parts[1]
						});
					}
				}
				else if (line.StartsWith("typedef"))
				{
					//typedef unsigned int FMOD_DRIVER_STATE;
					var fmodType = Regex.Match(line, @"([A-Z0-9_]+);$").Groups[1].Value;
					if (!string.IsNullOrEmpty(fmodType))
					{
						var t = line.Replace(fmodType, "").Replace("typedef", "").TrimEnd(';').Trim();
						types.TypeDefs.Add(new TypeDef
						{
							Type = t.Replace(" ", ""),
							FMODType = fmodType
						});
					}
                    else
                    {
                        // this is the callback function typedefs
                        var name = Regex.Match(line, @".*?\(F_CALL \*([A-Z0-9_]+)").Groups[1].Value;
                        // types.TypeDefs.Add(new TypeDef
                        // {
                        //     Type = "fn()",
                        //     FMODType = name
                        // });

                        // typedef FMOD_RESULT (F_CALLBACK *FMOD_CODEC_OPEN_CALLBACK)         (FMOD_CODEC_STATE *codec_state, FMOD_MODE usermode, FMOD_CREATESOUNDEXINFO *userexinfo);
                        if (string.IsNullOrEmpty(name))
                        {
                            name = Regex.Match(line, @".*?\(F_CALLBACK \*([A-Z0-9_]+)").Groups[1].Value;
                        }
                    }
				}
			}

			return types;
		}

        static Struct ExtractStruct(string[] lines, ref int i)
        {
            var s = new Struct
            {
                Name = lines[i].Replace("typedef struct", "").Trim()
            };



            return s;
        }

        static Enum ExtractEnum(string[] lines, ref int i)
        {
            var e = new Enum
            {
                Name = lines[i++].Replace("typedef enum", "").Trim()
            };

            do
            {
                if (lines[i].StartsWith("{") || lines[i].Contains("FORCEINT"))
                    continue;

                if (lines[i] == "")
                    continue;

				if (!e.HasNegativeValues && lines[i].Contains("-"))
					e.HasNegativeValues = true;

                e.Enums.Add(lines[i].Trim().TrimEnd(','));
            } while (!lines[++i].StartsWith("}"));

            if (string.IsNullOrEmpty(e.Name))
                e.Name = lines[i].TrimStart(' ', '}').TrimEnd(';');

            return e;
        }

		#endregion
	}
}
