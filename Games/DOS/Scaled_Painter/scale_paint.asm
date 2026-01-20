ASSUME ds:DATA, ss:myStack, cs:CODE

DATA SEGMENT
	welcome		db 10, " Welcome to Painter", 10, "________________________________________", 10
	tutorial_1	db "   Give a file name", 10
	tutorial_2	db "   Create, Edit, or Show the image", 10
	tutorial_3	db "   You can paint by selecting 0-9 or a-f"
	tutorial_4	db "   Arrows to move the curser", 10
	tutorial_5	db "   Esc to exit out of the program", 10, 10
	file_quest	db "Filename: $"
	edit_type	db 10, 10, "Select one:", 10, "New Image           (n)", 10, "Edit Image          (e)", 10, "Show Scaled Image   (s)", 10, "Show Original Image (o) $"

; pixel size = 4
	curser_img	db 0fh, 0, 0, 0fh, 0, 0fh, 0fh, 0, 0, 0fh, 0fh, 0, 0fh, 0, 0, 0fh
	curser_x	dw 0				; add 4s
	curser_y	dw 0				; add 4s
	curser_pos	dw 0				; add 1 or 80 as this is a scaled version
	show_curser	db 0

	canvas		db 4000 dup(0)
	handle		dw ?
	file_name	db 8, 8 dup(?), 0
DATA ENDS

myStack SEGMENT STACK
	db 10 dup(?)
myStack ENDS

CODE SEGMENT

set_video:
	; Change graphics modes to al
		mov al, 0Dh
		mov ah, 0
		int 10h
		ret

echo_char:
		mov ah, 01h
		int 21h
		ret

; https://stanislavs.org/helppc/scan_codes.html
get_key_press:	; ax is the key pressed
		mov ah, 0
		int 16h
		ret

display_phrase:
		mov ah, 09h
		int 21h
		ret

write_pxl:		; al = color value, cx = column, dx = row
		mov ah, 0Ch
		mov bh, 0
		int 10h
		ret

initial_paint:
		mov dx, 0
	v_paint:
		mov cx, 0
	h_paint:
	; Get the pixel color
		mov ax, dx
		mov bl, 80
		mul bl
		add ax, cx
		mov si, ax
		mov al, canvas[si]
	; Setting the color at that position
		push cx
		push dx
		push ax
		mov bl, 4
		
		mov ax, cx
		mul bl
		mov cx, ax
		mov ax, dx
		mul bl
		mov dx, ax
		pop ax
	; Fill the pixel
		mov bl, 0
		mov si, 0
	pxl_v:
		mov bh, 0
	pxl_h:
		cmp show_curser, 0
		jne no_curser
		cmp si, 0
		jne is_curser
		cmp cx, curser_x
		jne no_curser
		cmp dx, curser_y
		jne no_curser
	; Curser display
	is_curser:
		mov al, curser_img[si]
		inc si
	no_curser:
		push bx
		call write_pxl
		pop bx
		inc bh
		inc cx
		cmp bh, 4
		jne pxl_h
		sub cx, 4
		inc bl
		inc dx
		cmp bl, 4
		jne pxl_v
		
		pop dx
		pop cx
	; Loop through the image
		inc cx
		cmp cx, 80
		jne h_paint
		inc dx
		cmp dx, 50
		jne v_paint
		ret

paint_reduced:
		mov si, 0
		mov dx, 0
	scale_v:
		mov cx, 0
	scale_h:
		mov al, canvas[si]
		call write_pxl
		inc si
		inc cx
		cmp cx, 80
		jne scale_h
		inc dx
		cmp dx, 50
		jne scale_v
	display_loop:
		call get_key_press
		cmp ax, 011Bh
		jne display_loop
		ret

remove_curser:
		mov si, curser_pos
		mov al, canvas[si]
		mov cx, curser_x
		mov dx, curser_y
		mov bl, 0
	clear_v:
		mov bh, 0
	clear_h:
		push bx
		call write_pxl
		pop bx
		inc bh
		inc cx
		cmp bh, 4
		jne clear_h
		inc bl
		inc dx
		sub cx, 4
		cmp bl, 4
		jne clear_v
		ret

add_curser:
		mov cx, curser_x
		mov dx, curser_y	
		mov si, 0
		mov bl, 0
	curser_v:
		mov bh, 0
	curser_h:
		mov al, curser_img[si]
		push bx
		call write_pxl
		pop bx
		inc si
		inc bh
		inc cx
		cmp bh, 4
		jne curser_h
		inc bl
		inc dx
		sub cx, 4
		cmp bl, 4
		jne curser_v
		ret

move_curser:			; if al is an arrow have this be comparisons; this is incharge of drawing previous square and the new position
		cmp ax, 4800h
		je move_up
		cmp ax, 4B00h
		je move_left
		cmp ax, 5000h
		je move_down
		cmp ax, 4D00h
		je move_right
		jmp no_move
	move_up:
		cmp curser_y, 0
		je no_move
		call remove_curser
		sub curser_y, 4
		sub curser_pos, 80
		call add_curser
		jmp no_move
	move_left:
		cmp curser_x, 0
		je no_move
		call remove_curser
		sub curser_x, 4
		dec curser_pos
		call add_curser
		jmp no_move
	move_down:
		cmp curser_y, 196
		je no_move
		call remove_curser
		add curser_y, 4
		add curser_pos, 80
		call add_curser
		jmp no_move
	move_right:
		cmp curser_x, 316
		je no_move
		call remove_curser
		add curser_x, 4
		inc curser_pos
		call add_curser
	no_move:
		ret

paint_pxl:				; compare ax to 1234567890abcdef
		mov si, curser_pos
		cmp ax, 0B30h
		je write_0
		cmp ax, 0231h
		je write_1
		cmp ax, 0332h
		je write_2
		cmp ax, 0433h
		je write_3
		cmp ax, 0534h
		je write_4
		cmp ax, 0635h
		je write_5
		cmp ax, 0736h
		je write_6
		cmp ax, 0837h
		je write_7
		cmp ax, 0938h
		je write_8
		cmp ax, 0A39h
		je write_9
		cmp ax, 1E61h
		je write_A
		cmp ax, 3062h
		je write_B
		cmp ax, 2E63h
		je write_C
		cmp ax, 2064h
		je write_D
		cmp ax, 1265h
		je write_E
		cmp ax, 2166h
		je write_F
		jmp end_paint
	write_0:
		mov canvas[si], 0
		jmp end_paint
	write_1:
		mov canvas[si], 1
		jmp end_paint
	write_2:
		mov canvas[si], 2
		jmp end_paint
	write_3:
		mov canvas[si], 3
		jmp end_paint
	write_4:
		mov canvas[si], 4
		jmp end_paint
	write_5:
		mov canvas[si], 5
		jmp end_paint
	write_6:
		mov canvas[si], 6
		jmp end_paint
	write_7:
		mov canvas[si], 7
		jmp end_paint
	write_8:
		mov canvas[si], 8
		jmp end_paint
	write_9:
		mov canvas[si], 9
		jmp end_paint
	write_A:
		mov canvas[si], 10
		jmp end_paint
	write_B:
		mov canvas[si], 11
		jmp end_paint
	write_C:
		mov canvas[si], 12
		jmp end_paint
	write_D:
		mov canvas[si], 13
		jmp end_paint
	write_E:
		mov canvas[si], 14
		jmp end_paint
	write_F:
		mov canvas[si], 15
		jmp end_paint
	end_paint:
		ret

; File management
get_file:						; Gets the name of the file
		lea dx, file_name
		mov ah, 0Ah
		int 21h
		mov cl, file_name[1]
		add cl, 2				; The location is 2 spots after due to max and count
		mov ch, 0
		mov si, cx
		mov file_name[si], 0
		ret

new_file:
		mov ah, 3Ch
		mov cl, 1
		lea dx, file_name[2]
		int 21h
		mov handle, ax
		ret

open_file:
		mov ah, 3Dh
		lea dx, file_name[2]
		mov al, 2
		int 21h
		mov handle, ax
		ret

close_file:
		mov bx, handle
		mov ah, 3Eh
		int 21h
		ret

read_file:
		lea dx, canvas
		mov bx, handle
		mov ah, 3Fh
		mov cx, 4000
		int 21h
		ret

write_file:
		lea dx, canvas
		mov cx, 4000
		mov bx, handle
		mov ah, 40h
		int 21h
		ret

start_painter:
		call initial_paint
	paint_loop:
		call get_key_press
		cmp show_curser, 0
		jne remove_listener
		call paint_pxl
		call move_curser
		call paint_pxl
	remove_listener:
		cmp ax, 011Bh
		jne paint_loop
		ret

start:
		mov ax, DATA
		mov ds, ax
		mov ax, myStack
		mov ss, ax
		
		call set_video
		
		lea dx, welcome
		call display_phrase
		call get_file

		lea dx, edit_type
		call display_phrase
		
		call echo_char
		cmp al, 'n'		; Create new image
		je new_file_edit
		cmp al, 'e'		; Edit image
		je edit_image
		cmp al, 's'		; Show scaled image
		je show_image
		cmp al, 'o'		; Show original
		je show_scaled
		jmp end_program

	new_file_edit:
		call new_file
		call open_file
		call start_painter
		call write_file
		jmp end_program
	edit_image:
		call open_file
		jc skip_read
		call read_file
	skip_read:
		call close_file
		call new_file
		call open_file
		call start_painter
		call write_file
		jmp end_program
	show_image:
		call open_file
		jc end_program
		call read_file
		mov show_curser, 1
		call start_painter
		jmp end_program
	show_scaled:
		call open_file
		jc end_program
		call read_file
		call paint_reduced
	
	end_program:
		call close_file		
		
		mov ah, 4Ch
		int 21h
CODE ENDS
END start