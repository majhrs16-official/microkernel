hex:
;	rdi
;	rsi
	.init:
		mov al, [rsi]
		mov ah, al
		inc rsi

		shr al, 4
		and ah, 0x0F

	.worker:
		.high:
			add al, 0x30
			cmp al, 0x39
			jbe .low
			add al, 7

		.low:
			add ah, 0x30
			cmp ah, 0x39
			jbe .next
			add ah, 7

		.next:
			mov [rdi], al
			inc rdi
			dec rbx
			jnz .init

	.exit:
		ret

%if 0
	;deprecated
	hex:
		.init:
			push rax
			push rdi; Output pointer
			push rsi; Input  pointer

		.worker:
			lodsb
			test al, al
			jz .exit

			mov ah, al
			shr al, 4
			and ah, 0x0F

		.high:
			add al, 0x30
			cmp al, 0x39
			jbe .low
			add al, 7

		.low:
			add ah, 0x30
			cmp ah, 0x39
			jbe .next
			add ah, 7

		.next:
			stosw
			jmp .worker

		.exit:
			pop rax
			pop rdi
			pop rsi
			ret
%endif
