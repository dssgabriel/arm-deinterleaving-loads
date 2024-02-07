.text

.global neon_deinterleave2d
.type   neon_deinterleave2d, %function
neon_deinterleave2d:
        cmp     x0, #1
        beq     .LN3
        mov     x8, #0
        mov     x9, x1
        lsr     x10, x0, #1
        lsl     x10, x10, #4
        mrs     x14, pmccntr_el0
.LN0:
        ld2     {v0.2d - v1.2d}, [x9], #32
        str     q0, [x2, x8]
        str     q1, [x3, x8]
        add     x8, x8, #16
        cmp     x8, x10
        bne     .LN0
        tbz     x0, #0, .LN2
        and     x0, x0, #-2
.LN1:
        add     x8, x1, x0, lsl #4
        lsl     x9, x0, #4
        lsl     x0, x0, #3
        ldr     d0, [x1, x9]
        ldr     d1, [x8, #8]
        str     d0, [x2, x0]
        str     d1, [x3, x0]
.LN2:
        mrs     x15, pmccntr_el0
        sub     x0, x15, x14
        ret
.LN3:
        b       .LN1 
        mov     x0, #0

.global neon_deinterleave3d
.type   neon_deinterleave3d, %function
neon_deinterleave3d:
        cbz     x0, .LN6
        cmp     x0, #1
        beq     .LN7
        lsr     x7, x0, #1
        mov     x5, xzr
        mov     x6, x4
        lsl     x7, x7, #4
        mrs     x14, pmccntr_el0
.LN4:
        ld3     {v29.2d - v31.2d}, [x6], #48
        str     q29, [x1, x5]
        str     q30, [x2, x5]
        str     q31, [x3, x5]
        add     x5, x5, #16
        cmp     x5, x7
        bne     .LN4
        tbz     x0, #0, .LN6
        and     x0, x0, #-2
.LN5:
        add     x6, x0, x0, lsl 1
        lsl     x0, x0, #3
        add     x5, x4, x6, lsl 3
        ldr     d29, [x4, x6, lsl 3]
        ldp     d30, d31, [x5, #8]
        str     d29, [x1, x0]
        str     d30, [x2, x0]
        str     d31, [x3, x0]
.LN6:
        mrs     x15, pmccntr_el0
        sub     x0, x15, x14
        ret
.LN7:
        mov     x0, xzr
        b       .LN5

.global neon_deinterleave4d
.type   neon_deinterleave4d, %function
neon_deinterleave4d:
        cbz     x0, .LN10
        cmp     x0, 1
        beq     .LN11
        lsr     x8, x0, 1
        mov     x6, 0
        mov     x7, x5
        lsl     x8, x8, 4
        mrs     x14, pmccntr_el0
.LN8:
        ld4     {v28.2d - v31.2d}, [x7], 64
        str     q28, [x1, x6]
        str     q29, [x2, x6]
        str     q30, [x3, x6]
        str     q31, [x4, x6]
        add     x6, x6, 16
        cmp     x6, x8
        bne     .LN8
        tbz     x0, 0, .LN10
        and     x0, x0, -2
.LN9:
        lsl     x7, x0, 5
        lsl     x0, x0, 3
        add     x6, x5, x7
        ldr     d28, [x5, x7]
        ldr     d31, [x6, 24]
        ldp     d29, d30, [x6, 8]
        str     d28, [x1, x0]
        str     d31, [x4, x0]
        str     d29, [x2, x0]
        str     d30, [x3, x0]
.LN10:
        mrs     x15, pmccntr_el0
        sub     x0, x15, x14
        ret
.LN11:
        mov     x0, 0
        b       .LN9

