; ---------------------------------------------------------------------------
; Object 78 - Caterkiller enemy	(MZ, SBZ)
; ---------------------------------------------------------------------------

Caterkiller:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Cat_Index(pc,d0.w),d1
		jmp	Cat_Index(pc,d1.w)
; ===========================================================================
Cat_Index:	dc.w Cat_Main-Cat_Index
		dc.w Cat_Head-Cat_Index
		dc.w Cat_BodySeg1-Cat_Index
		dc.w Cat_BodySeg2-Cat_Index
		dc.w Cat_BodySeg1-Cat_Index
		dc.w Cat_Delete-Cat_Index
		dc.w loc_16CC0-Cat_Index

cat_parent = parent		; address of parent object ; was $3C in Sonic 1
; $2A replaced by objoff_2D
; $2B replaced by objoff_47
; $2C stays as-is :P
; ===========================================================================

locret_16950:
		rts	
; ===========================================================================

Cat_Main:	; Routine 0
		move.b	#7,y_radius(a0)
		move.b	#8,x_radius(a0)
		jsr	(ObjectMoveAndFall).l
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	locret_16950
		add.w	d1,y_pos(a0)
		clr.w	y_vel(a0)
		addq.b	#2,routine(a0)
		move.l	#Map_Cat,mappings(a0)
;		move.w	#$22B0,art_tile(a0)
;		cmpi.b	#id_SBZ,(v_zone).w ; if level is SBZ, branch
;		beq.s	.isscrapbrain
		move.w	#$24FF,art_tile(a0) ; MZ specific code

;.isscrapbrain:
		andi.b	#3,render_flags(a0)
		ori.b	#4,render_flags(a0)
		move.b	render_flags(a0),status(a0)
		move.w	#$200,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#$B,collision_flags(a0)
		move.w	x_pos(a0),d2
		moveq	#$C,d5
		btst	#0,status(a0)
		beq.s	.noflip
		neg.w	d5

.noflip:
		move.b	#4,d6
		moveq	#0,d3
		moveq	#4,d4
		movea.l	a0,a2
		moveq	#2,d1

Cat_Loop:
		jsr	(Create_New_Sprite3).l
		bne.w	Cat_ChkGone
		_move.l	#Caterkiller,0(a1) ; load body segment object
		move.b	d6,routine(a1) ; goto Cat_BodySeg1 or Cat_BodySeg2 next
		addq.b	#2,d6		; alternate between the two
		move.l	mappings(a0),mappings(a1)
		move.w	art_tile(a0),art_tile(a1)
		move.w	#$280,priority(a1)
		move.b	#8,width_pixels(a1)
		move.b	#$C,height_pixels(a0)
		move.b	#$CB,collision_flags(a1)
		add.w	d5,d2
		move.w	d2,x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		move.b	status(a0),status(a1)
		move.b	status(a0),render_flags(a1)
		move.b	#8,mapping_frame(a1)
		move.l	a2,cat_parent(a1)
		move.b	d4,cat_parent(a1)
		addq.b	#4,d4
		movea.l	a1,a2

.fail:
		dbf	d1,Cat_Loop	; repeat sequence 2 more times

		move.b	#7,objoff_2D(a0)
		clr.b	cat_parent(a0)

Cat_Head:	; Routine 2
		tst.b	status(a0)
		bmi.w	loc_16C96
		moveq	#0,d0
		move.b	routine_secondary(a0),d0
		move.w	Cat_Index2(pc,d0.w),d1
		jsr	Cat_Index2(pc,d1.w)
		move.b	objoff_47(a0),d1
		bpl.s	.display
		lea	(Ani_Cat).l,a1
		move.b	angle(a0),d0
		andi.w	#$7F,d0
		addq.b	#4,angle(a0)
		move.b	(a1,d0.w),d0
		bpl.s	.animate
		bclr	#7,objoff_47(a0)
		bra.s	.display

.animate:
		andi.b	#$10,d1
		add.b	d1,d0
		move.b	d0,mapping_frame(a0)

.display:
		jmp	(Sprite_OnScreen_Test).l
		; The code below is literally on "Sprite_OnScreen_Test", so it's been commented out
;		out_of_range.w	Cat_ChkGone
;		jmp	(Draw_Sprite).l
		; But this half is called multiple times through the object, so to avoid JmpTo's
		; It's being kept
Cat_ChkGone:
		move.w	respawn_addr(a0),d0	; get address in respawn table
		beq.s	.delete		; if it's zero, don't remember object
		movea.w	d0,a2	; load address into a2
		bclr	#7,(a2)	; clear respawn table entry, so object can be loaded again

.delete:
		move.b	#$A,routine(a0)	; goto Cat_Delete next
		rts
; ===========================================================================

Cat_Delete:	; Routine $A
		jmp	(Delete_Current_Sprite).l
; ===========================================================================
Cat_Index2:	dc.w .wait-Cat_Index2
		dc.w loc_16B02-Cat_Index2
; ===========================================================================

.wait:
		subq.b	#1,objoff_2D(a0)
		bmi.s	.move
		rts	
; ===========================================================================

.move:
		addq.b	#2,routine_secondary(a0)
		move.b	#$10,objoff_2D(a0)
		move.w	#-$C0,x_vel(a0)
		move.w	#$40,ground_vel(a0)
		bchg	#4,objoff_47(a0)
		bne.s	loc_16AFC
		clr.w	x_vel(a0)
		neg.w	ground_vel(a0)

loc_16AFC:
		bset	#7,objoff_47(a0)

loc_16B02:
		subq.b	#1,objoff_2D(a0)
		bmi.s	.loc_16B5E
		tst.w	x_vel(a0)
		beq.s	.notmoving
		move.l	x_pos(a0),d2
		move.l	d2,d3
		move.w	x_vel(a0),d0
		btst	#0,status(a0)
		beq.s	.noflip
		neg.w	d0

.noflip:
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.l	d2,x_pos(a0)
		swap	d3
		cmp.w	x_pos(a0),d3
		beq.s	.notmoving
		jsr	(ObjCheckFloorDist).l
		cmpi.w	#-8,d1
		blt.s	.loc_16B70
		cmpi.w	#$C,d1
		bge.s	.loc_16B70
		add.w	d1,y_pos(a0)
		moveq	#0,d0
		move.b	cat_parent(a0),d0
		addq.b	#1,cat_parent(a0)
		andi.b	#$F,cat_parent(a0)
		move.b	d1,objoff_2C(a0,d0.w)

.notmoving:
		rts	
; ===========================================================================

.loc_16B5E:
		subq.b	#2,routine_secondary(a0)
		move.b	#7,objoff_2D(a0)
		clr.w	x_vel(a0)
		clr.w	ground_vel(a0)
		rts
; ===========================================================================

.loc_16B70:
		moveq	#0,d0
		move.b	cat_parent(a0),d0
		move.b	#$80,objoff_2C(a0,d0.w)
		neg.w	x_pos+2(a0)
		beq.s	.loc_1730A
		btst	#0,status(a0)
		beq.s	.loc_1730A
		subq.w	#1,x_pos(a0)
		addq.b	#1,cat_parent(a0)
		moveq	#0,d0
		move.b	cat_parent(a0),d0
		clr.b	objoff_2C(a0,d0.w)
.loc_1730A:
		bchg	#0,status(a0)
		move.b	status(a0),render_flags(a0)
		addq.b	#1,cat_parent(a0)
		andi.b	#$F,cat_parent(a0)
		rts	
; ===========================================================================

Cat_BodySeg2:	; Routine 6
		movea.l	cat_parent(a0),a1
		move.b	objoff_47(a1),objoff_47(a0)
		bpl.s	Cat_BodySeg1
		lea	(Ani_Cat).l,a1
		move.b	angle(a0),d0
		andi.w	#$7F,d0
		addq.b	#4,angle(a0)
		tst.b	mappings(a1,d0.w)
		bpl.s	Cat_AniBody
		addq.b	#4,angle(a0)

Cat_AniBody:
		move.b	(a1,d0.w),d0
		addq.b	#8,d0
		move.b	d0,mapping_frame(a0)

Cat_BodySeg1:	; Routine 4, 8
		movea.l	cat_parent(a0),a1
		tst.b	status(a0)
		bmi.w	loc_16C90
		move.b	objoff_47(a1),objoff_47(a0)
		move.b	routine_secondary(a1),routine_secondary(a0)
		beq.w	loc_16C64
		move.w	ground_vel(a1),ground_vel(a0)
		move.w	x_vel(a1),d0
		add.w	ground_vel(a0),d0
		move.w	d0,x_vel(a0)
		move.l	x_pos(a0),d2
		move.l	d2,d3
		move.w	x_vel(a0),d0
		btst	#0,status(a0)
		beq.s	loc_16C0C
		neg.w	d0

loc_16C0C:
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.l	d2,x_pos(a0)
		swap	d3
		cmp.w	x_pos(a0),d3
		beq.s	loc_16C64
		moveq	#0,d0
		move.b	cat_parent(a0),d0
		move.b	objoff_2C(a1,d0.w),d1
		cmpi.b	#$80,d1
		bne.s	loc_16C50
		move.b	d1,objoff_2C(a0,d0.w)
		neg.w	x_pos+2(a0)
		beq.s	locj_173E4
		btst	#0,status(a0)
		beq.s	locj_173E4
		cmpi.w	#-$C0,x_vel(a0)
		bne.s	locj_173E4
		subq.w	#1,x_pos(a0)
		addq.b	#1,cat_parent(a0)
		moveq	#0,d0
		move.b	cat_parent(a0),d0
		clr.b	objoff_2C(a0,d0.w)
locj_173E4:
		bchg	#0,status(a0)
		move.b	status(a0),render_flags(a0)
		addq.b	#1,cat_parent(a0)
		andi.b	#$F,cat_parent(a0)
		bra.s	loc_16C64
; ===========================================================================

loc_16C50:
		ext.w	d1
		add.w	d1,y_pos(a0)
		addq.b	#1,cat_parent(a0)
		andi.b	#$F,cat_parent(a0)
		move.b	d1,objoff_2C(a0,d0.w)

loc_16C64:
		cmpi.b	#$C,routine(a1)
		beq.s	loc_16C90
		_cmpi.l	#Obj_Explosion,0(a1)
		beq.s	loc_16C7C
		cmpi.b	#$A,routine(a1)
		bne.s	loc_16C82

loc_16C7C:
		clr.b	collision_flags(a1)	; immediately remove all touch response values when destroying the head to avoid taking damage
		move.b	#$A,routine(a0)

loc_16C82:
		jmp	(Draw_Sprite).l

; ===========================================================================
Cat_FragSpeed:	dc.w -$200, -$180, $180, $200
; ===========================================================================

loc_16C90:
		bset	#7,status(a1)

loc_16C96:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Cat_FragSpeed-2(pc,d0.w),d0
		btst	#0,status(a0)
		beq.s	.loc_16CAA
		neg.w	d0

.loc_16CAA:
		move.w	d0,x_vel(a0)
		move.w	#-$400,y_vel(a0)
		move.b	#$C,routine(a0)
		andi.b	#$F8,mapping_frame(a0)

loc_16CC0:	; Routine $C
		jsr	(ObjectMoveAndFall).l
		tst.w	y_vel(a0)
		bmi.s	.loc_16CE0
		jsr	(ObjCheckFloorDist).l
		tst.w	d1
		bpl.s	.loc_16CE0
		add.w	d1,y_pos(a0)
		move.w	#-$400,y_vel(a0)

.loc_16CE0:
		tst.b	render_flags(a0)
		bpl.w	Cat_ChkGone
		jmp	(Draw_Sprite).l