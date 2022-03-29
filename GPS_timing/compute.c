#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <rtklib.h>

#define RNX_PARAM 1
#define TX_TIME_WN_PARAM 2
#define TX_TIME_TOW_PARAM 3
#define PRN_PARAM 4
#define X_PARAM 5
#define Y_PARAM 6
#define Z_PARAM 7

int main(int argc, char **argv) {
  nav_t *nav;
  int wn;
  double tow;
  gtime_t t;
  int prn;
  double rs[6], dts[2], var, e[3], rr[3], r;
  int svh;

  nav = malloc(sizeof(*nav));
  if (!nav) {
    perror("malloc");
    exit(1);
  }

  memset(nav, 0, sizeof(*nav));

  if (readrnx(argv[RNX_PARAM], 0, "-SYS=G", NULL, nav, NULL) != 1) {
    fprintf(stderr, "Could not read RINEX\n");
    exit(1);
  }

  wn = atoi(argv[TX_TIME_WN_PARAM]);
  tow = atof(argv[TX_TIME_TOW_PARAM]);
  t = gpst2time(wn, tow);

  prn = atoi(argv[PRN_PARAM]);

  rr[0] = atof(argv[X_PARAM]);
  rr[1] = atof(argv[Y_PARAM]);
  rr[2] = atof(argv[Z_PARAM]);

  // Compute a first satellite position assuming satellite clock bias zero.
  // This is only used to obtain the satellite clock bias.
  if (!satpos(t, t, satno(SYS_GPS, prn), EPHOPT_BRDC, nav, rs, dts, &var, &svh)) {
    fprintf(stderr, "Could not compute satpos\n");
    exit(1);
  }
  // Compute a second satellite position taking into account the satellite clock bias
  t = timeadd(t, -dts[0]);
  if (!satpos(t, t, satno(SYS_GPS, prn), EPHOPT_BRDC, nav, rs, dts, &var, &svh)) {
    fprintf(stderr, "Could not compute satpos\n");
    exit(1);
  }
  r = geodist(rs, rr, e);
  r -= CLIGHT * dts[0];
        
  printf("Time of flight (corrected with sat clock bias) = %0.12f\n", r / CLIGHT);

  free(nav);
  
  return 0;
}
