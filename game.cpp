#ifdef __GBA__

#include <cstdio>
#include <iostream>
#include <string>
#include <vector>

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

#include <cstdio>
#include <iostream>
#include <string>
#include <vector>

int main(void) {
  std::cout << "\x1b[10;10HHello World!\n" << std::endl;
}

#endif
