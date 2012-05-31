; Lisa McBride & Jared Kofron
; PHYS 335 - PIC radio project
; v0.1

;includes and such
	processor 16f84
	include <p16f84.inc>
	__config _RC_OSC & _WDT_OFF & _PWRTE_ON

	EQU M 0x01 		; FIX MY ADDRESSES
	EQU PHASEACC 0x02
	EQU TEMP		; TEMP VARIABLE, FIX ME
	
; program body

	org 0

	goto initialize
loop	movf M,0
	addwf PHASEACC,1
	
	btfsc PHASEACC,7
	call MSB7Set

	btfss PHASEACC,7
	call MSB7notSet
	goto loop

initialize:			; prepares PORTB for output, PORTA for input

	return

MSB7Set:
	btfsc PHASEACC,6
	goto MSB6Set
	movlf 0x3F
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
	goto MSB6Set
	movlf 0x3F
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