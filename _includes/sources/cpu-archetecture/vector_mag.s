	.file	"vector_mag.cpp"
	.text
	.p2align 4,,15
	.globl	_Z11vector_normRSt6vectorIfSaIfEE
	.def	_Z11vector_normRSt6vectorIfSaIfEE;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11vector_normRSt6vectorIfSaIfEE
_Z11vector_normRSt6vectorIfSaIfEE:
.LFB1022:
	subq	$56, %rsp
	.seh_stackalloc	56
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	pxor	%xmm6, %xmm6
	movq	(%rcx), %rdx
	movq	8(%rcx), %rax
	subq	%rdx, %rax
	sarq	$2, %rax
	testl	%eax, %eax
	movl	%eax, %ecx
	jle	.L1
	pxor	%xmm2, %xmm2
	xorl	%eax, %eax
	movaps	%xmm2, %xmm0
	.p2align 4,,10
.L3:
	movss	(%rdx,%rax,4), %xmm1
	addq	$1, %rax
	cmpl	%eax, %ecx
	mulss	%xmm1, %xmm1
	addss	%xmm1, %xmm0
	jg	.L3
	ucomiss	%xmm0, %xmm2
	sqrtss	%xmm0, %xmm6
	jbe	.L1
	call	sqrtf
.L1:
	movaps	%xmm6, %xmm0
	movaps	32(%rsp), %xmm6
	addq	$56, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
	.def	sqrtf;	.scl	2;	.type	32;	.endef
