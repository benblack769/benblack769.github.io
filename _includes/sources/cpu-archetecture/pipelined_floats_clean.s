.LFB780:
	movq	(%rcx), %rax 	//rax = argument(1)
	movq	8(%rcx), %rdx	//rdx =
	subq	%rax, %rdx		//
	sarq	$3, %rdx
	testl	%edx, %edx
	jle	.L5
	subl	$1, %edx
	leaq	8(%rax,%rdx,8), %rdx
.L4: // Main loop of vector_scalar_mul function
	movsd	(%rax), %xmm0	//
	addq	$8, %rax
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rax)
	cmpq	%rdx, %rax
	jne	.L4
.L5:
	ret
