#ifdef __GBA__

#include <iostream>

#include <gba_console.h>
#include <gba_input.h>
#include <gba_interrupt.h>
#include <gba_systemcalls.h>
#include <gba_video.h>

int main(void) {
  irqInit();
  irqEnable(IRQ_VBLANK);

  consoleDemoInit();

  std::cout << "\x1b[10;10HHello World!\n" << std::endl;

  while (1) {
    VBlankIntrWait();
  }
}

#else

#include <iostream>

int main(int argc, char * argv[]) {
  std::cout << "\x1b[10;10HHello World!\n" << std::endl;
}

#endif
