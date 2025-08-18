.186
ASSUME ds:DATA, ss:myStack, cs:CODE

DATA SEGMENT
	winning_txt		db "You win!", 10, "$"
	losing_txt		db "You lose!", 10, "$"
	score_txt		db "Score: $"
	tiles			db 0
	floor			db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	lava			db 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 15, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 15, 12
	lava1			db 15, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 15, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12
	key				db 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 14, 14, 14, 14, 14, 14, 14, 16, 14, 16, 14, 16, 16, 14, 16, 14
	key1			db 16, 16, 16, 16, 16, 16, 14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16
	coin			db 16, 16, 16, 14, 14, 16, 16, 16, 16, 16, 14, 14, 14, 14, 16, 16, 16, 16, 14, 14, 15, 14, 16, 16, 16, 14, 14, 14, 15, 14, 14, 16
	coin1			db 16, 14, 14, 14, 14, 14, 14, 16, 16, 16, 14, 14, 14, 14, 16, 16, 16, 16, 14, 14, 14, 14, 16, 16, 16, 16, 16, 14, 14, 16, 16, 16
	apple			db 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 2, 16, 16, 16, 16, 4, 4, 2, 2, 4, 4, 16, 16, 4, 4, 4, 4, 4, 4, 16
	apple1			db 16, 4, 4, 4, 4, 4, 4, 16, 16, 16, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16
	chest			db 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 6, 6, 6, 6, 6, 6, 6, 6, 6, 8, 8, 8, 8, 8, 8, 6, 6, 6, 6, 14, 14, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
	walls			db 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7, 7, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7, 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7, 4, 4, 4, 7
	v_door			db 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0
	h_door			db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	v_door_lock		db 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0
	h_door_lock		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 14, 14, 6, 6, 6, 6, 6, 6, 14, 14, 6, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	player_sprite	db 16, 16, 16, 0, 0, 16, 16, 16, 16, 16, 0, 0, 0, 0, 16, 16, 16, 16, 16, 12, 12, 16, 16, 16, 16, 12, 16, 12, 12, 16, 12, 16
	player_sprite1	db 16, 16, 12, 1, 1, 12, 16, 16, 16, 16, 16, 11, 11, 16, 16, 16, 16, 16, 12, 16, 16, 12, 16, 16, 16, 6, 6, 16, 16, 6, 6, 16

	map				db 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
	map1			db 6, 0, 0, 6, 0, 0, 0, 6, 0, 0, 0, 1, 0, 0, 0, 0, 6
	map2			db 6, 0, 0, 6, 0, 0, 0, 9, 0, 0, 0, 1, 1, 0, 0, 0, 6
	map3			db 6, 0, 0, 7, 0, 0, 0, 6, 0, 0, 0, 1, 1, 0, 3, 0, 6
	map4			db 6, 8, 6, 6, 0, 0, 0, 6, 0, 0, 0, 1, 0, 0, 0, 0, 6
	map5			db 6, 0, 0, 7, 0, 0, 0, 6, 8, 6, 6, 6, 6, 6, 6, 6, 6
	map6			db 6, 2, 0, 6, 8, 6, 6, 6, 0, 0, 0, 1, 6, 0, 0, 0, 6
	map7			db 6, 0, 0, 6, 0, 0, 5, 6, 0, 4, 0, 0, 7, 0, 3, 0, 6
	map8			db 6, 6, 6, 6, 6, 6, 8, 6, 6, 6, 6, 6, 6, 0, 0, 0, 6
	map9			db 0, 0, 0, 0, 0, 6, 3, 0, 9, 4, 1, 0, 0, 0, 0, 2, 6
	map10			db 0, 0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
	
	map_width		db 17
	map_height		db 11

	player_index	db 11
	player_pos		dw 18
	num_key			db 0
	health			db 3
	score			db 0
	win				db 0
DATA ENDS

myStack SEGMENT STACK
	db 100 dup(?)
myStack ENDS

CODE SEGMENT

assci_to_num:	; al = number to convert
	mov ah, 0
	mov bl, 10
	div bl
	mov dx, ax
	mov ah, 2
	add dl, '0'
	int 21h
	mov dl, dh
	add dl, '0'
	int 21h
	ret

get_char:		; returns al
	mov ah, 07h
	int 21h
	ret

write_pxl:		; al = color value, cx = x, dx = y
	mov ah, 0Ch
	mov bh, 0
	int 10h
	ret

get_xy:					; ax
	mov bl, map_width
	div bl
	mov dl, al
	mov cl, ah
	mov dh, 0
	mov ch, 0
	ret

draw_tile:		; cx = x, dx = y, bl = tile number
	mov bh, 0
	shl bx, 6
	shl cx, 3
	shl dx, 3
	mov si, bx
	mov bh, 0
	tile_yloop:
		mov bl, 0
		push cx
		tile_xloop:
			inc si
			inc bl
			mov al, tiles[si]
			cmp al, 15
			jg opaque
			push bx
			call write_pxl
			pop bx
		opaque:
			inc cx
			cmp bl, 8
			jl tile_xloop
		inc bh
		inc dx
		pop cx
		cmp bh, 8
		jl tile_yloop
	ret

draw_map:
	mov si, 0
	mov dx, 0
	map_yloop:
		mov cx, 0
		map_xloop:
			mov bl, map[si]
			push dx
			push cx
			push si
			call draw_tile
			pop si
			pop cx
			pop dx
			inc cx
			inc si
			cmp cl, map_width
			jne map_xloop
		inc dx
		cmp dl, map_height
		jne map_yloop
	ret

place_player:
	mov ax, player_pos
	call get_xy
	mov bl, player_index
	call draw_tile
	ret

setup:
	mov ax, 000Dh
	int 10h
	call draw_map
	call place_player
	ret

hdoor_check:		; si
	cmp map[si], 8
	je open_hdoor
	cmp map[si], 10
	jne hdoor_check_end
	cmp num_key, 0
	jg unlock_h
	jmp hdoor_check_end
open_hdoor:
	mov map[si], 0
	jmp hdoor_check_end
unlock_h:
	dec num_key
	mov map[si], 8
hdoor_check_end:
	ret

vdoor_check:		; si
	cmp map[si], 7
	je open_vdoor
	cmp map[si], 9
	jne vdoor_check_end
	cmp num_key, 0
	jg unlock_v
	jmp vdoor_check_end
open_vdoor:
	mov map[si], 0
	jmp vdoor_check_end
unlock_v:
	dec num_key
	mov map[si], 7
vdoor_check_end:
	ret

move_up:
	cmp dl, 0
	je end_moveup
	mov bl, map_width
	mov bh, 0
	sub si, bx
	cmp map[si], 5
	jg end_moveup
	dec dl
	sub player_pos, bx
end_moveup:
	call hdoor_check
	ret

move_down:
	mov bl, map_height
	dec bl
	cmp dl, bl
	je end_movedown
	mov bl, map_width
	mov bh, 0
	add si, bx
	cmp map[si], 5
	jg end_movedown
	inc dl
	add player_pos, bx
end_movedown:
	call hdoor_check
	ret

move_left:
	cmp cl, 0
	je end_moveleft
	dec si
	cmp map[si], 5
	jg end_moveleft
	dec cl
	dec player_pos
end_moveleft:
	call vdoor_check
	ret

move_right:
	mov al, cl
	mov ah, 0
	mov bl, map_width
	div bl
	dec bl
	cmp ah, bl
	je end_moveright
	inc si
	cmp map[si], 5
	jg end_moveright
	inc cl
	inc player_pos
end_moveright:
	call vdoor_check
	ret

move:
	push ax
	mov ax, player_pos
	mov si, ax
	call get_xy
	push cx
	push dx
	push si
	mov bl, map[si]
	call draw_tile
	pop si
	pop dx
	pop cx
	pop ax
	push ax

	cmp al, 'w'
	je up
	cmp al, 'a'
	je left
	cmp al, 's'
	je down
	cmp al, 'd'
	je right
	jmp end_move
up:
	call move_up
	jmp end_move
down:
	call move_down
	jmp end_move
left:
	call move_left
	jmp end_move
right:
	call move_right
end_move:
	mov ax, si
	call get_xy
	mov bl, map[si]
	call draw_tile

	mov si, player_pos
	mov bl, map[si]
	cmp bl, 1
	je damage
	cmp bl, 2
	je obtain_key
	cmp bl, 3
	je obtain_coin
	cmp bl, 4
	je obtain_apple
	cmp bl, 5
	je winning
	jmp end_detect
damage:
	dec health
	jmp end_detect
obtain_key:
	inc num_key
	mov map[si], 0
	jmp end_detect
obtain_coin:
	inc score
	mov map[si], 0
	jmp end_detect
obtain_apple:
	inc health
	mov map[si], 0
	jmp end_detect
winning:
	inc win
end_detect:
	call place_player
	pop ax
	ret

print:
	mov ah, 09h
	int 21h
	ret

start:
	mov ax,DATA
	mov ds, ax
	mov ax, myStack
	mov ss, ax
	
	call setup
game_loop:
	call get_char
	call move
	cmp al, 1Bh
	je end_game
	cmp health, 0
	jle end_game
	cmp win, 0
	jne end_game
	jmp game_loop
end_game:
	cmp win, 0
	je lose_txt
	lea dx, winning_txt
	jmp end_txt
lose_txt:
	lea dx, losing_txt
end_txt:
	call print
	lea dx, score_txt
	call print
	mov al, score
	call assci_to_num
	mov ah, 4Ch
	int 21h
CODE ENDS
END start