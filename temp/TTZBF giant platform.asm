; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 3 & Knuckles format
; --------------------------------------------------------------------------------

SME_JY2q1:	
		dc.w SME_JY2q1_4-SME_JY2q1, SME_JY2q1_1E-SME_JY2q1	
SME_JY2q1_4:	dc.w 4
		dc.b $E0, $D, 0, 0, $FF, $F8
		dc.b $F0, $F, 0, 8, $FF, $F8
		dc.b $E0, $D, 8, 0, 0,   $18
		dc.b $F0, $F, 8, 8, 0,   $18
SME_JY2q1_1E:	dc.w 4
		dc.b $E0, $D, 0, $18, 0, 0
		dc.b $E0, $D, 8, $18, 0, $20
		dc.b $F0, $F, 0, 8,   0, 0
		dc.b $F0, $F, 8, 8,   0, $20
		even