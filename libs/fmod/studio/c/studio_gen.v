module c

// Global
fn C.FMOD_Studio_ParseID(idstring byteptr, id &int) int
fn C.FMOD_Studio_System_Create(system &voidptr /* FMOD_STUDIO_SYSTEM** */, headerversion u32) int

// System
fn C.FMOD_Studio_System_IsValid(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_SetAdvancedSettings(system &FMOD_STUDIO_SYSTEM, settings &int) int
fn C.FMOD_Studio_System_GetAdvancedSettings(system &FMOD_STUDIO_SYSTEM, settings &int) int
fn C.FMOD_Studio_System_Initialize(system &FMOD_STUDIO_SYSTEM, maxchannels int, studioflags int, flags int, extradriverdata voidptr) int
fn C.FMOD_Studio_System_Release(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_Update(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_GetCoreSystem(system &FMOD_STUDIO_SYSTEM, coresystem &voidptr /* FMOD_SYSTEM** */) int
fn C.FMOD_Studio_System_GetEvent(system &FMOD_STUDIO_SYSTEM, pathOrID byteptr, event &voidptr /* FMOD_STUDIO_EVENTDESCRIPTION** */) int
fn C.FMOD_Studio_System_GetBus(system &FMOD_STUDIO_SYSTEM, pathOrID byteptr, bus &voidptr /* FMOD_STUDIO_BUS** */) int
fn C.FMOD_Studio_System_GetVCA(system &FMOD_STUDIO_SYSTEM, pathOrID byteptr, vca &voidptr /* FMOD_STUDIO_VCA** */) int
fn C.FMOD_Studio_System_GetBank(system &FMOD_STUDIO_SYSTEM, pathOrID byteptr, bank &voidptr /* FMOD_STUDIO_BANK** */) int
fn C.FMOD_Studio_System_GetEventByID(system &FMOD_STUDIO_SYSTEM, id &int, event &voidptr /* FMOD_STUDIO_EVENTDESCRIPTION** */) int
fn C.FMOD_Studio_System_GetBusByID(system &FMOD_STUDIO_SYSTEM, id &int, bus &voidptr /* FMOD_STUDIO_BUS** */) int
fn C.FMOD_Studio_System_GetVCAByID(system &FMOD_STUDIO_SYSTEM, id &int, vca &voidptr /* FMOD_STUDIO_VCA** */) int
fn C.FMOD_Studio_System_GetBankByID(system &FMOD_STUDIO_SYSTEM, id &int, bank &voidptr /* FMOD_STUDIO_BANK** */) int
fn C.FMOD_Studio_System_GetSoundInfo(system &FMOD_STUDIO_SYSTEM, key byteptr, info &int) int
fn C.FMOD_Studio_System_GetParameterDescriptionByName(system &FMOD_STUDIO_SYSTEM, name byteptr, parameter &int) int
fn C.FMOD_Studio_System_GetParameterDescriptionByID(system &FMOD_STUDIO_SYSTEM, id int, parameter &int) int
fn C.FMOD_Studio_System_GetParameterByID(system &FMOD_STUDIO_SYSTEM, id int, value &f32, finalvalue &f32) int
fn C.FMOD_Studio_System_SetParameterByID(system &FMOD_STUDIO_SYSTEM, id int, value f32, ignoreseekspeed int) int
fn C.FMOD_Studio_System_SetParametersByIDs(system &FMOD_STUDIO_SYSTEM, ids &int, values &f32, count int, ignoreseekspeed int) int
fn C.FMOD_Studio_System_GetParameterByName(system &FMOD_STUDIO_SYSTEM, name byteptr, value &f32, finalvalue &f32) int
fn C.FMOD_Studio_System_SetParameterByName(system &FMOD_STUDIO_SYSTEM, name byteptr, value f32, ignoreseekspeed int) int
fn C.FMOD_Studio_System_LookupID(system &FMOD_STUDIO_SYSTEM, path byteptr, id &int) int
fn C.FMOD_Studio_System_LookupPath(system &FMOD_STUDIO_SYSTEM, id &int, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_System_GetNumListeners(system &FMOD_STUDIO_SYSTEM, numlisteners &int) int
fn C.FMOD_Studio_System_SetNumListeners(system &FMOD_STUDIO_SYSTEM, numlisteners int) int
fn C.FMOD_Studio_System_GetListenerAttributes(system &FMOD_STUDIO_SYSTEM, index int, attributes &int) int
fn C.FMOD_Studio_System_SetListenerAttributes(system &FMOD_STUDIO_SYSTEM, index int, attributes &int) int
fn C.FMOD_Studio_System_GetListenerWeight(system &FMOD_STUDIO_SYSTEM, index int, weight &f32) int
fn C.FMOD_Studio_System_SetListenerWeight(system &FMOD_STUDIO_SYSTEM, index int, weight f32) int
fn C.FMOD_Studio_System_LoadBankFile(system &FMOD_STUDIO_SYSTEM, filename byteptr, flags int, bank &voidptr /* FMOD_STUDIO_BANK** */) int
fn C.FMOD_Studio_System_LoadBankMemory(system &FMOD_STUDIO_SYSTEM, buffer byteptr, length int, mode int, flags int, bank &voidptr /* FMOD_STUDIO_BANK** */) int
fn C.FMOD_Studio_System_LoadBankCustom(system &FMOD_STUDIO_SYSTEM, info &int, flags int, bank &voidptr /* FMOD_STUDIO_BANK** */) int
fn C.FMOD_Studio_System_RegisterPlugin(system &FMOD_STUDIO_SYSTEM, description &int) int
fn C.FMOD_Studio_System_UnregisterPlugin(system &FMOD_STUDIO_SYSTEM, name byteptr) int
fn C.FMOD_Studio_System_UnloadAll(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_FlushCommands(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_FlushSampleLoading(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_StartCommandCapture(system &FMOD_STUDIO_SYSTEM, filename byteptr, flags int) int
fn C.FMOD_Studio_System_StopCommandCapture(system &FMOD_STUDIO_SYSTEM) int
fn C.FMOD_Studio_System_LoadCommandReplay(system &FMOD_STUDIO_SYSTEM, filename byteptr, flags int, replay &voidptr /* FMOD_STUDIO_COMMANDREPLAY** */) int
fn C.FMOD_Studio_System_GetBankCount(system &FMOD_STUDIO_SYSTEM, count &int) int
fn C.FMOD_Studio_System_GetBankList(system &FMOD_STUDIO_SYSTEM, array &voidptr /* FMOD_STUDIO_BANK** */, capacity int, count &int) int
fn C.FMOD_Studio_System_GetParameterDescriptionCount(system &FMOD_STUDIO_SYSTEM, count &int) int
fn C.FMOD_Studio_System_GetParameterDescriptionList(system &FMOD_STUDIO_SYSTEM, array &int, capacity int, count &int) int
fn C.FMOD_Studio_System_GetCPUUsage(system &FMOD_STUDIO_SYSTEM, usage &int) int
fn C.FMOD_Studio_System_GetBufferUsage(system &FMOD_STUDIO_SYSTEM, usage &int) int
fn C.FMOD_Studio_System_ResetBufferUsage(system &FMOD_STUDIO_SYSTEM) int
// fn C.FMOD_Studio_System_SetCallback(system &FMOD_STUDIO_SYSTEM, callback voidptr, callbackmask voidptr) int
fn C.FMOD_Studio_System_SetUserData(system &FMOD_STUDIO_SYSTEM, userdata voidptr) int
fn C.FMOD_Studio_System_GetUserData(system &FMOD_STUDIO_SYSTEM, userdata voidptr) int

// EventDescription
fn C.FMOD_Studio_EventDescription_IsValid(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION) int
fn C.FMOD_Studio_EventDescription_GetID(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, id &int) int
fn C.FMOD_Studio_EventDescription_GetPath(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_EventDescription_GetParameterDescriptionCount(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, count &int) int
fn C.FMOD_Studio_EventDescription_GetParameterDescriptionByIndex(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, index int, parameter &int) int
fn C.FMOD_Studio_EventDescription_GetParameterDescriptionByName(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, name byteptr, parameter &int) int
fn C.FMOD_Studio_EventDescription_GetParameterDescriptionByID(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, id int, parameter &int) int
fn C.FMOD_Studio_EventDescription_GetUserPropertyCount(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, count &int) int
fn C.FMOD_Studio_EventDescription_GetUserPropertyByIndex(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, index int, property &int) int
fn C.FMOD_Studio_EventDescription_GetUserProperty(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, name byteptr, property &int) int
fn C.FMOD_Studio_EventDescription_GetLength(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, length &int) int
fn C.FMOD_Studio_EventDescription_GetMinimumDistance(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, distance &f32) int
fn C.FMOD_Studio_EventDescription_GetMaximumDistance(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, distance &f32) int
fn C.FMOD_Studio_EventDescription_GetSoundSize(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, size &f32) int
fn C.FMOD_Studio_EventDescription_IsSnapshot(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, snapshot &int) int
fn C.FMOD_Studio_EventDescription_IsOneshot(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, oneshot &int) int
fn C.FMOD_Studio_EventDescription_IsStream(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, isStream &int) int
fn C.FMOD_Studio_EventDescription_Is3D(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, is3D &int) int
fn C.FMOD_Studio_EventDescription_HasCue(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, cue &int) int
fn C.FMOD_Studio_EventDescription_CreateInstance(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, instance &voidptr /* FMOD_STUDIO_EVENTINSTANCE** */) int
fn C.FMOD_Studio_EventDescription_GetInstanceCount(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, count &int) int
fn C.FMOD_Studio_EventDescription_GetInstanceList(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, array &voidptr /* FMOD_STUDIO_EVENTINSTANCE** */, capacity int, count &int) int
fn C.FMOD_Studio_EventDescription_LoadSampleData(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION) int
fn C.FMOD_Studio_EventDescription_UnloadSampleData(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION) int
fn C.FMOD_Studio_EventDescription_GetSampleLoadingState(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, state &int) int
fn C.FMOD_Studio_EventDescription_ReleaseAllInstances(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION) int
// fn C.FMOD_Studio_EventDescription_SetCallback(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, callback voidptr, callbackmask voidptr) int
fn C.FMOD_Studio_EventDescription_GetUserData(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, userdata voidptr) int
fn C.FMOD_Studio_EventDescription_SetUserData(eventdescription &FMOD_STUDIO_EVENTDESCRIPTION, userdata voidptr) int

// EventInstance
fn C.FMOD_Studio_EventInstance_IsValid(eventinstance &FMOD_STUDIO_EVENTINSTANCE) int
fn C.FMOD_Studio_EventInstance_GetDescription(eventinstance &FMOD_STUDIO_EVENTINSTANCE, description &voidptr /* FMOD_STUDIO_EVENTDESCRIPTION** */) int
fn C.FMOD_Studio_EventInstance_GetVolume(eventinstance &FMOD_STUDIO_EVENTINSTANCE, volume &f32, finalvolume &f32) int
fn C.FMOD_Studio_EventInstance_SetVolume(eventinstance &FMOD_STUDIO_EVENTINSTANCE, volume f32) int
fn C.FMOD_Studio_EventInstance_GetPitch(eventinstance &FMOD_STUDIO_EVENTINSTANCE, pitch &f32, finalpitch &f32) int
fn C.FMOD_Studio_EventInstance_SetPitch(eventinstance &FMOD_STUDIO_EVENTINSTANCE, pitch f32) int
fn C.FMOD_Studio_EventInstance_Get3DAttributes(eventinstance &FMOD_STUDIO_EVENTINSTANCE, attributes &int) int
fn C.FMOD_Studio_EventInstance_Set3DAttributes(eventinstance &FMOD_STUDIO_EVENTINSTANCE, attributes &int) int
fn C.FMOD_Studio_EventInstance_GetListenerMask(eventinstance &FMOD_STUDIO_EVENTINSTANCE, mask &u32) int
fn C.FMOD_Studio_EventInstance_SetListenerMask(eventinstance &FMOD_STUDIO_EVENTINSTANCE, mask u32) int
fn C.FMOD_Studio_EventInstance_GetProperty(eventinstance &FMOD_STUDIO_EVENTINSTANCE, index int, value &f32) int
fn C.FMOD_Studio_EventInstance_SetProperty(eventinstance &FMOD_STUDIO_EVENTINSTANCE, index int, value f32) int
fn C.FMOD_Studio_EventInstance_GetReverbLevel(eventinstance &FMOD_STUDIO_EVENTINSTANCE, index int, level &f32) int
fn C.FMOD_Studio_EventInstance_SetReverbLevel(eventinstance &FMOD_STUDIO_EVENTINSTANCE, index int, level f32) int
fn C.FMOD_Studio_EventInstance_GetPaused(eventinstance &FMOD_STUDIO_EVENTINSTANCE, paused &int) int
fn C.FMOD_Studio_EventInstance_SetPaused(eventinstance &FMOD_STUDIO_EVENTINSTANCE, paused int) int
fn C.FMOD_Studio_EventInstance_Start(eventinstance &FMOD_STUDIO_EVENTINSTANCE) int
fn C.FMOD_Studio_EventInstance_Stop(eventinstance &FMOD_STUDIO_EVENTINSTANCE, mode int) int
fn C.FMOD_Studio_EventInstance_GetTimelinePosition(eventinstance &FMOD_STUDIO_EVENTINSTANCE, position &int) int
fn C.FMOD_Studio_EventInstance_SetTimelinePosition(eventinstance &FMOD_STUDIO_EVENTINSTANCE, position int) int
fn C.FMOD_Studio_EventInstance_GetPlaybackState(eventinstance &FMOD_STUDIO_EVENTINSTANCE, state &int) int
fn C.FMOD_Studio_EventInstance_GetChannelGroup(eventinstance &FMOD_STUDIO_EVENTINSTANCE, group &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_Studio_EventInstance_Release(eventinstance &FMOD_STUDIO_EVENTINSTANCE) int
fn C.FMOD_Studio_EventInstance_IsVirtual(eventinstance &FMOD_STUDIO_EVENTINSTANCE, virtualstate &int) int
fn C.FMOD_Studio_EventInstance_GetParameterByName(eventinstance &FMOD_STUDIO_EVENTINSTANCE, name byteptr, value &f32, finalvalue &f32) int
fn C.FMOD_Studio_EventInstance_SetParameterByName(eventinstance &FMOD_STUDIO_EVENTINSTANCE, name byteptr, value f32, ignoreseekspeed int) int
fn C.FMOD_Studio_EventInstance_GetParameterByID(eventinstance &FMOD_STUDIO_EVENTINSTANCE, id int, value &f32, finalvalue &f32) int
fn C.FMOD_Studio_EventInstance_SetParameterByID(eventinstance &FMOD_STUDIO_EVENTINSTANCE, id int, value f32, ignoreseekspeed int) int
fn C.FMOD_Studio_EventInstance_SetParametersByIDs(eventinstance &FMOD_STUDIO_EVENTINSTANCE, ids &int, values &f32, count int, ignoreseekspeed int) int
fn C.FMOD_Studio_EventInstance_TriggerCue(eventinstance &FMOD_STUDIO_EVENTINSTANCE) int
// fn C.FMOD_Studio_EventInstance_SetCallback(eventinstance &FMOD_STUDIO_EVENTINSTANCE, callback voidptr, callbackmask voidptr) int
fn C.FMOD_Studio_EventInstance_GetUserData(eventinstance &FMOD_STUDIO_EVENTINSTANCE, userdata voidptr) int
fn C.FMOD_Studio_EventInstance_SetUserData(eventinstance &FMOD_STUDIO_EVENTINSTANCE, userdata voidptr) int
fn C.FMOD_Studio_EventInstance_GetCPUUsage(eventinstance &FMOD_STUDIO_EVENTINSTANCE, exclusive &u32, inclusive &u32) int

// Bus
fn C.FMOD_Studio_Bus_IsValid(bus &FMOD_STUDIO_BUS) int
fn C.FMOD_Studio_Bus_GetID(bus &FMOD_STUDIO_BUS, id &int) int
fn C.FMOD_Studio_Bus_GetPath(bus &FMOD_STUDIO_BUS, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_Bus_GetVolume(bus &FMOD_STUDIO_BUS, volume &f32, finalvolume &f32) int
fn C.FMOD_Studio_Bus_SetVolume(bus &FMOD_STUDIO_BUS, volume f32) int
fn C.FMOD_Studio_Bus_GetPaused(bus &FMOD_STUDIO_BUS, paused &int) int
fn C.FMOD_Studio_Bus_SetPaused(bus &FMOD_STUDIO_BUS, paused int) int
fn C.FMOD_Studio_Bus_GetMute(bus &FMOD_STUDIO_BUS, mute &int) int
fn C.FMOD_Studio_Bus_SetMute(bus &FMOD_STUDIO_BUS, mute int) int
fn C.FMOD_Studio_Bus_StopAllEvents(bus &FMOD_STUDIO_BUS, mode int) int
fn C.FMOD_Studio_Bus_LockChannelGroup(bus &FMOD_STUDIO_BUS) int
fn C.FMOD_Studio_Bus_UnlockChannelGroup(bus &FMOD_STUDIO_BUS) int
fn C.FMOD_Studio_Bus_GetChannelGroup(bus &FMOD_STUDIO_BUS, group &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_Studio_Bus_GetCPUUsage(bus &FMOD_STUDIO_BUS, exclusive &u32, inclusive &u32) int

// VCA
fn C.FMOD_Studio_VCA_IsValid(vca &FMOD_STUDIO_VCA) int
fn C.FMOD_Studio_VCA_GetID(vca &FMOD_STUDIO_VCA, id &int) int
fn C.FMOD_Studio_VCA_GetPath(vca &FMOD_STUDIO_VCA, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_VCA_GetVolume(vca &FMOD_STUDIO_VCA, volume &f32, finalvolume &f32) int
fn C.FMOD_Studio_VCA_SetVolume(vca &FMOD_STUDIO_VCA, volume f32) int

// Bank
fn C.FMOD_Studio_Bank_IsValid(bank &FMOD_STUDIO_BANK) int
fn C.FMOD_Studio_Bank_GetID(bank &FMOD_STUDIO_BANK, id &int) int
fn C.FMOD_Studio_Bank_GetPath(bank &FMOD_STUDIO_BANK, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_Bank_Unload(bank &FMOD_STUDIO_BANK) int
fn C.FMOD_Studio_Bank_LoadSampleData(bank &FMOD_STUDIO_BANK) int
fn C.FMOD_Studio_Bank_UnloadSampleData(bank &FMOD_STUDIO_BANK) int
fn C.FMOD_Studio_Bank_GetLoadingState(bank &FMOD_STUDIO_BANK, state &int) int
fn C.FMOD_Studio_Bank_GetSampleLoadingState(bank &FMOD_STUDIO_BANK, state &int) int
fn C.FMOD_Studio_Bank_GetStringCount(bank &FMOD_STUDIO_BANK, count &int) int
fn C.FMOD_Studio_Bank_GetStringInfo(bank &FMOD_STUDIO_BANK, index int, id &int, path &byte, size int, retrieved &int) int
fn C.FMOD_Studio_Bank_GetEventCount(bank &FMOD_STUDIO_BANK, count &int) int
fn C.FMOD_Studio_Bank_GetEventList(bank &FMOD_STUDIO_BANK, array &voidptr /* FMOD_STUDIO_EVENTDESCRIPTION** */, capacity int, count &int) int
fn C.FMOD_Studio_Bank_GetBusCount(bank &FMOD_STUDIO_BANK, count &int) int
fn C.FMOD_Studio_Bank_GetBusList(bank &FMOD_STUDIO_BANK, array &voidptr /* FMOD_STUDIO_BUS** */, capacity int, count &int) int
fn C.FMOD_Studio_Bank_GetVCACount(bank &FMOD_STUDIO_BANK, count &int) int
fn C.FMOD_Studio_Bank_GetVCAList(bank &FMOD_STUDIO_BANK, array &voidptr /* FMOD_STUDIO_VCA** */, capacity int, count &int) int
fn C.FMOD_Studio_Bank_GetUserData(bank &FMOD_STUDIO_BANK, userdata voidptr) int
fn C.FMOD_Studio_Bank_SetUserData(bank &FMOD_STUDIO_BANK, userdata voidptr) int

// Command playback information
fn C.FMOD_Studio_CommandReplay_IsValid(replay &FMOD_STUDIO_COMMANDREPLAY) int
fn C.FMOD_Studio_CommandReplay_GetSystem(replay &FMOD_STUDIO_COMMANDREPLAY, system &voidptr /* FMOD_STUDIO_SYSTEM** */) int
fn C.FMOD_Studio_CommandReplay_GetLength(replay &FMOD_STUDIO_COMMANDREPLAY, length &f32) int
fn C.FMOD_Studio_CommandReplay_GetCommandCount(replay &FMOD_STUDIO_COMMANDREPLAY, count &int) int
fn C.FMOD_Studio_CommandReplay_GetCommandInfo(replay &FMOD_STUDIO_COMMANDREPLAY, commandindex int, info &int) int
fn C.FMOD_Studio_CommandReplay_GetCommandString(replay &FMOD_STUDIO_COMMANDREPLAY, commandindex int, buffer &byte, length int) int
fn C.FMOD_Studio_CommandReplay_GetCommandAtTime(replay &FMOD_STUDIO_COMMANDREPLAY, time f32, commandindex &int) int
fn C.FMOD_Studio_CommandReplay_SetBankPath(replay &FMOD_STUDIO_COMMANDREPLAY, bankPath byteptr) int
fn C.FMOD_Studio_CommandReplay_Start(replay &FMOD_STUDIO_COMMANDREPLAY) int
fn C.FMOD_Studio_CommandReplay_Stop(replay &FMOD_STUDIO_COMMANDREPLAY) int
fn C.FMOD_Studio_CommandReplay_SeekToTime(replay &FMOD_STUDIO_COMMANDREPLAY, time f32) int
fn C.FMOD_Studio_CommandReplay_SeekToCommand(replay &FMOD_STUDIO_COMMANDREPLAY, commandindex int) int
fn C.FMOD_Studio_CommandReplay_GetPaused(replay &FMOD_STUDIO_COMMANDREPLAY, paused &int) int
fn C.FMOD_Studio_CommandReplay_SetPaused(replay &FMOD_STUDIO_COMMANDREPLAY, paused int) int
fn C.FMOD_Studio_CommandReplay_GetPlaybackState(replay &FMOD_STUDIO_COMMANDREPLAY, state &int) int
fn C.FMOD_Studio_CommandReplay_GetCurrentCommand(replay &FMOD_STUDIO_COMMANDREPLAY, commandindex &int, currenttime &f32) int
fn C.FMOD_Studio_CommandReplay_Release(replay &FMOD_STUDIO_COMMANDREPLAY) int
// fn C.FMOD_Studio_CommandReplay_SetFrameCallback(replay &FMOD_STUDIO_COMMANDREPLAY, callback voidptr) int
// fn C.FMOD_Studio_CommandReplay_SetLoadBankCallback(replay &FMOD_STUDIO_COMMANDREPLAY, callback voidptr) int
// fn C.FMOD_Studio_CommandReplay_SetCreateInstanceCallback(replay &FMOD_STUDIO_COMMANDREPLAY, callback voidptr) int
fn C.FMOD_Studio_CommandReplay_GetUserData(replay &FMOD_STUDIO_COMMANDREPLAY, userdata voidptr) int
fn C.FMOD_Studio_CommandReplay_SetUserData(replay &FMOD_STUDIO_COMMANDREPLAY, userdata voidptr) int

