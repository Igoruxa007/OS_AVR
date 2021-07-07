		; Interrupts
USART:	LDS R16, UDR0	; USART
		RETI

Timer0_OV:
		PUSHSREG
		PUSH	OSRG
		PUSH	R18
		PUSH	R19

		INCM	CCNT

		CPI OSRG, $FF
		BRNE End_timer

		SUBI LED_Counter, (-1)

		LDI		R21, $10
		IN		R22, PORTD
		AND		R21, R22
		CPI R21, $10
		BRNE TikTak
		CPI LED_Counter, $10  ;$10 = 1 sek
		BRNE End_timer
		CLR		LED_Counter
		LDI		OSRG, TS_Proc3
		RCALL	SendTask
		
TikTak:
		CPI LED_Counter, $F0  ;$50 = 5 sek
		BRNE End_timer

		CLR		LED_Counter
		LDI		OSRG, TS_Proc1
		RCALL	SendTask

End_timer:
		POP		R19
		POP		R18
		POP		OSRG
		POPSREG
		RETI
		; End Interrupts ==========================
