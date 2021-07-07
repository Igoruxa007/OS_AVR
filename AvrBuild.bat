@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "C:\Projects\first\labels.tmp" -fI -W+ie -C V2E -o "C:\Projects\first\first.hex" -d "C:\Projects\first\first.obj" -e "C:\Projects\first\first.eep" -m "C:\Projects\first\first.map" "C:\Projects\first\first.asm"
