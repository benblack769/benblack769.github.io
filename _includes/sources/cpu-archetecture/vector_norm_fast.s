	.file	"vector_norm_fast.cpp"
	.text
	.p2align 4,,15
	.globl	_Z11vector_normRSt6vectorIfSaIfEE
	.def	_Z11vector_normRSt6vectorIfSaIfEE;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11vector_normRSt6vectorIfSaIfEE
_Z11vector_normRSt6vectorIfSaIfEE:
.LFB1022:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	movq	%rcx, %rdi
	movq	8(%rcx), %rcx
	subq	(%rdi), %rcx
	movq	%rcx, %rax
	sarq	$2, %rax
	je	.L39
	movabsq	$4611686018427387903, %rdx
	cmpq	%rdx, %rax
	ja	.L52
	call	_Znwy
	movq	(%rdi), %rsi
	movq	8(%rdi), %rcx
	movq	%rax, %rbx
	subq	%rsi, %rcx
	movq	%rcx, %rdi
	sarq	$2, %rdi
	jne	.L53
	testq	%rax, %rax
	jne	.L34
.L39:
	vxorps	%xmm6, %xmm6, %xmm6
.L47:
	vmovaps	%xmm6, %xmm0
	vmovaps	32(%rsp), %xmm6
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L53:
	movq	%rcx, %r8
	movq	%rsi, %rdx
	movq	%rax, %rcx
	call	memmove
	movl	%edi, %ecx
	testl	%edi, %edi
	jle	.L34
	leaq	32(%rsi), %rax
	movl	%edi, %r8d
	cmpq	%rax, %rbx
	leaq	32(%rbx), %rax
	setnb	%dl
	cmpq	%rax, %rsi
	setnb	%al
	orb	%al, %dl
	je	.L6
	cmpl	$12, %edi
	jbe	.L6
	movq	%rsi, %rdx
	xorl	%eax, %eax
	shrq	$2, %rdx
	negq	%rdx
	andl	$7, %edx
	je	.L7
	vmovss	(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx)
	cmpl	$1, %edx
	je	.L27
	vmovss	4(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 4(%rbx)
	cmpl	$2, %edx
	je	.L28
	vmovss	8(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 8(%rbx)
	cmpl	$3, %edx
	je	.L29
	vmovss	12(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 12(%rbx)
	cmpl	$4, %edx
	je	.L30
	vmovss	16(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbx)
	cmpl	$5, %edx
	je	.L31
	vmovss	20(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbx)
	cmpl	$6, %edx
	je	.L32
	vmovss	24(%rsi), %xmm0
	movl	$7, %eax
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbx)
.L7:
	movl	%r8d, %ebp
	subl	$1, %r8d
	movl	%edx, %r10d
	subl	%edx, %ebp
	subl	%edx, %r8d
	leal	-8(%rbp), %r9d
	shrl	$3, %r9d
	addl	$1, %r9d
	leal	0(,%r9,8), %r11d
	cmpl	$6, %r8d
	jbe	.L9
	salq	$2, %r10
	xorl	%edx, %edx
	xorl	%r8d, %r8d
	leaq	(%rsi,%r10), %r12
	addq	%rbx, %r10
.L11:
	vmovaps	(%r12,%rdx), %ymm0
	addl	$1, %r8d
	vmulps	%ymm0, %ymm0, %ymm0
	vmovups	%ymm0, (%r10,%rdx)
	addq	$32, %rdx
	cmpl	%r8d, %r9d
	ja	.L11
	addl	%r11d, %eax
	cmpl	%ebp, %r11d
	je	.L46
	vzeroupper
.L9:
	movslq	%eax, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %ecx
	jle	.L16
	movslq	%edx, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	2(%rax), %edx
	cmpl	%edx, %ecx
	jle	.L16
	movslq	%edx, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	3(%rax), %edx
	cmpl	%edx, %ecx
	jle	.L16
	movslq	%edx, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	4(%rax), %edx
	cmpl	%edx, %ecx
	jle	.L16
	movslq	%edx, %rdx
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	5(%rax), %edx
	cmpl	%edx, %ecx
	jle	.L16
	movslq	%edx, %rdx
	addl	$6, %eax
	vmovss	(%rsi,%rdx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	cmpl	%eax, %ecx
	jle	.L16
	cltq
	vmovss	(%rsi,%rax,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
.L16:
	cmpl	$7, %ecx
	jle	.L54
	leal	-8(%rdi), %r8d
	vxorps	%xmm1, %xmm1, %xmm1
	movq	%rbx, %rax
	shrl	$3, %r8d
	vmovaps	%xmm1, %xmm0
	movl	%r8d, %edx
	addq	$1, %rdx
	salq	$5, %rdx
	addq	%rbx, %rdx
	.p2align 4,,10
.L20:
	vaddss	(%rax), %xmm0, %xmm0
	addq	$32, %rax
	vaddss	-28(%rax), %xmm0, %xmm0
	vaddss	-24(%rax), %xmm0, %xmm0
	vaddss	-20(%rax), %xmm0, %xmm0
	vaddss	-16(%rax), %xmm0, %xmm0
	vaddss	-12(%rax), %xmm0, %xmm0
	vaddss	-8(%rax), %xmm0, %xmm0
	vaddss	-4(%rax), %xmm0, %xmm0
	cmpq	%rdx, %rax
	jne	.L20
	leal	8(,%r8,8), %eax
	cmpl	%eax, %ecx
	jle	.L18
.L14:
	cltq
	.p2align 4,,10
.L21:
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L21
.L18:
	vucomiss	%xmm0, %xmm1
	vsqrtss	%xmm0, %xmm6, %xmm6
	jbe	.L22
	call	sqrtf
.L22:
	movq	%rbx, %rcx
	call	_ZdlPv
	jmp	.L47
	.p2align 4,,10
.L46:
	vzeroupper
	jmp	.L16
.L6:
	xorl	%eax, %eax
	.p2align 4,,10
.L17:
	vmovss	(%rsi,%rax,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %ecx
	jg	.L17
	jmp	.L16
.L32:
	movl	$6, %eax
	jmp	.L7
.L31:
	movl	$5, %eax
	jmp	.L7
.L27:
	movl	$1, %eax
	jmp	.L7
.L28:
	movl	$2, %eax
	jmp	.L7
.L29:
	movl	$3, %eax
	jmp	.L7
.L30:
	movl	$4, %eax
	jmp	.L7
.L52:
	call	_ZSt17__throw_bad_allocv
.L54:
	vxorps	%xmm1, %xmm1, %xmm1
	xorl	%eax, %eax
	vmovaps	%xmm1, %xmm0
	jmp	.L14
.L34:
	vxorps	%xmm6, %xmm6, %xmm6
	jmp	.L22
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
	.def	_Znwy;	.scl	2;	.type	32;	.endef
	.def	memmove;	.scl	2;	.type	32;	.endef
	.def	sqrtf;	.scl	2;	.type	32;	.endef
	.def	_ZdlPv;	.scl	2;	.type	32;	.endef
	.def	_ZSt17__throw_bad_allocv;	.scl	2;	.type	32;	.endef
