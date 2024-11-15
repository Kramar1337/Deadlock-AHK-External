PatternVar1 := "48 8B 0D ? ? ? ? 8B C5 48 C1 E8"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x3
offset2 := 0x7
dwEntityList := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 63 C2 48 8D 0D ? ? ? ? 48 C1 E0"
aPattern := ConvertBytesStringToArray(PatternVar1)
gameDLL := "client.dll"
offset1 := 0x6
offset2 := 0xA
dwViewMatrix := FindAndCalculateAddress(aPattern, gameDLL, offset1, offset2)

PatternVar1 := "48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF"
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

PatternVar1 := "48 8B 05 ? ? ? ? 44 3B 40"
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

dwGameEntitySystem_highestEntityIndex = 0x1530
