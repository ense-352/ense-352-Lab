# Lab-4 Assignment

## Procedure

Accept your assignment, create a new project and put the project under revision control.

### Phase 1
The easiest way to begin is to setup the GPIO to turn on a led.  Looking at the board schematic, notice the port pins that the user LED's are attached to.  Using the information given in lab and class write an assembly routine to turn on one of the user LED's.  You have to configure the I/O lines first.  This should be done in a subroutine.

### Phase 2
Now that you can control the LED, write a routine to blink the LED.  HINT:  toggling an LED in code happens very quick!!  Use a delay routine to leave a LED on long enough to see it light up.  
At the end of this phase, have your code blinking the LED off and on in a loop for 10 times.

### Phase 3
Now write a routine such that when the user presses the button down, the LED will come on.  When the user releases the button the light will turn off.  This is called polling the state of the button.



### Submission
Make sure you have commited your latest solution and pushed it to your repository for grading.
