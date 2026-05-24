ASSUME ds:DATA, ss:myStack, cs:CODE

; https://en.wikipedia.org/wiki/Enhanced_Graphics_Adapter#Color_palette
; https://stackoverflow.com/questions/31748850/size-of-the-8086-code-segment : data segment cannot exceed 65536 bytes
DATA SEGMENT
	index		db 0
	max			db 5
	oob			db 0, 0, 0fh

	char1		db 16, 30, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char11		db 00h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char12		db 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	char13		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	char14		db 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 07h, 08h, 08h, 08h, 08h, 00h, 00h
	char15		db 00h, 08h, 08h, 08h, 08h, 00h, 00h, 08h, 07h, 00h, 00h, 08h, 08h, 08h, 08h, 00h
	char16		db 00h, 00h, 00h, 00h, 00h, 0fh, 08h, 07h, 07h, 08h, 0fh, 00h, 00h, 00h, 00h, 00h
	char17		db 00h, 00h, 00h, 00h, 07h, 0fh, 00h, 0ch, 0ch, 00h, 0fh, 07h, 00h, 00h, 00h, 00h
	char18		db 00h, 00h, 00h, 00h, 00h, 07h, 07h, 07h, 07h, 07h, 07h, 00h, 00h, 00h, 00h, 00h
	char19		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	char110		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char111		db 00h, 00h, 00h, 00h, 00h, 0ch, 03h, 07h, 07h, 03h, 0ch, 00h, 00h, 00h, 00h, 00h
	char112		db 00h, 00h, 00h, 03h, 03h, 0ch, 0ch, 08h, 08h, 0ch, 0ch, 03h, 03h, 00h, 00h, 00h
	char113		db 00h, 00h, 00h, 03h, 03h, 0ch, 0ch, 06h, 06h, 0ch, 0ch, 03h, 03h, 00h, 00h, 00h
	char114		db 00h, 00h, 03h, 03h, 00h, 0ch, 0ch, 06h, 06h, 0ch, 0ch, 00h, 03h, 03h, 00h, 00h
	char115		db 00h, 00h, 03h, 03h, 00h, 0ch, 0ch, 06h, 06h, 0ch, 0ch, 00h, 03h, 03h, 00h, 00h
	char116		db 00h, 03h, 03h, 03h, 00h, 0ch, 0ch, 06h, 06h, 0ch, 0ch, 00h, 03h, 03h, 03h, 00h
	char117		db 00h, 03h, 03h, 03h, 00h, 0ch, 0ch, 08h, 08h, 0ch, 0ch, 00h, 03h, 03h, 03h, 00h
	char118		db 00h, 00h, 03h, 03h, 03h, 00h, 00h, 00h, 00h, 00h, 00h, 03h, 03h, 03h, 00h, 00h
	char119		db 00h, 00h, 00h, 00h, 00h, 09h, 09h, 09h, 09h, 09h, 09h, 00h, 00h, 00h, 00h, 00h
	char120		db 00h, 00h, 00h, 07h, 00h, 09h, 09h, 09h, 09h, 09h, 09h, 00h, 07h, 00h, 00h, 00h
	char121		db 00h, 00h, 00h, 07h, 00h, 09h, 09h, 09h, 09h, 09h, 09h, 00h, 07h, 00h, 00h, 00h
	char122		db 00h, 00h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 00h, 00h
	char123		db 00h, 00h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 00h, 00h
	char124		db 00h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 00h, 00h
	char125		db 00h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 09h, 09h, 00h, 00h, 00h, 00h, 00h
	char126		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char127		db 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char128		db 00h, 00h, 00h, 08h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	char129		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	
	img			db 55, 53, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img1		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img2		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img3		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 04h, 00h, 00h
	img4		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img5		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img6		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h
	img7		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img8		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img9		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img10		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img11		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img12		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img13		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img14		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h
	img15		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img16		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img17		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img18		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img19		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img20		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h, 00h, 00h, 00h
	img21		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img22		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img23		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h, 00h, 00h, 00h
	img24		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img25		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 06h, 07h, 07h, 0ch, 00h, 00h, 00h, 00h, 00h, 00h
	img26		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img27		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img28		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh, 0fh, 0ch, 00h, 00h, 00h, 00h, 00h, 00h
	img29		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h
	img30		db 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img31		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0eh, 08h, 00h, 00h, 00h, 00h, 00h
	img32		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	img33		db 00h, 00h, 00h, 00h, 00h, 00h, 07h, 0fh, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img34		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 07h, 07h, 07h, 08h, 00h, 00h, 08h, 00h, 00h
	img35		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img36		db 00h, 00h, 00h, 00h, 00h, 00h, 07h, 0fh, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img37		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 0fh, 0fh, 07h, 08h, 00h, 00h, 00h, 00h, 00h
	img38		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img39		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h
	img40		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh, 07h, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h
	img41		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img42		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 07h, 0fh, 0ch, 08h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h
	img43		db 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 0fh, 07h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	img44		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img45		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 07h, 0fh, 08h, 08h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 00h
	img46		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 0fh, 07h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	img47		db 00h, 00h, 00h, 04h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img48		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 07h, 07h, 07h, 08h, 00h, 04h, 04h, 04h, 04h, 04h, 00h, 00h
	img49		db 04h, 00h, 08h, 08h, 00h, 00h, 00h, 08h, 07h, 07h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	img50		db 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img51		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 00h, 04h, 00h, 04h, 04h, 04h, 04h, 00h, 00h
	img52		db 00h, 04h, 04h, 04h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img53		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img54		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h, 08h, 04h, 04h, 04h, 00h, 00h
	img55		db 04h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img56		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img57		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 00h, 04h, 00h, 00h, 00h, 04h
	img58		db 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img59		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img60		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 08h, 00h, 08h, 04h, 04h
	img61		db 08h, 00h, 0ch, 0ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img62		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img63		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 0ch, 08h, 00h, 00h, 00h, 08h, 08h
	img64		db 00h, 0eh, 0eh, 0ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img65		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img66		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 0eh, 0ch, 00h, 00h, 00h, 00h, 00h
	img67		db 0ch, 0eh, 0eh, 0ch, 00h, 00h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h, 04h, 04h, 00h
	img68		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img69		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh, 0ch, 00h, 04h, 08h, 00h, 00h
	img70		db 00h, 0ch, 0ch, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 00h, 04h, 00h
	img71		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img72		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 04h, 04h, 08h, 04h, 00h
	img73		db 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 00h, 00h, 00h
	img74		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img75		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 00h, 04h, 04h, 00h, 04h
	img76		db 00h, 04h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 04h, 04h, 00h, 00h, 00h, 00h
	img77		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img78		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h, 0ch, 00h, 00h, 06h, 08h
	img79		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h
	img80		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img81		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 0eh, 00h, 08h, 07h, 00h
	img82		db 08h, 07h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img83		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img84		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 00h, 0ch, 00h, 00h, 08h, 00h
	img85		db 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img86		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img87		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img88		db 00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h
	img89		db 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img90		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img91		db 00h, 00h, 00h, 07h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img92		db 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img93		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 07h, 00h, 00h, 00h
	img94		db 00h, 07h, 00h, 07h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img95		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img96		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 07h, 00h, 00h, 07h
	img97		db 00h, 07h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img98		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img99		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 07h
	img100		db 00h, 00h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img101		db 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img102		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h
	img103		db 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img104		db 04h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img105		db 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h
	img106		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img107		db 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img108		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img109		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img110		db 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img111		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img112		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img113		db 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img114		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img115		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img116		db 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img117		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img118		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h
	img119		db 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img120		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img121		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h
	img122		db 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img123		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 04h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img124		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h
	img125		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img126		db 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img127		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 04h, 04h, 04h
	img128		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img129		db 00h, 00h, 00h, 00h, 04h, 00h, 04h, 08h, 00h, 00h, 00h, 04h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img130		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 04h, 04h, 00h, 08h, 00h, 00h
	img131		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img132		db 00h, 00h, 00h, 00h, 04h, 00h, 04h, 00h, 00h, 00h, 00h, 04h, 06h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img133		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 04h, 00h, 00h, 04h, 04h, 00h
	img134		db 00h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img135		db 00h, 00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h, 0ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img136		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 08h, 00h, 00h, 04h, 04h, 00h
	img137		db 00h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img138		db 00h, 00h, 00h, 00h, 08h, 00h, 07h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img139		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 04h, 00h, 00h
	img140		db 00h, 08h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img141		db 00h, 00h, 00h, 00h, 08h, 00h, 07h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img142		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h
	img143		db 00h, 07h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img144		db 00h, 00h, 00h, 00h, 00h, 06h, 00h, 0eh, 0ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img145		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 08h, 00h, 00h
	img146		db 00h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img147		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img148		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h, 00h
	img149		db 0eh, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img150		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img151		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h
	img152		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img153		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 08h, 00h
	img154		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 00h, 00h, 00h, 08h, 00h
	img155		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img156		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img157		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	img158		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	
	ruby		db 22, 37, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	ruby1		db 00h, 00h
	ruby2		db 00h, 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h, 00h, 00h
	ruby3		db 00h, 00h
	ruby4		db 00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h, 00h
	ruby5		db 00h, 00h
	ruby6		db 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h, 00h
	ruby7		db 00h, 00h
	ruby8		db 00h, 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby9		db 00h, 00h
	ruby10		db 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby11		db 00h, 00h
	ruby12		db 00h, 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 06h, 04h, 04h, 06h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby13		db 00h, 00h
	ruby14		db 00h, 00h, 04h, 04h, 04h, 04h, 0ch, 04h, 04h, 00h, 00h, 04h, 08h, 00h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby15		db 00h, 00h
	ruby16		db 00h, 00h, 04h, 04h, 04h, 04h, 0ch, 04h, 07h, 07h, 08h, 0ch, 07h, 08h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby17		db 00h, 00h
	ruby18		db 00h, 04h, 04h, 04h, 04h, 04h, 04h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 04h, 04h, 04h, 00h, 00h, 00h
	ruby19		db 00h, 00h
	ruby20		db 00h, 04h, 04h, 04h, 04h, 04h, 04h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 04h, 04h, 04h, 00h, 00h, 00h
	ruby21		db 00h, 00h
	ruby22		db 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 06h, 0ch, 0ch, 0ch, 0ch, 04h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby23		db 00h, 00h
	ruby24		db 00h, 04h, 04h, 04h, 04h, 08h, 09h, 08h, 06h, 06h, 06h, 08h, 08h, 04h, 04h, 04h, 04h, 00h, 00h, 00h
	ruby25		db 00h, 00h
	ruby26		db 00h, 04h, 04h, 04h, 09h, 09h, 09h, 09h, 08h, 06h, 06h, 07h, 09h, 09h, 08h, 04h, 00h, 00h, 00h, 00h
	ruby27		db 00h, 00h
	ruby28		db 00h, 04h, 04h, 09h, 09h, 09h, 09h, 09h, 09h, 08h, 06h, 07h, 09h, 09h, 09h, 08h, 00h, 00h, 08h, 00h
	ruby29		db 00h, 00h
	ruby30		db 04h, 04h, 0ch, 07h, 09h, 09h, 09h, 09h, 09h, 09h, 08h, 08h, 09h, 09h, 09h, 09h, 08h, 00h, 00h, 08h
	ruby31		db 00h, 00h
	ruby32		db 04h, 04h, 0ch, 0ch, 07h, 09h, 09h, 09h, 09h, 09h, 08h, 08h, 09h, 09h, 09h, 09h, 08h, 00h, 00h, 00h
	ruby33		db 08h, 00h
	ruby34		db 04h, 04h, 0ch, 0ch, 0ch, 07h, 09h, 09h, 09h, 09h, 09h, 08h, 08h, 09h, 09h, 08h, 08h, 00h, 00h, 00h
	ruby35		db 08h, 00h
	ruby36		db 04h, 04h, 0ch, 0ch, 0ch, 07h, 08h, 09h, 09h, 09h, 09h, 08h, 08h, 09h, 09h, 08h, 08h, 00h, 00h, 00h
	ruby37		db 08h, 00h
	ruby38		db 04h, 04h, 0ch, 0ch, 07h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 04h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	ruby39		db 00h, 08h
	ruby40		db 04h, 04h, 0ch, 0ch, 07h, 08h, 08h, 08h, 08h, 08h, 08h, 04h, 04h, 04h, 00h, 00h, 08h, 08h, 00h, 00h
	ruby41		db 00h, 08h
	ruby42		db 04h, 04h, 0ch, 0ch, 07h, 08h, 08h, 08h, 08h, 08h, 08h, 04h, 04h, 04h, 08h, 08h, 08h, 08h, 00h, 00h
	ruby43		db 00h, 08h
	ruby44		db 04h, 04h, 0ch, 0ch, 0ch, 07h, 08h, 08h, 00h, 08h, 08h, 08h, 04h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	ruby45		db 00h, 08h
	ruby46		db 04h, 04h, 00h, 0ch, 0ch, 0ch, 08h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	ruby47		db 00h, 08h
	ruby48		db 00h, 04h, 08h, 0ch, 0ch, 0ch, 08h, 00h, 07h, 0fh, 0fh, 0fh, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	ruby49		db 08h, 00h
	ruby50		db 00h, 04h, 08h, 08h, 0ch, 08h, 00h, 07h, 07h, 07h, 07h, 0fh, 0fh, 0fh, 0fh, 08h, 08h, 00h, 00h, 00h
	ruby51		db 08h, 00h
	ruby52		db 00h, 08h, 08h, 08h, 08h, 00h, 00h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 08h
	ruby53		db 00h, 00h
	ruby54		db 00h, 08h, 08h, 08h, 08h, 00h, 00h, 08h, 08h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 0fh, 0fh, 0fh, 0fh
	ruby55		db 07h, 00h
	ruby56		db 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 0fh
	ruby57		db 0fh, 0fh
	ruby58		db 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 08h, 08h, 08h, 08h, 07h, 07h, 07h, 07h, 07h, 07h
	ruby59		db 07h, 0fh
	ruby60		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 07h, 07h
	ruby61		db 07h, 07h
	ruby62		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	ruby63		db 00h, 00h
	ruby64		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	ruby65		db 00h, 00h
	ruby66		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	ruby67		db 00h, 00h
	ruby68		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	ruby69		db 00h, 00h
	ruby70		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	ruby71		db 00h, 00h
	ruby72		db 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	ruby73		db 00h, 00h
	
	char2		db 14, 29, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char21		db 00h, 00h, 00h, 00h, 0eh, 0ch, 0eh, 0eh, 0ch, 0eh, 00h, 00h, 00h, 00h
	char22		db 00h, 00h, 00h, 0eh, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0eh, 00h, 00h, 00h
	char23		db 00h, 00h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 00h, 00h
	char24		db 00h, 0ch, 0ch, 0ch, 0ch, 07h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 00h, 00h
	char25		db 0ch, 0ch, 0ch, 0ch, 00h, 00h, 07h, 07h, 00h, 00h, 0ch, 0ch, 0ch, 00h
	char26		db 00h, 0ch, 0ch, 00h, 07h, 08h, 07h, 07h, 08h, 07h, 00h, 0ch, 0ch, 0ch
	char27		db 00h, 0ch, 0ch, 07h, 0fh, 00h, 07h, 07h, 00h, 0fh, 07h, 0ch, 0ch, 0ch
	char28		db 00h, 0ch, 0ch, 0ch, 07h, 07h, 07h, 07h, 07h, 07h, 0ch, 0ch, 0ch, 00h
	char29		db 00h, 0ch, 0ch, 0ch, 0ch, 07h, 07h, 07h, 07h, 0ch, 0ch, 0ch, 00h, 00h
	char210		db 00h, 0ch, 0ch, 0ch, 0ch, 0ch, 07h, 07h, 0ch, 0ch, 0ch, 0ch, 00h, 00h
	char211		db 00h, 0ch, 00h, 00h, 07h, 07h, 07h, 07h, 07h, 07h, 00h, 00h, 00h, 00h
	char212		db 00h, 00h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 00h, 00h
	char213		db 00h, 00h, 07h, 07h, 07h, 0fh, 07h, 07h, 0fh, 07h, 07h, 07h, 00h, 00h
	char214		db 00h, 07h, 07h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 07h, 07h, 07h, 00h
	char215		db 00h, 07h, 07h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 07h, 07h, 07h, 00h
	char216		db 00h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h, 00h
	char217		db 00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 00h, 00h
	char218		db 00h, 00h, 07h, 00h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 00h, 07h, 00h, 00h
	char219		db 00h, 00h, 00h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 00h, 00h, 00h
	char220		db 00h, 00h, 00h, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 0ch, 00h, 00h, 00h
	char221		db 00h, 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 00h
	char222		db 00h, 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 00h
	char223		db 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 00h
	char224		db 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 0ch, 0ch, 00h, 00h, 00h, 00h
	char225		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char226		db 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 07h, 07h, 00h, 00h, 00h, 00h
	char227		db 00h, 00h, 08h, 08h, 08h, 00h, 00h, 00h, 07h, 07h, 07h, 00h, 00h, 00h
	char228		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	
	char3		db 17, 31, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char31		db 00h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char32		db 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char33		db 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	char34		db 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	char35		db 00h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 0ch, 08h, 08h, 08h, 08h, 00h, 00h
	char36		db 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 00h, 00h, 08h, 08h, 08h, 00h, 00h
	char37		db 00h, 08h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 08h, 07h, 0ch, 08h, 08h, 00h, 00h
	char38		db 00h, 00h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 07h, 00h, 0fh, 0ch, 08h, 08h, 00h, 00h
	char39		db 00h, 00h, 00h, 08h, 08h, 08h, 00h, 07h, 07h, 07h, 07h, 07h, 08h, 08h, 00h, 00h, 00h
	char310		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 07h, 07h, 07h, 07h, 08h, 08h, 00h, 00h, 00h, 00h
	char311		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 0ch, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char312		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 0eh, 07h, 07h, 0eh, 08h, 00h, 00h, 00h, 00h, 00h
	char313		db 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 0eh, 0eh, 08h, 08h, 08h, 08h, 00h, 00h, 00h
	char314		db 00h, 00h, 00h, 00h, 08h, 08h, 08h, 08h, 08h, 0eh, 09h, 09h, 08h, 08h, 00h, 00h, 00h
	char315		db 00h, 00h, 00h, 08h, 08h, 00h, 08h, 08h, 08h, 09h, 09h, 08h, 00h, 08h, 08h, 00h, 00h
	char316		db 00h, 00h, 00h, 08h, 08h, 00h, 08h, 08h, 08h, 09h, 08h, 08h, 00h, 08h, 08h, 00h, 00h
	char317		db 00h, 00h, 09h, 09h, 09h, 00h, 09h, 09h, 08h, 08h, 08h, 08h, 00h, 09h, 09h, 09h, 00h
	char318		db 00h, 00h, 00h, 07h, 07h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 07h, 00h, 00h
	char319		db 00h, 00h, 00h, 07h, 07h, 0ch, 00h, 00h, 00h, 00h, 00h, 00h, 0ch, 07h, 07h, 00h, 00h
	char320		db 00h, 00h, 00h, 00h, 07h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 00h, 00h, 00h
	char321		db 00h, 00h, 00h, 00h, 0ch, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 0ch, 00h, 00h, 00h
	char322		db 00h, 00h, 00h, 00h, 07h, 00h, 08h, 08h, 08h, 08h, 08h, 08h, 00h, 07h, 00h, 00h, 00h
	char323		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char324		db 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char325		db 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char326		db 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char327		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	char328		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 00h, 00h, 00h, 00h, 00h
	char329		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 08h, 08h, 08h, 00h, 00h, 00h, 00h
	char330		db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
DATA ENDS

myStack SEGMENT STACK
	db 100 dup(?)
myStack ENDS

CODE SEGMENT

key_listener: ; al
	mov ah, 08h
	int 21h
	ret

write_pixel: ; al = color value, cx = column, dx = row
	mov ah, 0Ch
	mov bh, 0
	int 10h
	ret

draw_image: ; bl = width, bh = height, [si] = img?
	mov dx, 0
	img_v:
		mov cx, 0
		img_h:
			; TODO Clear image
			mov al, 0
			cmp cl, bl
			jge clear_pxl
			cmp dl, bh
			jge clear_pxl
			mov al, [si]
			inc si
		clear_pxl:
			push bx
			call write_pixel
			pop bx
			inc cl
			cmp cl, 125
			jl img_h
		inc dl
		cmp dl, 125
		jl img_v
	ret

update_image:
	cmp index, 0
	je update_0
	cmp index, 1
	je update_1
	cmp index, 2
	je update_2
	cmp index, 3
	je update_3
	cmp index, 4
	je update_4
	lea si, oob
	jmp end_update
	update_0:
		lea si, char1
		jmp end_update
	update_1:
		lea si, img
		jmp end_update
	update_2:
		lea si, ruby
		jmp end_update
	update_3:
		lea si, char2
		jmp end_update
	update_4:
		lea si, char3
		jmp end_update
	end_update:
		mov bl, [si]
		inc si
		mov bh, [si]
		inc si
		call draw_image
	ret

next_image:
	inc index
	mov bl, max
	cmp index, bl
	jl no_reset_next
	mov index, 0
	no_reset_next:
	ret

prev_image:
	cmp index, 0
	jg no_reset_prev
	mov bl, max
	mov index, bl
	no_reset_prev:
	dec index
	ret

start:
	mov ax, DATA
	mov ds, ax
	mov ax, myStack
	mov ss, ax

		mov ax, 0Dh
		int 10h ; Set display type
	game_loop:
		call update_image
		call key_listener
		cmp al, 'a'
		je prev
		cmp al, 'd'
		je next
		cmp al, ' '
		je end_game
		jmp game_loop
	prev:
		call prev_image
		jmp game_loop
	next:
		call next_image
		jmp game_loop
	end_game:
		
	mov ah, 4Ch
	int 21h
CODE ENDS
END start