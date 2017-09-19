	.file	"vector_mag16.cpp"
	.text
	.p2align 4,,15
	.globl	_Z11vector_normRSt6vectorIfSaIfEE
	.def	_Z11vector_normRSt6vectorIfSaIfEE;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11vector_normRSt6vectorIfSaIfEE
_Z11vector_normRSt6vectorIfSaIfEE:
.LFB7057:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	vmovaps	%xmm6, -96(%rbp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	vxorps	%xmm0, %xmm0, %xmm0
	xorl	%r8d, %r8d
	vmovaps	%ymm0, %ymm2
	vmovaps	%ymm0, %ymm1
	movq	(%rcx), %r10
	movq	8(%rcx), %r9
	subq	%r10, %r9
	movq	%r10, %r11
	sarq	$2, %r9
	andq	$-33, %r11
	subq	$96, %rsp
	movq	%r9, %rdx
	movq	%r11, %rcx
	leaq	63(%rsp), %rax
	shrq	$4, %rdx
	andq	$-32, %rax
	leaq	-2(%rdx), %rbx
	vmovaps	%ymm0, (%rax)
	vmovaps	%ymm0, 32(%rax)
	.p2align 4,,10
.L2:
	vmovaps	(%rcx), %ymm0
	addq	$2, %r8
	addq	$64, %rcx
	vfmadd231ps	%ymm0, %ymm0, %ymm1
	vmovaps	-32(%rcx), %ymm0
	vfmadd231ps	%ymm0, %ymm0, %ymm2
	cmpq	%r8, %rbx
	jnb	.L2
	vmovaps	%ymm1, (%rax)
	vmovaps	%ymm2, 32(%rax)
	cmpq	%r10, %r11
	je	.L11
	vxorps	%xmm2, %xmm2, %xmm2
	movq	%r10, %rcx
	vmovaps	%xmm2, %xmm0
	.p2align 4,,10
.L6:
	vmovss	(%rcx), %xmm1
	addq	$4, %rcx
	vfmadd231ss	%xmm1, %xmm1, %xmm0
	cmpq	%rcx, %r11
	jne	.L6
.L3:
	sall	$4, %edx
	movslq	%edx, %rdx
	cmpq	%rdx, %r9
	jbe	.L7
	.p2align 4,,10
.L12:
	vmovss	(%r10,%rdx,4), %xmm1
	addq	$1, %rdx
	vfmadd231ss	%xmm1, %xmm1, %xmm0
	cmpq	%r9, %rdx
	jne	.L12
.L7:
	leaq	64(%rax), %rdx
	.p2align 4,,10
.L9:
	vaddss	(%rax), %xmm0, %xmm0
	addq	$4, %rax
	cmpq	%rax, %rdx
	jne	.L9
	vucomiss	%xmm0, %xmm2
	vsqrtss	%xmm0, %xmm6, %xmm6
	jbe	.L16
	call	sqrtf
.L16:
	vmovaps	%xmm6, %xmm0
	vmovaps	-96(%rbp), %xmm6
	leaq	-72(%rbp), %rsp
	popq	%rbx
	popq	%rbp
	ret
.L11:
	vxorps	%xmm2, %xmm2, %xmm2
	vmovaps	%xmm2, %xmm0
	jmp	.L3
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
	.def	sqrtf;	.scl	2;	.type	32;	.endef
