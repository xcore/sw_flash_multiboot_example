/* Custom flash loader file to allow switching between boot images */
#include <xs1.h>

extern void readFlashDataPage(unsigned addr);
int dpVersion;
unsigned imgAdr;

in port img = XS1_PORT_1K; // button 1 on XK-1A
in port img2 = XS1_PORT_1L; // button 2 on XK-1A

void init(void) {
  unsigned version, tmp;
  // Buttons are active low
  set_port_inv(img);
  set_port_inv(img2);
 img :> version;
 img2 :> tmp;
  version |= (tmp << 1);
dpVersion = version; // will be 0 through 3.
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
