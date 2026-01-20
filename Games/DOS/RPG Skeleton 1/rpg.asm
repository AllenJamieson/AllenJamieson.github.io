ASSUME cs:CODE, ds:DATA, ss:myStack

DATA SEGMENT
	max_x			db 78
	max_y			db 24
	map_val			db 1
	
	player_x		db 10
	player_y		db 10
	player_pos		dw 405
	player_stand	db ? ; tile value standing on
	
	current_map		db 2000 dup(?)
	
	map1			db " _____________________________________________________________________________  "
	map1_1			db "| MAP 1                                                                       | "
	map1_2			db "|                                                                             | "
	map1_3			db "|                                                                             | "
	map1_4			db "|                                                                             | "
	map1_5			db "|                                                                             | "
	map1_6			db "|                                                                             | "
	map1_7			db "|                                                                             | "
	map1_8			db "|                                                                             | "
	map1_9			db "|                                                                             | "
	map1_10			db "|                                                                             | "
	map1_11			db "|                                                                             | "
	map1_12			db "|                                                                             | "
	map1_13			db "|                                                                             | "
	map1_14			db "|                                                                             | "
	map1_15			db "|                                                                             | "
	map1_16			db "|                                                                             | "
	map1_17			db "|                                                                             | "
	map1_18			db "|                                                                             | "
	map1_19			db "|                                                                             | "
	map1_20			db "|                                                                             | "
	map1_21			db "|                                                                             | "
	map1_22			db "|                                                                             | "
	map1_23			db "|                                                                             | "
	map1_24			db " ----------------------------------------------------------------------------- $"

	map2			db " _____________________________________________________________________________  "
	map2_1			db "| MAP 2                                                                       | "
	map2_2			db "|                                                                             | "
	map2_3			db "|                                                                             | "
	map2_4			db "|                                                                             | "
	map2_5			db "|                                                                             | "
	map2_6			db "|                                                                             | "
	map2_7			db "|                                                                             | "
	map2_8			db "|                                                                             | "
	map2_9			db "|                                                                             | "
	map2_10			db "|                                                                             | "
	map2_11			db "|                                                                             | "
	map2_12			db "|                                                                             | "
	map2_13			db "|                                                                             | "
	map2_14			db "|                                                                             | "
	map2_15			db "|                                                                             | "
	map2_16			db "|                                                                             | "
	map2_17			db "|                                                                             | "
	map2_18			db "|                                                                             | "
	map2_19			db "|                                                                             | "
	map2_20			db "|                                                                             | "
	map2_21			db "|                                                                             | "
	map2_22			db "|                                                                             | "
	map2_23			db "|                                                                             | "
	map2_24			db " ----------------------------------------------------------------------------- $"

	map3			db " _____________________________________________________________________________  "
	map3_1			db "| MAP 3                                                                       | "
	map3_2			db "|                                                                             | "
	map3_3			db "|                                                                             | "
	map3_4			db "|                                                                             | "
	map3_5			db "|                                                                             | "
	map3_6			db "|                                                                             | "
	map3_7			db "|                                                                             | "
	map3_8			db "|                                                                             | "
	map3_9			db "|                                                                             | "
	map3_10			db "|                                                                             | "
	map3_11			db "|                                                                             | "
	map3_12			db "|                                                                             | "
	map3_13			db "|                                                                             | "
	map3_14			db "|                                                                             | "
	map3_15			db "|                                                                             | "
	map3_16			db "|                                                                             | "
	map3_17			db "|                                                                             | "
	map3_18			db "|                                                                             | "
	map3_19			db "|                                                                             | "
	map3_20			db "|                                                                             | "
	map3_21			db "|                                                                             | "
	map3_22			db "|                                                                             | "
	map3_23			db "|                                                                             | "
	map3_24			db " ----------------------------------------------------------------------------- $"

	map4			db " _____________________________________________________________________________  "
	map4_1			db "| MAP 4                                                                       | "
	map4_2			db "|                                                                             | "
	map4_3			db "|                                                                             | "
	map4_4			db "|                                                                             | "
	map4_5			db "|                                                                             | "
	map4_6			db "|                                                                             | "
	map4_7			db "|                                                                             | "
	map4_8			db "|                                                                             | "
	map4_9			db "|                                                                             | "
	map4_10			db "|                                                                             | "
	map4_11			db "|                                                                             | "
	map4_12			db "|                                                                             | "
	map4_13			db "|                                                                             | "
	map4_14			db "|                                                                             | "
	map4_15			db "|                                                                             | "
	map4_16			db "|                                                                             | "
	map4_17			db "|                                                                             | "
	map4_18			db "|                                                                             | "
	map4_19			db "|                                                                             | "
	map4_20			db "|                                                                             | "
	map4_21			db "|                                                                             | "
	map4_22			db "|                                                                             | "
	map4_23			db "|                                                                             | "
	map4_24			db " ----------------------------------------------------------------------------- $"

DATA ENDS

myStack SEGMENT STACK
	db 100 dup(?)
myStack ENDS

CODE SEGMENT

display_char:			; dl
		mov ah, 02h
		int 21h
		ret

display_phrase:			; dx
		mov ah, 09h
		int 21h
		ret

display_number:			; ax is the value to display
		cmp ax, 1000
		jl no_thousand
				
		push ax
		mov dl, '-'
		call display_char
		pop ax
	no_thousand:
		cmp ax, 100
		jl no_hundred
		mov bl, 100
		div bl
		mov dl, al
		mov al, ah
		mov ah, 0
		push ax
		add dl, '0'
		call display_char
		pop ax
	no_hundred:
		cmp ax, 10
		jl no_ten
		mov bl, 10
		div bl
		mov bx, ax
		mov dl, bl
		add dl, '0'
		call display_char
	no_ten:
		mov dl, bh
		add dl, '0'
		call display_char
		ret
load_map:					; lea di with map text
		dec di
		mov si, 0
	load_map_loop:
		mov dx, [di]
		mov current_map[si], dh
		inc si
		inc di
		cmp si, 2000
		jne load_map_loop
	no_map:
		ret

move_up:				; TODO Colision and collider
		cmp si, 80
		jl no_up
		sub si, 80
		jmp end_move_up
	no_up:
		mov al, map_val
		cmp al, 1
		je up_map1
		cmp al, 2
		je up_map2
		cmp al, 3
		je up_map3
		cmp al, 4
		je up_map4
		jmp end_move_up
	up_map1:
		mov map_val, 3
		lea di, map3
		jmp up_transition
	up_map2:
		mov map_val, 4
		lea di, map4
		jmp up_transition
	up_map3:
		mov map_val, 1
		lea di, map1
		jmp up_transition
	up_map4:
		mov map_val, 2
		lea di, map2
	up_transition:
		add si, 1920
		push si
		call load_map
		pop si
	end_move_up:
		ret

move_left:
		mov ax, player_pos
		mov bl, 80
		div bl
		cmp ah, 0
		je no_left
		dec si
		jmp end_move_left
	no_left:
		mov al, map_val
		cmp al, 1
		je left_map1
		cmp al, 2
		je left_map2
		cmp al, 3
		je left_map3
		cmp al, 4
		je left_map4
		jmp end_move_left
	left_map1:
		mov map_val, 2
		lea di, map2
		jmp left_transition
	left_map2:
		mov map_val, 1
		lea di, map1
		jmp left_transition
	left_map3:
		mov map_val, 4
		lea di, map4
		jmp left_transition
	left_map4:
		mov map_val, 3
		lea di, map3
	left_transition:
		add si, 78
		push si
		call load_map
		pop si
	end_move_left:
		ret

move_down:
		cmp si, 1919
		jg no_down
		add si, 80
		jmp end_move_down
	no_down:
		mov al, map_val
		cmp al, 1
		je down_map1
		cmp al, 2
		je down_map2
		cmp al, 3
		je down_map3
		cmp al, 4
		je down_map4
		jmp end_move_down
	down_map1:
		mov map_val, 3
		lea di, map3
		jmp down_transition
	down_map2:
		mov map_val, 4
		lea di, map4
		jmp down_transition
	down_map3:
		mov map_val, 1
		lea di, map1
		jmp down_transition
	down_map4:
		mov map_val, 2
		lea di, map2
	down_transition:
		sub si, 1920
		push si
		call load_map
		pop si
	end_move_down:
		ret

move_right:
		mov ax, player_pos
		mov bl, 80
		div bl
		cmp ah, 78
		je no_right
		inc si
		jmp end_move_right
	no_right:
		mov al, map_val
		cmp al, 1
		je right_map1
		cmp al, 2
		je right_map2
		cmp al, 3
		je right_map3
		cmp al, 4
		je right_map4
		jmp end_move_right
	right_map1:
		mov map_val, 2
		lea di, map2
		jmp right_transition
	right_map2:
		mov map_val, 1
		lea di, map1
		jmp right_transition
	right_map3:
		mov map_val, 4
		lea di, map4
		jmp right_transition
	right_map4:
		mov map_val, 3
		lea di, map3
	right_transition:
		sub si, 78
		push si
		call load_map
		pop si
	end_move_right:
		ret

player_move:				; al character move type
		mov si, player_pos
		mov bl, player_stand
		mov current_map[si], bl
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
	left:
		call move_left
		jmp end_move
	down:
		call move_down
		jmp end_move
	right:
		call move_right
		jmp end_move
	end_move:
		mov player_pos, si
		mov bl, current_map[si]
		mov player_stand, bl
		ret

get_char:				; returns al
		mov ah, 07h
		int 21h
		ret

start:
		mov ax, DATA
		mov ds, ax
		mov ax, myStack
		mov ss, ax
		
		lea di, map1
		call load_map
		mov si, player_pos
		mov bl, current_map[si]
		mov player_stand, bl
	game_loop:
		mov dl, 10
		call display_char
		mov si, player_pos
		mov current_map[si], 1

		lea dx, current_map
		call display_phrase
		call get_char
		cmp al, 1Bh
		je ending
		call player_move
		jmp game_loop
	ending:

		mov ah, 4Ch
		int 21h

CODE ENDS
END start