ASSUME cs:CODE, ds:DATA, ss:myStack
DATA SEGMENT

; 1 = JOKER
; X = Ten
; L = Leave
; suits start at 3 and end at 6

; Deck data
	deck_count		db	54
	faces			db	'A23456789XJQK'
	old_random		db	0

; Displays
	welcome			db	'This game is an iteration on Donsol', 10, 1, ' will denote the Joker and X will denote the Ten', '$'
	line			db	10, 10, '---------------------------------------------------', 10, 10, '$'
	card_use		db	'Cards left: $'
	dmg_name		db	'Damage: $'
	dmg_denom		db	'/21$'
	def_name		db	'Defense: $'
	cl_name			db	'Current Lowest: $'
	question_num	db	'Pick a card from position 1-4: $'
	leave_txt		db	'You can leave the room with L', 10, '$'
	lose_txt		db	'You lose', 10, '$'
	win_txt			db	'You win', 10, '$'
	end_game_txt	db	'Game has ended!!!', 10, '$'

	deck			db	108 dup(0)
	hand_count		db	0
	current_hand	db	8 dup(?)

; Player data
	current_damage	db	0
	defense			db	0
	current_lowest	db	0
	can_retreat		db	0	; TRUE

DATA ENDS

myStack SEGMENT STACK	; Required
;	db 100 dup(?)		; Not needed here as there is no pushing but useful for other projects
myStack ENDS

CODE SEGMENT

; --- Subject to change depending on the random number values and if the full register is used ----------------------------------

seed_generation:				; Gets the current time and uses that as the seed
		mov ah, 2ch
		int 21h
		mov old_random, dl
		ret

get_card:						; Uses the random number and mods by 54 to get card in ax
		call random_number
		mov al, ah
		mov ah, 0
		mov bl, 54
		div bl
	; Gets the card position at ah
		shl ah, 1
		mov al,ah
		mov ah, 0
		mov si, ax
		mov ah, deck[si]
		inc si
		mov al, deck[si]
		ret

; multiplier and the mod is the highest count
; adder > 2 * deck size remove those with 1 at the end and those with repeate numbers then take average
; 109, 127, 137, 139, 149, 157
random_number:
		mov ah, 0
		mov al, old_random
		mov bl, 211
		mul bl
		add ax, 137
		mov bl, 243
		div bl
		mov old_random, ah
		ret

temp_remove_cards:
		mov cl, 0
		; change the seed
	card_remove_loop:
		call random_number
		mov al, ah
		mov ah, 0
		mov bl, 54
		div bl
		mov al, ah
		mov ah, 0
		shl al, 1
		mov si, ax
		mov deck[si], 0
		inc si
		mov dl, deck[si]
		cmp dl, 0
		je no_card
		inc cl
		mov deck[si], 0
	no_card:
		cmp cl, 54
		jl card_remove_loop
		ret

; -----------------------------------------------------------------------------------------------------------------

make_deck:
		mov si, 0 ; deck counter location
		mov di, 0 ; face counter
		mov dl, 3 ; suit counter
	face_loop:
		mov dl, 3
	suit_loop:
		mov al, faces[di]
		mov deck[si], al
		inc si
		mov deck[si], dl
		inc si
		inc dl		
		cmp dl, 6
		jle suit_loop
		inc di
		cmp di, 13
		jne face_loop
	; Adding the JOKERS
		mov deck[si], 0
		inc si
		mov deck[si], 1
		inc si
		mov deck[si], 0
		inc si
		mov deck[si], 1
		ret

temp_deck_display:
		mov si, 0
	deck_display_loop:
		mov dl, deck[si]
		call display_char
		inc si
		cmp si, 108
		jne deck_display_loop
		ret

; TODO repeating cards
set_current_hand:
		cmp deck_count, 4
		jl less_cards
		mov hand_count, 8
		jmp set_hand
	less_cards:
		mov dl, deck_count
		shl dl, 1
		mov hand_count, dl
	set_hand:
		mov di, 0
		mov dl, hand_count
		mov dh, 0
	set_hand_loop:
		call get_card
		cmp al, 0
		je set_hand_loop
		mov si, 0
	check_hand:
		mov bh, current_hand[si]
		inc si
		mov bl, current_hand[si]
		cmp bx, ax
		je set_hand_loop
		inc si
		cmp si, di
		jl check_hand
	; add the card to the hand
		mov current_hand[di], ah
		inc di
		mov current_hand[di], al
		inc di
		cmp di, dx
		jl set_hand_loop
		ret

no_attacker:					; Checks for attacker and only changes can_retreat to true
		mov si, 0
		mov cl, hand_count
		mov ch, 0
	hand_loop:
		mov ax, si
		mov bl, 2
		div bl
		cmp ah, 0
		je no_suit
		mov bl, current_hand[si]
		cmp bl, 5
		je end_search
		cmp bl, 6
		je end_search
		cmp bl, 1
		je end_search
	no_suit:
		inc si
		cmp si, cx
		jl hand_loop
		mov can_retreat, 0
	end_search:
		ret

has_attacker:					; Checks for attacker and only changes can_retreat to false
		mov si, 0
		mov cl, hand_count
		mov ch, 0
	attack_hand_loop:
		mov ax, si
		mov bl, 2
		div bl
		cmp ah, 0
		je no_attack_suit
		mov bl, current_hand[si]
		cmp bl, 5
		je attacker
		cmp bl, 6
		je attacker
		cmp bl, 1
		je attacker
	no_attack_suit:
		inc si
		cmp si, cx
		jl attack_hand_loop
		jmp end_attack_search
	attacker:
		mov can_retreat, 1
	end_attack_search:
		ret

attack:							; damage is al and the face is dh
	; Setup the damage for faces
		cmp dh, 'A'
		je ace
		cmp dh, 'Q'
		je queen
		cmp dh, 'K'
		je king
		jmp start_attack
	ace:
		mov al, 17
		jmp start_attack
	queen:
		mov al, 13
		jmp start_attack
	king:
		mov al, 15

	start_attack:
		mov bl, current_lowest
		mov bh, defense
		cmp bl, al
		jle reset_attack
	cont_elseif:
		cmp bh, 0
		jne set_current_lowest
		jmp set_damage_amount

	reset_attack:
		cmp bl, 0
		je cont_elseif	; If it is equal that means that it is the wrong time; current_lowest <= amount AND current_lowest != 0
		mov defense, 0
		mov current_lowest, 0
		jmp set_damage_amount

	set_current_lowest:
		mov current_lowest, al
	set_damage_amount:
		cmp al, bh
		jl end_attack
		sub al, bh
		add current_damage, al
	end_attack:
		ret

heal:							; Heal by al
		mov ah, current_damage
		cmp ah, al
		jg heal_some
		mov ah, 0
		jmp heal_amount
	heal_some:
		sub ah, al
	heal_amount:
		mov current_damage, ah
		ret

defend:							; Alter the defense to be al
		mov defense, al
		mov current_lowest, 0
		ret

remove_card:	; dx is the card
		mov si, 0
	remove_card_loop:
		mov ah, deck[si]
		inc si
		mov al, deck[si]
		inc si
		cmp dx, ax
		je end_remove
		cmp si, 108
		jne remove_card_loop
	end_remove:
		dec si
		mov deck[si], 0
		dec si
		mov deck[si], 0
		ret

select_card:					; al is the card position
		shl al, 1
		mov ah, 0
		cmp al, hand_count
		jg end_selection ; for the times that the hand has less than 4
		mov si, ax
		mov dh, current_hand[si]
		cmp dh, '-'
		je end_selection
		mov current_hand[si], '-'
		inc si
		mov dl, current_hand[si]
		mov current_hand[si], '-'
		call remove_card
		dec deck_count

action_of_card:					; dx is the card; dh is face and dl is the suit
		cmp dh, 'A'
		je is_face
		cmp dh, 'J'
		je is_face
		cmp dh, 'Q'
		je is_face
		cmp dh, 'K'
		je is_face
		cmp dh, 1
		je is_face
		cmp dh, 'X'
		je is_ten
		jmp is_number
	is_face:
		mov al, 11
		jmp switch_suit
	is_ten:
		mov al, 10
		jmp switch_suit
	is_number:
		mov al, dh
		sub al, '0'

	switch_suit:
		cmp dl, 3
		je call_heal
		cmp dl, 4
		je call_defend
		cmp dl, 5
		je call_attack	; al is the damage
		cmp dl, 6
		je call_attack
		cmp dl, 1
		mov al, 21
		je call_attack
	call_heal:
		call heal
		jmp end_selection
	call_defend:
		call defend
		jmp end_selection
	call_attack:
		call attack
	end_selection:
		ret

display_hand:					; Displays the full hand and current data
		lea dx, card_use
		call display_phrase
		mov al, deck_count
		call display_number
		mov dl, 10
		call display_char
		mov si, 0
		mov bl, hand_count
	display_card_loop:
		mov dl, current_hand[si]
		call display_char
		mov ax, si
		mov dl, 2
		div dl
		cmp ah, 0
		je tab_skip	; Used to seperate the cards
		mov dl, ' '
		call display_char
		call display_char
	tab_skip:
		inc si
		mov ax, si
		mov ah, 0
		cmp al, bl
		jl display_card_loop

		mov dl, 10
		call display_char
	; Show player data
		lea dx, dmg_name
		call display_phrase
		mov al, current_damage
		call display_number
		lea dx, dmg_denom
		call display_phrase
		mov dl, ' '
		call display_char
		call display_char
		lea dx, def_name
		call display_phrase
		mov al, defense
		call display_number

		cmp current_lowest, 0	; current lowest for the defense
		je end_hand_display
		mov dl, 10
		call display_char
		lea dx, cl_name
		call display_phrase
		mov al, current_lowest
		call display_number
	end_hand_display:
		mov dl, 10
		call display_char
		ret


display_phrase:					; Displays whatever is stored in dx via lea until $
		mov ah, 9h
		int 21h
		ret

display_char:					; Display a character from dl
		mov ah, 2h
		int 21h
		ret

display_number:					; Displays the number value of the ascii al
		mov ah, 0
		mov bl, 10
		div bl
		mov dl, al
		mov bl, ah
		cmp dl, 0
		je single_digit
		add dl, '0'
	single_digit:
		call display_char
		mov dl, bl
		add dl, '0'
		call display_char
		ret

get_char:						; al is the charater inputed
		mov ah, 1h
		int 21h
		ret

; --- Main Function --------------------------------------------------------------------------------------------------------------------

start: 
	;Perform initialization 
		mov ax, DATA				;Put the starting address of the data segment into the ax register (must do this first)
		mov ds, ax					;Put the starting address of the data segment into the ds register (where it belongs)

		call seed_generation	; May be commented
		call make_deck
		call set_current_hand
		lea dx, welcome
		call display_phrase
		lea dx, line
		call display_phrase		

game_loop:
		call display_hand
; Check to see if there is a black suit and set it to 0 if there isn't
		call no_attacker
		cmp can_retreat, 0
		jne hide_leave_txt
		lea dx, leave_txt
		call display_phrase
	hide_leave_txt:
		lea dx, question_num
		call display_phrase
		call get_char
		lea dx, line
		call display_phrase

		cmp al, 1bh		; Escape character
		je end_game
		cmp al, 'L'
		je retreating
		cmp al, '1'
		je call_play_card
		cmp al, '2'
		je call_play_card
		cmp al, '3'
		je call_play_card
		cmp al, '4'
		je call_play_card
		jmp not_card

	retreating:
		cmp can_retreat, 0
		jne cannot_retreat
		call has_attacker
		call set_current_hand
	cannot_retreat:
		jmp not_card

	call_play_card:
		sub al, '1'
		call select_card
	not_card:
		cmp current_damage, 21
		jge lose_game
		cmp deck_count, 0 ; change depending on how the deck and hand will be created
		je win_game
		jmp game_loop

lose_game:
		lea dx, lose_txt
		call display_phrase
		jmp end_game
win_game:
		lea dx, win_txt
		call display_phrase
end_game:
		lea dx, end_game_txt
		call display_phrase

		mov ah, 4ch					;Set up code to specify return to dos
        int 21h						;Return control to dos prompt

CODE ENDS
END start