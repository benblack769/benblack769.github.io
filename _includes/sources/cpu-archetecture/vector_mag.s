.LFB1022:
	subq	$56, %rsp
	vmovaps	%xmm6, 32(%rsp)
	vxorps	%xmm6, %xmm6, %xmm6
	movq	8(%rcx), %rdx
	movq	(%rcx), %rax
	movq	%rdx, %rcx
	subq	%rax, %rcx
	shrq	$2, %rcx
	je	.L6
	vxorps	%xmm2, %xmm2, %xmm2
	vmovaps	%xmm2, %xmm0
.L3:
	vmovss	(%rax), %xmm1
	addq	$4, %rax
	vfmadd231ss	%xmm1, %xmm1, %xmm0
	cmpq	%rax, %rdx
	jne	.L3
	vucomiss	%xmm0, %xmm2
	vsqrtss	%xmm0, %xmm6, %xmm6
	jbe	.L6
	call	sqrtf
.L6:
	vmovaps	%xmm6, %xmm0
	vmovaps	32(%rsp), %xmm6
	addq	$56, %rsp
	ret
