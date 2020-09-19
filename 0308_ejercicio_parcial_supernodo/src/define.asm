%define NULL 0

;C	typedef struct supernode_s supernode_t;
;C	struct supernode_s
;C	{
;C		supernode_t *abajo;
;C		supernode_t *derecha;
;C		supernode_t *izquierda;
;C		int dato;
;C	};
%define supernode_abajo__off		(0)
%define supernode_derecha__off		(8)
%define supernode_izquierda__off	(16)
%define supernode_dato__off			(24)
%define supernode__size				(28)

extern malloc
extern free
