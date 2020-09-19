;----------------------------------------------------------
;
; Firma:
; void gris(uint8_t* imgRGB, short n, uint8_t* imgGray)
;
; Retorno:
; 	void		no retorno
;
; Argumentos:
;	uint8_t* 	imgRGB			RDI
;	short 		n				RSI
;	uint8_t* 	imgGray			RDX
;
;----------------------------------------------------------

; Identifico los argumentos recibidos
%define argDirImgRGB 	(rdi)
%define argN 			(rsi)
%define argDirImgGray 	(rdx)

; Variables locales para la operación
%define dirImgRGB 		(rsi)
%define dirImgGray 		(rdi)
%define nPixel			(rcx)
%define nColor 			(r11)
%define imgSize 		(r10)

section.text:
global gris_ASM

gris_ASM:
; stackframe init
	push rbp
	mov rbp, rsp
	push rbx

; acomodo los argumentos
	mov rax, argN
	mov dirImgRGB, argDirImgRGB
	mov dirImgGray, argDirImgGray
; calculo la cantidad de pixeles
	mul rax
	mov imgSize, 0
	mov imgSize, rax
; inicio el ciclo de recorrido de la imagen
	mov nPixel, 0
	mov nColor, 0
.loop_imgRGB:
; sumo los colores
	mov ax, 0
	mov al, [dirImgRGB + nColor + 1]
	sal ax, 1
	mov bx, 0
	mov bl, [dirImgRGB + nColor + 0]
	add ax, bx
	mov bl, [dirImgRGB + nColor + 2]
	add ax, bx
; divido
	sar ax, 2
; grabo en la imagen de salida
	mov [dirImgGray + nPixel], al
; condición del cico
	add nColor, 3
	inc nPixel
	cmp nPixel, imgSize
	jl .loop_imgRGB
; fin del ciclo

; stackframe deinit
	pop rbx
	pop rbp
	ret
; \gris_ASM
