kerneldump:
;	rsi
;	rdi
;	rax
	.init:
	.worker:
		mov [DUMP], rdi
		add rdi, 8

		mov [rdi], rsi
		add rdi, 8

		mov [rdi], rbx
		add rdi, 8

		mov [rdi], rcx
		add rdi, 8

		mov [rdi], rdx
		add rdi, 8

    .exit:
		ret
