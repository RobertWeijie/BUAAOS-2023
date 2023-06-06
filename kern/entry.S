#include <asm/asm.h>
#include <stackframe.h>

.section .text.tlb_miss_entry
tlb_miss_entry:
	j       exc_gen_entry

.section .text.exc_gen_entry
exc_gen_entry:
	SAVE_ALL
	mfc0 t0, CP0_CAUSE// 设置 Cause 寄存器，用于记录异常发生的原因。
 andi t0, 0x7c
lw t0, exception_handlers(t0) 
   jr t0
/* Exercise 3.9: Your code here. */
