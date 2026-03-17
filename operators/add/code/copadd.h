#ifndef COPADD_H_INCLUDED

#include <stdlib.h>
#include <stdint.h>
#include "cindex.h"
#include "ctensor.h"

void ctensor_add(struct ctensor a, struct ctensor b, struct ctensor r);

#define COPADD_H_INCLUDED
#endif // COPADD_H_INCLUDED
