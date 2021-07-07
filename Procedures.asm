	; «десь расположены процедуры

		; equ ====================================
		; ѕеременные дл€ записи в очередь, номер переменной должен соответствовать
		; пор€дковому номеру в таблице переходов
		.equ TS_Idle = 0
		.equ TS_Wait = 1
		.equ TS_Proc1 = 2
		.equ TS_Proc2 = 3
		.equ TS_Proc3 = 4

		; “аблица переходов =======================
TaskProcs:
		.dw Idle		; 00
		.dw Wait		; 01
		.dw Proc1		; 02
		.dw Proc2		; 03
		.dw Proc3		; 04
		
		; Procedure ==============================

							; Idel ==
Idle:	NOP
		NOP
		RET

							; Wait ==
		.equ Delay =5
Wait:	LDI		R17, Delay		
M3:		DEC		R17
		NOP
		BRNE	M3
		Ret

							; Proc1 ==
Proc1:	INVB	PORTD, 4
		Ret

							; Proc2 ==
Proc2:	SETB	PORTD, 7, Temp
		Ret

							; Proc3 ==
Proc3:	NOP
		INVB	PORTD, 4
		Ret

		; End Procedure ===========================



		; Process Task Queue ===================== 
ProcessTaskQueue:
		LDI ZL, low(TaskQueue)
		LDI ZH, high(TaskQueue)

		LD OSRG, Z
		CPI OSRG, $FF
		BREQ PTQEnd

		CLR ZH
		LSL OSRG
		MOV ZL, OSRG

		SUBI ZL, low(-TaskProcs*2)
		SBCI ZH, high(-TaskProcs*2)

		LPM
		MOV OSRG, R0
		LD R0, Z+

		LPM
		MOV ZL, OSRG
		MOV ZH, R0

		PUSH ZL
		PUSH ZH

		LDI Counter, TaskQueueSize-1
		LDI ZL, low(TaskQueue)
		LDI ZH, high(TaskQueue)

		CLI

PTQShift:
		LDD OSRG, Z+1
		ST Z+, OSRG
		DEC Counter
		BRNE PTQShift
		LDI OSRG, $FF
		ST Z+, OSRG

		SEI

		POP ZH
		POP ZL

		IJMP
		

PTQEnd:	RET
		; END Process Task Queue =====================

		; Send Task ==================================
SendTask:
		PUSH	ZL
		PUSH	ZH
		PUSH	Counter

		IN		Temp, SREG
		PUSH	Temp

		LDI 	ZL, low(TaskQueue)
		LDI 	ZH, high(TaskQueue)

		LDI		Counter, TaskQueueSize

		CLI
		
ST1:	LD		Temp, Z+
		
		CPI		Temp, $FF
		BREQ	ST2

		DEC		Counter
		BREQ	STEnd
		RJMP	ST1

ST2:	CPI		Temp, $FF
		ST		Z, Temp
		ST		-Z, OSRG

STEnd:	POP 	Temp
		OUT 	SREG, Temp

		POP 	Counter
		POP 	ZH
		POP 	ZL

		RET
		; End Send Task ============================
