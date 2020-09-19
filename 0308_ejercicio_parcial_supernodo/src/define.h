#ifndef DEFINE_H_
#define DEFINE_H_

typedef struct supernode_s supernode_t;
struct supernode_s
{
	supernode_t *abajo;
	supernode_t *derecha;
	supernode_t *izquierda;
	int dato;
};

#endif /* DEFINE_H_ */
