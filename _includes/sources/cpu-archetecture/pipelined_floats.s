	.file	"pipelined_floats.cpp"
	.text
	.p2align 4,,15
	.globl	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
	.def	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z17vector_scalar_mulRSt6vectorIdSaIdEEd
_Z17vector_scalar_mulRSt6vectorIdSaIdEEd:
.LFB780:
	.seh_endprologue
	movq	(%rcx), %rax
	movq	8(%rcx), %rdx
	subq	%rax, %rdx
	sarq	$3, %rdx
	testl	%edx, %edx
	jle	.L1
	subl	$1, %edx
	leaq	8(%rax,%rdx,8), %rdx
	.p2align 4,,10
.L4:
	movsd	(%rax), %xmm0
	addq	$8, %rax
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rax)
	cmpq	%rdx, %rax
	jne	.L4
.L1:
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
