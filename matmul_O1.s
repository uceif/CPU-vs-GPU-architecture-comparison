	.file	"matmul.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -O1 -std=c++17 -fno-asynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.type	_ZL11init_matrixRSt6vectorIdSaIdEEi, @function
_ZL11init_matrixRSt6vectorIdSaIdEEi:
.LFB2981:
	.cfi_startproc
	mov	r9, rdi	# M, tmp108
	mov	r11d, esi	# seed, tmp109
# matmul.cpp:29: static void init_matrix(Matrix& M, int seed) {
	mov	r8d, 8192	# ivtmp.128,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	mov	r10d, 0	# i,
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movsd	xmm1, QWORD PTR .LC0[rip]	# tmp107,
.L2:
	lea	edx, [r11+r10]	# ivtmp.116,
	lea	rcx, -8192[r8]	# ivtmp.117,
.L3:
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mov	rsi, QWORD PTR [r9]	# MEM[(struct vector *)M_16(D)].D.70397._M_impl.D.69704._M_start, MEM[(struct vector *)M_16(D)].D.70397._M_impl.D.69704._M_start
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movsx	rax, edx	# ivtmp.116, ivtmp.116
	imul	rax, rax, 1374389535	# tmp99, ivtmp.116,
	sar	rax, 37	# tmp101,
	mov	edi, edx	# tmp102, ivtmp.116
	sar	edi, 31	# tmp102,
	sub	eax, edi	# tmp97, tmp102
	imul	eax, eax, 100	# tmp103, tmp97,
	mov	edi, edx	# tmp104, ivtmp.116
	sub	edi, eax	# tmp104, tmp103
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	pxor	xmm0, xmm0	# tmp105
	cvtsi2sd	xmm0, edi	# tmp105, tmp104
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulsd	xmm0, xmm1	# tmp106, tmp107
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movsd	QWORD PTR [rsi+rcx], xmm0	# *_21, tmp106
# matmul.cpp:31:         for (int j = 0; j < N; ++j) {
	add	edx, 1	# ivtmp.116,
	add	rcx, 8	# ivtmp.117,
	cmp	rcx, r8	# ivtmp.117, ivtmp.128
	jne	.L3	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	r10d, 1	# i,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	r8, 8192	# ivtmp.128,
	cmp	r8, 8396800	# ivtmp.128,
	jne	.L2	#,
# matmul.cpp:37: }
	ret	
	.cfi_endproc
.LFE2981:
	.size	_ZL11init_matrixRSt6vectorIdSaIdEEi, .-_ZL11init_matrixRSt6vectorIdSaIdEEi
	.section	.text._ZNSt6vectorIdSaIdEED2Ev,"axG",@progbits,_ZNSt6vectorIdSaIdEED5Ev,comdat
	.align 2
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
	je	.L9	#,
# /usr/include/c++/13/bits/stl_vector.h:733:       ~vector() _GLIBCXX_NOEXCEPT
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	mov	rsi, QWORD PTR 16[rdi]	# MEM[(struct _Vector_base *)this_4(D)]._M_impl.D.69704._M_end_of_storage, MEM[(struct _Vector_base *)this_4(D)]._M_impl.D.69704._M_end_of_storage
	sub	rsi, rax	# tmp87, _10
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	mov	rdi, rax	#, _10
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:738:       }
	add	rsp, 8	#,
	.cfi_def_cfa_offset 8
	ret	
.L9:
	ret	
	.cfi_endproc
.LFE3298:
	.size	_ZNSt6vectorIdSaIdEED2Ev, .-_ZNSt6vectorIdSaIdEED2Ev
	.weak	_ZNSt6vectorIdSaIdEED1Ev
	.set	_ZNSt6vectorIdSaIdEED1Ev,_ZNSt6vectorIdSaIdEED2Ev
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Matrix multiplication "
.LC3:
	.string	" x "
.LC4:
	.string	"\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	"Element type: double (8 bytes)\n"
	.section	.rodata.str1.1
.LC6:
	.string	"Memory per matrix: "
.LC8:
	.string	" MB\n\n"
.LC11:
	.string	"Time:     "
.LC12:
	.string	" s\n"
.LC13:
	.string	"GFLOPS:   "
.LC14:
	.string	"Checksum: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB2984:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2984
	endbr64	
	push	r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 112	#,
	.cfi_def_cfa_offset 160
# matmul.cpp:71: int main() {
	mov	rax, QWORD PTR fs:40	# tmp226, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 104[rsp], rax	# D.76891, tmp226
	xor	eax, eax	# tmp226
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC2[rip]	# tmp145,
	lea	rbx, _ZSt4cout[rip]	# tmp146,
	mov	rdi, rbx	#, tmp146
.LEHB0:
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _8, tmp206
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
	call	_ZNSolsEi@PLT	#
	mov	rdi, rax	# _10, tmp207
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC3[rip]	# tmp147,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _12, tmp208
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
	call	_ZNSolsEi@PLT	#
	mov	rdi, rax	# _14, tmp209
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC4[rip]	# tmp148,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:73:     std::cout << "Element type: double (8 bytes)\n";
	lea	rsi, .LC5[rip]	# tmp149,
	mov	rdi, rbx	#, tmp146
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:74:     std::cout << "Memory per matrix: "
	lea	rsi, .LC6[rip]	# tmp151,
	mov	rdi, rbx	#, tmp146
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _18, tmp210
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR .LC7[rip]	#,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _46, tmp211
# matmul.cpp:76:               << " MB\n\n";
	lea	rsi, .LC8[rip]	# tmp154,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
	call	_Znwm@PLT	#
.LEHE0:
	mov	rbx, rax	# _101, tmp212
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 16[rsp], rax	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_start, _101
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rdx, 8388608[rax]	# _96,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 32[rsp], rdx	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_end_of_storage, _96
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_101,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rax, 8[rax]	# __first,
.L13:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	QWORD PTR [rax], 0x000000000	# MEM[(double *)__first_83],
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	add	rax, 8	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmp	rax, rdx	# __first, _96
	jne	.L13	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 24[rsp], rdx	# MEM[(struct vector *)&A].D.70397._M_impl.D.69704._M_finish, _96
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	mov	QWORD PTR 56[rsp], 0	# MEM[(struct _Vector_impl_data *)&B]._M_finish,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	mov	QWORD PTR 64[rsp], 0	# MEM[(struct _Vector_impl_data *)&B]._M_end_of_storage,
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
.LEHB1:
	call	_Znwm@PLT	#
.LEHE1:
	mov	r12, rax	# _111, tmp213
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 48[rsp], rax	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_start, _111
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rdx, 8388608[rax]	# _106,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 64[rsp], rdx	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_end_of_storage, _106
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_111,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rax, 8[rax]	# __first,
.L14:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	QWORD PTR [rax], 0x000000000	# MEM[(double *)__first_88],
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	add	rax, 8	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmp	rdx, rax	# _106, __first
	jne	.L14	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 56[rsp], rdx	# MEM[(struct vector *)&B].D.70397._M_impl.D.69704._M_finish, _106
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	mov	QWORD PTR 88[rsp], 0	# MEM[(struct _Vector_impl_data *)&C]._M_finish,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	mov	QWORD PTR 96[rsp], 0	# MEM[(struct _Vector_impl_data *)&C]._M_end_of_storage,
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
.LEHB2:
	call	_Znwm@PLT	#
.LEHE2:
	mov	rbp, rax	# _136, tmp214
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 80[rsp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_start, _136
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rdx, 8388608[rax]	# _131,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 96[rsp], rdx	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_end_of_storage, _131
.L15:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	QWORD PTR [rax], 0x000000000	# MEM[(double *)__first_80],
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	add	rax, 8	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmp	rax, rdx	# __first, _131
	jne	.L15	#,
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	QWORD PTR 88[rsp], rdx	# MEM[(struct vector *)&C].D.70397._M_impl.D.69704._M_finish, _131
# matmul.cpp:82:     init_matrix(A, 1);
	lea	rdi, 16[rsp]	# tmp163,
	mov	esi, 1	#,
	call	_ZL11init_matrixRSt6vectorIdSaIdEEi	#
# matmul.cpp:83:     init_matrix(B, 2);
	lea	rdi, 48[rsp]	# tmp164,
	mov	esi, 2	#,
	call	_ZL11init_matrixRSt6vectorIdSaIdEEi	#
# matmul.cpp:88:     auto t0 = std::chrono::steady_clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
	mov	r14, rax	# t0, tmp215
	mov	r13, rbp	# ivtmp.144, _136
	mov	rdi, rbp	# ivtmp.170, _136
	mov	esi, 0	# ivtmp.169,
	jmp	.L16	#
.L37:
# matmul.cpp:57:             C[i * N + j] = sum;
	movsd	QWORD PTR [rdi+rax*8], xmm0	# MEM[(value_type &)_114 + ivtmp.154_108 * 8], sum
# matmul.cpp:49:         for (int j = 0; j < N; ++j) {
	add	rax, 1	# ivtmp.154,
	add	rdx, 8	# ivtmp.160,
	cmp	rax, 1024	# ivtmp.154,
	je	.L18	#,
.L20:
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	rcx, rdx	# ivtmp.152, ivtmp.160
	mov	r8, rbx	# ivtmp.151, ivtmp.171
# matmul.cpp:50:             double sum = 0.0;
	pxor	xmm0, xmm0	# sum
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	lea	r9, 8388608[rdx]	# tmp167,
.L17:
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	movsd	xmm1, QWORD PTR [r8]	# MEM[(const value_type &)_95], MEM[(const value_type &)_95]
	mulsd	xmm1, QWORD PTR [rcx]	# tmp165, MEM[(const value_type &)_86]
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	addsd	xmm0, xmm1	# sum, tmp165
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	add	r8, 8	# ivtmp.151,
	add	rcx, 8192	# ivtmp.152,
	cmp	r9, rcx	# tmp167, ivtmp.152
	jne	.L17	#,
	jmp	.L37	#
.L18:
# matmul.cpp:48:     for (int i = 0; i < N; ++i) {
	add	esi, 1024	# ivtmp.169,
	add	rdi, 8192	# ivtmp.170,
	add	rbx, 8192	# ivtmp.171,
	cmp	esi, 1048576	# ivtmp.169,
	je	.L19	#,
.L16:
	mov	rdx, r12	# ivtmp.160, _111
# matmul.cpp:50:             double sum = 0.0;
	mov	eax, 0	# ivtmp.154,
	jmp	.L20	#
.L19:
# matmul.cpp:90:     auto t1 = std::chrono::steady_clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	sub	rax, r14	# tmp168, t0
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	pxor	xmm1, xmm1	# tmp169
	cvtsi2sd	xmm1, rax	# tmp169, tmp168
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	movsd	xmm0, QWORD PTR .LC9[rip]	# tmp170,
	divsd	xmm1, xmm0	# tmp169, tmp170
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	movsd	QWORD PTR 8[rsp], xmm1	# %sfp, _63
	mulsd	xmm0, xmm1	# tmp171, _63
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	movsd	xmm1, QWORD PTR .LC10[rip]	# tmp173,
	movapd	xmm2, xmm1	# tmp173, tmp173
	divsd	xmm2, xmm0	# tmp173, tmp171
	movq	rbx, xmm2	# gflops, tmp173
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	lea	rdi, _ZSt4cout[rip]	# tmp174,
	mov	rdx, QWORD PTR _ZSt4cout[rip]	# _36, cout._vptr.basic_ostream
	mov	rcx, rdi	# _20, tmp174
	add	rcx, QWORD PTR -24[rdx]	# _20, MEM[(long int *)_36 + -24B]
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	mov	eax, DWORD PTR 24[rcx]	# tmp177, _20->_M_flags
	and	eax, -261	# tmp177,
# /usr/include/c++/13/bits/ios_base.h:88:   { return _Ios_Fmtflags(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	eax, 4	# tmp179,
	mov	DWORD PTR 24[rcx], eax	# MEM[(_Ios_Fmtflags &)_20 + 24], tmp179
# /usr/include/c++/13/bits/ios_base.h:744:       _M_precision = __prec;
	mov	rax, QWORD PTR -24[rdx]	# MEM[(long int *)_36 + -24B], MEM[(long int *)_36 + -24B]
	mov	QWORD PTR 8[rdi+rax], 4	# _69->_M_precision,
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC11[rip]	# tmp182,
.LEHB3:
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _39, tmp217
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR 8[rsp]	#, %sfp
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _70, tmp218
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC12[rip]	# tmp184,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC13[rip]	# tmp185,
	lea	rdi, _ZSt4cout[rip]	# tmp186,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _42, tmp219
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movq	xmm0, rbx	#, gflops
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _71, tmp220
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC4[rip]	# tmp187,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC14[rip]	# tmp188,
	lea	rdi, _ZSt4cout[rip]	# tmp189,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
	mov	rdi, rax	# _45, tmp221
	add	rbp, 8388608	# _178,
# matmul.cpp:66:     double s = 0.0;
	pxor	xmm0, xmm0	# s
.L21:
# matmul.cpp:67:     for (int i = 0; i < N * N; ++i) s += C[i];
	addsd	xmm0, QWORD PTR 0[r13]	# s, MEM[(const value_type &)_215]
# matmul.cpp:67:     for (int i = 0; i < N * N; ++i) s += C[i];
	add	r13, 8	# ivtmp.144,
	cmp	rbp, r13	# _178, ivtmp.144
	jne	.L21	#,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _72, tmp222
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC4[rip]	# tmp190,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT	#
.LEHE3:
# matmul.cpp:104: }
	lea	rdi, 80[rsp]	# tmp191,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 48[rsp]	# tmp192,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 16[rsp]	# tmp193,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	mov	rax, QWORD PTR 104[rsp]	# tmp227, D.76891
	sub	rax, QWORD PTR fs:40	# tmp227, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L38	#,
	mov	eax, 0	#,
	add	rsp, 112	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbx	#
	.cfi_def_cfa_offset 40
	pop	rbp	#
	.cfi_def_cfa_offset 32
	pop	r12	#
	.cfi_def_cfa_offset 24
	pop	r13	#
	.cfi_def_cfa_offset 16
	pop	r14	#
	.cfi_def_cfa_offset 8
	ret	
.L29:
	.cfi_restore_state
	endbr64	
	mov	rbx, rax	# tmp197, tmp223
	lea	rdi, 80[rsp]	# tmp195,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L23:
	lea	rdi, 48[rsp]	# tmp200,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L24:
	lea	rdi, 16[rsp]	# tmp203,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
	mov	rax, QWORD PTR 104[rsp]	# tmp228, D.76891
	sub	rax, QWORD PTR fs:40	# tmp228, MEM[(<address-space-1> long unsigned int *)40B]
	je	.L25	#,
	call	__stack_chk_fail@PLT	#
.L28:
	endbr64	
	mov	rbx, rax	# tmp196, tmp224
	jmp	.L23	#
.L27:
	endbr64	
	mov	rbx, rax	# tmp201, tmp225
	jmp	.L24	#
.L25:
	mov	rdi, rbx	#, tmp201
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
.L38:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE2984:
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
	.uleb128 .L27-.LFB2984
	.uleb128 0
	.uleb128 .LEHB2-.LFB2984
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L28-.LFB2984
	.uleb128 0
	.uleb128 .LEHB3-.LFB2984
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L29-.LFB2984
	.uleb128 0
	.uleb128 .LEHB4-.LFB2984
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE2984:
	.text
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC7:
	.long	0
	.long	1075838976
	.align 8
.LC9:
	.long	0
	.long	1104006501
	.align 8
.LC10:
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
