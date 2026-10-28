sleep:
	.init:
		add rbx, [rel ticks] ; Usamos RCX como el "quantum" de tiempo a esperar

	.worker:
		hlt ; Dormir hasta el próximo tick
		cmp [rel ticks], rbx
		jl .worker ; Si aún no llegamos al tiempo, volver a dormir

	.exit:
		ret
