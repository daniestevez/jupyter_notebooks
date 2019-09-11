#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <rtklib.h>

#define RNX_PARAM 1
#define SP3_PARAM 2
#define ANTEX_PARAM 3
#define START_TIME_PARAM 4
#define NUM_EPOCHS_PARAM 5
#define FOUT_PARAM 6

int main(int argc, char **argv) {
  nav_t *nav;
  gtime_t t, t0;
  double rs[6], dts[2], var;
  int svh;
  FILE *f_out;
  int j;
  int computations[2] = {EPHOPT_BRDC, EPHOPT_PREC};
  pcvs_t pcvs = {0};
  pcv_t *pcv;

  nav = malloc(sizeof(*nav));
  if (!nav) {
    perror("malloc");
    exit(1);
  }

  memset(nav, 0, sizeof(*nav));

  if (readrnx(argv[RNX_PARAM], 0, "-SYS=E", NULL, nav, NULL) != 1) {
    fprintf(stderr, "Could not read RINEX\n");
    exit(1);
  }

  readsp3(argv[SP3_PARAM], nav, 0);
  if (!nav->peph) {
    fprintf(stderr, "Could not read SP3\n");
    exit(1);
  }

  if (!readpcv(argv[ANTEX_PARAM], &pcvs)) {
    fprintf(stderr, "Could not read ANTEX\n");
    exit(1);
  }

  if (str2time(argv[START_TIME_PARAM], 0, strlen(argv[START_TIME_PARAM]), &t0) < 0) {
    fprintf(stderr, "Could not interpret time\n");
    exit(1);
  }

  /* assign PCVs from ANTEX */
  for (j = 0; j < MAXSAT; j++) {
    if (satsys(j + 1, NULL) != SYS_GAL) continue;
    if ((pcv = searchpcv(j + 1, "", t0, &pcvs))) {
      nav->pcvs[j] = *pcv;
    }
    else {
      char id[64];
      satno2id(j + 1, id);
      fprintf(stderr, "Warning: could not find PCV for %s\n", id);
    }
  }

  /* assign carrier wavelengths */
  for (int i = 0; i < MAXSAT; i++) {
    for (j = 0; j < NFREQ; j++) {
      nav->lam[i][j] = satwavelen(i + 1, j, nav);
    }
  }

  f_out = fopen(argv[FOUT_PARAM], "wb");
  if (!f_out) {
    perror("Could not open output file");
    exit(1);
  }

  for (int sat = 1; sat <= 36; sat++) {
    for (j = 0, t = t0; j < atoi(argv[NUM_EPOCHS_PARAM]); j++, t = timeadd(t, 60)) {
      for (int comp = 0; comp < sizeof(computations)/sizeof(*computations); comp++) {
	if (!satpos(t, t, satno(SYS_GAL, sat), computations[comp], nav, rs, dts, &var, &svh)) {
	  rs[0] = rs[1] = rs[2] = rs[3] = rs[4] = rs[5] = dts[0] = dts[1] = NAN;
	}

	if ((fwrite(rs, sizeof(rs), 1, f_out) != 1) ||
	    (fwrite(dts, sizeof(dts), 1, f_out) != 1)) {
	  perror("Could not write to output file");
	  exit(1);
	}
      }
    }
  }

  fclose(f_out);
  free(nav);
  
  return 0;
}
