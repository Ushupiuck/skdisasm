Obj_FBZDEZPlayerLauncher:
		move.l	#Map_FBZDEZPlayerLauncher,mappings(a0)
		move.w	#$23B5,art_tile(a0)
		cmpi.b	#$B,(Current_zone).w
		bne.s	loc_3B956
		move.w	#$22FC,art_tile(a0)	; Death Egg specific graphics
		move.b	#1,mapping_frame(a0)

loc_3B956:
		ori.b	#4,render_flags(a0)
		move.b	#$10,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	#$280,priority(a0)
		move.w	x_pos(a0),$44(a0)
		move.l	#loc_3B97A,(a0)

loc_3B97A:
		tst.b	flips_remaining(a0)
		beq.s	loc_3B9AC
		subq.b	#1,flips_remaining(a0)
		bne.s	+
		move.w	#0,x_vel(a0)
		move.l	#loc_3BA4A,(a0)
		move.b	#1,$32(a0)
+
		jsr	(MoveSprite2).l
		tst.b	flip_speed(a0)
		beq.s	loc_3B9AC
		subq.b	#1,flip_speed(a0)
		asl	x_vel(a0)

loc_3B9AC:
		lea	(Player_1).w,a1
		moveq	#3,d6
		bsr.s	sub_3B9D8
		lea	(Player_2).w,a1
		moveq	#4,d6
		bsr.s	sub_3B9D8
		move.w	#$10,d1
		move.w	#3,d3
		move.w	x_pos(a0),d4
		jsr	(SolidObjectTop).l
		move.w	$44(a0),d0
		jmp	(Sprite_OnScreen_Test2).l

; =============== S U B R O U T I N E =======================================


sub_3B9D8:
		btst	d6,status(a0)
		beq.s	locret_3BA48
		moveq	#4,d0
		move.w	#$100,d1
		bclr	#0,status(a1)
		btst	#0,status(a0)
		beq.s	loc_3B9FC
		bset	#0,status(a1)
		neg.w	d0
		neg.w	d1

loc_3B9FC:
		add.w	x_pos(a0),d0
		move.w	d0,x_pos(a1)
		tst.b	$32(a0)
		beq.s	loc_3BA1E
		move.b	#0,anim(a1)
		bset	#1,status(a1)
		move.w	#0,status(a1)

locret_3BA48:
		rts
; ---------------------------------------------------------------------------

loc_3BA1E:
		move.w	x_vel(a0),d0
		move.w	d0,x_vel(a1)
		move.w	d0,ground_vel(a1)
		tst.b	flips_remaining(a0)
		bne.s	locret_3BA48
		move.w	d1,x_vel(a0)
		move.b	#$C,flips_remaining(a0)
		move.b	#4,flip_speed(a0)
		moveq	#signextendB(sfx_FloorLauncher),d0
		jmp	(Play_SFX).l
; End of function sub_3B9D8

; ---------------------------------------------------------------------------

loc_3BA4A:
		move.w	x_pos(a0),-(sp)
		moveq	#1,d1
		move.w	x_pos(a0),d0
		sub.w	$44(a0),d0
		bne.s	loc_3BA68
		move.l	#loc_3B97A,(a0)
		move.b	#0,$32(a0)
		bra.s	loc_3BA70
; ---------------------------------------------------------------------------

loc_3BA68:
		bcs.s	loc_3BA6C
		neg.w	d1

loc_3BA6C:
		add.w	d1,x_pos(a0)

loc_3BA70:
		move.w	#$10,d1
		move.w	#3,d3
		move.w	(sp)+,d4
		jsr	(SolidObjectTop).l
		move.w	$44(a0),d0
		jmp	(Sprite_OnScreen_Test2).l
; ---------------------------------------------------------------------------
Map_FBZDEZPlayerLauncher:
		include "Levels/FBZ/Misc Object Data/Map - DEZ Player Launcher.asm"
; ---------------------------------------------------------------------------