		; Макросы =========================
.macro UOUT
.if @0 < 0x40
OUT @0, @1
.else
STS @0,@1
.endif
.endm

		; Set BIT with stack ==============
.MACRO SETB
.if @0 < 0x20
SBI		@0, @1
.else
.if @0 <0x40
PUSH	OSRG
IN		OSRG, @0
ORI		OSRG, 1<<@1
OUT		@0, OSRG
POP		OSRG
.else
PUSH	OSRG
LDS		OSRG, @0
ORI		OSRG, 1<<@1
STS		@0, OSRG
POP		OSRG
.endif
.endif
.ENDM

		; Set BIT with REG =================
.MACRO SETBR
.if @0 < 0x20
SBI		@0, @1
.else
.if @0 <0x40
IN		@2, @0
ORI		@2, 1<<@1
OUT		@0, @2
.else
LDS		@2, @0
ORI		@2, 1<<@1
STS		@0, @2
.endif
.endif
.ENDM

		; Clear BIT with stack ==============
.MACRO CLRB
if @0 < 0x20
CBI		@0, @1
.else
.if @0 <0x40
PUSH	OSRG
IN		OSRG, @0
ANDI	OSRG, ~(1<<@1)
OUT		@0, OSRG
POP		OSRG
.else
PUSH	OSRG
LDS		OSRG, @0
ANDI	OSRG, ~(1<<@1)
STS		@0, OSRG
POP		OSRG
.endif
.endif
.ENDM

		; Clear BIT with REG ==============
.MACRO CLRBR
if @0 < 0x20
CBI		@0, @1
.else
.if @0 <0x40
IN		@2, @0
ANDI	@2, ~(1<<@1)
OUT		@0, @2
.else
LDS		@2, @0
ANDI	@2, ~(1<<@1)
STS		@0, @2
.endif
.endif
.ENDM

		; Invert BIT
.MACRO INVB
.if		@0 < 40
PUSH	OSRG
PUSH	Temp
IN		OSRG, @0
LDI		Temp,1<<@1
EOR		OSRG, Temp
OUT		@0, OSRG
POP		Temp
POP		OSRG
.else
PUSH	OSRG
PUSH	Temp
LDS		OSRG, @0
LDI		OSRG,1<<@1
EOR		OSRG, Temp
STS		@0, OSRG
POP		Temp
POP		OSRG
.endif
.ENDM

		; Increment
.MACRO INCM
LDS		R16, @0
LDS		R17, @0+1
LDS		R18, @0+2
LDS		R19, @0+3

SUBI	R16, (-1)
SUBI	R17, (-1)
SUBI	R18, (-1)
SUBI	R19, (-1)

STS		@0, R16
STS		@0+1, R17
STS		@0+2, R18
STS		@0+3, R19
.ENDM

		; PUSH SREG
.MACRO PUSHSREG
PUSH	R16
IN		R16, SREG
PUSH	R16
.ENDM

		; POP SREG
.MACRO POPSREG
POP		R16
OUT		SREG, R16
POP		R16
.ENDM

		; Обзываем регистры ===============
.def	OSRG	= R17
.def	Counter	= R16
.def	Temp	= R18
.def	LED_Counter	= R20


