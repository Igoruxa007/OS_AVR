	; Include =====================================
	.include "m328Pdef.inc"
	.include "Macro.inc"

; RAM ==============================================
	.DSEG ; ОЗУ
	.ORG SRAM_START+100
CCNT:		.byte	4

Var1:		.byte 	2
Var2:		.byte 	10

		; Очередь может выйти за 11 !!!!!
			.equ 	TaskQueueSize = 11
TaskQueue:	.byte 	TaskQueueSize


; FLASH ============================================
	.CSEG ; Кодовый сегмент

	.ORG INT_VECTORS_SIZE+100

		; Main ==================================
Main:	SEI
		WDR
		RCALL ProcessTaskQueue
		RCALL Idle
		RJMP Main
		; End Main ===============================


		; ASM ====================================
	.include "Reset.asm"
	.include "Interrupts.asm"
	.include "Procedures.asm"

	.include "Interrupts_table.asm"


; EEPROM ==========================================
	.ESEG ; Сегмент EEPROM
