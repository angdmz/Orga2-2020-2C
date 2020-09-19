#ifndef AGREGAR_H_
#define AGREGAR_H_

#include <stdio.h>
#include <stdlib.h>
#include "define.h"

supernode_t *buscar_nodo_inferior_izquierdo_ASM(supernode_t *pNodo);
void agregar_subnodo_ASM(supernode_t *pNodo, supernode_t *pSubNodo);
void agregar_abajo_ASM(supernode_t **sn, int d);

supernode_t *buscar_nodo_inferior_izquierdo_C(supernode_t *pNodo);
void agregar_subnodo_C(supernode_t *pNodo, supernode_t *pSubNodo);
void agregar_abajo_C(supernode_t **sn, int d);

#endif /* AGREGAR_H_ */
