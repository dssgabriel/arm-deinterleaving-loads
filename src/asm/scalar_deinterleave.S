.text

.global scalar_deinterleave2d
.type   scalar_deinterleave2d, %function
scalar_deinterleave2d:
        mov     x8, xzr
        mrs     x14, pmccntr_el0  //; Retrieve cycles counter: start
.LA0:
        ldr     d0, [x1, x8]
        ldr     d1, [x1, x8]
        str     d0, [x2, x8]
        str     d1, [x3, x8]
        add     x8, x8, #8
        cmp     x8, x0
        b.lt    .LA0
        mrs     x15, pmccntr_el0  //; Retrieve cycles counter: start
        sub     x0, x15, x14
        ret

.global scalar_deinterleave3d
.type   scalar_deinterleave3d, %function
scalar_deinterleave3d:
        mov     x8, xzr
        mrs     x14, pmccntr_el0  //; Retrieve cycles counter: start
.LA1:
        ldr     d0, [x1, x8]
        ldr     d1, [x1, x8]
        ldr     d2, [x1, x8]
        str     d0, [x2, x8]
        str     d1, [x3, x8]
        str     d2, [x4, x8]
        add     x8, x8, #8
        cmp     x8, x0
        b.lt    .LA1
        mrs     x15, pmccntr_el0  //; Retrieve cycles counter: start
        sub     x0, x15, x14
        ret

.global scalar_deinterleave4d
.type   scalar_deinterleave4d, %function
scalar_deinterleave4d:
        mov     x8, xzr
        mrs     x14, pmccntr_el0  //; Retrieve cycles counter: start
.LA2:
        ldr     d0, [x1, x8]
        ldr     d1, [x1, x8]
        ldr     d2, [x1, x8]
        ldr     d3, [x1, x8]
        str     d0, [x2, x8]
        str     d1, [x3, x8]
        str     d2, [x4, x8]
        str     d3, [x5, x8]
        add     x8, x8, #8
        cmp     x8, x0
        b.lt    .LA2
        mrs     x15, pmccntr_el0  //; Retrieve cycles counter: start
        sub     x0, x15, x14
        ret
