memcopy:
;	rdi
;	rsi
;	xmm0..15
	.init:
	.worker:
		movdqa xmm0, [rsi + 0]
		movntdq [rdi + 0],   xmm0

		movdqa xmm1, [rsi + 16]
		movntdq [rdi + 16],  xmm1

		movdqa xmm2, [rsi + 32]
		movntdq [rdi + 32],  xmm2

		movdqa xmm3, [rsi + 48]
		movntdq [rdi + 48],  xmm3

		movdqa xmm4, [rsi + 64]
		movntdq [rdi + 64],  xmm4

		movdqa xmm5, [rsi + 80]
		movntdq [rdi + 80],  xmm5

		movdqa xmm6, [rsi + 96]
		movntdq [rdi + 96],  xmm6

		movdqa xmm7,  [rsi + 112]
		movntdq [rdi + 112], xmm7

		movdqa xmm8, [rsi + 128]
		movntdq [rdi + 128], xmm8

		movdqa xmm9, [rsi + 144]
		movntdq [rdi + 144], xmm9

		movdqa xmm10, [rsi + 160]
		movntdq [rdi + 160], xmm10

		movdqa xmm11, [rsi + 176]
		movntdq [rdi + 176], xmm11

		movdqa xmm12, [rsi + 192]
		movntdq [rdi + 192], xmm12

		movdqa xmm13, [rsi + 208]
		movntdq [rdi + 208], xmm13

		movdqa xmm14, [rsi + 224]
		movntdq [rdi + 224], xmm14

		movdqa xmm15, [rsi + 240]
		movntdq [rdi + 240], xmm15

		add rsi, 256
		add rdi, 256
		dec rbx
		jnz .worker

	.exit:
		sfence
		ret

copy:
;	rdx
;	rsi
;	r10
	.init:
		mov rcx, r10

	.worker:
		mov al, [rsi]
		mov [rdi], al

		inc rsi
		inc rdi
		dec rcx
		jnz .worker

	.exit:
		ret
