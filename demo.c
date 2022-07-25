#include <stdio.h>
#include <stdlib.h>

#include "deutsch.h"

typendefinition vereinigung zahl {
  unsignierte grosse lange ganzzahl u;
  signierte grosse lange ganzzahl z;
  kurzes k;
  schwebe s;
  doppelt d;
} zahl;

typendefinition struktur zaehler {
  zahl anfangswert;
  zahl wert;
  zahl richtung;
} zaehler;

aufzaehlung wertVonFuenf {
  fuenf = 5
};

statisch eingereihte leere druckeZahl(konstante zahl z) {
  druckf("Zahl: %llx %lld %d %f %f\n", z.u, z.z, z.k, z.s, z.d);
}

statisch eingereihte leere naechste(zaehler* z) {
  z->wert.z += z->richtung.z;
}

ganzzahl haupt(ganzzahl argumentc, buchstabe** argumentv) {
  falls (argumentc < 2) {
    druckf("Zu wenige argumente.\n");
  } ansonsten {
    zahl z;
    z.z = atoz(argumentv[1]);
    druckeZahl(z);

    zaehler zh = {z, z, { .z = z.z > 0 ? -1 : 1 } };

    tue {
      naechste(&zh);
      falls (zh.wert.z == 0) breche;
      falls (zh.wert.z % 2 == 0) weiter;

      schalte (zh.wert.z) {
        fall fuenf:
          druckf("Fünf.\n");
          breche;
        normalerweise:
          druckf("Nicht fünf.\n");
          breche;
      }
    } solange (wahr);
  }
}
