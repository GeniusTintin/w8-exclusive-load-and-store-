.syntax unified

.global main

.type main, %function
main:
  nop
  ldr r0, =my_data
  ldrex r1, [r0]        //update the exclusive monitors
  add r1, 1
  strex r2, r1, [r0]    //successful store
  ldr r0, =my_data2
  ldrex r1, [r0]        //try another exclusive load
  add r1, 1
  strex r2, r1, [r0]    //it needs a exclusive load before to update the monitors
  cbz r2, success

  b main
  success:
  nop
  b success
.size main, .-main

.data
my_data:
.word 100
my_data2:
.word 200
