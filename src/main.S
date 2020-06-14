.syntax unified

.global main

another_task:
  ldr r0, =charlesword
  ldr r1, [r0]
  sub r1, 1
  strex r2, r1, [r0]
bx lr

.type main, %function
main:
  nop
  ldr r0, =charlesword
  ldrex r1, [r0]
  add r1, 1
  @ interrupt
  bl another_task @ a wild task appeared
  strex r2, r1, [r0]
  cbz r2, success_loop
  b failure_loop
  nop
  b main
.size main, .-main

success_loop:
nop
b success_loop

failure_loop:
nop
b failure_loop
.data
charlesword:
.word 0x80000000