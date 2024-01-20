ASSUME cs:CODE, ds:DATA, ss:myStack
DATA SEGMENT
; Questions
	welcome		db "Start by giving the file name and whether to create, edit, or show the image.", 10
	welcome_1	db "  When painting, you can paint by selecting 0-4", 10
	welcome_2	db "  When finished ' ' will remove the curser. esc will exit out of painting.", 10, 10
	file_quest	db "Give the filename you wish to use: $"
	edit_type	db 10, "Create image (n), edit image (e), or show image (s): $" 
; Curser
	curser_pos	dw 0
	show_curser	db 0
	curser_on	db ?
; Canvas
	; width = 80; height = 25
	canvas		db 1999 dup(0), '$', 0
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
		mov si, curser_pos
		mov bl, canvas[si]
		mov curser_on, bl
		
		mov cl, 0
		lea di, canvas
	image_loop:
		mov dl, 10
		call display_char
		cmp show_curser, 1
		je hide_curser
		mov si, curser_pos
		mov canvas[si], 1
	hide_curser:
		lea dx, canvas
		call display_phrase
		call echo_char
		cmp al, 1Bh
		je end_display
		cmp show_curser, 1
		je image_loop

		call curser_move
		sub al, '0'
		cmp al, 0
		je display_pxl
		cmp al, 1
		je dk_grey_pxl
		cmp al, 2
		je grey_pxl
		cmp al, 3
		je lt_grey_pxl
		cmp al, 4
		je white_pxl
		jmp image_loop
	dk_grey_pxl:
		mov al, 176
		jmp display_pxl
	grey_pxl:
		mov al, 177
		jmp display_pxl
	lt_grey_pxl:
		mov al, 178
		jmp display_pxl
	white_pxl:
		mov al, 219
	display_pxl:
		mov curser_on, al
		jmp image_loop
	end_display:
		ret

curser_move:				; al character move type
		mov si, curser_pos
		mov bl, curser_on
		mov canvas[si], bl
		cmp al, 'w'
		je move_up
		cmp al, 'a'
		je move_left
		cmp al, 's'
		je move_down
		cmp al, 'd'
		je move_right
		jmp end_move
	move_up:
		cmp si, 80
		jl no_up
		sub si, 80
	no_up:
		jmp end_move
	move_left:
		mov ax, curser_pos
		mov bl, 80
		div bl
		cmp ah, 0
		je no_left
		dec si
	no_left:
		jmp end_move
	move_down:
		cmp si, 1919
		jg no_down
		add si, 80
	no_down:
		jmp end_move
	move_right:
		mov ax, curser_pos
		mov bl, 80
		div bl
		cmp ah, 78
		je no_right
		inc si
	no_right:
		jmp end_move
	end_move:
		mov curser_pos, si
		mov bl, canvas[si]
		mov curser_on, bl
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
		mov cx, 1999
		int 21h
		ret

write_file:
		mov si, curser_pos
		mov bl, curser_on
		mov canvas[si], bl
		lea dx, canvas
		mov cx, 1999
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
		call display_image
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
		call display_image
		call write_file
		jmp end_program
	show_image:
		call open_file
		jc end_program
		lea dx, canvas
		call read_file
		mov show_curser, 1
		call display_image
	end_program:
		call close_file
		mov ah, 4Ch
		int 21h
CODE ENDS
END start