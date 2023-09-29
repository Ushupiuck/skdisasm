; ---------------------------------------------------------------------------
byte_1ED1A:	dc.b $14
		dc.b $28
		dc.b $20
		dc.b 0
		dc.b $24
		dc.b $48
		dc.b $30
		dc.b 1
		dc.b $34
		dc.b $68
		dc.b $40
		dc.b 2
; ---------------------------------------------------------------------------

Obj_HCZBreakableBar:
		move.l	#Map_HCZBreakableBar,mappings(a0)
		move.w	#$43CA,art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		moveq	#0,d0
		move.b	$2C(a0),d0	; subtype?
		move.w	d0,d1
		andi.b	#$F,d0
		mulu.w	#$3C,d0
		move.w	d0,$30(a0)
		andi.w	#$30,d1
		lsr.w	#2,d1
		lea	byte_1ED1A(pc,d1.w),a1
		tst.b	$2C(a0)
		bpl.s	loc_1ED8E
		moveq	#0,d0
		move.b	(a1)+,d0
		move.w	d0,$36(a0)
		move.b	(a1)+,d0
		move.w	d0,$38(a0)
		move.b	(a1)+,width_pixels(a0)
		move.b	#4,height_pixels(a0)
		move.b	(a1)+,d0
		addq.b	#4,d0
		move.b	d0,mapping_frame(a0)
		move.l	#loc_1EF64,(a0)
		bra.w	loc_1EF64
; ---------------------------------------------------------------------------

loc_1ED8E:
		moveq	#0,d0
		move.b	(a1)+,d0
		move.w	d0,$36(a0)
		move.b	(a1)+,d0
		move.w	d0,$38(a0)
		move.b	#4,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.l	#loc_1EDB0,(a0)

loc_1EDB0:
		lea	$32(a0),a2
		tst.w	$30(a0)
		beq.s	loc_1EDC6
		tst.w	(a2)
		beq.s	loc_1EDC6
		subq.w	#1,$30(a0)
		beq.w	loc_1EEEC

loc_1EDC6:
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d1
		moveq	#0,d2
		bsr.s	sub_1EDEC
		addq.w	#1,a2
		lea	(Player_2).w,a1
		move.w	(Ctrl_2).w,d1
		moveq	#1,d2
		bsr.s	sub_1EDEC
		tst.b	$3A(a0)
		bne.w	loc_1EEEC
		bra.w	Sprite_OnScreen_Test

; =============== S U B R O U T I N E =======================================


sub_1EDEC:
		tst.b	(a2)
		beq.s	loc_1EE4E
		move.w	y_pos(a0),d0
		sub.w	$36(a0),d0
		btst	#8,d1
		beq.s	loc_1EE0C
		subq.w	#1,y_pos(a1)
		cmp.w	y_pos(a1),d0
		blo.s	loc_1EE0C
		move.w	d0,y_pos(a1)

loc_1EE0C:
		add.w	$38(a0),d0
		btst	#9,d1
		beq.s	loc_1EE24
		addq.w	#1,y_pos(a1)
		cmp.w	y_pos(a1),d0
		bhs.s	loc_1EE24
		move.w	d0,y_pos(a1)

loc_1EE24:
		andi.w	#$70,d1
		beq.w	locret_1EEEA
		clr.b	(a2)
		move.b	#$3C,2(a2)
		bclr	d2,(_unkF7C7).w
		andi.b	#-2,$2E(a1)
		btst	#6,$2C(a0)
		bne.s	locret_1EE4C
		move.b	#1,$3A(a0)

locret_1EE4C:
		rts
; ---------------------------------------------------------------------------

loc_1EE4E:
		tst.b	2(a2)
		beq.s	loc_1EE5A
		subq.b	#1,2(a2)
		rts
; ---------------------------------------------------------------------------

loc_1EE5A:
		moveq	#0,d1
		move.b	height_pixels(a0),d1
		move.w	y_pos(a0),d0
		sub.w	d1,d0
		move.w	y_pos(a1),d2
		cmp.w	d0,d2
		blo.s	locret_1EEEA
		add.w	d1,d0
		add.w	d1,d0
		cmp.w	d0,d2
		bhs.s	locret_1EEEA
		move.w	x_pos(a0),d0
		addi.w	#$14,d0
		cmp.w	x_pos(a1),d0
		bhs.s	locret_1EEEA
		addi.w	#$10,d0
		cmp.w	x_pos(a1),d0
		blo.s	locret_1EEEA
		cmpi.b	#4,routine(a1)
		bhs.s	locret_1EEEA
		tst.b	$2E(a1)
		bne.s	locret_1EEEA
		move.w	y_pos(a0),d0
		sub.w	$36(a0),d0
		cmp.w	y_pos(a1),d0
		blo.s	loc_1EEAE
		move.w	d0,y_pos(a1)

loc_1EEAE:
		add.w	$38(a0),d0
		cmp.w	y_pos(a1),d0
		bhs.s	loc_1EEBC
		move.w	d0,y_pos(a1)

loc_1EEBC:
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		move.w	x_pos(a0),d0
		addi.w	#$14,d0
		move.w	d0,x_pos(a1)
		bclr	#0,$2A(a1)
		move.b	#$11,anim(a1)
		move.b	#1,$2E(a1)	; object_control?
		bset	d2,(_unkF7C7).w
		move.b	#1,(a2)

locret_1EEEA:
		rts
; End of function sub_1EDEC

; ---------------------------------------------------------------------------

loc_1EEEC:
		tst.b	$32(a0)
		beq.s	loc_1EEF8
		andi.b	#$FE,(Player_1+object_control).w

loc_1EEF8:
		tst.b	$33(a0)
		beq.s	loc_1EF04
		andi.b	#$FE,(Player_2+object_control).w

loc_1EF04:
		clr.b	(_unkF7C7).w
		clr.w	$32(a0)
		move.l	#loc_1EF3E,(a0)
		move.b	#3,mapping_frame(a0)
		move.w	#$400,x_vel(a0)
		move.w	#0,y_vel(a0)
		lea	(word_1F108).l,a4
		lea	(byte_1F0F0).l,a2
		moveq	#0,d1
		move.b	height_pixels(a0),d1
		lsr.w	#2,d1
		subq.w	#1,d1
		bsr.w	sub_1F188

loc_1EF3E:
		tst.b	$3F(a0)
		beq.s	loc_1EF4A
		subq.b	#1,$3F(a0)
		bra.s	loc_1EF56
; ---------------------------------------------------------------------------

loc_1EF4A:
		jsr	(ObjectMove).l
		addi.w	#8,y_vel(a0)

loc_1EF56:
		tst.b	4(a0)
		bpl.w	loc_1EBAA
		jmp	(Draw_Sprite).l
; ---------------------------------------------------------------------------

loc_1EF64:
		lea	$32(a0),a2
		tst.w	$30(a0)
		beq.s	loc_1EF7A
		tst.w	(a2)
		beq.s	loc_1EF7A
		subq.w	#1,$30(a0)
		beq.w	loc_1F09A

loc_1EF7A:
		lea	(Player_1).w,a1
		move.w	(Ctrl_1).w,d1
		moveq	#0,d2
		bsr.s	sub_1EFA0
		addq.w	#1,a2
		lea	(Player_2).w,a1
		move.w	(Ctrl_2).w,d1
		moveq	#1,d2
		bsr.s	sub_1EFA0
		tst.b	$3A(a0)
		bne.w	loc_1F09A
		bra.w	Sprite_OnScreen_Test

; =============== S U B R O U T I N E =======================================


sub_1EFA0:
		tst.b	(a2)
		beq.s	loc_1F002
		move.w	x_pos(a0),d0
		sub.w	$36(a0),d0
		btst	#$A,d1
		beq.s	loc_1EFC0
		subq.w	#1,x_pos(a1)
		cmp.w	x_pos(a1),d0
		blo.s	loc_1EFC0
		move.w	d0,x_pos(a1)

loc_1EFC0:
		add.w	$38(a0),d0
		btst	#$B,d1
		beq.s	loc_1EFD8
		addq.w	#1,x_pos(a1)
		cmp.w	x_pos(a1),d0
		bhs.s	loc_1EFD8
		move.w	d0,x_pos(a1)

loc_1EFD8:
		andi.w	#$70,d1
		beq.w	locret_1F098
		clr.b	(a2)
		move.b	#$3C,2(a2)
		bclr	d2,(_unkF7C7).w
		andi.b	#$FE,$2E(a1)	; object_control?
		btst	#6,$2C(a0)	; either subtype or air_left
		bne.s	locret_1F000
		move.b	#1,$3A(a0)

locret_1F000:
		rts
; ---------------------------------------------------------------------------

loc_1F002:
		tst.b	2(a2)
		beq.s	loc_1F00E
		subq.b	#1,2(a2)
		rts
; ---------------------------------------------------------------------------

loc_1F00E:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		move.w	x_pos(a0),d0
		sub.w	d1,d0
		move.w	x_pos(a1),d2
		cmp.w	d0,d2
		blo.s	locret_1F098
		add.w	d1,d0
		add.w	d1,d0
		cmp.w	d0,d2
		bhs.s	locret_1F098
		move.w	y_pos(a0),d0
		subi.w	#$14,d0
		cmp.w	y_pos(a1),d0
		bhs.s	locret_1F098
		addi.w	#$10,d0
		cmp.w	y_pos(a1),d0
		blo.s	locret_1F098
		cmpi.b	#4,routine(a1)
		bhs.s	locret_1F098
		tst.b	$2E(a1)	; object_control?
		bne.s	locret_1F098
		move.w	x_pos(a0),d0
		sub.w	$36(a0),d0
		cmp.w	x_pos(a1),d0
		blo.s	loc_1F062
		move.w	d0,x_pos(a1)

loc_1F062:
		add.w	$38(a0),d0
		cmp.w	x_pos(a1),d0
		bhs.s	loc_1F070
		move.w	d0,x_pos(a1)

loc_1F070:
		clr.w	x_vel(a1)
		clr.w	y_vel(a1)
		move.w	y_pos(a0),d0
		subi.w	#$14,d0
		move.w	d0,y_pos(a1)
		move.b	#$14,anim(a1)
		move.b	#1,$2E(a1)	; object_control?
		bset	d2,(_unkF7C7).w
		move.b	#1,(a2)

locret_1F098:
		rts
; End of function sub_1EFA0

; ---------------------------------------------------------------------------

loc_1F09A:
		tst.b	$32(a0)
		beq.s	loc_1F0A6
		andi.b	#$FE,(Player_1+object_control).w

loc_1F0A6:
		tst.b	$33(a0)
		beq.s	loc_1F0B2
		andi.b	#$FE,(Player_2+object_control).w

loc_1F0B2:
		clr.b	(_unkF7C7).w
		clr.w	$32(a0)	; move_lock?
		move.l	#loc_1EF3E,(a0)
		move.b	#7,mapping_frame(a0)
		move.w	#0,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		lea	(word_1F148).l,a4
		lea	(byte_1F0F0).l,a2
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		lsr.w	#2,d1
		subq.w	#1,d1
		bsr.w	sub_1F188
		bra.w	loc_1EF3E
; ---------------------------------------------------------------------------
byte_1F0F0:	dc.b    7,   5,   2,   0,   1,   3,   4,   6,   7,   5,   2,   0,   1,   3,   4,   6,   8,   9,  $A,  $B
		dc.b   $C,  $D,  $E,  $F
word_1F108:	dc.w      0, $FFE4
		dc.w      0, $FFEC
		dc.w      0, $FFF4
		dc.w      0, $FFFC
		dc.w      0,     4
		dc.w      0,    $C
		dc.w      0,   $14
		dc.w      0,   $1C
		dc.w      0,   $24
		dc.w      0, $FFDC
		dc.w      0,   $2C
		dc.w      0, $FFD4
		dc.w      0,   $34
		dc.w      0, $FFCC
		dc.w      0,   $3C
		dc.w      0, $FFC4
word_1F148:	dc.w  $FFE4,     0
		dc.w  $FFEC,     0
		dc.w  $FFF4,     0
		dc.w  $FFFC,     0
		dc.w      4,     0
		dc.w     $C,     0
		dc.w    $14,     0
		dc.w    $1C,     0
		dc.w    $24,     0
		dc.w  $FFDC,     0
		dc.w    $2C,     0
		dc.w  $FFD4,     0
		dc.w    $34,     0
		dc.w  $FFCC,     0
		dc.w    $3C,     0
		dc.w  $FFC4,     0

; =============== S U B R O U T I N E =======================================


sub_1F188:
		move.w	x_pos(a0),d2
		move.w	y_pos(a0),d3
		move.w	priority(a0),d4
		movea.l	a0,a1
		bra.s	loc_1F1A0
; ---------------------------------------------------------------------------

loc_1F198:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	loc_1F1FA

loc_1F1A0:
		move.l	(a0),(a1)
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.b	#$84,render_flags(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.w	(a4)+,d0
		add.w	d2,d0
		move.w	d0,x_pos(a1)
		move.w	(a4)+,d0
		add.w	d3,d0
		move.w	d0,y_pos(a1)
		move.w	d4,priority(a1)
		move.b	#4,width_pixels(a1)
		move.b	#4,height_pixels(a1)
		move.b	mapping_frame(a0),mapping_frame(a1)
		move.w	x_vel(a0),x_vel(a1)
		move.w	y_vel(a0),y_vel(a1)
		move.b	(a2)+,$3F(a1)
		dbf	d1,loc_1F198

loc_1F1FA:
		moveq	#signextendB(sfx_Collapse),d0
		jmp	(Play_SFX).l
; End of function sub_1F188