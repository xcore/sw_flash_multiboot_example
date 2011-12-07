/* Custom flash loader file to allow switching between boot images */
#include <xs1.h>

extern void readFlashDataPage(unsigned addr);
int dpVersion;
unsigned imgAdr;

in port img = XS1_PORT_1K; // button 1 on XK-1A

void init(void) {
  // Buttons are active low
  unsigned version, tmp;
  set_port_inv(img);
 img :> dpVersion;
}

int checkCandidateImageVersion(int v) {
  return v == dpVersion;
}

void recordCandidateImage(int v, unsigned adr) {
  imgAdr = adr;
}

unsigned reportSelectedImage(void) {
  return imgAdr;
}
