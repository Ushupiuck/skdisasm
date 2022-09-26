LockOnROM_Start:
		binclude "Lockon S3/Header.bin"
		even

SSMagic_TestLoc_200114		EQU LockOnROM_Start+$114
SSMagic_TestLoc_20011A		EQU LockOnROM_Start+$11A
LockonDate			EQU LockOnROM_Start+$11C
SSMagic_TestLoc_200150		EQU LockOnROM_Start+$150
LockonSerialNumber		EQU LockOnROM_Start+$180
SSMagic_TestLoc_2001A4		EQU LockOnROM_Start+$1A4

; Music data placed here
	;org $2C8000
	;org $2F8000