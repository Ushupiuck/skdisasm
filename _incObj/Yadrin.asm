; ===========================================================================
; ---------------------------------------------------------------------------
; Object 50 - Yadrin enemy (SYZ)
; ---------------------------------------------------------------------------

Yadrin:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Yad_Index(pc,d0.w),d1
		jmp	Yad_Index(pc,d1.w)
; ===========================================================================
Yad_Index:	dc.w Yad_Main-Yad_Index
		dc.w Yad_Action-Yad_Index

yad_timedelay = $30
; ===========================================================================

Yad_Main:	; Routine 0
		move.l	#Map_Yad,mappings(a0)
		move.w	#$247B,art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$200,priority(a0)
		move.b	#$14,width_pixels(a0)
		move.b	#$20,height_pixels(a0)	; rough estimate, could be wrong
		move.b	#$11,y_radius(a0)
		move.b	#8,x_radius(a0)
		move.b	#$CC,collision_flags(a0)
		bsr.w	ObjectMoveAndFall
		bsr.w	ObjCheckFloorDist
		tst.w	d1
		bpl.s	locret_F89E
		add.w	d1,y_pos(a0)	; match	object's position with the floor
		move.w	#0,y_vel(a0)
		addq.b	#2,routine(a0)
		bchg	#0,status(a0)

locret_F89E:
		rts	
; ===========================================================================

Yad_Action:	; Routine 2
		moveq	#0,d0
		move.b	routine_secondary(a0),d0
		move.w	Yad_Index2(pc,d0.w),d1
		jsr	Yad_Index2(pc,d1.w)
		lea	(Ani_Yad).l,a1
		bsr.w	Animate_Sprite
		bra.w	Sprite_OnScreen_Test
; ===========================================================================
Yad_Index2:	dc.w Yad_Move-Yad_Index2
		dc.w Yad_FixToFloor-Yad_Index2
; ===========================================================================

Yad_Move:
		subq.w	#1,yad_timedelay(a0) ; subtract 1 from pause time
		bpl.s	locret_F8E2	; if time remains, branch
		addq.b	#2,routine_secondary(a0)
		move.w	#-$100,x_vel(a0) ; move object
		move.b	#1,anim(a0)
		bchg	#0,status(a0)
		bne.s	locret_F8E2
		neg.w	x_vel(a0)	; change direction

locret_F8E2:
		rts	
; ===========================================================================

Yad_FixToFloor:
		bsr.w	ObjectMove
		bsr.w	ObjCheckFloorDist
		cmpi.w	#-8,d1
		blt.s	Yad_Pause
		cmpi.w	#$C,d1
		bge.s	Yad_Pause
		add.w	d1,y_pos(a0)	; match	object's position to the floor
		bsr.w	Yad_ChkWall
		bne.s	Yad_Pause
		rts	
; ===========================================================================

Yad_Pause:
		subq.b	#2,routine_secondary(a0)
		move.w	#59,yad_timedelay(a0) ; set pause time to 1 second
		move.w	#0,x_vel(a0)
		move.b	#0,anim(a0)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Yad_ChkWall:
		move.w	(Level_frame_counter).w,d0
		add.w	d7,d0
		andi.w	#3,d0
		bne.s	++
		moveq	#0,d3
		move.b	width_pixels(a0),d3
		tst.w	x_vel(a0)
		bmi.s	.going_left
		jsr	(ObjCheckRightWallDist).l
		tst.w	d1
		bpl.s	++
-
		moveq	#1,d0
		rts
; ===========================================================================

.going_left
		not.w	d3
		jsr	(ObjCheckLeftWallDist).l
		tst.w	d1
		bmi.s	-
+
		moveq	#0,d0
		rts	
; End of function Yad_ChkWall