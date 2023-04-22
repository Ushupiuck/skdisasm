; ---------------------------------------------------------------------------

ALZ_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

BPZ_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DPZ_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

CGZ_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

EMZ_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionActual).l
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

ALZ_BackgroundEvent:
;		jsr	ALZ_Deformation(pc)
;		lea	ALZ_BGDeformArray(pc),a4
;		bra.s	loc_23A764
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

BPZ_BackgroundEvent:
;		jsr	BPZ_Deformation(pc)
;		lea	BPZ_BGDeformArray(pc),a4
;		bra.s	loc_23A764
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

CGZ_BackgroundEvent:
;		jsr	CGZ_Deformation(pc)
;		lea	CGZ_BGDeformArray(pc),a4
;		bra.s	loc_23A764
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

EMZ_BackgroundEvent:
;		jsr	EMZ_Deformation(pc)
;		lea	EMZ_BGDeformArray(pc),a4
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DPZ_BackgroundEvent:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

BPZ_Deformation:
		rts
; ---------------------------------------------------------------------------

DPZ_Deformation:
		rts
; ---------------------------------------------------------------------------

CGZ_Deformation:
		rts
; ---------------------------------------------------------------------------

EMZ_Deformation:
		rts
; ---------------------------------------------------------------------------
ALZ_BGDeformArray:
		dc.w  $18,   8,   8,   8,   8,   8, $2E,   6,  $D,$803F,$7FFF
BPZ_BGDeformArray:
		dc.w  $88, $16,  $A, $28, $10,   8,$7FFF
CGZ_BGDeformArray:
		dc.w  $50,   8, $10, $10,$7FFF
EMZ_BGDeformArray:
		dc.w  $10, $10, $10, $10,   8,  $C, $24, $38, $20,$7FFF
; ---------------------------------------------------------------------------

MGZ1_Deform:
		move.w	(Screen_shake_offset).w,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#2,d0
		move.l	d0,d1
		asr.l	#4,d1
		lea	(HScroll_table+$01C).w,a1
		moveq	#8,d2

loc_23C98A:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_23C98A
		lea	(HScroll_table).w,a1
		move.l	(HScroll_table+$01C).w,d2
		addi.l	#$500,(HScroll_table+$01C).w
		asr.l	#1,d0
		moveq	#4,d3

loc_23C9AA:
		add.l	d2,d0
		addi.l	#$500,d2
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_23C9AA
		move.w	-2(a1),d0
		move.w	-4(a1),-2(a1)
		move.w	d0,-4(a1)
		rts
; ---------------------------------------------------------------------------
MGZ1_BGDeformArray:
		dc.w $10, 4, 4, 8, 8, 8, $D, $13, 8, 8, 8, 8, $18, $7FFF
MGZ2_QuakeEventArray:
		dc.w   $780,  $7C0,  $580,  $600,  $5A0,  $7E0  ; Player X boundaries, Player Y boundaries, Level size reset val
		dc.w  $31C0, $3200,  $1C0,  $280,  $1E0, $2F60
		dc.w  $3440, $3480,  $680,  $700,  $6A0, $32C0
MGZ2_ChunkEventArray:
		dc.w   $F68,  $F78,  $500,  $580,  $F00,  $500  ; Player X boundaries, Player Y boundaries, Screen redraw area
		dc.w  $3680, $3700,  $2F0,  $380, $3700,  $280
		dc.w  $3000, $3080,  $770,  $800, $3080,  $700
MGZ2_ScreenRedrawArray:
		dc.w   $40,    3
		dc.w   $50,    3
		dc.w   $50,    4
		dc.w   $60,    4
		dc.w   $60,    3
		dc.w   $70,    2
		dc.w   $70,    3
		dc.w   $80,    3
		dc.w   $80,    3
		dc.w   $80,    4
		dc.w   $80,    4
		dc.w   $80,    4
		dc.w   $80,    5
		dc.w   $90,    5
		dc.w   $A0,    4
		dc.w   $90,    6
		dc.w   $80,    6
		dc.w   $90,    6
		dc.w   $A0,    5
		dc.w   $B0,    4
		dc.w   $C0,    3
		dc.w   $D0,    2
		dc.w   $E0,    1
MGZ2_ChunkReplaceArray:
		dc.w  $100, $500
		dc.w  $180, $580
		dc.w  $200, $600
		dc.w  $280, $680
		dc.w  $300, $700
		dc.w  $380, $780
		dc.w     0, $800
		dc.w     0, $880
		dc.w     0, $900
		dc.w     0, $980
		dc.w     0, $A00
		dc.w     0, $A80
		dc.w     0, $B00
		dc.w     0, $B80
		dc.w     0, $C00
		dc.w     0, $C80
		dc.w     0, $D00
		dc.w     0, $D80
		dc.w     0, $E00
		dc.w     0, $E80
		dc.w     0, $F00
		dc.w     0, $F80
		dc.w     0,$1000
		dc.w   $80, $480
MGZ2_CollapseScrollDelay:
		dc.w    $A,  $10,    2,    8,   $E,    6,    0,   $C,  $12,    4
MGZ2_FGVScrollArray:
		dc.w $3CA0,  $20,  $20,  $20,  $20,  $20,  $20,  $20,  $20,$7FFF
; ---------------------------------------------------------------------------

MGZ2_BGDeform:
		move.w	(Events_bg+$00).w,d0
		jmp	loc_23D1D8(pc,d0.w)
; ---------------------------------------------------------------------------

loc_23D1D8:
		bra.w	loc_23D21E	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_23D1F4	; 4 - Knuckles BG move event
; ---------------------------------------------------------------------------
		bra.w	loc_23D1EA	; 8 - Sonic BG move event
; ---------------------------------------------------------------------------
		move.w	#$500,d1	; C - After BG move event
		bra.s	loc_23D220
; ---------------------------------------------------------------------------

loc_23D1EA:
		move.w	#$8F0,d1
		move.w	#$3200,d2
		bra.s	loc_23D1FC
; ---------------------------------------------------------------------------

loc_23D1F4:
		move.w	#$1E0,d1
		move.w	#$3580,d2

loc_23D1FC:
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	d1,d0
		add.w	(Events_bg+$02).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is offset, but otherwise matched in ratio during the special BG events
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	d2,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(HScroll_table+$004).w
		move.w	d0,(HScroll_table+$036).w
		bra.s	loc_23D24C
; ---------------------------------------------------------------------------

loc_23D21E:
		moveq	#0,d1

loc_23D220:
		move.w	(Camera_Y_pos_copy).w,d0		; Get BG Y camera
		move.w	(Screen_shake_offset).w,d2		; Get screen shake offset
		sub.w	d2,d0
		sub.w	d1,d0					; Subtract from that and the special offset for MGZ2 events
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is normal 3/16ths normal BG Y during normal play
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(HScroll_table+$004).w
		clr.w	(HScroll_table+$036).w

loc_23D24C:
		move.w	(Camera_X_pos_copy).w,d0
		cmpi.w	#8,(Events_routine_fg).w
		bne.s	loc_23D25C
		move.w	(Events_bg+$0C).w,d0		; If playing on the boss, use the special camera scrolling set by MGZ2's screen event

loc_23D25C:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		move.l	d1,d2
		asr.l	#2,d2
		lea	(HScroll_table+$036).w,a1
		moveq	#7,d3

loc_23D270:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d3,loc_23D270
		tst.w	(Events_bg+$0E).w			; If EEE0 is set, don't bother moving the clouds automatically
		bne.s	loc_23D28A
		addi.l	#$800,(HScroll_table+$038).w

loc_23D28A:
		move.l	(HScroll_table+$038).w,d1
		lea	(HScroll_table+$008).w,a1
		lea	MGZ2_BGDeformIndex(pc),a5
		move.l	d2,d0
		asr.l	#1,d2
		moveq	#$E,d3

loc_23D29C:
		move.w	(a5)+,d4
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1,d4.w)
		swap	d0
		add.l	d2,d0
		dbf	d3,loc_23D29C
		lea	MGZ2_BGDeformOffset(pc),a5
		moveq	#$16,d0

loc_23D2B4:
		move.w	(a5)+,d1
		add.w	d1,(a1)+
		dbf	d0,loc_23D2B4
		rts
; ---------------------------------------------------------------------------
MGZ2_BGDrawArray:
		dc.w $200, $7FFF
MGZ2_BGDeformArray:
		dc.w $10, $10, $10, $10, $10, $18, 8, $10, 8, 8, $10, 8
		dc.w 8, 8, 5, $2B, $C, 6, 6, 8, 8, $18, $D8, $7FFF
MGZ2_BGDeformIndex:
		dc.w  $1C, $18, $1A,  $C,   6, $14,   2, $10, $16, $12,  $A,   0,   8,   4,  $E
MGZ2_BGDeformOffset:
		dc.w   -5,  -8,   9,  $A,   2, -$C,   3, $10,  -1,  $D, -$F,   6, -$B,  -4,  $E
		dc.w   -8, $10,   8,   0,  -8, $10,   8,   0
; ---------------------------------------------------------------------------

ICZ1_SetIntroPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23DE92
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_23DE96

loc_23DE92:
		lea	(Target_palette_line_4+2).w,a1

sub_23DE96:
		move.l	#$EEE0EEC,(a1)+
		move.l	#$EEA0ECA,(a1)+
		move.l	#$EC80EA6,(a1)+
		move.l	#$E860E64,(a1)+
		move.l	#$E400E00,(a1)+
		move.l	#$C000000,(a1)+
		move.l	#$AEC0CEA,(a1)+
		move.w	#$E80,(a1)
		rts
; ---------------------------------------------------------------------------

ICZ1_SetIndoorPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23DED2
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_23DED6

loc_23DED2:
		lea	(Target_palette_line_4+2).w,a1

sub_23DED6:
		move.l	#$EC00E40,(a1)+
		move.l	#$E040C00,(a1)+
		move.l	#$6000200,(a1)+
		move.l	#$E64,(a1)+
		move.l	#$E240A02,(a1)+
		move.w	#$402,(a1)
		rts
; ---------------------------------------------------------------------------
ICZ1_IntroBGDeformArray:
		dc.w $44, $C, $B, $D, $18, $50, 2, 6, 8, $10, $18, $20, $28, $7FFF
; ---------------------------------------------------------------------------

ICZ2_OutDeform:
		clr.w	(Camera_Y_pos_BG_copy).w		; Effective Y is always 0
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		andi.l	#$7FFFFF,d0
		move.l	d0,d1
		asr.l	#6,d1
		lea	(HScroll_table+$064).w,a1
		moveq	#$27,d2

loc_23E0E8:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_23E0E8
		lea	(HScroll_table).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d0,d1
		move.l	d1,$64(a1)
		asr.l	#2,d0
		move.l	d0,d1
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1)+
		move.w	(Level_frame_counter).w,d1
		lsr.w	#2,d1
		andi.w	#$3E,d1
		lea	(AIZ2_ALZ_BGDeformDelta).l,a5
		adda.w	d1,a5
		moveq	#7,d1

loc_23E12E:
		move.w	(a5)+,d2
		add.w	d0,d2
		move.w	d2,(a1)+
		dbf	d1,loc_23E12E
		rts
; ---------------------------------------------------------------------------

ICZ2_InDeform:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$700,d0
		asr.w	#2,d0
		addi.w	#$118,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(HScroll_table).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,8(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		rts
; ---------------------------------------------------------------------------

ICZ2_SetOutdoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E1B6
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_23E1BA

loc_23E1B6:
		lea	(Target_palette_line_4+2).w,a1

sub_23E1BA:
		move.l	#$EEE0EEA,(a1)+
		move.l	#$EC80EA4,(a1)+
		move.l	#$C820C60,(a1)+
		move.l	#$C400E20,(a1)+
		move.l	#$A000E00,(a1)
		rts
; ---------------------------------------------------------------------------

ICZ2_SetIndoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E1E6
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_23E1EA

loc_23E1E6:
		lea	(Target_palette_line_4+2).w,a1

sub_23E1EA:
		move.l	#$EE20E24,(a1)+
		move.l	#$E040E02,(a1)+
		move.l	#$4020200,(a1)+
		move.l	#$E20,(a1)+
		move.l	#$E400840,(a1)+
		move.w	#$600,(a1)
		rts
; ---------------------------------------------------------------------------

ICZ2_SetICZ1Pal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E21A
		lea	(Normal_palette_line_4+2).w,a1
		bsr.s	sub_23E21E

loc_23E21A:
		lea	(Target_palette_line_4+2).w,a1

sub_23E21E:
		move.l	#$EEC0CC6,(a1)+
		move.l	#$C800C60,(a1)+
		move.l	#$C400A40,(a1)+
		move.l	#$8200620,(a1)+
		move.l	#$2000600,(a1)
		rts
; ---------------------------------------------------------------------------
ICZ2_OutBGDeformArray:
		dc.w $5A, $26, $8030, $7FFF
ICZ2_InBGDeformArray:
		dc.w $1A0, $40, $20, $18, $40, 8, 8, $18, $7FFF
; ---------------------------------------------------------------------------

LBZ1_CheckLayoutMod:
		lea	LBZ1_LayoutModRange(pc),a1
		moveq	#3,d3

loc_23E45E:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		bcs.s	loc_23E480
		cmp.w	(a5)+,d0
		bhi.s	loc_23E480
		cmp.w	(a5)+,d1
		bcs.s	loc_23E480
		cmp.w	(a5)+,d1
		bhi.s	loc_23E480
		tst.w	d2
		bne.s	loc_23E48A
		cmpi.w	#$1580,d0		; The first layout mod range ignores a small corner on the lower right.
		bcs.s	loc_23E48A
		cmpi.w	#$400,d1
		bcs.s	loc_23E48A

loc_23E480:
		addq.w	#8,a1
		addq.w	#4,d2
		dbf	d3,loc_23E45E
		rts
; ---------------------------------------------------------------------------

loc_23E48A:
		addq.w	#4,d2
		move.w	d2,(Events_bg+$00).w
		lsr.w	#1,d2
		jmp	LBZ1_LayoutModBranch-2(pc,d2.w)
; ---------------------------------------------------------------------------

LBZ1_LayoutModBranch:
		bra.s	LBZ1_LayoutMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod4
; ---------------------------------------------------------------------------

LBZ1_LayoutMod1:
		movea.w (a3),a5
		lea	$80(a5),a5
		bra.w	LBZ1_DoMod1
; ---------------------------------------------------------------------------

LBZ1_LayoutMod2:
		movea.w $24(a3),a5
		lea	$80(a5),a5
		bra.s	LBZ1_DoMod2
; ---------------------------------------------------------------------------

LBZ1_LayoutMod3:
		tst.w	(Events_bg+$02).w
		beq.s	loc_23E4C0
		clr.w	(Events_bg+$00).w
		moveq	#-1,d3
		rts
; ---------------------------------------------------------------------------

loc_23E4C0:
		movea.w (a3),a5
		lea	$94(a5),a5
		bra.s	LBZ1_DoMod3
; ---------------------------------------------------------------------------

LBZ1_LayoutMod4:
		movea.w $30(a3),a5
		lea	$94(a5),a5

LBZ1_DoMod4:
		movea.w (a3),a1
		lea	$7A(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#5,d1

loc_23E4DE:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E4DE
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod3:
		movea.w (a3),a1
		lea	$74(a1),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$B,d1

loc_23E4FA:
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E4FA
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod2:
		movea.w (a3),a1
		lea	$42(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#$D,d1

loc_23E516:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E516
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod1:
		movea.w 8(a3),a1
		lea	$26(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#8,d1

loc_23E536:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E536
		rts
; ---------------------------------------------------------------------------
LBZ1_FGVScrollArray:
		dc.w $3B60, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $7FFF
LBZ1_LayoutModRange:
		dc.w $13E0,$16A0, $100, $580
		dc.w $2160,$2520,    0, $700
		dc.w $3A60,$3BA0,    0, $600
		dc.w $3DE0,$3FA0,    0, $300
LBZ1_LayoutModExitRange:
		dc.w $1376,$170A
		dc.w $20F6,$258A
		dc.w $39F6,$3C0A
		dc.w $3D76,$400A
LBZ1_CollapseScrollSpeed:
		dc.w  $1EE, $1F2,  $C7, $1B3, $1B7, $198,   $E, $139
; ---------------------------------------------------------------------------

LBZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Screen_shake_offset).w,d1
		sub.w	d1,d0
		asr.w	#4,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d0
		swap	d0
		move.w	d0,(Events_bg+$10).w
		swap	d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		move.w	d1,(HScroll_table).w
		move.w	d1,(HScroll_table+$008).w
		swap	d1
		lea	(HScroll_table+$00A).w,a1
		add.l	d0,d1
		add.l	d0,d1
		asr.l	#2,d0
		moveq	#3,d2

loc_23E79A:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d0,d1
		dbf	d2,loc_23E79A
		moveq	#$A,d0
		add.w	d0,(Events_bg+$10).w
		add.w	d0,(Camera_X_pos_BG_copy).w
		add.w	d0,(HScroll_table).w
		add.w	d0,(HScroll_table+$008).w
		lea	(HScroll_table+$00A).w,a1
		addq.w	#4,(a1)+
		subq.w	#2,(a1)+
		addq.w	#7,(a1)
		rts
; ---------------------------------------------------------------------------
LBZ2_BGDeformArray:
		dc.w $C0, $40, $38, $18, $28, $10, $10, $10, $18, $40, $20, $10, $20
		dc.w $70, $30, $80E0, $20, $7FFF
LBZ2_DEBGDeformArray:
		dc.w $38, $18, $28, $10, $10, $10, $18, $40, $38, $18, $28, $10, $10
		dc.w $10, $18, $40, $20, $10, $20, $70, $60, $10, $805F, $7FFF
LBZ2_CloudDeformArray:
		dc.w  $16,  $E,  $A, $14,  $C,   6, $18, $10, $12,   2,   8,   4,   0
LBZ2_BGUWDeformRange:
		dc.w    7,   1,   3,   1,   7
; ---------------------------------------------------------------------------

Gumball_ScreenInit:
		move.w	#$3FF,(Screen_Y_wrap_value).w
		move.w	#$3F0,(Camera_Y_pos_mask).w
		move.w	#$1C,(Layout_row_index_mask).w
		move.w	#4,(Special_V_int_routine).w
		move.w	#$C0,d0
		move.w	d0,d1
		jsr	Gumball_VScroll(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		move.w	d2,(HScroll_table+$002).w
		move.w	d2,(HScroll_table+$00A).w
		move.w	(HScroll_table+$00E).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(HScroll_table+$006).w
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table).w,a5
		move.w	(Camera_X_pos_rounded).w,d0
		jmp	(Refresh_PlaneDirectVScroll).l
; ---------------------------------------------------------------------------

Gumball_ScreenEvent:
		jsr	Gumball_SetUpVScroll(pc)
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table).w,a5
		moveq	#$F,d6
		moveq	#3,d5
		jmp	(DrawTilesVDeform).l
; ---------------------------------------------------------------------------

Gumball_SetUpVScroll:
		move.w	(Camera_Y_pos_copy).w,d0
		movea.w (_unkFAA4).w,a5
		move.w	$14(a5),d1
		subi.w	#$C8,d1
		sub.w	d0,d1
		neg.w	d1

Gumball_VScroll:
		lea	(HScroll_table).w,a1
		move.w	d0,(a1)
		move.w	d0,8(a1)
		move.w	d0,$C(a1)
		move.w	d0,$10(a1)
		move.w	d1,4(a1)
		move.w	d1,$E(a1)
		rts
; ---------------------------------------------------------------------------
Gumball_VScrollArray:
		dc.w $C0, $80, $7FFF
; ---------------------------------------------------------------------------

Gumball_BackgroundInit:
		jsr	Gumball_Deform(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

Gumball_BackgroundEvent:
		jsr	Gumball_Deform(pc)
		jsr	(PlainDeformation).l
		lea	Gumball_VScrollArray(pc),a4
		lea	(HScroll_table+$00A).w,a5
		jmp	(Apply_FGVScroll).l
; ---------------------------------------------------------------------------

Gumball_Deform:
		move.w	#$FFE0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		asr.w	#1,d0
		move.w	d0,(Events_bg+$10).w
		rts
; ---------------------------------------------------------------------------
