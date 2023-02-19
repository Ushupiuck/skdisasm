Obj_S2LavaMarker:
		moveq	#0,d0
		move.b	subtype(a0),d0
		move.b	byte_1EB32(pc,d0.w),collision_flags(a0)
		move.l	#Map_S2LavaMarker,mappings(a0)
		tst.w	(Debug_placement_mode).w
		beq.s	loc_1EB58
		move.l	#Map_S2LavaMarkerDebug,mappings(a0)

loc_1EB58:
		move.w	#make_art_tile(ArtTile_Ring,0,1),art_tile(a0)
		move.b	#$84,render_flags(a0)
		move.b	#$80,width_pixels(a0)
		move.b	#$80,height_pixels(a0)
		move.w	#$200,priority(a0)
		move.b	$2C(a0),mapping_frame(a0)
		move.l	#loc_1EB82,(a0)

loc_1EB82:
		move.w	x_pos(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_1EBAA

loc_1EB9C:
		tst.w	(Debug_placement_mode).w
		beq.s	locret_1EBA8
		jmp	(Draw_Sprite).l

locret_1EBA8:
		rts
; ---------------------------------------------------------------------------

loc_1EBAA:
		move.w	respawn_addr(a0),d0
		beq.s	loc_1EBB6
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1EBB6:
		jmp	(Delete_Current_Sprite).l
; ---------------------------------------------------------------------------
byte_1EB32:	dc.b $96
		dc.b $94
		dc.b $95
		dc.b 0
; ---------------------------------------------------------------------------