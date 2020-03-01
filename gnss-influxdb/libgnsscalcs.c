#include <stdlib.h>
#include <math.h>

#include <rtklib.h>

nav_t nav;

int load_sp3(char *path) {
  readsp3(path, &nav, 0);
  if (!nav.peph) {
    return -1;
  }

  return 0;
}

int compute_azel(char *sat, double *utc_epoch, double lat, double lon, double h, double *azel) {
  double rs[6], dts[2], var, rr[3], e[3], pos[3];
  int svh;
  int satn;
  gtime_t t;

  if (!(satn = satid2no(sat))) {
    return -1;
  }

  t = utc2gpst(epoch2time(utc_epoch));
   
  if (!satpos(t, t, satn, EPHOPT_PREC, &nav, rs, dts, &var, &svh)) {
    return -1;
  }

  pos[0] = lat * PI / 180.0;
  pos[1] = lon * PI / 180.0;
  pos[2] = h;
  pos2ecef(pos, rr);
  geodist(rs, rr, e);
  satazel(pos, e, azel);
  azel[0] *= 180.0 / PI;
  azel[1] *= 180.0 / PI;
  
  return 0;
}

void compute_dops(int ns, double *azel_deg, double elevation_mask, double *dop) {
  for (int i = 0; i < 2*ns; i++) azel_deg[i] *= PI / 180.0;
  dops(ns, azel_deg, elevation_mask * PI / 180.0, dop);
  return;
}
