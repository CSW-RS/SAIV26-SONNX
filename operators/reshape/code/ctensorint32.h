#ifndef CTENSORINT32_H_INCLUDED

#include <stdlib.h>
#include <stdint.h>
#include "cindex.h"

struct ctensorint32 {
  int32_t t_rank;
  int32_t * t_dims;
  int32_t * t_data;
};

struct ctensorint32 ctensorint32_create(int32_t * ds, int32_t n);

void ctensorint32_clear(struct ctensorint32 r);

void ctensorint32_reset(struct ctensorint32 r, int32_t v);

#define CTENSORINT32_H_INCLUDED
#endif // CTENSORINT32_H_INCLUDED
