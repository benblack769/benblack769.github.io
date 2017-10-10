	.file	"vector_norm_fast.cpp"
	.text
	.p2align 4,,15
	.globl	_Z11vector_normRSt6vectorIfSaIfEE
	.def	_Z11vector_normRSt6vectorIfSaIfEE;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11vector_normRSt6vectorIfSaIfEE
_Z11vector_normRSt6vectorIfSaIfEE:
.LFB1022:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	movq	%rcx, %rdi
	movq	8(%rcx), %rcx
	subq	(%rdi), %rcx
	movq	%rcx, %rax
	sarq	$2, %rax
	je	.L33
	movabsq	$4611686018427387903, %rdx
	cmpq	%rdx, %rax
	ja	.L44
	call	_Znwy
	movq	(%rdi), %rsi
	movq	8(%rdi), %rcx
	movq	%rax, %rbx
	subq	%rsi, %rcx
	movq	%rcx, %rdi
	sarq	$2, %rdi
	jne	.L45
	testq	%rax, %rax
	jne	.L28
.L33:
	vxorps	%xmm6, %xmm6, %xmm6
.L41:
	vmovaps	%xmm6, %xmm0
	vmovaps	32(%rsp), %xmm6
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L45:
	movq	%rcx, %r8
	movq	%rsi, %rdx
	movq	%rax, %rcx
	call	memmove
	movl	%edi, %edx
	testl	%edi, %edi
	jle	.L28
	leaq	32(%rsi), %rax
	cmpq	%rax, %rbx
	leaq	32(%rbx), %rax
	setnb	%cl
	cmpq	%rax, %rsi
	setnb	%al
	orb	%al, %cl
	je	.L6
	cmpl	$12, %edi
	jbe	.L6
	movq	%rsi, %rcx
	xorl	%eax, %eax
	shrq	$2, %rcx
	negq	%rcx
	andl	$7, %ecx
	je	.L7
	vmovss	(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx)
	cmpl	$1, %ecx
	je	.L22
	vmovss	4(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 4(%rbx)
	cmpl	$2, %ecx
	je	.L23
	vmovss	8(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 8(%rbx)
	cmpl	$3, %ecx
	je	.L24
	vmovss	12(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 12(%rbx)
	cmpl	$4, %ecx
	je	.L25
	vmovss	16(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbx)
	cmpl	$5, %ecx
	je	.L26
	vmovss	20(%rsi), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbx)
	cmpl	$6, %ecx
	je	.L27
	vmovss	24(%rsi), %xmm0
	movl	$7, %eax
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbx)
.L7:
	movl	%edi, %ebp
	subl	$1, %edi
	movl	%ecx, %r10d
	subl	%ecx, %ebp
	subl	%ecx, %edi
	leal	-8(%rbp), %r9d
	shrl	$3, %r9d
	addl	$1, %r9d
	leal	0(,%r9,8), %r11d
	cmpl	$6, %edi
	jbe	.L9
	salq	$2, %r10
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	leaq	(%rsi,%r10), %rdi
	addq	%rbx, %r10
.L11:
	vmovaps	(%rdi,%rcx), %ymm0
	addl	$1, %r8d
	vmulps	%ymm0, %ymm0, %ymm0
	vmovups	%ymm0, (%r10,%rcx)
	addq	$32, %rcx
	cmpl	%r8d, %r9d
	ja	.L11
	addl	%r11d, %eax
	cmpl	%r11d, %ebp
	je	.L40
	vzeroupper
.L9:
	movslq	%eax, %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	leal	1(%rax), %ecx
	cmpl	%ecx, %edx
	jle	.L14
	movslq	%ecx, %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	leal	2(%rax), %ecx
	cmpl	%ecx, %edx
	jle	.L14
	movslq	%ecx, %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	leal	3(%rax), %ecx
	cmpl	%ecx, %edx
	jle	.L14
	movslq	%ecx, %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	leal	4(%rax), %ecx
	cmpl	%ecx, %edx
	jle	.L14
	movslq	%ecx, %rcx
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	leal	5(%rax), %ecx
	cmpl	%ecx, %edx
	jle	.L14
	movslq	%ecx, %rcx
	addl	$6, %eax
	vmovss	(%rsi,%rcx,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%eax, %edx
	jle	.L14
	cltq
	vmovss	(%rsi,%rax,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
.L14:
	vxorps	%xmm1, %xmm1, %xmm1
	xorl	%eax, %eax
	vmovaps	%xmm1, %xmm0
	.p2align 4,,10
.L16:
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	addq	$1, %rax
	cmpl	%eax, %edx
	jg	.L16
	vucomiss	%xmm0, %xmm1
	vsqrtss	%xmm0, %xmm6, %xmm6
	jbe	.L18
	call	sqrtf
.L18:
	movq	%rbx, %rcx
	call	_ZdlPv
	jmp	.L41
	.p2align 4,,10
.L40:
	vzeroupper
	jmp	.L14
.L6:
	xorl	%eax, %eax
	.p2align 4,,10
.L15:
	vmovss	(%rsi,%rax,4), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rax,4)
	addq	$1, %rax
	cmpl	%eax, %edx
	jg	.L15
	jmp	.L14
.L27:
	movl	$6, %eax
	jmp	.L7
.L26:
	movl	$5, %eax
	jmp	.L7
.L22:
	movl	$1, %eax
	jmp	.L7
.L23:
	movl	$2, %eax
	jmp	.L7
.L24:
	movl	$3, %eax
	jmp	.L7
.L25:
	movl	$4, %eax
	jmp	.L7
.L28:
	vxorps	%xmm6, %xmm6, %xmm6
	jmp	.L18
.L44:
	call	_ZSt17__throw_bad_allocv
	nop
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
	.def	_Znwy;	.scl	2;	.type	32;	.endef
	.def	memmove;	.scl	2;	.type	32;	.endef
	.def	sqrtf;	.scl	2;	.type	32;	.endef
	.def	_ZdlPv;	.scl	2;	.type	32;	.endef
	.def	_ZSt17__throw_bad_allocv;	.scl	2;	.type	32;	.endef
