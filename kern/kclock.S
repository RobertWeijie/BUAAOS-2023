#include <asm/asm.h>
#include <drivers/dev_rtc.h>
#include <kclock.h>
#include <mmu.h>


LEAF(kclock_init)
	li      t0, 200 // the timer interrupt frequency in Hz

	/* Write 't0' into the timer (RTC) frequency register.
	 *
	 * Hint:
	 *   You may want to use 'sw' instruction and constants 'DEV_RTC_ADDRESS' and
	 *   'DEV_RTC_HZ' defined in include/drivers/dev_rtc.h.
	 *   To access device through mmio, a physical address must be converted to a
	 *   kseg1 address.
	 *
	 * Reference: http://gavare.se/gxemul/gxemul-stable/doc/experiments.html#expdevices
	 */
	/* Exercise 3.11: Your code here. */
	la      t1, DEV_RTC_ADDRESS       // Load the RTC device address into t1

    li      t2, KSEG1               
    addu    t1, t1, t2                
    sw      t0, DEV_RTC_HZ(t1)        // Store the frequency in t0 to the RTC frequency register
	jr      ra
END(kclock_init)
