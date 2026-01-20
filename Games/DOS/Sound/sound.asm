ASSUME ds:DATA, ss:myStack, cs:CODE

DATA SEGMENT
	hello	db  "Hello World$"
	EIGHTH	equ 3
DATA ENDS

myStack SEGMENT STACK
	db 100 dup(?)
myStack ENDS

CODE SEGMENT

; http://muruganad.com/8086/8086-assembly-language-program-to-play-sound-using-pc-speaker.html	

set_sound_port:
		mov al, 182
		out 43h, al
		ret

set_note:			; bx is the note to play
		mov al, bl
		out 42h, al
		mov al, bh
		out 42h, al
		ret

start_sound:
		in al, 61h
		or al, 3
		out 61h, al
		ret

delay:					; cx, dx will hold length
	; This is a bug in DOSBOX not the system?
		mov al, 0
		mov ah, 86h
		int 15h
		ret

play_sound:
		call set_note
		mov bl, dl
		call delay
		ret

end_sound:
		in al, 61h
		and al, 0FCh
		out 61h, al
		ret
; https://musescore.com/user/2891181/scores/907946
mule:
		mov cx, EIGHTH
		mov bx, 3619
		call play_sound
		mov cx, EIGHTH
		mov bx, 1809
		call play_sound
		mov cx, EIGHTH
		mov bx, 5746
		call play_sound
		mov cx, EIGHTH
		mov bx, 2873
		call play_sound

		mov cx, EIGHTH
		mov bx, 5423
		call play_sound
		mov cx, EIGHTH
		mov bx, 2711
		call play_sound
		mov cx, EIGHTH
		mov bx, 5119
		call play_sound
		mov cx, EIGHTH
		mov bx, 2559
		call play_sound
		
	; ---------------------
		
		mov cx, EIGHTH
		mov bx, 4831
		call play_sound
		mov cx, EIGHTH
		mov bx, 2415
		call play_sound
		mov cx, EIGHTH
		mov bx, 4304
		call play_sound
		mov cx, EIGHTH
		mov bx, 2152
		call play_sound
		
		mov cx, EIGHTH
		mov bx, 4063
		call play_sound
		mov cx, EIGHTH
		mov bx, 2031
		call play_sound
		mov cx, EIGHTH
		mov bx, 3834
		call play_sound
		mov cx, EIGHTH
		mov bx, 1917
		call play_sound

	; --------------------

		mov cx, EIGHTH
		mov bx, 3619
		call play_sound
		mov cx, EIGHTH
		mov bx, 1809
		call play_sound
		mov cx, EIGHTH
		mov bx, 5746
		call play_sound
		mov cx, EIGHTH
		mov bx, 2873
		call play_sound

		mov cx, EIGHTH
		mov bx, 5423
		call play_sound
		mov cx, EIGHTH
		mov bx, 2711
		call play_sound
		mov cx, EIGHTH
		mov bx, 5119
		call play_sound
		mov cx, EIGHTH
		mov bx, 2559
		call play_sound
		
	; ---------------------
		
		mov cx, EIGHTH
		mov bx, 4831
		call play_sound
		mov cx, EIGHTH
		mov bx, 2415
		call play_sound
		mov cx, EIGHTH
		mov bx, 4304
		call play_sound
		mov cx, EIGHTH
		mov bx, 2152
		call play_sound
		
		mov cx, EIGHTH
		mov bx, 4063
		call play_sound
		mov cx, EIGHTH
		mov bx, 2031
		call play_sound
		mov cx, EIGHTH
		mov bx, 3834
		call play_sound
		mov cx, EIGHTH
		mov bx, 1917
		call play_sound
		
	; -----------------------------
		ret

start:
		mov ax, DATA
		mov ds, ax

		call set_sound_port
		call start_sound
		
		call mule
		call end_sound
		mov ah, 4Ch
		int 21h
CODE ENDS
END start