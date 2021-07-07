	; � ���� ����� ������������� �������

Reset:	LDI R16, Low(RAMEND)	; ������������� �����
		OUT SPL, R16
		LDI R16, High(RAMEND)
		OUT SPH, R16

		LDI ZL, Low(SRAM_START)		; ������� ����������
		LDI ZH, High(SRAM_START)
		CLR R16
RAM_Clean:ST Z+, R16
		CPI ZH, High(RAMEND)
		BRNE RAM_Clean
		CPI ZL, Low(RAMEND)
		BRNE RAM_Clean

		CLR ZL ; ������� ������
		CLR ZH
		CLR R0
		CLR R1
		CLR R2
		CLR R3
		CLR R4
		CLR R5
		CLR R6
		CLR R7
		CLR R8
		CLR R9
		CLR R10
		CLR R11
		CLR R12
		CLR R13
		CLR R14
		CLR R15
		CLR R16
		CLR R17
		CLR R18
		CLR R19
		CLR R20
		CLR R21
		CLR R22
		CLR R23
		CLR R24
		CLR R25
		CLR R26
		CLR R27
		CLR R28
		CLR R29

		; Internal Hardware Init ================
		LDI		R17,(1<<RXCIE0)		; ��������� ���������� �� ������ ����� USART
		STS		UCSR0B, R17

		SETBR	DDRD, 4, Temp		; ��������� ������
		SETBR	DDRD, 5, Temp
		SETBR	DDRD, 6, Temp

		SETBR	TIMSK2, TOIE2, Temp	; ��������� �������

	;	LDI		R17,(1<<RXCIE0)		; ��������� ���������� ��� ��������� �������� ����� PB1
	;	STS		UCSR0B, R17

		CLR		Temp
		LDI		Temp, 1<<CS01 
		UOUT	TCCR2B, Temp

		SEI							; ��������� ���������� ���������
		; End Internal Hardware Init ============

		; External Hardware Init

		; End External Hardware Init ============

		; �������� ������� ====
		LDI ZL, low(TaskQueue)
		LDI ZH, high(TaskQueue)

		LDI OSRG, $FF
		ST Z+, OSRG
		; �������� ������� ====

		RJMP Main				; � �������� ����
