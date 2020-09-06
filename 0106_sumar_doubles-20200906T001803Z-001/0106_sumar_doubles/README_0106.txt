- Ignoren que el código inicial de assembler es sumarenteros pero con rdi y rsi en vez de edi y esi, partí de un código erróneo sin darme cuenta. Ustedes deberían partir de su código de sumarenteros.

- https://www.felixcloutier.com/x86/addpd descripción del manual de Intel de la función addpd. Como en un registro XMM (16 bytes) entran dos doubles (8 bytes), addpd asume que en los registros XMM de entrada hay dos doubles, uno en la parte alta y otro en la parte baja, y suma los de la parte alta de cada registro entre sí y los de la parte baja de cada registro entre sí. Acá estamos trabajando con dos doubles que se encuentran en registros distintos, en la parte baja de cada uno. Por lo tanto, ignoramos la parte alta de los registros y nos quedamos con el resultado de la parte baja. Todo esto lo veremos más adelante.

- Qué pasaría si hicieramos "add xmm0, 20"? 
(los invito a agregar esta línea al .asm y compilar)
Pueden ver en el manual de Intel, en la descripción de la instrucción add (volumen 2, o https://www.felixcloutier.com/x86/add) todos los tipos de operandos que puede recibir la instrucción: por ejemplo tenemos r/m8-r/m64 que indica que puede tomar registros de 8 a 64 bits o posiciones de memoria de 8 a 64 bits. Si contrastamos con la entrada de la instrucción addpd, vemos que esta tiene como operando destino permitido 'xmm1'. Esto indica que la función puede tomar como operando un registro xmm cualquiera. En add no vemos en ningún lado xmm como operando posible, así que tiene sentido que al intentar compilar esto, veamos el error "Invalid combination of opcode and operands" en la línea correspondiente.
Si cambiamos add por addps, va a seguir sin funcionar porque 20 es un inmediato y addps no permite que el operando fuente (el de la derecha) sea un inmediato (imm en el manual, fíjense que add sí permite que el operando fuente sea un imm de algún tamaño). Tendríamos que cargar al 20 a un registro xmm de alguna forma, o colocarlo en memoria y pasarlo como operando (la función SI permite que el operando fuente sea una posición de memoria, porque dice m128).

- Para compilar y correr el código con el makefile provisto:
	"make" en /src (sin las comillas)
	"./ejec" para correr el código compilado
	"make clean" para borrar los .o y el ejecutable 
