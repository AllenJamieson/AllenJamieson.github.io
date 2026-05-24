ASSUME ds:DATA, ss:myStack, cs:CODE

; https://en.wikipedia.org/wiki/Enhanced_Graphics_Adapter#Color_palette
DATA SEGMENT
	padding_top		db 25
	click_width		dw 550
	score			dw 0
	increment		db 0
	price			db 0
	inc_size		db 1, 5, 25, 50, 100, 0
	price_list		dw 5, 50, 250, 1000, 6500, 0
	empty_img		db 0
DATA ENDS

myStack SEGMENT STACK
	db 100 dup(?)
myStack ENDS

CODE SEGMENT

write_pixel: ; al = color value, cx = column, dx = row
	mov ah, 0Ch
	mov bh, 0
	int 10h
	ret

draw_color: ; ax = width, bl = height, [si] = img?
	mov dx, 0
	img_v:
		mov cx, 0
		img_h:
			push ax
			mov al, increment
			add dl, padding_top
			call write_pixel
			sub dl, padding_top
			; TODO image?
			pop ax
			inc si
			inc cx
			cmp cx, click_width
			jl img_h
		inc dx
		cmp dx, 200
		jl img_v
	ret

write_character: ; al: ASCII character, dh: row, dl: column
	mov ah, 2
	mov bh, 0
	int 10h
	mov ah, 0Ah
	mov bl, 0Fh
	mov cx, 1
	int 10h
	ret

show_number: ; ax: number, dh: row, dl: column Anchor right
	push dx
	mov dx, 0
	mov bx, 1000
	div bx
	add al, '0'
	mov si, dx
	pop dx
	call write_character

	inc dl
	mov ax, si
	mov bl, 100
	div bl
	push ax
	add al, '0'
	call write_character

	inc dl
	pop ax
	mov al, ah
	mov ah, 0
	mov bl, 10
	div bl
	push ax
	add al, '0'
	call write_character

	inc dl
	pop ax
	mov al, ah
	add al, '0'
	call write_character
	ret

buy_button:
	mov al, 5 ; BG Color
	mov dl, padding_top
	mov dh, 0
	button_v:
		mov cx, click_width
		button_w:
			call write_pixel
			inc cx
			cmp cx, 640 ; Window Width
			jl button_w
		inc dx
		cmp dx, 200 ; Window Height
		jl button_v
	mov dl, 74
	mov dh, 5

	mov al, 'U'
	call write_character
	add dh, 3
	mov al, 'P'
	call write_character
	add dh, 3
	mov al, 'G'
	call write_character
	add dh, 3
	mov al, 'A'
	call write_character
	add dh, 3
	mov al, 'D'
	call write_character
	add dh, 3
	mov al, 'E'
	call write_character
	ret

get_price:		; Returns the price in ax
	mov bh, 0
	mov bl, price
	mov di, bx
	mov ax, [price_list+di]
	ret

mouse_listener: ; Returns: cx: h position, dx: v position, ax: status (left/right button)
	mov ax, 5
	mov bx, 0
	int 33h
	ret

update_score:
	mov ax, score
	mov dl, 72
	mov dh, 1
	call show_number
	ret

update_price:
	call get_price
	mov dl, 72
	mov dh, 23
	call show_number
	ret

tap_area:
	cmp cx, click_width
	jg end_tap
	mov bl, increment
	mov di, bx
	mov bl, [inc_size+di]
	add bx, score
	mov score, bx
	end_tap:
	ret

button_area:
	cmp cx, click_width
	jl end_button
	call get_price
	cmp score, ax
	jl end_button
	inc price
	inc price
	inc increment
	sub score, ax
; TODO Update the image
	call draw_color
	end_button:	
	ret

start:
	mov ax, DATA
	mov ds, ax
	mov ax, myStack
	mov ss, ax

		mov ax, 0Eh
		int 10h ; Set display type
		mov ax, 1
		int 33h		

		call buy_button
	game_loop:
		call update_score
		call update_price
		
		call mouse_listener
		cmp bx, 1
		jne continue
		cmp ax, 1
		jne continue
		cmp dl, padding_top
		jl continue

		mov bh, 0
		push ax
		call tap_area
		call button_area
		pop ax
	continue:
		cmp ax, 2
		jne game_loop

	mov ah, 4Ch
	int 21h
CODE ENDS
END start