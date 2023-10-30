Obj_FBZScrewDoor:
		move.b	subtype(a0),d0
		lsr.w	#4,d0
		andi.w	#7,d0
		move.b	d0,anim(a0)
		andi.w	#6,d0
		move.b	byte_3BBE8(pc,d0.w),width_pixels(a0)
		move.b	byte_3BBE9(pc,d0.w),height_pixels(a0)
		move.l	#Map_FBZScrewDoor,mappings(a0)
		move.w	#$23D2,art_tile(a0)
		ori.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.w	x_pos(a0),$44(a0)
		move.w	y_pos(a0),$46(a0)
		lea	(Ani_FBZScrewDoor).l,a1
		jsr	(Animate_Sprite).l
		tst.b	subtype(a0)
		bpl.s	loc_3BC6C
		move.w	respawn_addr(a0),d0
		beq.s	loc_3BC62
		movea.w	d0,a2
		btst	#0,(a2)
		beq.s	loc_3BC62
		addi.w	#$40,y_pos(a0)
		move.l	#loc_3BCF2,(a0)
		bra.w	loc_3BCF2
; ---------------------------------------------------------------------------
byte_3BBE8:	dc.b 8
byte_3BBE9:	dc.b $20
		dc.b $20
		dc.b 8
		dc.b $40
		dc.b 8
; ---------------------------------------------------------------------------

loc_3BC62:
		move.l	#loc_3BD1A,(a0)
		bra.w	loc_3BD1A
; ---------------------------------------------------------------------------

loc_3BC6C:
		move.l	#loc_3BC72,(a0)

loc_3BC72:
		move.b	subtype(a0),d0
		andi.w	#$F,d0
		lea	(Level_trigger_array).w,a3
		tst.b	(a3,d0.w)
		beq.s	loc_3BCF2
		move.l	#loc_3BC92,(a0)
		moveq	#signextendB(sfx_DoorOpen),d0
		jsr	(Play_SFX).l

loc_3BC92:
		addq.b	#1,$2E(a0)
		cmpi.b	#-$80,$2E(a0)
		bne.s	loc_3BCA4
		move.l	#loc_3BCF2,(a0)

loc_3BCA4:
		moveq	#0,d0
		move.b	$2E(a0),d0
		btst	#4,subtype(a0)
		beq.s	loc_3BCB4
		neg.w	d0

loc_3BCB4:
		btst	#5,subtype(a0)
		bne.s	loc_3BCDC
		btst	#6,subtype(a0)
		bne.s	loc_3BCDE
		asr.w	#1,d0
		add.w	$46(a0),d0
		move.w	d0,y_pos(a0)
		lea	(Ani_FBZScrewDoor).l,a1
		jsr	(Animate_Sprite).l
		bra.s	loc_3BCF2
; ---------------------------------------------------------------------------

loc_3BCDC:
		asr.w	#1,d0

loc_3BCDE:
		add.w	$44(a0),d0
		move.w	d0,x_pos(a0)
		lea	(Ani_FBZScrewDoor).l,a1
		jsr	(Animate_Sprite).l

loc_3BCF2:
		moveq	#0,d1
		move.b	width_pixels(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	height_pixels(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectFull).l
		move.w	$44(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------

loc_3BD1A:
		lea	(Player_1).w,a1
		move.w	y_pos(a1),d0
		sub.w	y_pos(a0),d0
		addi.w	#-$20,d0
		cmpi.w	#$40,d0
		bhs.s	loc_3BCF2
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		btst	#0,status(a0)
		beq.s	loc_3BD42
		neg.w	d0

loc_3BD42:
		cmpi.w	#$40,d0
		blt.s	loc_3BCF2
		move.w	respawn_addr(a0),d0
		beq.s	loc_3BD54
		movea.w	d0,a2
		bset	#0,(a2)

loc_3BD54:
		move.l	#loc_3BC92,(a0)
		bra.w	loc_3BC92
; ---------------------------------------------------------------------------
Ani_FBZScrewDoor:
		include "Levels/FBZ/Misc Object Data/Anim - Screw Door.asm"
Map_FBZScrewDoor:
		include "Levels/FBZ/Misc Object Data/Map - Screw Door.asm"