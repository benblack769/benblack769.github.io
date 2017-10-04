	.file	"pipelined_floats.cpp"
	.section .rdata,"dr"
_ZStL19piecewise_construct:
	.space 1
	.text
	.globl	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
	.def	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
_Z17vector_scalar_mulRSt6vectorIdSaIdEEd:
.LFB780:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	vmovsd	%xmm1, 24(%rbp)
	movq	16(%rbp), %rcx
	call	_ZNKSt6vectorIdSaIdEE4sizeEv
	movl	%eax, -8(%rbp)
	movl	$0, -4(%rbp)
.L3:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.L4
	movl	-4(%rbp), %eax
	cltq
	movq	%rax, %rdx
	movq	16(%rbp), %rcx
	call	_ZNSt6vectorIdSaIdEEixEy
	vmovsd	(%rax), %xmm0
	vmulsd	24(%rbp), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax)
	addl	$1, -4(%rbp)
	jmp	.L3
.L4:
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section	.text$_ZNKSt6vectorIdSaIdEE4sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	_ZNKSt6vectorIdSaIdEE4sizeEv
	.def	_ZNKSt6vectorIdSaIdEE4sizeEv;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZNKSt6vectorIdSaIdEE4sizeEv
_ZNKSt6vectorIdSaIdEE4sizeEv:
.LFB784:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	sarq	$3, %rax
	popq	%rbp
	ret
	.seh_endproc
	.section	.text$_ZNSt6vectorIdSaIdEEixEy,"x"
	.linkonce discard
	.align 2
	.globl	_ZNSt6vectorIdSaIdEEixEy
	.def	_ZNSt6vectorIdSaIdEEixEy;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZNSt6vectorIdSaIdEEixEy
_ZNSt6vectorIdSaIdEEixEy:
.LFB785:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	24(%rbp), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
