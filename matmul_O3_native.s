	.file	"matmul.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=sapphirerapids -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mavx512f -mbmi -mbmi2 -maes -mpclmul -mavx512vl -mavx512bw -mavx512dq -mavx512cd -mno-avx512er -mno-avx512pf -mavx512vbmi -mavx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mavx512vpopcntdq -mavx512vbmi2 -mgfni -mvpclmulqdq -mavx512vnni -mavx512bitalg -mavx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mcldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mhle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mrtm -mserialize -mno-sgx -msha -mno-shstk -mno-tbm -mtsxldtrk -mvaes -mno-waitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mamx-tile -mamx-int8 -mamx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mavx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex --param=l1-cache-size=48 --param=l1-cache-line-size=64 --param=l2-cache-size=266240 -mtune=sapphirerapids -masm=intel -O3 -std=c++17 -fno-asynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
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
	mov	esi, DWORD PTR 32[rdi]	# tmp94, MEM[(const struct basic_ios *)_12].D.49435._M_streambuf_state
# /usr/include/c++/13/ostream:670:     }
	pop	rax	#
	.cfi_def_cfa_offset 24
	pop	rbx	#
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/ios_base.h:171:   { return _Ios_Iostate(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	esi, 1	# tmp94,
# /usr/include/c++/13/ostream:670:     }
	pop	rbp	#
	.cfi_def_cfa_offset 8
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
	mov	rax, QWORD PTR [rdi]	# _7, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.72305._M_start
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	test	rax, rax	# _7
	je	.L8	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	mov	rsi, QWORD PTR 16[rdi]	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.72305._M_end_of_storage, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.72305._M_end_of_storage
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	mov	rdi, rax	#, _7
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	sub	rsi, rax	# tmp87, _7
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4,,10
	.p2align 3
.L8:
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
.LC18:
	.string	"Time:     "
.LC19:
	.string	" s\n"
.LC20:
	.string	"GFLOPS:   "
.LC21:
	.string	"Checksum: "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB23:
	.section	.text.startup,"ax",@progbits
.LHOTB23:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB2984:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2984
	endbr64	
	lea	r10, 8[rsp]	#,
	.cfi_def_cfa 10, 0
	and	rsp, -32	#,
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	lea	rsi, .LC2[rip]	# tmp184,
	mov	edx, 22	#,
# matmul.cpp:71: int main() {
	push	QWORD PTR -8[r10]	#
	push	rbp	#
	mov	rbp, rsp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	push	r15	#
	push	r14	#
	push	r13	#
	push	r12	#
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	lea	r12, _ZSt4cout[rip]	# tmp342,
	mov	rdi, r12	#, tmp342
# matmul.cpp:71: int main() {
	push	r10	#
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	push	rbx	#
	add	rsp, -128	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
# matmul.cpp:71: int main() {
	mov	rax, QWORD PTR fs:40	# tmp361, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -56[rbp], rax	# D.79637, tmp361
	xor	eax, eax	# tmp361
.LEHB0:
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	esi, 1024	#,
	mov	rdi, r12	#, tmp342
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 3	#,
	lea	rsi, .LC3[rip]	# tmp187,
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	mov	rbx, rax	# _8, tmp345
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
	mov	rdi, rax	# _10, tmp346
# matmul.cpp:72:     std::cout << "Matrix multiplication " << N << " x " << N << "\n";
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# matmul.cpp:73:     std::cout << "Element type: double (8 bytes)\n";
	lea	rsi, .LC5[rip]	# tmp189,
	mov	rdi, r12	#, tmp342
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 19	#,
	lea	rsi, .LC6[rip]	# tmp191,
	mov	rdi, r12	#, tmp342
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	vmovsd	xmm0, QWORD PTR .LC7[rip]	#,
	mov	rdi, r12	#, tmp342
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# matmul.cpp:76:               << " MB\n\n";
	lea	rsi, .LC8[rip]	# tmp195,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	mov	rdi, rax	# _43, tmp347
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
	mov	r13, rax	# _133, tmp348
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR -144[rbp], rax	# MEM[(struct _Vector_base *)&A]._M_impl.D.72305._M_start, _133
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR -128[rbp], rbx	# MEM[(struct _Vector_base *)&A]._M_impl.D.72305._M_end_of_storage, _128
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	xmm0, xmm0, xmm0	# tmp203
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR -136[rbp], rbx	# MEM[(struct vector *)&A].D.72998._M_impl.D.72305._M_finish, _128
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu	XMMWORD PTR -104[rbp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&B + 8B], tmp203
.LEHB1:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE1:
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	mov	QWORD PTR [rax], 0x000000000	# *_150,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	r15, 8388608[rax]	# ivtmp.197,
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	lea	rdi, 8[rax]	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388600	#,
	xor	esi, esi	#
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR -112[rbp], rax	# MEM[(struct _Vector_base *)&B]._M_impl.D.72305._M_start, _150
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	r14, rax	# _150, tmp349
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR -96[rbp], r15	# MEM[(struct _Vector_base *)&B]._M_impl.D.72305._M_end_of_storage, ivtmp.197
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	xmm0, xmm0, xmm0	# tmp211
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	mov	edi, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:1717: 	this->_M_impl._M_finish =
	mov	QWORD PTR -104[rbp], r15	# MEM[(struct vector *)&B].D.72998._M_impl.D.72305._M_finish, ivtmp.197
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu	XMMWORD PTR -72[rbp], xmm0	# MEM <vector(2) long unsigned int> [(double * *)&C + 8B], tmp211
.LEHB2:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
.LEHE2:
	mov	rbx, rax	# _175, tmp350
# /usr/include/c++/13/bits/stl_vector.h:398: 	this->_M_impl._M_start = this->_M_allocate(__n);
	mov	QWORD PTR -80[rbp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.72305._M_start, _175
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	mov	edx, 8388608	#,
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	lea	rax, 8388608[rax]	# _70,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xor	esi, esi	#
	mov	rdi, rbx	#, _175
# /usr/include/c++/13/bits/stl_vector.h:400: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	mov	QWORD PTR -152[rbp], rax	# %sfp, _70
	mov	QWORD PTR -64[rbp], rax	# MEM[(struct _Vector_base *)&C]._M_impl.D.72305._M_end_of_storage, _70
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	rax, QWORD PTR -152[rbp]	# _70, %sfp
	vmovdqa	ymm4, YMMWORD PTR .LC12[rip]	# tmp338,
	lea	rsi, 8192[r13]	# ivtmp.239,
	vbroadcastsd	ymm3, QWORD PTR .LC14[rip]	# tmp339,
	vmovdqa	ymm5, YMMWORD PTR .LC0[rip]	# vect_vec_iv_.142,
	mov	rcx, r13	# ivtmp.238, _133
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	xor	edx, edx	# i
# /usr/include/c++/13/bits/stl_vector.h:1706: 	this->_M_impl._M_finish =
	mov	QWORD PTR -72[rbp], rax	# MEM[(struct vector *)&C].D.72998._M_impl.D.72305._M_finish, _70
	mov	eax, 8	# tmp219,
	vpbroadcastd	ymm8, eax	# tmp218, tmp219
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mov	eax, 1	# tmp223,
	vpbroadcastd	ymm7, eax	# tmp222, tmp223
	mov	eax, 1374389535	# tmp227,
	vpbroadcastd	ymm6, eax	# tmp226, tmp227
.L10:
	vpbroadcastd	ymm10, edx	# vect_cst__19, i
# matmul.cpp:71: int main() {
	mov	rax, rcx	# ivtmp.227, ivtmp.238
	vmovdqa	ymm9, ymm5	# vect_vec_iv_.153, vect_vec_iv_.142
.L11:
	vmovdqa	ymm0, ymm9	# vect_vec_iv_.153, vect_vec_iv_.153
	add	rax, 64	# ivtmp.227,
	vpaddd	ymm9, ymm9, ymm8	# vect_vec_iv_.153, vect_vec_iv_.153, tmp218
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vpaddd	ymm0, ymm10, ymm0	# vect__70.154, vect_cst__19, vect_vec_iv_.153
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vpaddd	ymm0, ymm0, ymm7	# vect__71.155, vect__70.154, tmp222
	vpsrlq	ymm1, ymm0, 32	# tmp232, vect__71.155,
	vpmuldq	ymm2, ymm0, ymm6	# tmp224, vect__71.155, tmp226
	vpmuldq	ymm1, ymm1, ymm6	# tmp228, tmp232, tmp226
	vpermt2d	ymm2, ymm4, ymm1	# vect_patt_69.156, tmp338, tmp228
	vpsrad	ymm2, ymm2, 5	# vect_patt_68.157, vect_patt_69.156,
	vpslld	ymm1, ymm2, 1	# tmp239, vect_patt_68.157,
	vpaddd	ymm1, ymm1, ymm2	# tmp240, tmp239, vect_patt_68.157
	vpslld	ymm1, ymm1, 3	# tmp241, tmp240,
	vpaddd	ymm1, ymm1, ymm2	# vect_patt_54.158, tmp241, vect_patt_68.157
	vpslld	ymm1, ymm1, 2	# tmp243, vect_patt_54.158,
	vpsubd	ymm0, ymm0, ymm1	# vect_patt_53.159, vect__71.155, tmp243
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vcvtdq2pd	ymm1, xmm0	# vect__73.160, vect_patt_53.159
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmulpd	ymm1, ymm1, ymm3	# vect__74.161, vect__73.160, tmp339
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vextracti128	xmm0, ymm0, 0x1	# tmp249, vect_patt_53.159
	vcvtdq2pd	ymm0, xmm0	# vect__73.160, tmp249
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmulpd	ymm0, ymm0, ymm3	# vect__74.161, vect__73.160, tmp339
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmovupd	YMMWORD PTR -64[rax], ymm1	# MEM <vector(4) double> [(value_type &)_139], vect__74.161
	vmovupd	YMMWORD PTR -32[rax], ymm0	# MEM <vector(4) double> [(value_type &)_139 + 32], vect__74.161
	cmp	rsi, rax	# ivtmp.239, ivtmp.227
	jne	.L11	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	inc	edx	# i
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	rcx, 8192	# ivtmp.238,
	add	rsi, 8192	# ivtmp.239,
	cmp	edx, 1024	# i,
	jne	.L10	#,
	mov	eax, 8	# tmp256,
	lea	rsi, 8192[r14]	# ivtmp.223,
	mov	rcx, r14	# ivtmp.222, _150
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	xor	edx, edx	# i
	vpbroadcastd	ymm8, eax	# tmp255, tmp256
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	mov	eax, 2	# tmp260,
	vpbroadcastd	ymm7, eax	# tmp259, tmp260
	mov	eax, 1374389535	# tmp264,
	vpbroadcastd	ymm6, eax	# tmp263, tmp264
.L12:
	vpbroadcastd	ymm10, edx	# vect_cst__163, i
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	mov	rax, rcx	# ivtmp.214, ivtmp.222
	vmovdqa	ymm9, ymm5	# vect_vec_iv_.142, vect_vec_iv_.142
.L13:
	vmovdqa	ymm0, ymm9	# vect_vec_iv_.142, vect_vec_iv_.142
	add	rax, 64	# ivtmp.214,
	vpaddd	ymm9, ymm9, ymm8	# vect_vec_iv_.142, vect_vec_iv_.142, tmp255
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vpaddd	ymm0, ymm10, ymm0	# vect__55.143, vect_cst__163, vect_vec_iv_.142
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vpaddd	ymm0, ymm0, ymm7	# vect__56.144, vect__55.143, tmp259
	vpsrlq	ymm1, ymm0, 32	# tmp269, vect__56.144,
	vpmuldq	ymm2, ymm0, ymm6	# tmp261, vect__56.144, tmp263
	vpmuldq	ymm1, ymm1, ymm6	# tmp265, tmp269, tmp263
	vpermt2d	ymm2, ymm4, ymm1	# vect_patt_179.145, tmp338, tmp265
	vpsrad	ymm2, ymm2, 5	# vect_patt_174.146, vect_patt_179.145,
	vpslld	ymm1, ymm2, 1	# tmp276, vect_patt_174.146,
	vpaddd	ymm1, ymm1, ymm2	# tmp277, tmp276, vect_patt_174.146
	vpslld	ymm1, ymm1, 3	# tmp278, tmp277,
	vpaddd	ymm1, ymm1, ymm2	# vect_patt_173.147, tmp278, vect_patt_174.146
	vpslld	ymm1, ymm1, 2	# tmp280, vect_patt_173.147,
	vpsubd	ymm0, ymm0, ymm1	# vect_patt_172.148, vect__56.144, tmp280
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vcvtdq2pd	ymm1, xmm0	# vect__58.149, vect_patt_172.148
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmulpd	ymm1, ymm1, ymm3	# vect__59.150, vect__58.149, tmp339
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vextracti128	xmm0, ymm0, 0x1	# tmp286, vect_patt_172.148
	vcvtdq2pd	ymm0, xmm0	# vect__58.149, tmp286
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmulpd	ymm0, ymm0, ymm3	# vect__59.150, vect__58.149, tmp339
# matmul.cpp:34:             M[i * N + j] = static_cast<double>((i + j + seed) % 100) * 0.5;
	vmovupd	YMMWORD PTR -64[rax], ymm1	# MEM <vector(4) double> [(value_type &)_279], vect__59.150
	vmovupd	YMMWORD PTR -32[rax], ymm0	# MEM <vector(4) double> [(value_type &)_279 + 32], vect__59.150
	cmp	rsi, rax	# ivtmp.223, ivtmp.214
	jne	.L13	#,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	inc	edx	# i
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	add	rcx, 8192	# ivtmp.222,
	add	rsi, 8192	# ivtmp.223,
	cmp	edx, 1024	# i,
	jne	.L12	#,
# matmul.cpp:88:     auto t0 = std::chrono::steady_clock::now();
	vzeroupper
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
	mov	rsi, rbx	# ivtmp.205, ivtmp.177
	xor	edx, edx	# ivtmp.199
	mov	QWORD PTR -160[rbp], rax	# %sfp, tmp351
.L15:
	mov	r9, rdx	# tmp294, ivtmp.199
	mov	rdi, r15	# ivtmp.197, ivtmp.197
	lea	r10, 8192[rsi]	# _195,
# matmul.cpp:30:     for (int i = 0; i < N; ++i) {
	mov	r8, r14	# ivtmp.196, _150
	sal	r9, 13	# tmp294,
	add	r9, r13	# _285, _133
.L19:
	mov	rcx, r9	# ivtmp.188, _285
	mov	rax, r8	# ivtmp.184, ivtmp.196
	vxorpd	xmm1, xmm1, xmm1	# vect_sum_136.133
	.p2align 4,,10
	.p2align 3
.L16:
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	vbroadcastsd	ymm0, QWORD PTR [rcx]	# tmp292, MEM[(const value_type &)_60]
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	add	rax, 8192	# ivtmp.184,
	add	rcx, 8	# ivtmp.188,
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	vmulpd	ymm0, ymm0, YMMWORD PTR -8192[rax]	# vect__196.137, tmp292, MEM <const vector(4) double> [(const value_type &)_276]
# matmul.cpp:55:                 sum += A[i * N + k] * B[k * N + j];
	vaddpd	ymm1, ymm1, ymm0	# vect_sum_136.133, vect_sum_136.133, vect__196.137
# matmul.cpp:51:             for (int k = 0; k < N; ++k) {
	cmp	rdi, rax	# ivtmp.197, ivtmp.184
	jne	.L16	#,
# matmul.cpp:57:             C[i * N + j] = sum;
	vmovupd	YMMWORD PTR [rsi], ymm1	# MEM <vector(4) double> [(value_type &)_280], vect_sum_136.133
	add	rsi, 32	# ivtmp.194,
	add	r8, 32	# ivtmp.196,
	add	rdi, 32	# ivtmp.197,
	cmp	rsi, r10	# ivtmp.194, _195
	jne	.L19	#,
# matmul.cpp:48:     for (int i = 0; i < N; ++i) {
	inc	rdx	# ivtmp.199
	cmp	rdx, 1024	# ivtmp.199,
	jne	.L15	#,
# matmul.cpp:90:     auto t1 = std::chrono::steady_clock::now();
	vzeroupper
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	mov	rdx, QWORD PTR -160[rbp]	# t0, %sfp
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vxorps	xmm0, xmm0, xmm0	# tmp359
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vmovsd	xmm1, QWORD PTR .LC16[rip]	# tmp297,
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	lea	rsi, .LC18[rip]	# tmp308,
	mov	rdi, r12	#, tmp342
# /usr/include/c++/13/bits/chrono.h:716: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	sub	rax, rdx	# tmp295, t0
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vcvtsi2sd	xmm0, xmm0, rax	# tmp360, tmp359, tmp295
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	mov	rax, QWORD PTR _ZSt4cout[rip]	# cout._vptr.basic_ostream, cout._vptr.basic_ostream
	mov	rdx, QWORD PTR -24[rax]	# _47, MEM[(long int *)_44 + -24B]
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vdivsd	xmm4, xmm0, xmm1	# _49, tmp296, tmp297
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	vmovsd	xmm0, QWORD PTR .LC17[rip]	# tmp300,
# /usr/include/c++/13/ostream:134: 	__pf(*this);
	add	rdx, r12	# _47, tmp342
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	mov	eax, DWORD PTR 24[rdx]	# tmp305, _47->_M_flags
# /usr/include/c++/13/bits/ios_base.h:744:       _M_precision = __prec;
	mov	QWORD PTR 8[rdx], 4	# _47->_M_precision,
# /usr/include/c++/13/bits/ios_base.h:84:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	and	eax, -261	# tmp305,
# /usr/include/c++/13/bits/ios_base.h:88:   { return _Ios_Fmtflags(static_cast<int>(__a) | static_cast<int>(__b)); }
	or	eax, 4	# tmp307,
	mov	DWORD PTR 24[rdx], eax	# MEM[(_Ios_Fmtflags &)_47 + 24], tmp307
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	vmulsd	xmm1, xmm4, xmm1	# tmp298, _49, tmp297
# /usr/include/c++/13/bits/chrono.h:212: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vmovq	r13, xmm4	# _49, _49
# matmul.cpp:97:     double gflops = (2.0 * N * N * N) / (seconds * 1e9);
	vdivsd	xmm7, xmm0, xmm1	# gflops, tmp300, tmp298
	vmovq	r14, xmm7	# gflops, gflops
.LEHB3:
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	vmovq	xmm0, r13	#, _49
	mov	rdi, r12	#, tmp342
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _83, tmp353
# matmul.cpp:100:     std::cout << "Time:     " << seconds << " s\n";
	lea	rsi, .LC19[rip]	# tmp311,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
	lea	rsi, .LC20[rip]	# tmp312,
	mov	rdi, r12	#, tmp342
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	vmovq	xmm0, r14	#, gflops
	mov	rdi, r12	#, tmp342
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _84, tmp354
# matmul.cpp:101:     std::cout << "GFLOPS:   " << gflops << "\n";
	lea	rsi, .LC4[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
# /usr/include/c++/13/ostream:667: 	__ostream_insert(__out, __s,
	mov	edx, 10	#,
	lea	rsi, .LC21[rip]	# tmp316,
	mov	rdi, r12	#, tmp342
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# matmul.cpp:66:     double s = 0.0;
	vxorpd	xmm0, xmm0, xmm0	# s
.L20:
	vaddsd	xmm0, xmm0, QWORD PTR [rbx]	# stmp_s_93.132, s, BIT_FIELD_REF <MEM <const vector(4) double> [(const value_type &)_122], 64, 0>
	add	rbx, 32	# ivtmp.177,
	vaddsd	xmm0, xmm0, QWORD PTR -24[rbx]	# stmp_s_93.132, stmp_s_93.132, BIT_FIELD_REF <MEM <const vector(4) double> [(const value_type &)_122], 64, 64>
# matmul.cpp:67:     for (int i = 0; i < N * N; ++i) s += C[i];
	vaddsd	xmm0, xmm0, QWORD PTR -16[rbx]	# stmp_s_93.132, stmp_s_93.132, BIT_FIELD_REF <MEM <const vector(4) double> [(const value_type &)_122], 64, 128>
	vaddsd	xmm0, xmm0, QWORD PTR -8[rbx]	# s, stmp_s_93.132, BIT_FIELD_REF <MEM <const vector(4) double> [(const value_type &)_122], 64, 192>
	cmp	QWORD PTR -152[rbp], rbx	# %sfp, ivtmp.177
	jne	.L20	#,
# /usr/include/c++/13/ostream:223:       { return _M_insert(__f); }
	mov	rdi, r12	#, tmp342
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
	mov	rdi, rax	# _85, tmp355
# matmul.cpp:102:     std::cout << "Checksum: " << checksum(C) << "\n";
	lea	rsi, .LC4[rip]	#,
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0	#
.LEHE3:
# matmul.cpp:104: }
	lea	rdi, -80[rbp]	# tmp321,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, -112[rbp]	# tmp322,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	lea	rdi, -144[rbp]	# tmp323,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
# matmul.cpp:104: }
	mov	rax, QWORD PTR -56[rbp]	# tmp362, D.79637
	sub	rax, QWORD PTR fs:40	# tmp362, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L36	#,
	sub	rsp, -128	#,
	xor	eax, eax	#
	pop	rbx	#
	pop	r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	pop	rbp	#
	lea	rsp, -8[r10]	#,
	.cfi_def_cfa 7, 8
	ret	
.L36:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
.L28:
	endbr64	
	mov	rbx, rax	# tmp327, tmp356
	jmp	.L21	#
.L27:
	endbr64	
	mov	rbx, rax	# tmp326, tmp357
	vzeroupper
	jmp	.L22	#
.L26:
	endbr64	
	mov	rbx, rax	# tmp331, tmp358
	vzeroupper
	jmp	.L23	#
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
	.uleb128 .L26-.LFB2984
	.uleb128 0
	.uleb128 .LEHB2-.LFB2984
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L27-.LFB2984
	.uleb128 0
	.uleb128 .LEHB3-.LFB2984
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L28-.LFB2984
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
.L21:
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	lea	rdi, -80[rbp]	# tmp325,
	vzeroupper
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L22:
	lea	rdi, -112[rbp]	# tmp330,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
.L23:
	lea	rdi, -144[rbp]	# tmp333,
	call	_ZNSt6vectorIdSaIdEED1Ev	#
	mov	rax, QWORD PTR -56[rbp]	# tmp363, D.79637
	sub	rax, QWORD PTR fs:40	# tmp363, MEM[(<address-space-1> long unsigned int *)40B]
	jne	.L37	#,
	mov	rdi, rbx	#, tmp331
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
.L37:
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
	.uleb128 .LEHB4-.LCOLDB23
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSEC2984:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE23:
	.section	.text.startup
.LHOTE23:
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC7:
	.long	0
	.long	1075838976
	.section	.rodata.cst32
	.align 32
.LC12:
	.long	1
	.long	9
	.long	3
	.long	11
	.long	5
	.long	13
	.long	7
	.long	15
	.section	.rodata.cst8
	.align 8
.LC14:
	.long	0
	.long	1071644672
	.align 8
.LC16:
	.long	0
	.long	1104006501
	.align 8
.LC17:
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
