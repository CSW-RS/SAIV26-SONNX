#include "ctensorint32.h"
struct ctensorint32;


struct ctensorint32 ctensorint32_create(int32_t * ds, int32_t n) {
  int32_t m;
  int32_t * vs;
  struct ctensorint32 ctensorint32;
  m = cdim_size(ds, n);
  vs = malloc(((uint32_t) m) * sizeof(int32_t));
  ctensorint32.t_rank = !vs ? 0 : n;
  ctensorint32.t_dims = ds;
  ctensorint32.t_data = vs;
  return ctensorint32;
}

void ctensorint32_clear(struct ctensorint32 r) {
  int32_t m, i, o;
  m = cdim_size(r.t_dims, r.t_rank);
  o = m - 1;
  if (0 <= o) {
    for (i = 0; ; ++i) {
      r.t_data[i] = 0;
      if (i == o) {
        break;
      }
    }
  }
}

void ctensorint32_reset(struct ctensorint32 r, int32_t v) {
  int32_t m, i, o;
  m = cdim_size(r.t_dims, r.t_rank);
  o = m - 1;
  if (0 <= o) {
    for (i = 0; ; ++i) {
      r.t_data[i] = v;
      if (i == o) {
        break;
      }
    }
  }
}
