.text

.global sve_deinterleave2d
.type   sve_deinterleave2d, %function
sve_deinterleave2d:
        mov     x8, xzr
        cntd    x9
        cntb    x10, all, mul #2            //; Number of bytes in SVE regs multiplied by 2-elements
        whilelo p0.d, x8, x0
        mrs     x14, pmccntr_el0            //; Retrieve cycles counter: start
.LS0:
        ld2d    {z0.d-z1.d}, p0/z, [x1]
        st1d    z0.d, p0, [x2, x8, lsl #3]
        st1d    z1.d, p0, [x3, x8, lsl #3]
        add     x8, x8, x9
        add     x1, x1, x10
        whilelo p0.d, x8, x0
        b.lt    .LS0
        mrs     x15, pmccntr_el0            //; Retrieve cycles counter: stop
        sub     x0, x15, x14
        ret

.global sve_deinterleave3d
.type   sve_deinterleave3d, %function
sve_deinterleave3d:
        mov     x8, xzr
        cntd    x9
        cntb    x10, all, mul #3            //; Number of bytes in SVE regs multiplied by 3-elements
        whilelo p0.d, x8, x0
        mrs     x14, pmccntr_el0            //; Retrieve cycles counter: start
.LS1:
        ld3d    {z0.d-z2.d}, p0/z, [x1]
        st1d    z0.d, p0, [x2, x8, lsl #3]
        st1d    z1.d, p0, [x3, x8, lsl #3]
        st1d    z2.d, p0, [x4, x8, lsl #3]
        add     x8, x8, x9
        add     x1, x1, x10
        whilelo p0.d, x8, x0
        b.lt    .LS1
        mrs     x15, pmccntr_el0            //; Retrieve cycles counter: stop
        sub     x0, x15, x14
        ret

.global sve_deinterleave4d
.type   sve_deinterleave4d, %function
sve_deinterleave4d:
        mov     x8, xzr
        cntd    x9
        cntb    x10, all, mul #4            //; Number of bytes in SVE regs multiplied by 4-elements
        whilelo p0.d, x8, x0
        mrs     x14, pmccntr_el0            //; Retrieve cycles counter: start
.LS2:
        ld4d    {z0.d-z3.d}, p0/z, [x1]
        st1d    z0.d, p0, [x2, x8, lsl #3]
        st1d    z1.d, p0, [x3, x8, lsl #3]
        st1d    z2.d, p0, [x4, x8, lsl #3]
        st1d    z3.d, p0, [x5, x8, lsl #3]
        add     x8, x8, x9
        add     x1, x1, x10
        whilelo p0.d, x8, x0
        b.lt    .LS2
        mrs     x15, pmccntr_el0            //; Retrieve cycles counter: stop
        sub     x0, x15, x14
        ret
