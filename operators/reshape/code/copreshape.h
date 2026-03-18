#ifndef COPRESHAPE_H_INCLUDED

#include <stdlib.h>
#include <stdint.h>
#include "cindex.h"
#include "ctensor.h"
#include "ctensorint64.h"

void creshape(struct ctensor x, struct ctensor r, struct ctensorint64 s,
              int32_t allowzero);

#define COPRESHAPE_H_INCLUDED
#endif // COPRESHAPE_H_INCLUDED
