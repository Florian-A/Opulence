#! /bin/bash

# Configuration du terminal Xterm
xterm_terminal()
{
  xterm -geometry 85x10 -bg black -fg white -fa 'Monospace' -fs 11 -e "$*"; 
}
