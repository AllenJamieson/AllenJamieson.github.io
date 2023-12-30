ASSUME cs:CODE, ds:DATA, ss:myStack
DATA SEGMENT
; Questions
	welcome		db "Start by giving the file name and whether to create, edit, or show the image.", 10
	welcome_1	db "  When painting, you can paint by selecting 0-4", 10
	welcome_2	db "  When finished ' ' will remove the curser. esc will exit out of painting.", 10, 10
	file_quest	db "Give the filename you wish to use: $"
	edit_type	db 10, "Create image (n), edit image (e), or show image (s): $" 
; Curser
	curser_x	db 0
	curser_y	db 0
	show_curser	db 0
; Canvas
	; width = 77 with another being 0; height = 25
	canvas		db 1950 dup('0')	; 1 extra 0 because of screen issues
	
; File management
	handle		dw ?
	file_name	db 25, 25 dup(?)	; n characters and a CR for max and n and a terminate for the dup

DATA ENDS

myStack SEGMENT STACK
myStack ENDS

CODE SEGMENT

display_phrase:
		mov ah, 09h
		int 21h
		ret

display_char:
		mov ah, 02h
		int 21h
		ret
		
get_char:
		mov ah, 07h
		int 21h
		ret

echo_char:
		mov ah, 01h
		int 21h
		ret

display_image:
		mov cl, 0
		lea di, canvas
	row_loop:
		mov ch, 0
		mov dl, 10
		call display_char
	column_loop:
		cmp show_curser, 0
		jne show_char
		cmp curser_y, cl
		jne show_char
		cmp curser_x, ch
		jne show_char
		mov dl, 1
		call display_char
		jmp hide_char
	show_char:
		mov dl, [di]
		sub dl, '0'
		cmp dl, 1
		je dk_grey_pxl
		cmp dl, 2
		je grey_pxl
		cmp dl, 3
		je lt_grey_pxl
		cmp dl, 4
		je white_pxl
		jmp display_pxl
	dk_grey_pxl:
		mov dl, 176
		jmp display_pxl
	grey_pxl:
		mov dl, 177
		jmp display_pxl
	lt_grey_pxl:
		mov dl, 178
		jmp display_pxl
	white_pxl:
		mov dl, 219
	display_pxl:
		call display_char
	hide_char:
		inc di
		inc ch
		cmp ch, 78
		jne column_loop
		inc cl
		cmp cl, 25		
		jne row_loop
		ret

paint_position:
		mov bl, curser_x
		mov bh, curser_y
		mov ax, 78
		mul bh
		mov bh, 0
		add ax, bx
		mov si, ax
		mov canvas[si], dl
		ret

paint_display:
	paint_display_loop:
		call display_image
		call get_char
		mov bl, curser_x
		mov bh, curser_y
		cmp al, 1Bh
		je end_paint_display
		cmp show_curser, 0
		jne paint_display_loop
		cmp al, ' '
		je to_image
		cmp al, '0'
		je paint
		cmp al, '1'
		je paint
		cmp al, '2'
		je paint
		cmp al, '3'
		je paint
		cmp al, '4'
		je paint
		cmp al, 'a'
		je left
		cmp al, 'd'
		je right
		cmp al, 's'
		je down
		cmp al, 'w'
		je up
		jmp paint_display_loop
	paint:
		mov dl, al
		call paint_position
		jmp paint_display_loop
	to_image:
		mov ah, 0
		mov al, show_curser
		mov bl, 2
		div bl
		mov show_curser, ah
		jmp paint_display_loop
	left:
		cmp bl, 0
		je paint_display_loop
		dec curser_x
		jmp paint_display_loop
	right:
		cmp bl, 77
		je paint_display_loop
		inc curser_x
		jmp paint_display_loop
	up:
		cmp bh, 0
		je paint_display_loop
		dec curser_y
		jmp paint_display_loop
	down:
		cmp bh, 24
		je paint_display_loop
		inc curser_y
		jmp paint_display_loop
	end_paint_display:
		ret

; File management
get_file:						; Gets the name of the file
		mov ah, 0Ah
		int 21h
		mov cl, file_name[1]
		mov ch, 0
		add cl, 2
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
		mov bx, handle
		mov ah, 3Fh
		mov cx, 1950
		int 21h
		ret

write_file:
		mov bx, handle
		mov ah, 40h
		int 21h
		ret


start:
		mov ax, DATA
		mov ds, ax
		
		
		lea dx, welcome
		call display_phrase
		lea dx, file_name
		call get_file

		lea dx, edit_type
		call display_phrase
		call echo_char
		cmp al, 'n'		; Create new image
		je new_file_edit
		cmp al, 'e'		; Edit image
		je edit_image
		cmp al, 's'		; Show image
		je show_image
		jmp end_program

	new_file_edit:
		call new_file
		call open_file
		call paint_display
		mov cx, 1950
		lea dx, canvas
		call write_file
		jmp end_program
	edit_image:
		call open_file
		jc skip_read
		lea dx, canvas
		call read_file
	skip_read:
		call close_file
		call new_file
		call open_file
		call paint_display
		mov cx, 1950
		lea dx, canvas
		call write_file
		jmp end_program
	show_image:
		call open_file
		jc end_program
		lea dx, canvas
		call read_file
		mov show_curser, 1
		call paint_display
	end_program:
		call close_file
		mov ah, 4Ch
		int 21h
CODE ENDS
END start