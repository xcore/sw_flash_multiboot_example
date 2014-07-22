/* Custom flash loader file to allow switching between boot images */
#include <xs1.h>

extern void readFlashDataPage(unsigned addr);

int dpVersion;    //for storing the version we want to boot
unsigned imgAdr;  //for storing the address of the image we want to boot

in port but1 = XS1_PORT_1K; // button 1 on XK-1A

//init : decide which firmware version you are wanting to boot and store the
//version number in dpVersion.
//0 = factory image;
//1 = upgrade image version 1;
void init(void) {
  // Buttons are active low
  unsigned but1_in;

  but1 :> but1_in;

  dpVersion = !but1_in;
}

//checkCandidateImageVersion : decided if this version is a wanted version
//in : v - the version found in flash by the second stage bootloader;
//return : 1 if you want to boot this version; 
//         0 if you are not interested in this version;
int checkCandidateImageVersion(int v) {
  return v == dpVersion;
}

//recordCandidateImage : if checkCandidateImageVersion returns 1 then the second 
//stage bootloader will call recordCandidateImage. Save the address of the 
//wanted image locally to imgAdr;
//in : v - the version found in flash by the second stage bootloader;
//in : adr - the address in flash of the version found by the second stage bootloader;
void recordCandidateImage(int v, unsigned adr) {
  imgAdr = adr;
}

//reportSelectedImage : after the second stage bootloader has finished searching
//flash it will call reportSelectedImage and we return the address of the image
//we want to boot as last saved in recordCandidateImage
unsigned reportSelectedImage(void) {
  return imgAdr;
}
