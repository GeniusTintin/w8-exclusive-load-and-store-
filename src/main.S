.syntax unified

.global main

.type main, %function
main:
  nop
  ldr r0, =my_data
  ldrex r2, [r0]        //update the exclusive monitors
  ldr r1, =my_data2
  ldrex r3, [r1]        //try another exclusive load
  add r2, 1
  add r3, 1
  strex r3, r3, [r1]    //it needs a exclusive load before to update the monitors
  strex r2, r2, [r0]    //successful store
  
 

  cbz r3, success

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
