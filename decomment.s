	.cpu generic+fp+simd
	.file	"decomment.c"
	.section	.rodata
	.align	3
.LC0:
	.string	"Error: line %i: unterminated comment\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	mov	w0, 1
	str	w0, [x29,28]
	str	wzr, [x29,24]
	str	wzr, [x29,40]
	str	wzr, [x29,36]
	b	.L2
.L18:
	ldr	w0, [x29,32]
	strb	w0, [x29,47]
	ldr	w0, [x29,40]
	str	w0, [x29,36]
	ldr	w0, [x29,40]
	cmp	w0, 7
	bhi	.L3
	adrp	x1, .L5
	add	x1, x1, :lo12:.L5
	ldr	w2, [x1,w0,uxtw #2]
	adr	x3, .Lrtx5
	add	x2, x3, w2, sxtw #2
	br	x2
.Lrtx5:
	.section	.rodata
	.align	0
	.align	2
.L5:
	.word	(.L4 - .Lrtx5) / 4
	.word	(.L6 - .Lrtx5) / 4
	.word	(.L7 - .Lrtx5) / 4
	.word	(.L8 - .Lrtx5) / 4
	.word	(.L9 - .Lrtx5) / 4
	.word	(.L10 - .Lrtx5) / 4
	.word	(.L11 - .Lrtx5) / 4
	.word	(.L12 - .Lrtx5) / 4
	.text
.L4:
	ldr	w0, [x29,32]
	bl	handleStartState
	str	w0, [x29,40]
	b	.L3
.L6:
	ldr	w0, [x29,32]
	bl	handleMaybeCommentState
	str	w0, [x29,40]
	b	.L3
.L7:
	ldr	w0, [x29,32]
	uxtb	w0, w0
	cmp	w0, 10
	bne	.L13
	mov	w0, 10
	bl	putchar
.L13:
	add	x1, x29, 24
	add	x2, x29, 28
	ldr	w0, [x29,32]
	bl	handleMaybeNotCommentState
	str	w0, [x29,40]
	b	.L3
.L8:
	ldr	w0, [x29,32]
	uxtb	w0, w0
	cmp	w0, 10
	bne	.L14
	mov	w0, 10
	bl	putchar
.L14:
	ldr	w0, [x29,32]
	bl	handleInCommentState
	str	w0, [x29,40]
	b	.L3
.L9:
	ldr	w0, [x29,32]
	bl	handleInCharState
	str	w0, [x29,40]
	b	.L3
.L10:
	ldr	w0, [x29,32]
	bl	handleInLiteralState
	str	w0, [x29,40]
	b	.L3
.L11:
	ldr	w0, [x29,32]
	bl	handleReturnStringState
	str	w0, [x29,40]
	b	.L3
.L12:
	ldr	w0, [x29,32]
	bl	handleReturnCharState
	str	w0, [x29,40]
	nop
.L3:
	ldr	w0, [x29,32]
	uxtb	w0, w0
	cmp	w0, 10
	bne	.L15
	ldr	w0, [x29,40]
	cmp	w0, 3
	beq	.L15
	ldr	w0, [x29,28]
	add	w0, w0, 1
	str	w0, [x29,28]
	b	.L16
.L15:
	ldr	w0, [x29,32]
	uxtb	w0, w0
	cmp	w0, 10
	bne	.L16
	ldr	w0, [x29,40]
	cmp	w0, 3
	bne	.L16
	ldr	w0, [x29,24]
	add	w0, w0, 1
	str	w0, [x29,24]
.L16:
	ldr	w0, [x29,40]
	cmp	w0, wzr
	beq	.L17
	ldr	w0, [x29,40]
	cmp	w0, 5
	beq	.L17
	ldr	w0, [x29,40]
	cmp	w0, 4
	bne	.L2
.L17:
	ldr	w0, [x29,36]
	cmp	w0, 2
	beq	.L2
	ldr	w0, [x29,32]
	uxtb	w0, w0
	bl	putchar
.L2:
	bl	getchar
	str	w0, [x29,32]
	ldr	w0, [x29,32]
	cmn	w0, #1
	bne	.L18
	ldr	w0, [x29,40]
	cmp	w0, 1
	bne	.L19
	mov	w0, 47
	bl	putchar
	b	.L20
.L19:
	ldr	w0, [x29,40]
	cmp	w0, 6
	beq	.L21
	ldr	w0, [x29,40]
	cmp	w0, 7
	bne	.L20
.L21:
	ldrb	w0, [x29,47]
	bl	putchar
.L20:
	ldr	w0, [x29,40]
	cmp	w0, 3
	beq	.L22
	ldr	w0, [x29,40]
	cmp	w0, 2
	bne	.L23
.L22:
	adrp	x0, stderr
	add	x0, x0, :lo12:stderr
	ldr	x0, [x0]
	ldr	w2, [x29,28]
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	bl	fprintf
	mov	w0, 1
	bl	exit
.L23:
	mov	w0, 0
	bl	exit
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.align	2
	.global	handleStartState
	.type	handleStartState, %function
handleStartState:
.LFB1:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	w0, [sp,12]
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 47
	bne	.L25
	mov	w0, 1
	str	w0, [sp,28]
	b	.L26
.L25:
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 39
	bne	.L27
	mov	w0, 4
	str	w0, [sp,28]
	b	.L26
.L27:
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 34
	bne	.L28
	mov	w0, 5
	str	w0, [sp,28]
	b	.L26
.L28:
	str	wzr, [sp,28]
.L26:
	ldr	w0, [sp,28]
	add	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	handleStartState, .-handleStartState
	.align	2
	.global	handleMaybeCommentState
	.type	handleMaybeCommentState, %function
handleMaybeCommentState:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	ldr	w0, [x29,28]
	uxtb	w0, w0
	cmp	w0, 42
	bne	.L31
	mov	w0, 32
	bl	putchar
	mov	w0, 3
	str	w0, [x29,44]
	b	.L32
.L31:
	ldr	w0, [x29,28]
	uxtb	w0, w0
	cmp	w0, 47
	bne	.L33
	mov	w0, 1
	str	w0, [x29,44]
	mov	w0, 47
	bl	putchar
	b	.L32
.L33:
	ldr	w0, [x29,28]
	uxtb	w0, w0
	cmp	w0, 39
	bne	.L34
	mov	w0, 4
	str	w0, [x29,44]
	mov	w0, 47
	bl	putchar
	b	.L32
.L34:
	ldr	w0, [x29,28]
	uxtb	w0, w0
	cmp	w0, 34
	bne	.L35
	mov	w0, 5
	str	w0, [x29,44]
	mov	w0, 47
	bl	putchar
	b	.L32
.L35:
	mov	w0, 47
	bl	putchar
	str	wzr, [x29,44]
.L32:
	ldr	w0, [x29,44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE2:
	.size	handleMaybeCommentState, .-handleMaybeCommentState
	.align	2
	.global	handleInCommentState
	.type	handleInCommentState, %function
handleInCommentState:
.LFB3:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	w0, [sp,12]
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 42
	bne	.L38
	mov	w0, 2
	str	w0, [sp,28]
	b	.L39
.L38:
	mov	w0, 3
	str	w0, [sp,28]
.L39:
	ldr	w0, [sp,28]
	add	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3:
	.size	handleInCommentState, .-handleInCommentState
	.align	2
	.global	handleMaybeNotCommentState
	.type	handleMaybeNotCommentState, %function
handleMaybeNotCommentState:
.LFB4:
	.cfi_startproc
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	str	w0, [sp,28]
	str	x1, [sp,16]
	str	x2, [sp,8]
	ldr	w0, [sp,28]
	uxtb	w0, w0
	cmp	w0, 42
	bne	.L42
	mov	w0, 2
	str	w0, [sp,44]
	b	.L43
.L42:
	ldr	w0, [sp,28]
	uxtb	w0, w0
	cmp	w0, 47
	bne	.L44
	ldr	x0, [sp,8]
	ldr	w1, [x0]
	ldr	x0, [sp,16]
	ldr	w0, [x0]
	add	w1, w1, w0
	ldr	x0, [sp,8]
	str	w1, [x0]
	ldr	x0, [sp,16]
	str	wzr, [x0]
	str	wzr, [sp,44]
	b	.L43
.L44:
	mov	w0, 3
	str	w0, [sp,44]
.L43:
	ldr	w0, [sp,44]
	add	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE4:
	.size	handleMaybeNotCommentState, .-handleMaybeNotCommentState
	.align	2
	.global	handleInCharState
	.type	handleInCharState, %function
handleInCharState:
.LFB5:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	w0, [sp,12]
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 92
	bne	.L47
	mov	w0, 7
	str	w0, [sp,28]
	b	.L48
.L47:
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 39
	bne	.L48
	str	wzr, [sp,28]
.L48:
	ldr	w0, [sp,28]
	add	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5:
	.size	handleInCharState, .-handleInCharState
	.align	2
	.global	handleInLiteralState
	.type	handleInLiteralState, %function
handleInLiteralState:
.LFB6:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	w0, [sp,12]
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 92
	bne	.L51
	mov	w0, 6
	str	w0, [sp,28]
	b	.L52
.L51:
	ldr	w0, [sp,12]
	uxtb	w0, w0
	cmp	w0, 34
	bne	.L52
	str	wzr, [sp,28]
.L52:
	ldr	w0, [sp,28]
	add	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	handleInLiteralState, .-handleInLiteralState
	.align	2
	.global	handleReturnCharState
	.type	handleReturnCharState, %function
handleReturnCharState:
.LFB7:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	mov	w0, 4
	str	w0, [x29,44]
	mov	w0, 92
	bl	putchar
	ldr	w0, [x29,44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE7:
	.size	handleReturnCharState, .-handleReturnCharState
	.align	2
	.global	handleReturnStringState
	.type	handleReturnStringState, %function
handleReturnStringState:
.LFB8:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	mov	w0, 5
	str	w0, [x29,44]
	mov	w0, 92
	bl	putchar
	ldr	w0, [x29,44]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE8:
	.size	handleReturnStringState, .-handleReturnStringState
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-28)"
	.section	.note.GNU-stack,"",%progbits
