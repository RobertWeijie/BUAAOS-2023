#include <asm/asm.h>
#include <mmu.h>
#include <trap.h>

.text
LEAF(env_pop_tf)
.set reorder
.set at
	sll     a1, a1, 6 //将 a1 寄存器中的值左移 6 位，相当于将其乘以 64，以得到物理地址。
	mtc0    a1, CP0_ENTRYHI//将物理地址存储到 CP0 寄存器 ENTRYHI 里，以便在异常处理过程中使用
	move    sp, a0//将 a0 寄存器中的值（即栈顶指针）存储到 sp 寄存器中，以便弹出 TrapFrame 结构体
	j       ret_from_exception//跳转到 ret_from_exception 函数，以便返回到之前的执行现场。
END(env_pop_tf)

LEAF(enable_irq)
	li      t0, (STATUS_CU0 | STATUS_IM4 | STATUS_IEc)//将 t0 寄存器设置为二进制 1001，即将 STATUS 寄存器的 CU0、IM4 和 IEc 位分别设置为 1。
	mtc0    t0, CP0_STATUS //将 t0 寄存器中的值存储到 CP0 寄存器 STATUS 中，以开启 CPU 中断
	jr      ra//跳转回 ra 寄存器中保存的返回地址，以便返回到调用该函数的位置
END(enable_irq)//函数将一个常量值赋给寄存器t0，然后将t0的值写入协处理器0的status寄存器中，使能中断，最后跳转到函数调用点。

