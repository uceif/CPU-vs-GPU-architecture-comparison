	.file	"matmul.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64 -O3 -std=c++17 -fno-asynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, @function
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0:
.LFB3646:
	.cfi_startproc
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rdi	# __out, tmp99
	push	rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/ostream:664:       if (!__s)
	test	rsi, rsi	# __s
	je	.L5	#,
# /usr/include/c++/13/bits/char_traits.h:399: 	return __builtin_strlen(__s);
	mov	rdi, rsi	#, __s
	mov	rbx, rsi	# __s, tmp100
	call	strlen@PLT	#
# /usr/include/c++/13/ostream:670:     }
	add	rsp, 8	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	rsi, rbx	#, __s
	mov	rdi, rbp	#, __out
# /usr/include/c++/13/ostream:670:     }
	pop	rbx	#
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/char_traits.h:399: 	return __builtin_strlen(__s);
	mov	rdx, rax	# tmp97, tmp101
# /usr/include/c++/13/ostream:670:     }
	pop	rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	jmp	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
.L5:
	.cfi_restore_state
# /usr/include/c++/13/ostream:665: 	__out.setstate(ios_base::badbit);
	mov	rax, QWORD PTR [rdi]	# __out_2(D)->_vptr.basic_ostream, __out_2(D)->_vptr.basic_ostream
	mov	rdi, QWORD PTR -24[rax]	# __out, MEM[(long int *)_9 + -24B]
	add	rdi, rbp	# __out, __out
# /usr/include/c++/13/bits/ios_base.h:171:   { return _Ios_Iostate(static_cast<int>(__a) | static_cast<int>(__b)); }
	mov	esi, DWORD PTR 32[rdi]	# tmp94, MEM[(const struct basic_ios *)_12].D.46834._M_streambuf_state
# /usr/include/c++/13/ostream:670:     }
	pop	rax	#
	.cfi_def_cfa_offset 24
	pop	rbx	#
	.cfi_def_cfa_offset 16
	pop	rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/ios_base.h:171:   { return _Ios_Iostate(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	esi, 1	# tmp94,
# /usr/include/c++/13/bits/basic_ios.h:158:       { this->clear(this->rdstate() | __state); }
	jmp	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT	#
	.cfi_endproc
.LFE3646:
	.size	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, .-_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
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
	mov	rax, QWORD PTR [rdi]	# _7, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.69704._M_start
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	test	rax, rax	# _7
	je	.L6	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	mov	rsi, QWORD PTR 16[rdi]	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.69704._M_end_of_storage, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.69704._M_end_of_storage
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	mov	rdi, rax	#, _7
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	sub	rsi, rax	# tmp87, _7
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4,,10
	.p2align 3
.L6:
# /usr/include/c++/13/bits/stl_vector.h:738:       }
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
.LC17:
	.string	"Time:     "
.LC18:
	.string	" s\n"
.LC19:
	.string	"GFLOPS:   "
.LC20:
	.string	"Checksum: "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB22:
	.section	.text.startup,"ax",@progbits
.LHOTB22:
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
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 22	#,
	lea	rsi, .LC2[rip]	# tmp180,
# matmul.cpp:71: int main() {
	push	r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	lea	rbp, _ZSt4cout[rip]	# tmp358,
# matmul.cpp:71: int main() {
	push	rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	rdi, rbp	#, tmp358
# matmul.cpp:71: int main() {
	sub	rsp, 120	#,
	.cfi_def_cfa_offset 176
# matmul.cpp:71: int main() {
	mov	rax, QWORD PTR fs:40	# tmp376, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR 104[rsp], rax	# D.77036, tmp376
	xor	eax, eax	# tmp376
.LEHB0:
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
	mov	rdi, rbp	#, tmp358
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 3	#,
	lea	rsi, .LC3[rip]	# tmp183,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rbx, rax	# _8, tmp362
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	rdi, rax	#, _8
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rbx	#, _8
	mov	esi, 1024	#,
	call	_ZNSolsEi@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	lea	rsi, .LC4[rip]	#,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rdi, rax	# _10, tmp363
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# matmul.cpp:73:     std::cout << "Element type: double (8 bytes)\n";
	lea	rsi, .LC5[rip]	# tmp185,
	mov	rdi, rbp	#, tmp358
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 19	#,
	lea	rsi, .LC6[rip]	# tmp187,
	mov	rdi, rbp	#, tmp358
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR .LC7[rip]	#,
	mov	rdi, rbp	#, tmp358
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# matmul.cpp:76:               << " MB\n\n";
	lea	rsi, .LC8[rip]	# tmp191,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	mov	rdi, rax	# _43, tmp364
# matmul.cpp:76:               << " MB\n\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
	call	_Znwm@PLT	#
.LEHE0:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388600	#,
	xor	esi, esi	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_133,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rbx, 8388608[rax]	# _128,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rdi, 8[rax]	# __first,
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	r12, rax	# _133, tmp365
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 16[rsp], rax	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_start, _133
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 32[rsp], rbx	# MEM[(struct _Vector_base *)&A]._M_impl.D.69704._M_end_of_storage, _128
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	pxor	xmm0, xmm0	# tmp199
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 24[rsp], rbx	# MEM[(struct vector *)&A].D.70397._M_impl.D.69704._M_finish, _128
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movups	XMMWORD PTR 56[rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&B + 8B], tmp199
.LEHB1:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE1:
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_150,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rdi, 8[rax]	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xor	esi, esi	#
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	r13, rax	# _150, tmp366
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	r15, 8388608[rax]	# ivtmp.197,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388600	#,
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 48[rsp], rax	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_start, _150
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 64[rsp], r15	# MEM[(struct _Vector_base *)&B]._M_impl.D.69704._M_end_of_storage, ivtmp.197
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	pxor	xmm0, xmm0	# tmp207
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR 56[rsp], r15	# MEM[(struct vector *)&B].D.70397._M_impl.D.69704._M_finish, ivtmp.197
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movups	XMMWORD PTR 88[rsp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&C + 8B], tmp207
.LEHB2:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE2:
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	r14, 8388608[rax]	# _70,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xor	esi, esi	#
	mov	rdi, rax	#, _175
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	rbx, rax	# _175, tmp367
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR 80[rsp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_start, _175
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR 96[rsp], r14	# MEM[(struct _Vector_base *)&C]._M_impl.D.69704._M_end_of_storage, _70
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
	pxor	xmm7, xmm7	# tmp219
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	QWORD PTR 88[rsp], r14	# MEM[(struct vector *)&C].D.70397._M_impl.D.69704._M_finish, _70
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	xor	edx, edx	# i
	movdqa	xmm2, XMMWORD PTR .LC11[rip]	# tmp355,
	movdqa	xmm8, xmm7	# tmp223, tmp219
	movsd	xmm3, QWORD PTR .LC13[rip]	# tmp353,
	lea	rcx, 8192[r12]	# ivtmp.239,
	movdqa	xmm4, XMMWORD PTR .LC9[rip]	# tmp352,
	movdqa	xmm5, XMMWORD PTR .LC0[rip]	# vect_vec_iv_.142,
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	rsi, r12	# ivtmp.238, _133
	pcmpgtd	xmm8, xmm2	# tmp223, tmp355
	unpcklpd	xmm3, xmm3	# tmp353
	movdqa	xmm9, XMMWORD PTR .LC10[rip]	# tmp354,
.L9:
	movd	xmm6, edx	# i, i
# matmul.cpp:71: int main() {
	mov	rax, rsi	# ivtmp.227, ivtmp.238
	pshufd	xmm10, xmm6, 0	# vect_cst__38, i
	movdqa	xmm6, xmm5	# vect_vec_iv_.153, vect_vec_iv_.142
.L10:
	movdqa	xmm0, xmm6	# vect_vec_iv_.153, vect_vec_iv_.153
	movdqa	xmm1, xmm7	# tmp220, tmp219
	movdqa	xmm12, xmm8	# tmp225, tmp223
	add	rax, 32	# ivtmp.227,
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm10	# vect__70.154, vect_cst__38
	movdqa	xmm13, xmm8	# tmp237, tmp223
	paddd	xmm6, xmm4	# vect_vec_iv_.153, tmp352
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm9	# vect__71.155, tmp354
	pcmpgtd	xmm1, xmm0	# tmp220, vect__71.155
	pmuludq	xmm12, xmm0	# tmp225, vect__71.155
	movdqa	xmm11, xmm0	# tmp226, vect__71.155
	pmuludq	xmm11, xmm2	# tmp226, tmp355
	pmuludq	xmm1, xmm2	# tmp224, tmp355
	paddq	xmm1, xmm12	# tmp224, tmp225
	movdqa	xmm12, xmm7	# tmp232, tmp219
	psllq	xmm1, 32	# tmp224,
	paddq	xmm11, xmm1	# tmp216, tmp224
	movdqa	xmm1, xmm0	# tmp229, vect__71.155
	psrlq	xmm1, 32	# tmp229,
	pcmpgtd	xmm12, xmm1	# tmp232, tmp229
	pmuludq	xmm13, xmm1	# tmp237, tmp229
	pmuludq	xmm1, xmm2	# tmp238, tmp355
	pmuludq	xmm12, xmm2	# tmp236, tmp355
	paddq	xmm12, xmm13	# tmp236, tmp237
	psllq	xmm12, 32	# tmp236,
	paddq	xmm1, xmm12	# tmp227, tmp236
	shufps	xmm11, xmm1, 221	# tmp242, tmp227,
	pshufd	xmm11, xmm11, 216	# vect_patt_96.156, tmp242,
	psrad	xmm11, 5	# vect_patt_95.157,
	movdqa	xmm1, xmm11	# tmp245, vect_patt_95.157
	pslld	xmm1, 1	# tmp245,
	paddd	xmm1, xmm11	# tmp246, vect_patt_95.157
	pslld	xmm1, 3	# tmp247,
	paddd	xmm1, xmm11	# vect_patt_92.158, vect_patt_95.157
	pslld	xmm1, 2	# tmp249,
	psubd	xmm0, xmm1	# vect_patt_86.159, tmp249
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	cvtdq2pd	xmm1, xmm0	# vect__73.160, vect_patt_86.159
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm1, xmm3	# vect__74.161, tmp353
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	pshufd	xmm0, xmm0, 238	# tmp255, vect_patt_86.159,
	cvtdq2pd	xmm0, xmm0	# vect__73.160, tmp255
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm0, xmm3	# vect__74.161, tmp353
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movups	XMMWORD PTR -32[rax], xmm1	# MEM <vector(2) double> [(value_type &)_264], vect__74.161
	movups	XMMWORD PTR -16[rax], xmm0	# MEM <vector(2) double> [(value_type &)_264 + 16], vect__74.161
	cmp	rcx, rax	# ivtmp.239, ivtmp.227
	jne	.L10	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	edx, 1	# i,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	rsi, 8192	# ivtmp.238,
	add	rcx, 8192	# ivtmp.239,
	cmp	edx, 1024	# i,
	jne	.L9	#,
	pxor	xmm7, xmm7	# tmp266
	lea	rcx, 8192[r13]	# ivtmp.223,
	mov	rsi, r13	# ivtmp.222, _150
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	xor	edx, edx	# i
	movdqa	xmm9, XMMWORD PTR .LC14[rip]	# tmp356,
	movdqa	xmm8, xmm7	# tmp270, tmp266
	pcmpgtd	xmm8, xmm2	# tmp270, tmp355
.L11:
	movd	xmm6, edx	# i, i
	mov	rax, rsi	# ivtmp.214, ivtmp.222
	pshufd	xmm10, xmm6, 0	# vect_cst__168, i
	movdqa	xmm6, xmm5	# vect_vec_iv_.142, vect_vec_iv_.142
.L12:
	movdqa	xmm0, xmm6	# vect_vec_iv_.142, vect_vec_iv_.142
	movdqa	xmm1, xmm7	# tmp267, tmp266
	movdqa	xmm12, xmm8	# tmp272, tmp270
	add	rax, 32	# ivtmp.214,
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm10	# vect__55.143, vect_cst__168
	movdqa	xmm13, xmm8	# tmp284, tmp270
	paddd	xmm6, xmm4	# vect_vec_iv_.142, tmp352
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	paddd	xmm0, xmm9	# vect__56.144, tmp356
	pcmpgtd	xmm1, xmm0	# tmp267, vect__56.144
	pmuludq	xmm12, xmm0	# tmp272, vect__56.144
	movdqa	xmm11, xmm0	# tmp273, vect__56.144
	pmuludq	xmm11, xmm2	# tmp273, tmp355
	pmuludq	xmm1, xmm2	# tmp271, tmp355
	paddq	xmm1, xmm12	# tmp271, tmp272
	movdqa	xmm12, xmm7	# tmp279, tmp266
	psllq	xmm1, 32	# tmp271,
	paddq	xmm11, xmm1	# tmp263, tmp271
	movdqa	xmm1, xmm0	# tmp276, vect__56.144
	psrlq	xmm1, 32	# tmp276,
	pcmpgtd	xmm12, xmm1	# tmp279, tmp276
	pmuludq	xmm13, xmm1	# tmp284, tmp276
	pmuludq	xmm1, xmm2	# tmp285, tmp355
	pmuludq	xmm12, xmm2	# tmp283, tmp355
	paddq	xmm12, xmm13	# tmp283, tmp284
	psllq	xmm12, 32	# tmp283,
	paddq	xmm1, xmm12	# tmp274, tmp283
	shufps	xmm11, xmm1, 221	# tmp289, tmp274,
	pshufd	xmm11, xmm11, 216	# vect_patt_192.145, tmp289,
	psrad	xmm11, 5	# vect_patt_189.146,
	movdqa	xmm1, xmm11	# tmp292, vect_patt_189.146
	pslld	xmm1, 1	# tmp292,
	paddd	xmm1, xmm11	# tmp293, vect_patt_189.146
	pslld	xmm1, 3	# tmp294,
	paddd	xmm1, xmm11	# vect_patt_184.147, vect_patt_189.146
	pslld	xmm1, 2	# tmp296,
	psubd	xmm0, xmm1	# vect_patt_181.148, tmp296
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	cvtdq2pd	xmm1, xmm0	# vect__58.149, vect_patt_181.148
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm1, xmm3	# vect__59.150, tmp353
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	pshufd	xmm0, xmm0, 238	# tmp302, vect_patt_181.148,
	cvtdq2pd	xmm0, xmm0	# vect__58.149, tmp302
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mulpd	xmm0, xmm3	# vect__59.150, tmp353
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	movups	XMMWORD PTR -32[rax], xmm1	# MEM <vector(2) double> [(value_type &)_279], vect__59.150
	movups	XMMWORD PTR -16[rax], xmm0	# MEM <vector(2) double> [(value_type &)_279 + 16], vect__59.150
	cmp	rcx, rax	# ivtmp.223, ivtmp.214
	jne	.L12	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	edx, 1	# i,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	rsi, 8192	# ivtmp.222,
	add	rcx, 8192	# ivtmp.223,
	cmp	edx, 1024	# i,
	jne	.L11	#,
# matmul.cpp:88:     auto t0 = std::chrono::steady_clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
	mov	rsi, rbx	# ivtmp.205, ivtmp.177
	xor	r9d, r9d	# ivtmp.199
	mov	rdx, rax	# t0, tmp368
.L14:
	mov	r10, r9	# tmp310, ivtmp.199
	mov	rdi, r15	# ivtmp.197, ivtmp.197
	lea	r11, 8192[rsi]	# _195,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	mov	r8, r13	# ivtmp.196, _150
	sal	r10, 13	# tmp310,
	add	r10, r12	# _285, _133
.L18:
	mov	rcx, r10	# ivtmp.188, _285
	mov	rax, r8	# ivtmp.184, ivtmp.196
	pxor	xmm1, xmm1	# vect_sum_136.133
	.p2align 4,,10
	.p2align 3
.L15:
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	movsd	xmm0, QWORD PTR [rcx]	# tmp308, MEM[(const value_type &)_60]
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	movupd	xmm5, XMMWORD PTR [rax]	# tmp453, MEM <const vector(2) double> [(const value_type &)_276]
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	add	rax, 8192	# ivtmp.184,
	add	rcx, 8	# ivtmp.188,
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	unpcklpd	xmm0, xmm0	# tmp308
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	mulpd	xmm0, xmm5	# vect__196.137, tmp453
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	addpd	xmm1, xmm0	# vect_sum_136.133, vect__196.137
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	cmp	rdi, rax	# ivtmp.197, ivtmp.184
	jne	.L15	#,
# matmul.cpp:57:             C[i * N + j] = sum;
	movups	XMMWORD PTR [rsi], xmm1	# MEM <vector(2) double> [(value_type &)_280], vect_sum_136.133
	add	rsi, 16	# ivtmp.194,
	add	r8, 16	# ivtmp.196,
	add	rdi, 16	# ivtmp.197,
	cmp	rsi, r11	# ivtmp.194, _195
	jne	.L18	#,
# matmul.cpp:48:     for (int i = 0; i < N; ++i) {
	add	r9, 1	# ivtmp.199,
	cmp	r9, 1024	# ivtmp.199,
	jne	.L14	#,
# matmul.cpp:90:     auto t1 = std::chrono::steady_clock::now();
	mov	QWORD PTR 8[rsp], rdx	# %sfp, t0
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	mov	rdx, QWORD PTR 8[rsp]	# t0, %sfp
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	pxor	xmm1, xmm1	# tmp312
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	movsd	xmm0, QWORD PTR .LC15[rip]	# tmp313,
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	lea	rsi, .LC17[rip]	# tmp324,
	mov	rdi, rbp	#, tmp358
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	sub	rax, rdx	# tmp311, t0
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	cvtsi2sd	xmm1, rax	# tmp312, tmp311
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	mov	rax, QWORD PTR _ZSt4cout[rip]	# cout._vptr.basic_ostream, cout._vptr.basic_ostream
	mov	rdx, QWORD PTR -24[rax]	# _47, MEM[(long int *)_44 + -24B]
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	divsd	xmm1, xmm0	# tmp312, tmp313
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	add	rdx, rbp	# _47, tmp358
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	mov	eax, DWORD PTR 24[rdx]	# tmp321, _47->_M_flags
# /usr/include/c++/13/bits/ios_base.h:744:       _M_precision = __prec;
	mov	QWORD PTR 8[rdx], 4	# _47->_M_precision,
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	and	eax, -261	# tmp321,
# /usr/include/c++/13/bits/ios_base.h:88:   { return _Ios_Fmtflags(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	eax, 4	# tmp323,
	mov	DWORD PTR 24[rdx], eax	# MEM[(_Ios_Fmtflags &)_47 + 24], tmp323
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	mulsd	xmm0, xmm1	# tmp314, _49
	movsd	QWORD PTR 8[rsp], xmm1	# %sfp, _49
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	movsd	xmm1, QWORD PTR .LC16[rip]	# tmp316,
	movapd	xmm4, xmm1	# tmp316, tmp316
	divsd	xmm4, xmm0	# tmp316, tmp314
	movq	r12, xmm4	# gflops, tmp316
.LEHB3:
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movsd	xmm0, QWORD PTR 8[rsp]	#, %sfp
	mov	rdi, rbp	#, tmp358
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _83, tmp370
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC18[rip]	# tmp327,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
	lea	rsi, .LC19[rip]	# tmp328,
	mov	rdi, rbp	#, tmp358
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	movq	xmm0, r12	#, gflops
	mov	rdi, rbp	#, tmp358
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _84, tmp371
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC4[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
	lea	rsi, .LC20[rip]	# tmp332,
	mov	rdi, rbp	#, tmp358
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# matmul.cpp:66:     double s = 0.0;
	pxor	xmm0, xmm0	# s
.L19:
	addsd	xmm0, QWORD PTR [rbx]	# stmp_s_93.132, BIT_FIELD_REF <MEM <const vector(2) double> [(const value_type &)_243], 64, 0>
	add	rbx, 16	# ivtmp.177,
# matmul.cpp:67:     for (int i = 0; i < N * N; ++i) s += C[i];
	addsd	xmm0, QWORD PTR -8[rbx]	# s, BIT_FIELD_REF <MEM <const vector(2) double> [(const value_type &)_243], 64, 64>
	cmp	r14, rbx	# _70, ivtmp.177
	jne	.L19	#,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	mov	rdi, rbp	#, tmp358
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _85, tmp372
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC4[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
.LEHE3:
# matmul.cpp:104: }
	lea	rdi, 80[rsp]	# tmp336,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 48[rsp]	# tmp337,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, 16[rsp]	# tmp338,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	mov	rax, QWORD PTR 104[rsp]	# tmp377, D.77036
	sub	rax, QWORD PTR fs:40	# tmp377, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L35	#,
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
.L35:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
.L27:
	endbr64	
	mov	rbx, rax	# tmp342, tmp373
	jmp	.L20	#
.L26:
	endbr64	
	mov	rbx, rax	# tmp341, tmp374
	jmp	.L21	#
.L25:
	endbr64	
	mov	rbx, rax	# tmp346, tmp375
	jmp	.L22	#
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
	.uleb128 .L25-.LFB2984
	.uleb128 0
	.uleb128 .LEHB2-.LFB2984
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L26-.LFB2984
	.uleb128 0
	.uleb128 .LEHB3-.LFB2984
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L27-.LFB2984
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
.L20:
	.cfi_def_cfa_offset 176
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, 80[rsp]	# tmp340,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L21:
	lea	rdi, 48[rsp]	# tmp345,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L22:
	lea	rdi, 16[rsp]	# tmp348,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
	mov	rax, QWORD PTR 104[rsp]	# tmp378, D.77036
	sub	rax, QWORD PTR fs:40	# tmp378, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L36	#,
	mov	rdi, rbx	#, tmp346
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
.L36:
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
	.uleb128 .LEHB4-.LCOLDB22
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSEC2984:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE22:
	.section	.text.startup
.LHOTE22:
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	0
	.long	1075838976
	.section	.rodata.cst16
	.align 16
.LC9:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC10:
	.long	1
	.long	1
	.long	1
	.long	1
	.align 16
.LC11:
	.long	1374389535
	.long	1374389535
	.long	1374389535
	.long	1374389535
	.section	.rodata.cst8
	.align 8
.LC13:
	.long	0
	.long	1071644672
	.section	.rodata.cst16
	.align 16
.LC14:
	.long	2
	.long	2
	.long	2
	.long	2
	.section	.rodata.cst8
	.align 8
.LC15:
	.long	0
	.long	1104006501
	.align 8
.LC16:
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
