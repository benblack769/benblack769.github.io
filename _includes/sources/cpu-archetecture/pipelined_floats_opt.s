	.file	"pipelined_floats.cpp"
	.text
	.p2align 4,,15
	.globl	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
	.def	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
_Z17vector_scalar_mulRSt6vectorIdSaIdEEd:
.LFB780:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movq	(%rcx), %r9
	movq	8(%rcx), %rdx
	subq	%r9, %rdx
	sarq	$3, %rdx
	testl	%edx, %edx
	jle	.L21
	movq	%r9, %rax
	shrq	$3, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	%edx, %eax
	cmova	%edx, %eax
	cmpl	$4, %edx
	cmovbe	%edx, %eax
	testl	%eax, %eax
	je	.L13
	vmulsd	(%r9), %xmm1, %xmm0
	movl	$1, %ecx
	vmovsd	%xmm0, (%r9)
	cmpl	$1, %eax
	je	.L5
	vmulsd	8(%r9), %xmm1, %xmm0
	movl	$2, %ecx
	vmovsd	%xmm0, 8(%r9)
	cmpl	$2, %eax
	je	.L5
	vmulsd	16(%r9), %xmm1, %xmm0
	movl	$3, %ecx
	vmovsd	%xmm0, 16(%r9)
	cmpl	$3, %eax
	je	.L5
	vmulsd	24(%r9), %xmm1, %xmm0
	movl	$4, %ecx
	vmovsd	%xmm0, 24(%r9)
.L5:
	cmpl	%eax, %edx
	je	.L21
.L4:
	movl	%edx, %ebx
	leal	-1(%rdx), %r10d
	movl	%eax, %r11d
	subl	%eax, %ebx
	subl	%eax, %r10d
	leal	-4(%rbx), %r8d
	shrl	$2, %r8d
	addl	$1, %r8d
	leal	0(,%r8,4), %esi
	cmpl	$2, %r10d
	jbe	.L7
	leaq	(%r9,%r11,8), %r11
	vbroadcastsd	%xmm1, %ymm2
	xorl	%eax, %eax
	xorl	%r10d, %r10d
.L9:
	vmulpd	(%r11,%rax), %ymm2, %ymm0
	addl	$1, %r10d
	vmovapd	%ymm0, (%r11,%rax)
	addq	$32, %rax
	cmpl	%r10d, %r8d
	ja	.L9
	addl	%esi, %ecx
	cmpl	%esi, %ebx
	je	.L20
	vzeroupper
.L7:
	movslq	%ecx, %rax
	leaq	(%r9,%rax,8), %rax
	vmulsd	(%rax), %xmm1, %xmm0
	vmovsd	%xmm0, (%rax)
	leal	1(%rcx), %eax
	cmpl	%eax, %edx
	jle	.L21
	cltq
	leaq	(%r9,%rax,8), %rax
	vmulsd	(%rax), %xmm1, %xmm0
	vmovsd	%xmm0, (%rax)
	leal	2(%rcx), %eax
	cmpl	%eax, %edx
	jle	.L21
	cltq
	leaq	(%r9,%rax,8), %rax
	vmulsd	(%rax), %xmm1, %xmm1
	vmovsd	%xmm1, (%rax)
.L21:
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L13:
	xorl	%ecx, %ecx
	jmp	.L4
	.p2align 4,,10
.L20:
	vzeroupper
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
