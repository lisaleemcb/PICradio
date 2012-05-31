; Lisa McBride & Jared Kofron
; PHYS 335 - PIC radio project
; v0.2

;includes and such
	processor 16f84
	include <p16f84.inc>
	__config _RC_OSC & _WDT_OFF & _PWRTE_ON

	EQU M 		0x1C 
	EQU PHASEACC 	0x1D
	EQU TEMP	0x1E
	
; program body

	org 0

	goto initialize
loop	movf M,0		; beginning of sine wave construction
	addwf PHASEACC,1
	
	btfsc PHASEACC,7	; checks the PHASEACC register quadrant
	call MSB7Set

	btfss PHASEACC,7
	call MSB7notSet
	goto loop

initialize:			; prepares PORTB for output, PORTA for input
	bcf STATUS,RP0
	clrf PORTB
	bsf STATUS,RP0
	clrf PORTB
	bcf STATUS,RP0
	return

MSB7Set:
	btfsc PHASEACC,6
	goto MSB6Set		; PHASEACC is in Quadrant IV
	movlf 0x3F		; PHASEACC is in Quadrant III
	andwf PHASEACC,0
	sublw 0x100
	call lut
	movwf PORTB
	goto end

MSB6Set
	movlf 0x3F
	movwf TEMP
	andwf PHASEACC,0
	subwf TEMP,0
	sublw 0x100
	call lut
	movwf PORTB
	goto end
end	noop
	return

MSB7notSet:
	btfsc PHASEACC,6
	goto MSB6Set		; PHASEACC is in Quadrant II
	movlf 0x3F		; PHASEACC is in Quadrant I
	andwf PHASEACC,0
	call lut
	movwf PORTB
	goto end

MSB6Set
	movlw 0x3F
	movwf TEMP
	andwf PHASEACC,0
	subwf TEMP,0
	call lut
	movwf PORTB
	goto end
end	nop
	return


lut
	addwf PCL

	dt	0x80,0x83,0x86,0x89,0x8c,0x8f,0x92,0x95
	dt	0x98,0x9c,0x9f,0xa2,0xa5,0xa8,0xab,0xae
	dt	0xb0,0xb3,0xb6,0xb9,0xbc,0xbf,0xc1,0xc4
	dt	0xc7,0xc9,0xcc,0xce,0xd1,0xd3,0xd5,0xd8
	dt	0xda,0xdc,0xde,0xe0,0xe2,0xe4,0xe6,0xe8
	dt	0xea,0xec,0xed,0xef,0xf0,0xf2,0xf3,0xf5
	dt	0xf6,0xf7,0xf8,0xf9,0xfa,0xfb,0xfc,0xfc
	dt	0xfd,0xfe,0xfe,0xff,0xff,0xff,0xff,0xff

	end			; end program