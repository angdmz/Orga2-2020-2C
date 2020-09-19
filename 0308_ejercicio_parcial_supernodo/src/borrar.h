#ifndef BORRAR_H_
#define BORRAR_H_

#include <stdio.h>
#include <stdlib.h>
#include "define.h"

void borrar_nodo_ASM(supernode_t* pNodo);
void borrar_columna_ASM(supernode_t* *sn);

void borrar_nodo_C(supernode_t* pNodo);
void borrar_columna_C(supernode_t* *sn);

#endif /* BORRAR_H_ */
