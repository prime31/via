module c

// FMOD global system functions (optional).
// fn C.FMOD_Memory_Initialize(poolmem voidptr, poollen int, useralloc voidptr, userrealloc voidptr, userfree voidptr, memtypeflags int) int
fn C.FMOD_Memory_GetStats(currentalloced &int, maxalloced &int, blocking int) int
// fn C.FMOD_Debug_Initialize(flags int, mode int, callback voidptr, filename byteptr) int
fn C.FMOD_File_SetDiskBusy(busy int) int
fn C.FMOD_File_GetDiskBusy(busy &int) int

// FMOD System factory functions.  Use this to create an FMOD System Instance.  below you will see FMOD_System_Init/Close to get started.
fn C.FMOD_System_Create(system &voidptr /* FMOD_SYSTEM** */) int
fn C.FMOD_System_Release(system &FMOD_SYSTEM) int

// Setup functions.
fn C.FMOD_System_SetOutput(system &FMOD_SYSTEM, output int) int
fn C.FMOD_System_GetOutput(system &FMOD_SYSTEM, output &int) int
fn C.FMOD_System_GetNumDrivers(system &FMOD_SYSTEM, numdrivers &int) int
fn C.FMOD_System_GetDriverInfo(system &FMOD_SYSTEM, id int, name &byte, namelen int, guid &int, systemrate &int, speakermode &int, speakermodechannels &int) int
fn C.FMOD_System_SetDriver(system &FMOD_SYSTEM, driver int) int
fn C.FMOD_System_GetDriver(system &FMOD_SYSTEM, driver &int) int
fn C.FMOD_System_SetSoftwareChannels(system &FMOD_SYSTEM, numsoftwarechannels int) int
fn C.FMOD_System_GetSoftwareChannels(system &FMOD_SYSTEM, numsoftwarechannels &int) int
fn C.FMOD_System_SetSoftwareFormat(system &FMOD_SYSTEM, samplerate int, speakermode int, numrawspeakers int) int
fn C.FMOD_System_GetSoftwareFormat(system &FMOD_SYSTEM, samplerate &int, speakermode &int, numrawspeakers &int) int
fn C.FMOD_System_SetDSPBufferSize(system &FMOD_SYSTEM, bufferlength u32, numbuffers int) int
fn C.FMOD_System_GetDSPBufferSize(system &FMOD_SYSTEM, bufferlength &u32, numbuffers &int) int
fn C.FMOD_System_SetFileSystem(system &FMOD_SYSTEM, useropen voidptr, userclose voidptr, userread voidptr, userseek voidptr, userasyncread voidptr, userasynccancel voidptr, blockalign int) int
// fn C.FMOD_System_AttachFileSystem(system &FMOD_SYSTEM, useropen voidptr, userclose voidptr, userread voidptr, userseek voidptr) int
fn C.FMOD_System_SetAdvancedSettings(system &FMOD_SYSTEM, settings &int) int
fn C.FMOD_System_GetAdvancedSettings(system &FMOD_SYSTEM, settings &int) int
// fn C.FMOD_System_SetCallback(system &FMOD_SYSTEM, callback voidptr, callbackmask voidptr) int

// Plug-in support.
fn C.FMOD_System_SetPluginPath(system &FMOD_SYSTEM, path byteptr) int
fn C.FMOD_System_LoadPlugin(system &FMOD_SYSTEM, filename byteptr, handle &u32, priority u32) int
fn C.FMOD_System_UnloadPlugin(system &FMOD_SYSTEM, handle u32) int
fn C.FMOD_System_GetNumNestedPlugins(system &FMOD_SYSTEM, handle u32, count &int) int
fn C.FMOD_System_GetNestedPlugin(system &FMOD_SYSTEM, handle u32, index int, nestedhandle &u32) int
fn C.FMOD_System_GetNumPlugins(system &FMOD_SYSTEM, plugintype int, numplugins &int) int
fn C.FMOD_System_GetPluginHandle(system &FMOD_SYSTEM, plugintype int, index int, handle &u32) int
fn C.FMOD_System_GetPluginInfo(system &FMOD_SYSTEM, handle u32, plugintype &int, name &byte, namelen int, version &u32) int
fn C.FMOD_System_SetOutputByPlugin(system &FMOD_SYSTEM, handle u32) int
fn C.FMOD_System_GetOutputByPlugin(system &FMOD_SYSTEM, handle &u32) int
fn C.FMOD_System_CreateDSPByPlugin(system &FMOD_SYSTEM, handle u32, dsp &voidptr /* FMOD_DSP** */) int
fn C.FMOD_System_GetDSPInfoByPlugin(system &FMOD_SYSTEM, handle u32, description &voidptr /* FMOD_DSP_DESCRIPTION** */) int
fn C.FMOD_System_RegisterCodec(system &FMOD_SYSTEM, description &int, handle &u32, priority u32) int
fn C.FMOD_System_RegisterDSP(system &FMOD_SYSTEM, description &int, handle &u32) int
fn C.FMOD_System_RegisterOutput(system &FMOD_SYSTEM, description &int, handle &u32) int

// Init/Close.
fn C.FMOD_System_Init(system &FMOD_SYSTEM, maxchannels int, flags int, extradriverdata voidptr) int
fn C.FMOD_System_Close(system &FMOD_SYSTEM) int

// General post-init system functions.
fn C.FMOD_System_Update(system &FMOD_SYSTEM) int
fn C.FMOD_System_SetSpeakerPosition(system &FMOD_SYSTEM, speaker int, x f32, y f32, active int) int
fn C.FMOD_System_GetSpeakerPosition(system &FMOD_SYSTEM, speaker int, x &f32, y &f32, active &int) int
fn C.FMOD_System_SetStreamBufferSize(system &FMOD_SYSTEM, filebuffersize u32, filebuffersizetype int) int
fn C.FMOD_System_GetStreamBufferSize(system &FMOD_SYSTEM, filebuffersize &u32, filebuffersizetype &int) int
fn C.FMOD_System_Set3DSettings(system &FMOD_SYSTEM, dopplerscale f32, distancefactor f32, rolloffscale f32) int
fn C.FMOD_System_Get3DSettings(system &FMOD_SYSTEM, dopplerscale &f32, distancefactor &f32, rolloffscale &f32) int
fn C.FMOD_System_Set3DNumListeners(system &FMOD_SYSTEM, numlisteners int) int
fn C.FMOD_System_Get3DNumListeners(system &FMOD_SYSTEM, numlisteners &int) int
fn C.FMOD_System_Set3DListenerAttributes(system &FMOD_SYSTEM, listener int, pos &int, vel &int, forward &int, up &int) int
fn C.FMOD_System_Get3DListenerAttributes(system &FMOD_SYSTEM, listener int, pos &int, vel &int, forward &int, up &int) int
// fn C.FMOD_System_Set3DRolloffCallback(system &FMOD_SYSTEM, callback voidptr) int
fn C.FMOD_System_MixerSuspend(system &FMOD_SYSTEM) int
fn C.FMOD_System_MixerResume(system &FMOD_SYSTEM) int
fn C.FMOD_System_GetDefaultMixMatrix(system &FMOD_SYSTEM, sourcespeakermode int, targetspeakermode int, matrix &f32, matrixhop int) int
fn C.FMOD_System_GetSpeakerModeChannels(system &FMOD_SYSTEM, mode int, channels &int) int

// System information functions.
fn C.FMOD_System_GetVersion(system &FMOD_SYSTEM, version &u32) int
fn C.FMOD_System_GetOutputHandle(system &FMOD_SYSTEM, handle voidptr) int
fn C.FMOD_System_GetChannelsPlaying(system &FMOD_SYSTEM, channels &int, realchannels &int) int
fn C.FMOD_System_GetCPUUsage(system &FMOD_SYSTEM, dsp &f32, stream &f32, geometry &f32, update &f32, total &f32) int
fn C.FMOD_System_GetFileUsage(system &FMOD_SYSTEM, sampleBytesRead &i64, streamBytesRead &i64, otherBytesRead &i64) int

// Sound/DSP/Channel/FX creation and retrieval.
fn C.FMOD_System_CreateSound(system &FMOD_SYSTEM, name_or_data byteptr, mode int, exinfo &FMOD_CREATESOUNDEXINFO, sound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_System_CreateStream(system &FMOD_SYSTEM, name_or_data byteptr, mode int, exinfo &FMOD_CREATESOUNDEXINFO, sound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_System_CreateDSP(system &FMOD_SYSTEM, description &int, dsp &voidptr /* FMOD_DSP** */) int
fn C.FMOD_System_CreateDSPByType(system &FMOD_SYSTEM, typ int, dsp &voidptr /* FMOD_DSP** */) int
fn C.FMOD_System_CreateChannelGroup(system &FMOD_SYSTEM, name byteptr, channelgroup &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_System_CreateSoundGroup(system &FMOD_SYSTEM, name byteptr, soundgroup &voidptr /* FMOD_SOUNDGROUP** */) int
fn C.FMOD_System_CreateReverb3D(system &FMOD_SYSTEM, reverb &voidptr /* FMOD_REVERB3D** */) int
fn C.FMOD_System_PlaySound(system &FMOD_SYSTEM, sound &FMOD_SOUND, channelgroup &FMOD_CHANNELGROUP, paused int, channel &voidptr /* FMOD_CHANNEL** */) int
fn C.FMOD_System_PlayDSP(system &FMOD_SYSTEM, dsp &FMOD_DSP, channelgroup &FMOD_CHANNELGROUP, paused int, channel &voidptr /* FMOD_CHANNEL** */) int
fn C.FMOD_System_GetChannel(system &FMOD_SYSTEM, channelid int, channel &voidptr /* FMOD_CHANNEL** */) int
fn C.FMOD_System_GetMasterChannelGroup(system &FMOD_SYSTEM, channelgroup &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_System_GetMasterSoundGroup(system &FMOD_SYSTEM, soundgroup &voidptr /* FMOD_SOUNDGROUP** */) int

// Routing to ports.
fn C.FMOD_System_AttachChannelGroupToPort(system &FMOD_SYSTEM, portType int, portIndex int, channelgroup &FMOD_CHANNELGROUP, passThru int) int
fn C.FMOD_System_DetachChannelGroupFromPort(system &FMOD_SYSTEM, channelgroup &FMOD_CHANNELGROUP) int

// Reverb API.
fn C.FMOD_System_SetReverbProperties(system &FMOD_SYSTEM, instance int, prop &int) int
fn C.FMOD_System_GetReverbProperties(system &FMOD_SYSTEM, instance int, prop &int) int

// System level DSP functionality.
fn C.FMOD_System_LockDSP(system &FMOD_SYSTEM) int
fn C.FMOD_System_UnlockDSP(system &FMOD_SYSTEM) int

// Recording API.
fn C.FMOD_System_GetRecordNumDrivers(system &FMOD_SYSTEM, numdrivers &int, numconnected &int) int
fn C.FMOD_System_GetRecordDriverInfo(system &FMOD_SYSTEM, id int, name &byte, namelen int, guid &int, systemrate &int, speakermode &int, speakermodechannels &int, state &int) int
fn C.FMOD_System_GetRecordPosition(system &FMOD_SYSTEM, id int, position &u32) int
fn C.FMOD_System_RecordStart(system &FMOD_SYSTEM, id int, sound &FMOD_SOUND, loop int) int
fn C.FMOD_System_RecordStop(system &FMOD_SYSTEM, id int) int
fn C.FMOD_System_IsRecording(system &FMOD_SYSTEM, id int, recording &int) int

// Geometry API.
// fn C.FMOD_System_CreateGeometry(system &FMOD_SYSTEM, maxpolygons int, maxvertices int, geometry &voidptr /* FMOD_GEOMETRY** */) int
fn C.FMOD_System_SetGeometrySettings(system &FMOD_SYSTEM, maxworldsize f32) int
fn C.FMOD_System_GetGeometrySettings(system &FMOD_SYSTEM, maxworldsize &f32) int
// fn C.FMOD_System_LoadGeometry(system &FMOD_SYSTEM, data voidptr, datasize int, geometry &voidptr /* FMOD_GEOMETRY** */) int
fn C.FMOD_System_GetGeometryOcclusion(system &FMOD_SYSTEM, listener &int, source &int, direct &f32, reverb &f32) int

// Network functions.
fn C.FMOD_System_SetNetworkProxy(system &FMOD_SYSTEM, proxy byteptr) int
fn C.FMOD_System_GetNetworkProxy(system &FMOD_SYSTEM, proxy &byte, proxylen int) int
fn C.FMOD_System_SetNetworkTimeout(system &FMOD_SYSTEM, timeout int) int
fn C.FMOD_System_GetNetworkTimeout(system &FMOD_SYSTEM, timeout &int) int

// Userdata set/get.
fn C.FMOD_System_SetUserData(system &FMOD_SYSTEM, userdata voidptr) int
fn C.FMOD_System_GetUserData(system &FMOD_SYSTEM, userdata voidptr) int
fn C.FMOD_Sound_SetUserData(sound &FMOD_SOUND, userdata voidptr) int
fn C.FMOD_Sound_GetUserData(sound &FMOD_SOUND, userdata voidptr) int
fn C.FMOD_Channel_SetUserData(channel &FMOD_CHANNEL, userdata voidptr) int
fn C.FMOD_Channel_GetUserData(channel &FMOD_CHANNEL, userdata voidptr) int
fn C.FMOD_ChannelGroup_SetUserData(channelgroup &FMOD_CHANNELGROUP, userdata voidptr) int
fn C.FMOD_ChannelGroup_GetUserData(channelgroup &FMOD_CHANNELGROUP, userdata voidptr) int
fn C.FMOD_ChannelGroup_Release(channelgroup &FMOD_CHANNELGROUP) int
fn C.FMOD_SoundGroup_SetUserData(soundgroup &FMOD_SOUNDGROUP, userdata voidptr) int
fn C.FMOD_SoundGroup_GetUserData(soundgroup &FMOD_SOUNDGROUP, userdata voidptr) int
fn C.FMOD_DSP_SetUserData(dsp &FMOD_DSP, userdata voidptr) int
fn C.FMOD_DSP_GetUserData(dsp &FMOD_DSP, userdata voidptr) int
fn C.FMOD_DSPConnection_SetUserData(dspconnection &FMOD_DSPCONNECTION, userdata voidptr) int
fn C.FMOD_DSPConnection_GetUserData(dspconnection &FMOD_DSPCONNECTION, userdata voidptr) int
// fn C.FMOD_Geometry_SetUserData(geometry &FMOD_GEOMETRY, userdata voidptr) int
// fn C.FMOD_Geometry_GetUserData(geometry &FMOD_GEOMETRY, userdata voidptr) int
fn C.FMOD_Reverb3D_SetUserData(reverb3d &FMOD_REVERB3D, userdata voidptr) int
fn C.FMOD_Reverb3D_GetUserData(reverb3d &FMOD_REVERB3D, userdata voidptr) int

// Sound API
fn C.FMOD_Sound_Release(sound &FMOD_SOUND) int
fn C.FMOD_Sound_GetSystemObject(sound &FMOD_SOUND, system &voidptr /* FMOD_SYSTEM** */) int

// Standard sound manipulation functions.
fn C.FMOD_Sound_Lock(sound &FMOD_SOUND, offset u32, length u32, ptr1 voidptr, ptr2 voidptr, len1 &u32, len2 &u32) int
fn C.FMOD_Sound_Unlock(sound &FMOD_SOUND, ptr1 voidptr, ptr2 voidptr, len1 u32, len2 u32) int
fn C.FMOD_Sound_SetDefaults(sound &FMOD_SOUND, frequency f32, priority int) int
fn C.FMOD_Sound_GetDefaults(sound &FMOD_SOUND, frequency &f32, priority &int) int
fn C.FMOD_Sound_Set3DMinMaxDistance(sound &FMOD_SOUND, min f32, max f32) int
fn C.FMOD_Sound_Get3DMinMaxDistance(sound &FMOD_SOUND, min &f32, max &f32) int
fn C.FMOD_Sound_Set3DConeSettings(sound &FMOD_SOUND, insideconeangle f32, outsideconeangle f32, outsidevolume f32) int
fn C.FMOD_Sound_Get3DConeSettings(sound &FMOD_SOUND, insideconeangle &f32, outsideconeangle &f32, outsidevolume &f32) int
fn C.FMOD_Sound_Set3DCustomRolloff(sound &FMOD_SOUND, points &int, numpoints int) int
fn C.FMOD_Sound_Get3DCustomRolloff(sound &FMOD_SOUND, points &voidptr /* FMOD_VECTOR** */, numpoints &int) int
fn C.FMOD_Sound_GetSubSound(sound &FMOD_SOUND, index int, subsound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_Sound_GetSubSoundParent(sound &FMOD_SOUND, parentsound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_Sound_GetName(sound &FMOD_SOUND, name &byte, namelen int) int
fn C.FMOD_Sound_GetLength(sound &FMOD_SOUND, length &u32, lengthtype int) int
fn C.FMOD_Sound_GetFormat(sound &FMOD_SOUND, typ &int, format &int, channels &int, bits &int) int
fn C.FMOD_Sound_GetNumSubSounds(sound &FMOD_SOUND, numsubsounds &int) int
fn C.FMOD_Sound_GetNumTags(sound &FMOD_SOUND, numtags &int, numtagsupdated &int) int
fn C.FMOD_Sound_GetTag(sound &FMOD_SOUND, name byteptr, index int, tag &int) int
fn C.FMOD_Sound_GetOpenState(sound &FMOD_SOUND, openstate &int, percentbuffered &u32, starving &int, diskbusy &int) int
fn C.FMOD_Sound_ReadData(sound &FMOD_SOUND, buffer voidptr, length u32, read &u32) int
fn C.FMOD_Sound_SeekData(sound &FMOD_SOUND, pcm u32) int
fn C.FMOD_Sound_SetSoundGroup(sound &FMOD_SOUND, soundgroup &FMOD_SOUNDGROUP) int
fn C.FMOD_Sound_GetSoundGroup(sound &FMOD_SOUND, soundgroup &voidptr /* FMOD_SOUNDGROUP** */) int

// Synchronization point API.  These points can come from markers embedded in wav files, and can also generate channel callbacks.
fn C.FMOD_Sound_GetNumSyncPoints(sound &FMOD_SOUND, numsyncpoints &int) int
fn C.FMOD_Sound_GetSyncPoint(sound &FMOD_SOUND, index int, point &voidptr /* FMOD_SYNCPOINT** */) int
fn C.FMOD_Sound_GetSyncPointInfo(sound &FMOD_SOUND, point &FMOD_SYNCPOINT, name &byte, namelen int, offset &u32, offsettype int) int
fn C.FMOD_Sound_AddSyncPoint(sound &FMOD_SOUND, offset u32, offsettype int, name byteptr, point &voidptr /* FMOD_SYNCPOINT** */) int
fn C.FMOD_Sound_DeleteSyncPoint(sound &FMOD_SOUND, point &FMOD_SYNCPOINT) int

// Functions also in Channel class but here they are the 'default' to save having to change it in Channel all the time.
fn C.FMOD_Sound_SetMode(sound &FMOD_SOUND, mode int) int
fn C.FMOD_Sound_GetMode(sound &FMOD_SOUND, mode &int) int
fn C.FMOD_Sound_SetLoopCount(sound &FMOD_SOUND, loopcount int) int
fn C.FMOD_Sound_GetLoopCount(sound &FMOD_SOUND, loopcount &int) int
fn C.FMOD_Sound_SetLoopPoints(sound &FMOD_SOUND, loopstart u32, loopstarttype int, loopend u32, loopendtype int) int
fn C.FMOD_Sound_GetLoopPoints(sound &FMOD_SOUND, loopstart &u32, loopstarttype int, loopend &u32, loopendtype int) int

// For MOD/S3M/XM/IT/MID sequenced formats only.
fn C.FMOD_Sound_GetMusicNumChannels(sound &FMOD_SOUND, numchannels &int) int
fn C.FMOD_Sound_SetMusicChannelVolume(sound &FMOD_SOUND, channel int, volume f32) int
fn C.FMOD_Sound_GetMusicChannelVolume(sound &FMOD_SOUND, channel int, volume &f32) int
fn C.FMOD_Sound_SetMusicSpeed(sound &FMOD_SOUND, speed f32) int
fn C.FMOD_Sound_GetMusicSpeed(sound &FMOD_SOUND, speed &f32) int

// 'Channel' API
fn C.FMOD_Channel_GetSystemObject(channel &FMOD_CHANNEL, system &voidptr /* FMOD_SYSTEM** */) int

// General control functionality for Channels and ChannelGroups.
fn C.FMOD_Channel_Stop(channel &FMOD_CHANNEL) int
fn C.FMOD_Channel_SetPaused(channel &FMOD_CHANNEL, paused int) int
fn C.FMOD_Channel_GetPaused(channel &FMOD_CHANNEL, paused &int) int
fn C.FMOD_Channel_SetVolume(channel &FMOD_CHANNEL, volume f32) int
fn C.FMOD_Channel_GetVolume(channel &FMOD_CHANNEL, volume &f32) int
fn C.FMOD_Channel_SetVolumeRamp(channel &FMOD_CHANNEL, ramp int) int
fn C.FMOD_Channel_GetVolumeRamp(channel &FMOD_CHANNEL, ramp &int) int
fn C.FMOD_Channel_GetAudibility(channel &FMOD_CHANNEL, audibility &f32) int
fn C.FMOD_Channel_SetPitch(channel &FMOD_CHANNEL, pitch f32) int
fn C.FMOD_Channel_GetPitch(channel &FMOD_CHANNEL, pitch &f32) int
fn C.FMOD_Channel_SetMute(channel &FMOD_CHANNEL, mute int) int
fn C.FMOD_Channel_GetMute(channel &FMOD_CHANNEL, mute &int) int
fn C.FMOD_Channel_SetReverbProperties(channel &FMOD_CHANNEL, instance int, wet f32) int
fn C.FMOD_Channel_GetReverbProperties(channel &FMOD_CHANNEL, instance int, wet &f32) int
fn C.FMOD_Channel_SetLowPassGain(channel &FMOD_CHANNEL, gain f32) int
fn C.FMOD_Channel_GetLowPassGain(channel &FMOD_CHANNEL, gain &f32) int
fn C.FMOD_Channel_SetMode(channel &FMOD_CHANNEL, mode int) int
fn C.FMOD_Channel_GetMode(channel &FMOD_CHANNEL, mode &int) int
// fn C.FMOD_Channel_SetCallback(channel &FMOD_CHANNEL, callback voidptr) int
fn C.FMOD_Channel_IsPlaying(channel &FMOD_CHANNEL, isplaying &int) int
fn C.FMOD_ChannelGroup_Stop(channelgroup &FMOD_CHANNELGROUP) int
fn C.FMOD_ChannelGroup_SetPaused(channelgroup &FMOD_CHANNELGROUP, paused int) int
fn C.FMOD_ChannelGroup_GetPaused(channelgroup &FMOD_CHANNELGROUP, paused &int) int
fn C.FMOD_ChannelGroup_SetVolume(channelgroup &FMOD_CHANNELGROUP, volume f32) int
fn C.FMOD_ChannelGroup_GetVolume(channelgroup &FMOD_CHANNELGROUP, volume &f32) int
fn C.FMOD_ChannelGroup_SetVolumeRamp(channelgroup &FMOD_CHANNELGROUP, ramp int) int
fn C.FMOD_ChannelGroup_GetVolumeRamp(channelgroup &FMOD_CHANNELGROUP, ramp &int) int
fn C.FMOD_ChannelGroup_GetAudibility(channelgroup &FMOD_CHANNELGROUP, audibility &f32) int
fn C.FMOD_ChannelGroup_SetPitch(channelgroup &FMOD_CHANNELGROUP, pitch f32) int
fn C.FMOD_ChannelGroup_GetPitch(channelgroup &FMOD_CHANNELGROUP, pitch &f32) int
fn C.FMOD_ChannelGroup_SetMute(channelgroup &FMOD_CHANNELGROUP, mute int) int
fn C.FMOD_ChannelGroup_GetMute(channelgroup &FMOD_CHANNELGROUP, mute &int) int
fn C.FMOD_ChannelGroup_SetReverbProperties(channelgroup &FMOD_CHANNELGROUP, instance int, wet f32) int
fn C.FMOD_ChannelGroup_GetReverbProperties(channelgroup &FMOD_CHANNELGROUP, instance int, wet &f32) int
fn C.FMOD_ChannelGroup_SetLowPassGain(channelgroup &FMOD_CHANNELGROUP, gain f32) int
fn C.FMOD_ChannelGroup_GetLowPassGain(channelgroup &FMOD_CHANNELGROUP, gain &f32) int
fn C.FMOD_ChannelGroup_SetMode(channelgroup &FMOD_CHANNELGROUP, mode int) int
fn C.FMOD_ChannelGroup_GetMode(channelgroup &FMOD_CHANNELGROUP, mode &int) int
// fn C.FMOD_ChannelGroup_SetCallback(channelgroup &FMOD_CHANNELGROUP, callback voidptr) int
fn C.FMOD_ChannelGroup_IsPlaying(channelgroup &FMOD_CHANNELGROUP, isplaying &int) int

// Note all 'set' functions alter a final matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
fn C.FMOD_Channel_SetPan(channel &FMOD_CHANNEL, pan f32) int
fn C.FMOD_Channel_SetMixLevelsOutput(channel &FMOD_CHANNEL, frontleft f32, frontright f32, center f32, lfe f32, surroundleft f32, surroundright f32, backleft f32, backright f32) int
fn C.FMOD_Channel_SetMixLevelsInput(channel &FMOD_CHANNEL, levels &f32, numlevels int) int
fn C.FMOD_Channel_SetMixMatrix(channel &FMOD_CHANNEL, matrix &f32, outchannels int, inchannels int, inchannel_hop int) int
fn C.FMOD_Channel_GetMixMatrix(channel &FMOD_CHANNEL, matrix &f32, outchannels &int, inchannels &int, inchannel_hop int) int
fn C.FMOD_ChannelGroup_SetPan(channelgroup &FMOD_CHANNELGROUP, pan f32) int
fn C.FMOD_ChannelGroup_SetMixLevelsOutput(channelgroup &FMOD_CHANNELGROUP, frontleft f32, frontright f32, center f32, lfe f32, surroundleft f32, surroundright f32, backleft f32, backright f32) int
fn C.FMOD_ChannelGroup_SetMixLevelsInput(channelgroup &FMOD_CHANNELGROUP, levels &f32, numlevels int) int
fn C.FMOD_ChannelGroup_SetMixMatrix(channelgroup &FMOD_CHANNELGROUP, matrix &f32, outchannels int, inchannels int, inchannel_hop int) int
fn C.FMOD_ChannelGroup_GetMixMatrix(channelgroup &FMOD_CHANNELGROUP, matrix &f32, outchannels &int, inchannels &int, inchannel_hop int) int

// Clock based functionality.
fn C.FMOD_Channel_GetDSPClock(channel &FMOD_CHANNEL, dspclock &u64, parentclock &u64) int
fn C.FMOD_Channel_SetDelay(channel &FMOD_CHANNEL, dspclock_start u64, dspclock_end u64, stopchannels int) int
fn C.FMOD_Channel_GetDelay(channel &FMOD_CHANNEL, dspclock_start &u64, dspclock_end &u64, stopchannels &int) int
fn C.FMOD_Channel_AddFadePoint(channel &FMOD_CHANNEL, dspclock u64, volume f32) int
fn C.FMOD_Channel_SetFadePointRamp(channel &FMOD_CHANNEL, dspclock u64, volume f32) int
fn C.FMOD_Channel_RemoveFadePoints(channel &FMOD_CHANNEL, dspclock_start u64, dspclock_end u64) int
fn C.FMOD_Channel_GetFadePoints(channel &FMOD_CHANNEL, numpoints &u32, point_dspclock &u64, point_volume &f32) int
fn C.FMOD_ChannelGroup_GetDSPClock(channelgroup &FMOD_CHANNELGROUP, dspclock &u64, parentclock &u64) int
fn C.FMOD_ChannelGroup_SetDelay(channelgroup &FMOD_CHANNELGROUP, dspclock_start u64, dspclock_end u64, stopchannels int) int
fn C.FMOD_ChannelGroup_GetDelay(channelgroup &FMOD_CHANNELGROUP, dspclock_start &u64, dspclock_end &u64, stopchannels &int) int
fn C.FMOD_ChannelGroup_AddFadePoint(channelgroup &FMOD_CHANNELGROUP, dspclock u64, volume f32) int
fn C.FMOD_ChannelGroup_SetFadePointRamp(channelgroup &FMOD_CHANNELGROUP, dspclock u64, volume f32) int
fn C.FMOD_ChannelGroup_RemoveFadePoints(channelgroup &FMOD_CHANNELGROUP, dspclock_start u64, dspclock_end u64) int
fn C.FMOD_ChannelGroup_GetFadePoints(channelgroup &FMOD_CHANNELGROUP, numpoints &u32, point_dspclock &u64, point_volume &f32) int

// DSP effects.
fn C.FMOD_Channel_GetDSP(channel &FMOD_CHANNEL, index int, dsp &voidptr /* FMOD_DSP** */) int
fn C.FMOD_Channel_AddDSP(channel &FMOD_CHANNEL, index int, dsp &FMOD_DSP) int
fn C.FMOD_Channel_RemoveDSP(channel &FMOD_CHANNEL, dsp &FMOD_DSP) int
fn C.FMOD_Channel_GetNumDSPs(channel &FMOD_CHANNEL, numdsps &int) int
fn C.FMOD_Channel_SetDSPIndex(channel &FMOD_CHANNEL, dsp &FMOD_DSP, index int) int
fn C.FMOD_Channel_GetDSPIndex(channel &FMOD_CHANNEL, dsp &FMOD_DSP, index &int) int
fn C.FMOD_ChannelGroup_GetDSP(channelgroup &FMOD_CHANNELGROUP, index int, dsp &voidptr /* FMOD_DSP** */) int
fn C.FMOD_ChannelGroup_AddDSP(channelgroup &FMOD_CHANNELGROUP, index int, dsp &FMOD_DSP) int
fn C.FMOD_ChannelGroup_RemoveDSP(channelgroup &FMOD_CHANNELGROUP, dsp &FMOD_DSP) int
fn C.FMOD_ChannelGroup_GetNumDSPs(channelgroup &FMOD_CHANNELGROUP, numdsps &int) int
fn C.FMOD_ChannelGroup_SetDSPIndex(channelgroup &FMOD_CHANNELGROUP, dsp &FMOD_DSP, index int) int
fn C.FMOD_ChannelGroup_GetDSPIndex(channelgroup &FMOD_CHANNELGROUP, dsp &FMOD_DSP, index &int) int

// 3D functionality.
fn C.FMOD_Channel_Set3DAttributes(channel &FMOD_CHANNEL, pos &int, vel &int) int
fn C.FMOD_Channel_Get3DAttributes(channel &FMOD_CHANNEL, pos &int, vel &int) int
fn C.FMOD_Channel_Set3DMinMaxDistance(channel &FMOD_CHANNEL, mindistance f32, maxdistance f32) int
fn C.FMOD_Channel_Get3DMinMaxDistance(channel &FMOD_CHANNEL, mindistance &f32, maxdistance &f32) int
fn C.FMOD_Channel_Set3DConeSettings(channel &FMOD_CHANNEL, insideconeangle f32, outsideconeangle f32, outsidevolume f32) int
fn C.FMOD_Channel_Get3DConeSettings(channel &FMOD_CHANNEL, insideconeangle &f32, outsideconeangle &f32, outsidevolume &f32) int
fn C.FMOD_Channel_Set3DConeOrientation(channel &FMOD_CHANNEL, orientation &int) int
fn C.FMOD_Channel_Get3DConeOrientation(channel &FMOD_CHANNEL, orientation &int) int
fn C.FMOD_Channel_Set3DCustomRolloff(channel &FMOD_CHANNEL, points &int, numpoints int) int
fn C.FMOD_Channel_Get3DCustomRolloff(channel &FMOD_CHANNEL, points &voidptr /* FMOD_VECTOR** */, numpoints &int) int
fn C.FMOD_Channel_Set3DOcclusion(channel &FMOD_CHANNEL, directocclusion f32, reverbocclusion f32) int
fn C.FMOD_Channel_Get3DOcclusion(channel &FMOD_CHANNEL, directocclusion &f32, reverbocclusion &f32) int
fn C.FMOD_Channel_Set3DSpread(channel &FMOD_CHANNEL, angle f32) int
fn C.FMOD_Channel_Get3DSpread(channel &FMOD_CHANNEL, angle &f32) int
fn C.FMOD_Channel_Set3DLevel(channel &FMOD_CHANNEL, level f32) int
fn C.FMOD_Channel_Get3DLevel(channel &FMOD_CHANNEL, level &f32) int
fn C.FMOD_Channel_Set3DDopplerLevel(channel &FMOD_CHANNEL, level f32) int
fn C.FMOD_Channel_Get3DDopplerLevel(channel &FMOD_CHANNEL, level &f32) int
fn C.FMOD_Channel_Set3DDistanceFilter(channel &FMOD_CHANNEL, custom int, customLevel f32, centerFreq f32) int
fn C.FMOD_Channel_Get3DDistanceFilter(channel &FMOD_CHANNEL, custom &int, customLevel &f32, centerFreq &f32) int
fn C.FMOD_ChannelGroup_Set3DAttributes(channelgroup &FMOD_CHANNELGROUP, pos &int, vel &int) int
fn C.FMOD_ChannelGroup_Get3DAttributes(channelgroup &FMOD_CHANNELGROUP, pos &int, vel &int) int
fn C.FMOD_ChannelGroup_Set3DMinMaxDistance(channelgroup &FMOD_CHANNELGROUP, mindistance f32, maxdistance f32) int
fn C.FMOD_ChannelGroup_Get3DMinMaxDistance(channelgroup &FMOD_CHANNELGROUP, mindistance &f32, maxdistance &f32) int
fn C.FMOD_ChannelGroup_Set3DConeSettings(channelgroup &FMOD_CHANNELGROUP, insideconeangle f32, outsideconeangle f32, outsidevolume f32) int
fn C.FMOD_ChannelGroup_Get3DConeSettings(channelgroup &FMOD_CHANNELGROUP, insideconeangle &f32, outsideconeangle &f32, outsidevolume &f32) int
fn C.FMOD_ChannelGroup_Set3DConeOrientation(channelgroup &FMOD_CHANNELGROUP, orientation &int) int
fn C.FMOD_ChannelGroup_Get3DConeOrientation(channelgroup &FMOD_CHANNELGROUP, orientation &int) int
fn C.FMOD_ChannelGroup_Set3DCustomRolloff(channelgroup &FMOD_CHANNELGROUP, points &int, numpoints int) int
fn C.FMOD_ChannelGroup_Get3DCustomRolloff(channelgroup &FMOD_CHANNELGROUP, points &voidptr /* FMOD_VECTOR** */, numpoints &int) int
fn C.FMOD_ChannelGroup_Set3DOcclusion(channelgroup &FMOD_CHANNELGROUP, directocclusion f32, reverbocclusion f32) int
fn C.FMOD_ChannelGroup_Get3DOcclusion(channelgroup &FMOD_CHANNELGROUP, directocclusion &f32, reverbocclusion &f32) int
fn C.FMOD_ChannelGroup_Set3DSpread(channelgroup &FMOD_CHANNELGROUP, angle f32) int
fn C.FMOD_ChannelGroup_Get3DSpread(channelgroup &FMOD_CHANNELGROUP, angle &f32) int
fn C.FMOD_ChannelGroup_Set3DLevel(channelgroup &FMOD_CHANNELGROUP, level f32) int
fn C.FMOD_ChannelGroup_Get3DLevel(channelgroup &FMOD_CHANNELGROUP, level &f32) int
fn C.FMOD_ChannelGroup_Set3DDopplerLevel(channelgroup &FMOD_CHANNELGROUP, level f32) int
fn C.FMOD_ChannelGroup_Get3DDopplerLevel(channelgroup &FMOD_CHANNELGROUP, level &f32) int
fn C.FMOD_ChannelGroup_Set3DDistanceFilter(channelgroup &FMOD_CHANNELGROUP, custom int, customLevel f32, centerFreq f32) int
fn C.FMOD_ChannelGroup_Get3DDistanceFilter(channelgroup &FMOD_CHANNELGROUP, custom &int, customLevel &f32, centerFreq &f32) int

// Channel specific control functionality.
fn C.FMOD_Channel_SetFrequency(channel &FMOD_CHANNEL, frequency f32) int
fn C.FMOD_Channel_GetFrequency(channel &FMOD_CHANNEL, frequency &f32) int
fn C.FMOD_Channel_SetPriority(channel &FMOD_CHANNEL, priority int) int
fn C.FMOD_Channel_GetPriority(channel &FMOD_CHANNEL, priority &int) int
fn C.FMOD_Channel_SetPosition(channel &FMOD_CHANNEL, position u32, postype int) int
fn C.FMOD_Channel_GetPosition(channel &FMOD_CHANNEL, position &u32, postype int) int
fn C.FMOD_Channel_SetChannelGroup(channel &FMOD_CHANNEL, channelgroup &FMOD_CHANNELGROUP) int
fn C.FMOD_Channel_GetChannelGroup(channel &FMOD_CHANNEL, channelgroup &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_Channel_SetLoopCount(channel &FMOD_CHANNEL, loopcount int) int
fn C.FMOD_Channel_GetLoopCount(channel &FMOD_CHANNEL, loopcount &int) int
fn C.FMOD_Channel_SetLoopPoints(channel &FMOD_CHANNEL, loopstart u32, loopstarttype int, loopend u32, loopendtype int) int
fn C.FMOD_Channel_GetLoopPoints(channel &FMOD_CHANNEL, loopstart &u32, loopstarttype int, loopend &u32, loopendtype int) int

// Information only functions.
fn C.FMOD_Channel_IsVirtual(channel &FMOD_CHANNEL, isvirtual &int) int
fn C.FMOD_Channel_GetCurrentSound(channel &FMOD_CHANNEL, sound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_Channel_GetIndex(channel &FMOD_CHANNEL, index &int) int
fn C.FMOD_ChannelGroup_GetName(channelgroup &FMOD_CHANNELGROUP, name &byte, namelen int) int
fn C.FMOD_ChannelGroup_GetNumChannels(channelgroup &FMOD_CHANNELGROUP, numchannels &int) int
fn C.FMOD_ChannelGroup_GetChannel(channelgroup &FMOD_CHANNELGROUP, index int, channel &voidptr /* FMOD_CHANNEL** */) int
fn C.FMOD_SoundGroup_GetName(soundgroup &FMOD_SOUNDGROUP, name &byte, namelen int) int
fn C.FMOD_SoundGroup_GetNumSounds(soundgroup &FMOD_SOUNDGROUP, numsounds &int) int
fn C.FMOD_SoundGroup_GetSound(soundgroup &FMOD_SOUNDGROUP, index int, sound &voidptr /* FMOD_SOUND** */) int
fn C.FMOD_SoundGroup_GetNumPlaying(soundgroup &FMOD_SOUNDGROUP, numplaying &int) int

// 'ChannelGroup' API
fn C.FMOD_ChannelGroup_GetSystemObject(channelgroup &FMOD_CHANNELGROUP, system &voidptr /* FMOD_SYSTEM** */) int

// Nested channel groups.
fn C.FMOD_ChannelGroup_AddGroup(channelgroup &FMOD_CHANNELGROUP, group &FMOD_CHANNELGROUP, propagatedspclock int, connection &voidptr /* FMOD_DSPCONNECTION** */) int
fn C.FMOD_ChannelGroup_GetNumGroups(channelgroup &FMOD_CHANNELGROUP, numgroups &int) int
fn C.FMOD_ChannelGroup_GetGroup(channelgroup &FMOD_CHANNELGROUP, index int, group &voidptr /* FMOD_CHANNELGROUP** */) int
fn C.FMOD_ChannelGroup_GetParentGroup(channelgroup &FMOD_CHANNELGROUP, group &voidptr /* FMOD_CHANNELGROUP** */) int

// 'SoundGroup' API
fn C.FMOD_SoundGroup_Release(soundgroup &FMOD_SOUNDGROUP) int
fn C.FMOD_SoundGroup_GetSystemObject(soundgroup &FMOD_SOUNDGROUP, system &voidptr /* FMOD_SYSTEM** */) int

// SoundGroup control functions.
fn C.FMOD_SoundGroup_SetMaxAudible(soundgroup &FMOD_SOUNDGROUP, maxaudible int) int
fn C.FMOD_SoundGroup_GetMaxAudible(soundgroup &FMOD_SOUNDGROUP, maxaudible &int) int
fn C.FMOD_SoundGroup_SetMaxAudibleBehavior(soundgroup &FMOD_SOUNDGROUP, behavior int) int
fn C.FMOD_SoundGroup_GetMaxAudibleBehavior(soundgroup &FMOD_SOUNDGROUP, behavior &int) int
fn C.FMOD_SoundGroup_SetMuteFadeSpeed(soundgroup &FMOD_SOUNDGROUP, speed f32) int
fn C.FMOD_SoundGroup_GetMuteFadeSpeed(soundgroup &FMOD_SOUNDGROUP, speed &f32) int
fn C.FMOD_SoundGroup_SetVolume(soundgroup &FMOD_SOUNDGROUP, volume f32) int
fn C.FMOD_SoundGroup_GetVolume(soundgroup &FMOD_SOUNDGROUP, volume &f32) int
fn C.FMOD_SoundGroup_Stop(soundgroup &FMOD_SOUNDGROUP) int

// 'DSP' API
fn C.FMOD_DSP_Release(dsp &FMOD_DSP) int
fn C.FMOD_DSP_GetSystemObject(dsp &FMOD_DSP, system &voidptr /* FMOD_SYSTEM** */) int

// Connection / disconnection / input and output enumeration.
fn C.FMOD_DSP_AddInput(dsp &FMOD_DSP, input &FMOD_DSP, connection &voidptr /* FMOD_DSPCONNECTION** */, typ int) int
fn C.FMOD_DSP_DisconnectFrom(dsp &FMOD_DSP, target &FMOD_DSP, connection &FMOD_DSPCONNECTION) int
fn C.FMOD_DSP_DisconnectAll(dsp &FMOD_DSP, inputs int, outputs int) int
fn C.FMOD_DSP_GetNumInputs(dsp &FMOD_DSP, numinputs &int) int
fn C.FMOD_DSP_GetNumOutputs(dsp &FMOD_DSP, numoutputs &int) int
fn C.FMOD_DSP_GetInput(dsp &FMOD_DSP, index int, input &voidptr /* FMOD_DSP** */, inputconnection &voidptr /* FMOD_DSPCONNECTION** */) int
fn C.FMOD_DSP_GetOutput(dsp &FMOD_DSP, index int, output &voidptr /* FMOD_DSP** */, outputconnection &voidptr /* FMOD_DSPCONNECTION** */) int

// DSP unit control.
fn C.FMOD_DSP_SetActive(dsp &FMOD_DSP, active int) int
fn C.FMOD_DSP_GetActive(dsp &FMOD_DSP, active &int) int
fn C.FMOD_DSP_SetBypass(dsp &FMOD_DSP, bypass int) int
fn C.FMOD_DSP_GetBypass(dsp &FMOD_DSP, bypass &int) int
fn C.FMOD_DSP_SetWetDryMix(dsp &FMOD_DSP, prewet f32, postwet f32, dry f32) int
fn C.FMOD_DSP_GetWetDryMix(dsp &FMOD_DSP, prewet &f32, postwet &f32, dry &f32) int
fn C.FMOD_DSP_SetChannelFormat(dsp &FMOD_DSP, channelmask int, numchannels int, source_speakermode int) int
fn C.FMOD_DSP_GetChannelFormat(dsp &FMOD_DSP, channelmask &int, numchannels &int, source_speakermode &int) int
fn C.FMOD_DSP_GetOutputChannelFormat(dsp &FMOD_DSP, inmask int, inchannels int, inspeakermode int, outmask &int, outchannels &int, outspeakermode &int) int
fn C.FMOD_DSP_Reset(dsp &FMOD_DSP) int

// DSP parameter control.
fn C.FMOD_DSP_SetParameterFloat(dsp &FMOD_DSP, index int, value f32) int
fn C.FMOD_DSP_SetParameterInt(dsp &FMOD_DSP, index int, value int) int
fn C.FMOD_DSP_SetParameterBool(dsp &FMOD_DSP, index int, value int) int
fn C.FMOD_DSP_SetParameterData(dsp &FMOD_DSP, index int, data voidptr, length u32) int
fn C.FMOD_DSP_GetParameterFloat(dsp &FMOD_DSP, index int, value &f32, valuestr &byte, valuestrlen int) int
fn C.FMOD_DSP_GetParameterInt(dsp &FMOD_DSP, index int, value &int, valuestr &byte, valuestrlen int) int
fn C.FMOD_DSP_GetParameterBool(dsp &FMOD_DSP, index int, value &int, valuestr &byte, valuestrlen int) int
fn C.FMOD_DSP_GetParameterData(dsp &FMOD_DSP, index int, data voidptr, length &u32, valuestr &byte, valuestrlen int) int
fn C.FMOD_DSP_GetNumParameters(dsp &FMOD_DSP, numparams &int) int
fn C.FMOD_DSP_GetParameterInfo(dsp &FMOD_DSP, index int, desc &voidptr /* FMOD_DSP_PARAMETER_DESC** */) int
fn C.FMOD_DSP_GetDataParameterIndex(dsp &FMOD_DSP, datatype int, index &int) int
fn C.FMOD_DSP_ShowConfigDialog(dsp &FMOD_DSP, hwnd voidptr, show int) int

// DSP attributes.
fn C.FMOD_DSP_GetInfo(dsp &FMOD_DSP, name &byte, version &u32, channels &int, configwidth &int, configheight &int) int
fn C.FMOD_DSP_GetType(dsp &FMOD_DSP, typ &int) int
fn C.FMOD_DSP_GetIdle(dsp &FMOD_DSP, idle &int) int

// Metering.
fn C.FMOD_DSP_SetMeteringEnabled(dsp &FMOD_DSP, inputEnabled int, outputEnabled int) int
fn C.FMOD_DSP_GetMeteringEnabled(dsp &FMOD_DSP, inputEnabled &int, outputEnabled &int) int
fn C.FMOD_DSP_GetMeteringInfo(dsp &FMOD_DSP, inputInfo &int, outputInfo &int) int
fn C.FMOD_DSP_GetCPUUsage(dsp &FMOD_DSP, exclusive &u32, inclusive &u32) int

// 'DSPConnection' API
fn C.FMOD_DSPConnection_GetInput(dspconnection &FMOD_DSPCONNECTION, input &voidptr /* FMOD_DSP** */) int
fn C.FMOD_DSPConnection_GetOutput(dspconnection &FMOD_DSPCONNECTION, output &voidptr /* FMOD_DSP** */) int
fn C.FMOD_DSPConnection_SetMix(dspconnection &FMOD_DSPCONNECTION, volume f32) int
fn C.FMOD_DSPConnection_GetMix(dspconnection &FMOD_DSPCONNECTION, volume &f32) int
fn C.FMOD_DSPConnection_SetMixMatrix(dspconnection &FMOD_DSPCONNECTION, matrix &f32, outchannels int, inchannels int, inchannel_hop int) int
fn C.FMOD_DSPConnection_GetMixMatrix(dspconnection &FMOD_DSPCONNECTION, matrix &f32, outchannels &int, inchannels &int, inchannel_hop int) int
fn C.FMOD_DSPConnection_GetType(dspconnection &FMOD_DSPCONNECTION, typ &int) int

// 'Geometry' API
// fn C.FMOD_Geometry_Release(geometry &FMOD_GEOMETRY) int

// Polygon manipulation.
// fn C.FMOD_Geometry_AddPolygon(geometry &FMOD_GEOMETRY, directocclusion f32, reverbocclusion f32, doublesided int, numvertices int, vertices &int, polygonindex &int) int
// fn C.FMOD_Geometry_GetNumPolygons(geometry &FMOD_GEOMETRY, numpolygons &int) int
// fn C.FMOD_Geometry_GetMaxPolygons(geometry &FMOD_GEOMETRY, maxpolygons &int, maxvertices &int) int
// fn C.FMOD_Geometry_GetPolygonNumVertices(geometry &FMOD_GEOMETRY, index int, numvertices &int) int
// fn C.FMOD_Geometry_SetPolygonVertex(geometry &FMOD_GEOMETRY, index int, vertexindex int, vertex &int) int
// fn C.FMOD_Geometry_GetPolygonVertex(geometry &FMOD_GEOMETRY, index int, vertexindex int, vertex &int) int
// fn C.FMOD_Geometry_SetPolygonAttributes(geometry &FMOD_GEOMETRY, index int, directocclusion f32, reverbocclusion f32, doublesided int) int
// fn C.FMOD_Geometry_GetPolygonAttributes(geometry &FMOD_GEOMETRY, index int, directocclusion &f32, reverbocclusion &f32, doublesided &int) int

// Object manipulation.
// fn C.FMOD_Geometry_SetActive(geometry &FMOD_GEOMETRY, active int) int
// fn C.FMOD_Geometry_GetActive(geometry &FMOD_GEOMETRY, active &int) int
// fn C.FMOD_Geometry_SetRotation(geometry &FMOD_GEOMETRY, forward &int, up &int) int
// fn C.FMOD_Geometry_GetRotation(geometry &FMOD_GEOMETRY, forward &int, up &int) int
// fn C.FMOD_Geometry_SetPosition(geometry &FMOD_GEOMETRY, position &int) int
// fn C.FMOD_Geometry_GetPosition(geometry &FMOD_GEOMETRY, position &int) int
// fn C.FMOD_Geometry_SetScale(geometry &FMOD_GEOMETRY, scale &int) int
// fn C.FMOD_Geometry_GetScale(geometry &FMOD_GEOMETRY, scale &int) int
// fn C.FMOD_Geometry_Save(geometry &FMOD_GEOMETRY, data voidptr, datasize &int) int

// 'Reverb3D' API
fn C.FMOD_Reverb3D_Release(reverb3d &FMOD_REVERB3D) int

// Reverb manipulation.
fn C.FMOD_Reverb3D_Set3DAttributes(reverb3d &FMOD_REVERB3D, position &int, mindistance f32, maxdistance f32) int
fn C.FMOD_Reverb3D_Get3DAttributes(reverb3d &FMOD_REVERB3D, position &int, mindistance &f32, maxdistance &f32) int
fn C.FMOD_Reverb3D_SetProperties(reverb3d &FMOD_REVERB3D, properties &int) int
fn C.FMOD_Reverb3D_GetProperties(reverb3d &FMOD_REVERB3D, properties &int) int
fn C.FMOD_Reverb3D_SetActive(reverb3d &FMOD_REVERB3D, active int) int
fn C.FMOD_Reverb3D_GetActive(reverb3d &FMOD_REVERB3D, active &int) int

