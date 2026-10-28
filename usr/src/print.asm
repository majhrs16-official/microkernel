print:
    .worker:
        mov rax, [rsi]   ; Lee el QWORD completo (4 caracteres de golpe)
        mov [rdi], rax   ; Lo escribe directamente en la memoria de video
        add rsi, 8       ; Avanza al siguiente QWORD
        add rdi, 8       ; Avanza la posición de la pantalla
        dec rcx
        jnz .worker
    .exit:
        ret

%if 0
	;deprecated
	print:
		.init:
			push rax
			push rbx; Back/fore-ground nibbles.
			push rdi; Input pointer
			push rsi; Output pointer

			cmp rdx, 1
			shr rdx, 1
			je .worker

		.worker:
			lodsb
			test rax, rax
			jz .exit

			shl rax, 8
			or rax, rbx
			stosq
			jmp .worker_raw

		.exit:
			pop rsi
			pop rdi
			pop rbx
			pop rax
			ret
%endif
