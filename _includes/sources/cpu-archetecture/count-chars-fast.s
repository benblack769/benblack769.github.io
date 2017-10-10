	.file	"count-chars-fast.cpp"
	.section .rdata,"dr"
_ZStL19piecewise_construct:
	.space 1
	.text
	.globl	_Z11count_charsRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEc
	.def	_Z11count_charsRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11count_charsRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEc
_Z11count_charsRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEc:
.LFB985:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	movl	$0, -4(%rbp)
	movl	$255, -20(%rbp)
	movq	16(%rbp), %rcx
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4sizeEv
	movl	%eax, -24(%rbp)
	movl	$0, -8(%rbp)
.L5:
	movl	-24(%rbp), %eax
	subl	$255, %eax
	cmpl	-8(%rbp), %eax
	jl	.L2
	movb	$0, -9(%rbp)
	movl	$0, -16(%rbp)
.L4:
	cmpl	$254, -16(%rbp)
	jg	.L3
	movl	-8(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	cltq
	movq	%rax, %rdx
	movq	16(%rbp), %rcx
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEixEy
	movzbl	(%rax), %eax
	cmpb	24(%rbp), %al
	sete	%al
	movl	%eax, %edx
	movzbl	-9(%rbp), %eax
	addl	%edx, %eax
	movb	%al, -9(%rbp)
	addl	$1, -16(%rbp)
	jmp	.L4
.L3:
	movsbl	-9(%rbp), %eax
	addl	%eax, -4(%rbp)
	addl	$255, -8(%rbp)
	jmp	.L5
.L2:
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	.L6
	movl	-8(%rbp), %eax
	cltq
	movq	%rax, %rdx
	movq	16(%rbp), %rcx
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEixEy
	movzbl	(%rax), %eax
	cmpb	24(%rbp), %al
	sete	%al
	movzbl	%al, %eax
	addl	%eax, -4(%rbp)
	addl	$1, -8(%rbp)
	jmp	.L2
.L6:
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 6.2.0"
	.def	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4sizeEv;	.scl	2;	.type	32;	.endef
	.def	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEixEy;	.scl	2;	.type	32;	.endef
