	.file	"matmul.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -O2 -std=c++17 -fno-asynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0, @function
_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0:
.LFB3649:
	.cfi_startproc
	movdqa	xmm2, XMMWORD PTR .LC2[rip]	# tmp154,
	pxor	xmm4, xmm4	# tmp108
# matmul.cpp:29: static void init_matrix(Matrix& M, int seed) {
	mov	eax, esi	# tmp156, seed
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	xor	ecx, ecx	# i
	movdqa	xmm5, xmm4	# tmp112, tmp108
	movd	xmm7, eax	# tmp156, tmp156
	movsd	xmm6, QWORD PTR .LC4[rip]	# tmp150,
	movdqa	xmm9, XMMWORD PTR .LC1[rip]	# tmp153,
	pcmpgtd	xmm5, xmm2	# tmp112, tmp154
	mov	rsi, rdi	# ivtmp.138, tmp155
	movdqa	xmm10, XMMWORD PTR .LC0[rip]	# vect_vec_iv_.112,
	lea	rdx, 8192[rdi]	# ivtmp.139,
	unpcklpd	xmm6, xmm6	# tmp150
	pshufd	xmm8, xmm7, 0	# vect_cst__46, tmp156
	.p2align 4,,10
	.p2align 3
.L2:
	movd	xmm7, ecx	# i, i
# matmul.cpp:29: static void init_matrix(Matrix& M, int seed) {
	mov	rax, rsi	# ivtmp.126, ivtmp.138
	movdqa	xmm3, xmm10	# vect_vec_iv_.112, vect_vec_iv_.112
	pshufd	xmm7, xmm7, 0	# vect_cst__44, i
	.p2align 4,,10
	.p2align 3
.L3:
	movdqa	xmm0, xmm3	# vect_vec_iv_.112, vect_vec_iv_.112
	movdqa	xmm1, xmm4	# tmp109, tmp108
	movdqa	xmm12, xmm5	# tmp114, tmp112
	add	rax, 32	# ivtmp.126,
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm7	# vect__3.113, vect_cst__44
	movdqa	xmm13, xmm5	# tmp126, tmp112
	paddd	xmm3, xmm9	# vect_vec_iv_.112, tmp153
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm8	# vect__5.114, vect_cst__46
	pcmpgtd	xmm1, xmm0	# tmp109, vect__5.114
	pmuludq	xmm12, xmm0	# tmp114, vect__5.114
	movdqa	xmm11, xmm0	# tmp115, vect__5.114
	pmuludq	xmm11, xmm2	# tmp115, tmp154
	pmuludq	xmm1, xmm2	# tmp113, tmp154
	paddq	xmm1, xmm12	# tmp113, tmp114
	movdqa	xmm12, xmm4	# tmp121, tmp108
	psllq	xmm1, 32	# tmp113,
	paddq	xmm11, xmm1	# tmp105, tmp113
	movdqa	xmm1, xmm0	# tmp118, vect__5.114
	psrlq	xmm1, 32	# tmp118,
	pcmpgtd	xmm12, xmm1	# tmp121, tmp118
	pmuludq	xmm13, xmm1	# tmp126, tmp118
	pmuludq	xmm1, xmm2	# tmp127, tmp154
	pmuludq	xmm12, xmm2	# tmp125, tmp154
	paddq	xmm12, xmm13	# tmp125, tmp126
	psllq	xmm12, 32	# tmp125,
	paddq	xmm1, xmm12	# tmp116, tmp125
	shufps	xmm11, xmm1, 221	# tmp131, tmp116,
	pshufd	xmm11, xmm11, 216	# vect_patt_23.115, tmp131,
	psrad	xmm11, 5	# vect_patt_22.116,
	movdqa	xmm1, xmm11	# tmp134, vect_patt_22.116
	pslld	xmm1, 1	# tmp134,
	paddd	xmm1, xmm11	# tmp135, vect_patt_22.116
	pslld	xmm1, 3	# tmp136,
	paddd	xmm1, xmm11	# vect_patt_18.117, vect_patt_22.116
	pslld	xmm1, 2	# tmp138,
	psubd	xmm0, xmm1	# vect_patt_17.118, tmp138
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	cvtdq2pd	xmm1, xmm0	# vect__7.119, vect_patt_17.118
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm1, xmm6	# vect__8.120, tmp150
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	pshufd	xmm0, xmm0, 238	# tmp144, vect_patt_17.118,
	cvtdq2pd	xmm0, xmm0	# vect__7.119, tmp144
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm0, xmm6	# vect__8.120, tmp150
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movups	XMMWORD PTR -32[rax], xmm1	# MEM <vector(2) double> [(value_type &)_3], vect__8.120
	movups	XMMWORD PTR -16[rax], xmm0	# MEM <vector(2) double> [(value_type &)_3 + 16], vect__8.120
	cmp	rdx, rax	# ivtmp.139, ivtmp.126
	jne	.L3	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	ecx, 1	# i,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	rsi, 8192	# ivtmp.138,
	add	rdx, 8192	# ivtmp.139,
	cmp	ecx, 1024	# i,
	jne	.L2	#,
# matmul.cpp:37: }
	ret	
	.cfi_endproc
.LFE3649:
	.size	_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0, .-_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0
	.section	.text._ZNSt6vectorIdSaIdEED2Ev,"axG",@progbits,_ZNSt6vectorIdSaIdEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIdSaIdEED2Ev
	.type	_ZNSt6vectorIdSaIdEED2Ev, @function
_ZNSt6vectorIdSaIdEED2Ev:
.LFB3298:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	mov	rax, QWORD PTR [rdi]	# _10, MEM[(struct _Vector_base *)this_4(D)]._M_impl.D.69704._M_start
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	test	rax, rax	# _10
	je	.L7	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	mov	rsi, QWORD PTR 16[rdi]	# MEM[(struct _Vector_base *)this_4(D)]._M_impl.D.69704._M_end_of_storage, MEM[(struct _Vector_base *)this_4(D)]._M_impl.D.69704._M_end_of_storage
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	mov	rdi, rax	#, _10
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	sub	rsi, rax	# tmp87, _10
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4,,10
	.p2align 3
.L7:
# /usr/include/c++/13/bits/stl_vector.h:738:       }
	ret	
	.cfi_endproc
.LFE3298:
	.size	_ZNSt6vectorIdSaIdEED2Ev, .-_ZNSt6vectorIdSaIdEED2Ev
	.weak	_ZNSt6vectorIdSaIdEED1Ev
	.set	_ZNSt6vectorIdSaIdEED1Ev,_ZNSt6vectorIdSaIdEED2Ev
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"Matrix multiplication "
.LC7:
	.string	" x "
.LC8:
	.string	"\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"Element type: double (8 bytes)\n"
	.section	.rodata.str1.1
.LC10:
	.string	"Memory per matrix: "
.LC12:
	.string	" MB\n\n"
.LC15:
	.string	"Time:     "
.LC16:
	.string	" s\n"
.LC17:
	.string	"GFLOPS:   "
.LC18:
	.string	"Checksum: "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB20:
	.section	.text.startup,"ax",@progbits
.LHOTB20:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB2984:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2984
	endbr64	
	push	r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC6[rip]	# tmp147,
# matmul.cpp:71: int main() {
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	r13, _ZSt4cout[rip]	# tmp222,
# matmul.cpp:71: int main() {
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, r13	#, tmp222
# matmul.cpp:71: int main() {
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 120	#,
	.cfi_def_cfa_offset 176
# matmul.cpp:71: int main() {
	mov	rax, QWORD PTR fs:40	# tmp243, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 104[rsp], rax	# D.77060, tmp243
	xor	eax, eax	# tmp243
.LEHB0:
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rax	# _8, tmp223
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZNSolsEi@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC7[rip]	# tmp149,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rax	# _10, tmp224
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rax	# _12, tmp225
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZNSolsEi@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC8[rip]	#,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rax	# _14, tmp226
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:73:     std::cout << "Element type: double (8 bytes)\n";
	lea	rsi, .LC9[rip]	# tmp151,
	mov	rdi, r13	#, tmp222
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:74:     std::cout << "Memory per matrix: "
	lea	rsi, .LC10[rip]	# tmp153,
	mov	rdi, r13	#, tmp222
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR .LC11[rip]	#,
# matmul.cpp:74:     std::cout << "Memory per matrix: "
	mov	rdi, rax	# _18, tmp227
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# matmul.cpp:76:               << " MB\n\n";
	lea	rsi, .LC12[rip]	# tmp156,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	mov	rdi, rax	# _46, tmp228
# matmul.cpp:76:               << " MB\n\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
	call	_Znwm@PLT	#
.LEHE0:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388600	#,
	xor	esi, esi	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_105,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	r14, 8388608[rax]	# _76,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rdi, 8[rax]	# __first,
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	rbx, rax	# _105, tmp229
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 16[rsp], rax	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_start, _105
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 32[rsp], r14	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_end_of_storage, _76
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	pxor	xmm0, xmm0	# tmp164
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 24[rsp], r14	# A.D.70397._M_impl.D.69704._M_finish, _76
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movups	XMMWORD PTR 56[rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&B + 8B], tmp164
.LEHB1:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE1:
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_127,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rdi, 8[rax]	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xor	esi, esi	#
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	r12, rax	# _127, tmp230
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	r15, 8388608[rax]	# ivtmp.202,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388600	#,
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 48[rsp], rax	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_start, _127
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 64[rsp], r15	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_end_of_storage, ivtmp.202
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	pxor	xmm0, xmm0	# tmp172
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 56[rsp], r15	# B.D.70397._M_impl.D.69704._M_finish, ivtmp.202
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movups	XMMWORD PTR 88[rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&C + 8B], tmp172
.LEHB2:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE2:
	mov	rbp, rax	# tmp173, tmp231
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 80[rsp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_start, tmp173
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xor	esi, esi	#
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rax, 8388608[rax]	# _176,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	rdi, rbp	#, tmp173
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR [rsp], rax	# %sfp, _176
	mov	QWORD PTR 96[rsp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_end_of_storage, _176
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	rax, QWORD PTR [rsp]	# _176, %sfp
# matmul.cpp:82:     init_matrix(A, 1);
	mov	esi, 1	#,
	mov	rdi, rbx	#, _105
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	QWORD PTR 88[rsp], rax	# C.D.70397._M_impl.D.69704._M_finish, _176
# matmul.cpp:82:     init_matrix(A, 1);
	call	_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0	#
# matmul.cpp:83:     init_matrix(B, 2);
	mov	esi, 2	#,
	mov	rdi, r12	#, _127
	call	_ZL11init_matrixRSt6vectorIdSaIdEEi.isra.0	#
# matmul.cpp:88:     auto t0 = std::chrono::steady_clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
	lea	r8, 8192[rbp]	# ivtmp.209,
	mov	r9, rbp	# ivtmp.210, ivtmp.181
	mov	rdx, rax	# t0, tmp232
.L10:
	mov	r10, r12	# ivtmp.201, _127
	mov	rsi, r15	# ivtmp.202, ivtmp.202
# matmul.cpp:71: int main() {
	mov	rdi, r9	# ivtmp.199, ivtmp.210
.L14:
	mov	rcx, rbx	# ivtmp.193, ivtmp.211
	mov	rax, r10	# ivtmp.188, ivtmp.201
	pxor	xmm1, xmm1	# vect_sum_88.163
	.p2align 4,,10
	.p2align 3
.L11:
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	movsd	xmm0, QWORD PTR [rcx]	# tmp179, MEM[(const value_type &)_192]
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	movupd	xmm2, XMMWORD PTR [rax]	# tmp286, MEM <const vector(2) double> [(const value_type &)_193]
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	add	rax, 8192	# ivtmp.188,
	add	rcx, 8	# ivtmp.193,
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	unpcklpd	xmm0, xmm0	# tmp179
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	mulpd	xmm0, xmm2	# vect__184.167, tmp286
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	addpd	xmm1, xmm0	# vect_sum_88.163, vect__184.167
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	cmp	rsi, rax	# ivtmp.202, ivtmp.188
	jne	.L11	#,
# matmul.cpp:57:             C[i * N + j] = sum;
	movups	XMMWORD PTR [rdi], xmm1	# MEM <vector(2) double> [(value_type &)_217], vect_sum_88.163
	add	rdi, 16	# ivtmp.199,
	add	r10, 16	# ivtmp.201,
	add	rsi, 16	# ivtmp.202,
	cmp	r8, rdi	# ivtmp.209, ivtmp.199
	jne	.L14	#,
# matmul.cpp:48:     for (int i = 0; i < N; ++i) {
	add	rbx, 8192	# ivtmp.211,
	add	r8, 8192	# ivtmp.209,
	add	r9, 8192	# ivtmp.210,
	cmp	r14, rbx	# _76, ivtmp.211
	jne	.L10	#,
# matmul.cpp:90:     auto t1 = std::chrono::steady_clock::now();
	mov	QWORD PTR 8[rsp], rdx	# %sfp, t0
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	mov	rdx, QWORD PTR 8[rsp]	# t0, %sfp
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	pxor	xmm1, xmm1	# tmp182
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	movsd	xmm0, QWORD PTR .LC13[rip]	# tmp183,
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC15[rip]	# tmp194,
	mov	rdi, r13	#, tmp222
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	sub	rax, rdx	# tmp181, t0
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	cvtsi2sd	xmm1, rax	# tmp182, tmp181
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	mov	rax, QWORD PTR _ZSt4cout[rip]	# cout._vptr.basic_ostream, cout._vptr.basic_ostream
	mov	rdx, QWORD PTR -24[rax]	# _20, MEM[(long int *)_36 + -24B]
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	divsd	xmm1, xmm0	# tmp182, tmp183
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	add	rdx, r13	# _20, tmp222
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	mov	eax, DWORD PTR 24[rdx]	# tmp191, _20->_M_flags
# /usr/include/c++/13/bits/ios_base.h:744:       _M_precision = __prec;
	mov	QWORD PTR 8[rdx], 4	# _20->_M_precision,
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	and	eax, -261	# tmp191,
# /usr/include/c++/13/bits/ios_base.h:88:   { return _Ios_Fmtflags(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	eax, 4	# tmp193,
	mov	DWORD PTR 24[rdx], eax	# MEM[(_Ios_Fmtflags &)_20 + 24], tmp193
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	mulsd	xmm0, xmm1	# tmp184, _63
	movsd	QWORD PTR 8[rsp], xmm1	# %sfp, _63
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	movsd	xmm1, QWORD PTR .LC14[rip]	# tmp186,
	movapd	xmm3, xmm1	# tmp186, tmp186
	divsd	xmm3, xmm0	# tmp186, tmp184
	movq	rbx, xmm3	# gflops, tmp186
.LEHB3:
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR 8[rsp]	#, %sfp
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	mov	rdi, rax	# _39, tmp234
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _67, tmp235
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC16[rip]	# tmp196,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC17[rip]	# tmp197,
	mov	rdi, r13	#, tmp222
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _42, tmp236
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movq	xmm0, rbx	#, gflops
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _68, tmp237
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC8[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC18[rip]	# tmp200,
	mov	rdi, r13	#, tmp222
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _45, tmp238
# matmul.cpp:66:     double s = 0.0;
	pxor	xmm0, xmm0	# s
.L15:
	addsd	xmm0, QWORD PTR 0[rbp]	# stmp_s_77.162, BIT_FIELD_REF <MEM <const vector(2) double> [(const value_type &)_92], 64, 0>
	add	rbp, 16	# ivtmp.181,
# matmul.cpp:67:     for (int i = 0; i < N * N; ++i) s += C[i];
	addsd	xmm0, QWORD PTR -8[rbp]	# s, BIT_FIELD_REF <MEM <const vector(2) double> [(const value_type &)_92], 64, 64>
	cmp	QWORD PTR [rsp], rbp	# %sfp, ivtmp.181
	jne	.L15	#,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _69, tmp239
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC8[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
.LEHE3:
# matmul.cpp:104: }
	lea	rdi, 80[rsp]	# tmp203,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 48[rsp]	# tmp204,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 16[rsp]	# tmp205,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	mov	rax, QWORD PTR 104[rsp]	# tmp244, D.77060
	sub	rax, QWORD PTR fs:40	# tmp244, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L28	#,
	add	rsp, 120	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xor	eax, eax	#
	pop	rbx	#
	.cfi_def_cfa_offset 48
	pop	rbp	#
	.cfi_def_cfa_offset 40
	pop	r12	#
	.cfi_def_cfa_offset 32
	pop	r13	#
	.cfi_def_cfa_offset 24
	pop	r14	#
	.cfi_def_cfa_offset 16
	pop	r15	#
	.cfi_def_cfa_offset 8
	ret	
.L28:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
.L23:
	endbr64	
	mov	rbx, rax	# tmp209, tmp240
	jmp	.L16	#
.L22:
	endbr64	
	mov	rbx, rax	# tmp208, tmp241
	jmp	.L17	#
.L21:
	endbr64	
	mov	rbx, rax	# tmp213, tmp242
	jmp	.L18	#
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA2984:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2984-.LLSDACSB2984
.LLSDACSB2984:
	.uleb128 .LEHB0-.LFB2984
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB2984
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L21-.LFB2984
	.uleb128 0
	.uleb128 .LEHB2-.LFB2984
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L22-.LFB2984
	.uleb128 0
	.uleb128 .LEHB3-.LFB2984
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L23-.LFB2984
	.uleb128 0
.LLSDACSE2984:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC2984
	.type	main.cold, @function
main.cold:
.LFSB2984:
.L16:
	.cfi_def_cfa_offset 176
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, 80[rsp]	# tmp207,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L17:
	lea	rdi, 48[rsp]	# tmp212,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L18:
	lea	rdi, 16[rsp]	# tmp215,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
	mov	rax, QWORD PTR 104[rsp]	# tmp245, D.77060
	sub	rax, QWORD PTR fs:40	# tmp245, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L29	#,
	mov	rdi, rbx	#, tmp213
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
.L29:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE2984:
	.section	.gcc_except_table
.LLSDAC2984:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC2984-.LLSDACSBC2984
.LLSDACSBC2984:
	.uleb128 .LEHB4-.LCOLDB20
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSEC2984:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE20:
	.section	.text.startup
.LHOTE20:
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC1:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC2:
	.long	1374389535
	.long	1374389535
	.long	1374389535
	.long	1374389535
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 8
.LC11:
	.long	0
	.long	1075838976
	.align 8
.LC13:
	.long	0
	.long	1104006501
	.align 8
.LC14:
	.long	0
	.long	1105199104
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
