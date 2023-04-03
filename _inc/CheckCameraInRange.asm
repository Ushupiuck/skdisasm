; =============== S U B R O U T I N E =======================================


Check_CameraInRange:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(a1)+,d0
		blo.s	loc_85C74
		cmp.w	(a1)+,d0
		bhi.s	loc_85C74
		move.w	(Camera_X_pos).w,d1
		cmp.w	(a1)+,d1
		blo.s	loc_85C74
		cmp.w	(a1)+,d1
		bhi.s	loc_85C74
		bclr	#7,$27(a0)
		cmp.w	(a1),d0
		bls.s	loc_85C5E
		bset	#7,$27(a0)

loc_85C5E:
		bclr	#6,$27(a0)
		cmp.w	4(a1),d1
		bls.s	loc_85C70
		bset	#6,$27(a0)

loc_85C70:
		move.l	(sp),(a0)
		rts
; ---------------------------------------------------------------------------

loc_85C74:
		jsr	(Delete_Sprite_If_Not_In_Range).l
		addq.w	#4,sp
		rts
; End of function Check_CameraInRange