using System.Collections.Generic;
using System.Linq;

namespace Generator
{
	public static class Statics
	{
        static string[] reserved = new[] { "map", "string", "return", "or", "none", "type", "select", "false", "true" };

		static Dictionary<string, string> CTypeToVType = new Dictionary<string, string>
		{
			{"float", "f32"},
            {"float&", "&f32"},
            {"double", "f64"},
			{"ImU32", "u32"},
			{"const ImVec4", "C.ImVec4"},
			{"void*", "voidptr"},
			{"const char*", "byteptr"},
			{"unsigned int", "u32"},
			{"unsigned short", "u16"},
			{"short", "i16"},
			{"size_t", "u32"},
			{"char", "byte"},
            {"int*", "&int"}
		};

		public static (string, bool) GetVTypeForCType(string cType)
		{
			// first, get direct matches out of the way
			if (CTypeToVType.ContainsKey(cType))
				return (CTypeToVType[cType], true);

			// strip const
			if (cType.Contains("const "))
				cType = cType.Replace("const ", "");

			// check again for a direct match
			if (CTypeToVType.ContainsKey(cType))
				return (CTypeToVType[cType], true);

			// change pointers to V style
			if (cType.EndsWith("*"))
                return ("&" + GetVTypeForCType(cType.Substring(0, cType.Length - 1)).Item1, true);

			if (cType.Contains("["))
			{
				var t = cType.Substring(0, cType.IndexOf("["));
				var num = cType.Substring(cType.IndexOf("[") + 1, 1);
				return ($"[{num}]{t}", true);
			}

			return (cType, false);
		}

        public static bool HasReservedWord(string name) => reserved.Contains(name);

		public static string EscapeReservedWordsForVarName(string name)
		{
			if (reserved.Contains(name))
				return $"@{name}";
			return name;
		}

		public static string ToSnakeCase(string name)
		{
			if (name.EndsWith("1D") || name.EndsWith("2D") || name.EndsWith("3D"))
				name = name.Substring(0, name.Length - 2) + "_" + name.Substring(name.Length - 2, 1) + char.ToLower(name[name.Length - 1]);
			name = string.Concat(name.Select((x, i) => i > 0 && char.IsUpper(x) ? "_" + x.ToString() : x.ToString())).ToLower();

            if (HasReservedWord(name))
                return name.Substring(0, name.Length - 1);
			return name;
		}
	}
}