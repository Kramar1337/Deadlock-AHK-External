PatternVar1 := "48 8B 0D ? ? ? ? 48 89 7C 24 ? 8B FA C1 EB"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwEntityList := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 8D ? ? ? ? ? 48 C1 E0 06 48 03 C1 C3"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwViewMatrix := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 8B 1D ? ? ? ? 48 8B 6C 24"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwLocalPlayerPawn := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 8D 3D ? ? ? ? 8B D9"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
CCameraManager := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 89 15 ? ? ? ? 48 89 42"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwGlobalVars := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 89 1d ? ? ? ? ff 15 ? ? ? ? 84 c0"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwGameRules := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)


dwGameEntitySystem_highestEntityIndex = 0x20F0

