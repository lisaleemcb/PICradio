; I don't know how to do this

;includes and such
	processor 16f84
	include <p16f84.inc>
	__config _RC_OSC & _WDT_OFF & _PWRTE_ON

	EQU M 0x01
	EQU PHASEACC 0x02
	
; program body

	org 0

	goto initialize

loop	movf M,0
	addwf PHASEACC,1

	goto convert

	movwf PORTB

	goto loop

initialize:			; prepares PORTB for output, PORTA for input

	return

convert:			; creates sine wave
	; assumes puts value into to the W reg

	return

