using System;
using System.Collections.Generic;
using System.Linq;

namespace Generator
{
    public static class Statics
    {
        static string[] Structs = new string[] {
            "FMOD_SYSTEM",
            "FMOD_SOUND",
            "FMOD_CHANNELCONTROL",
            "FMOD_CHANNEL",
            "FMOD_CHANNELGROUP",
            "FMOD_SOUNDGROUP",
            "FMOD_REVERB3D",
            "FMOD_DSP",
            "FMOD_DSPCONNECTION",
            "FMOD_POLYGON",
            "FMOD_GEOMETRY",
            "FMOD_SYNCPOINT",
            "FMOD_ASYNCREADINFO",

            "FMOD_CREATESOUNDEXINFO",

            "FMOD_STUDIO_SYSTEM",
            "FMOD_STUDIO_EVENTDESCRIPTION",
            "FMOD_STUDIO_EVENTINSTANCE",
            "FMOD_STUDIO_BUS",
            "FMOD_STUDIO_VCA",
            "FMOD_STUDIO_BANK",
            "FMOD_STUDIO_COMMANDREPLAY"
        };

        static Dictionary<string, string> CTypeToVType = new Dictionary<string, string>
        {
            {"FMOD_BOOL", "int"},
            {"void*", "voidptr"},
            {"void**", "voidptr"},
            {"int", "int"},
            {"long", "i64"},
            {"float", "f32"},
            {"char", "byte"},
            {"unsignedint", "u32"},
            {"unsignedlong", "u64"},
            {"unsignedlonglong", "u64"},
            {"const char *", "byteptr"},
            {"FMOD_RESULT", "int"}
        };

        public static string GetVTypeForCType(string cType)
        {
            if (CTypeToVType.ContainsKey(cType))
                return CTypeToVType[cType];

            if (cType.Contains("_CALLBACK"))
            {
                return "voidptr";
                // cant have the callbacks declared in the module because they cant be declared pub for now...
                // var name = Program.GetVEnumName(cType);
                // if (char.IsDigit(name[0]))
                //     name = "_" + name;
                // return name;
            }

            if (Structs.Contains(cType))
                return cType;

            if (cType.Contains("**"))
                return $"voidptr /* {cType} */";

            // TODO: we should filter for FMOD enums here because #defines can be unsigned
            if (cType.StartsWith("FMOD") || cType.StartsWith("C."))
                return "int";

            Console.WriteLine($"No V for {cType}");

            return "UNKNOWN_TYPE";
        }
    }
}