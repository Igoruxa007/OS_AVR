		; таблица прерываний ====================================
	.ORG 0x00			; Reset
		RJMP Reset
	.ORG 0x02			; (INT0) External Interrupt Request 0
		RETI
	.ORG 0x04			; (INT1) External Interrupt Request 1
		RETI
	.ORG 0x06			; Pin Change Interrupt Request 0
		RETI
	.ORG 0x08			; Pin Change Interrupt Request 1
		RETI
	.ORG 0x0A			; Pin Change Interrupt Request 2
		RETI
	.ORG 0x0C			; Watchdog Time-out Interrupt
		RETI
	.ORG 0x0E			; Timer/Counter2 Compare Match A
		RETI
	.ORG 0x10			; Timer/Counter2 Compare Match A
		RETI
	.ORG 0x12			; Timer/Counter2 Overflow
		RJMP	Timer0_OV
	.ORG 0x14			; Timer/Counter1 Capture Event
		RETI
	.ORG 0x16			; Timer/Counter1 Compare Match A
		RETI
	.ORG 0x18			; Timer/Counter1 Compare Match B
		RETI
	.ORG 0x1A			; Timer/Counter1 Overflow
		RETI
	.ORG 0x1C			; TimerCounter0 Compare Match A
		RETI
	.ORG 0x1E			; TimerCounter0 Compare Match B
		RETI
	.ORG 0x20			; Timer/Couner0 Overflow
		RJMP	Timer0_OV
	.ORG 0x22			; SPI Serial Transfer Complete
		RETI
	.ORG 0x24			; USART Rx Complete
		RJMP USART		; —сылка на обработчик прерывани€ по USART READ
	.ORG 0x26			; USART, Data Register Empty
		RETI
	.ORG 0x28			; USART Tx Complete
		RETI
	.ORG 0x2A			; ADC Conversion Complete
		RETI
	.ORG 0x2C			; EEPROM Ready
		RETI
	.ORG 0x2E			; Analog Comparator
		RETI
	.ORG 0x30			; Two-wire Serial Interface
		RETI
	.ORG 0x32			; Store Program Memory Read
		RETI
