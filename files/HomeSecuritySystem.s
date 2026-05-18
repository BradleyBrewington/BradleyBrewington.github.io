area HomeSecuritySystemCode, code, readonly
        
                        export __main
__main                proc
                        
                        ; Output Port Configuration for Safe and Attempt LEDs                        
                        ldr r0, =0x40004C00
                        add r0, #0x40
                        
                        mov r1, #0x17 ; Configures P5.0, P5.1, P5.2, P5.4 (3 Red and 1 Green LED (P5.0))
                        strb r1, [r0, #0x04] 
                        
                        mov r1, #0x00
                        strb r1, [r0, #0x02] 
                        
                        ; Input Port Configuration for Tactile Switches                        
                        ; NOTE                        
                        ;(P6.0 - P6.1, P6.6 - P6.7 are switches) 
                        ; Available Port 6 Pins: .0, .1, .4, .5, .6, .7
                        
                        ldr r2, =0x40004C00
                        add r2, #0x41
                        
                        mov r3, #0x00 ; Sets all pins to input
                        strb r3, [r2, #0x04] 
                        
                        mov r3, #0xC3 ; Enables resistors for Pins 
                        strb r3, [r2, #0x06] 
                        
                        mov r3, #0xC3 ; Configures Pull-Up tactile switches 
                        strb r3, [r2, #0x02]
                        
                        ; Input and Output Port Configuration for Check, Obstacle Sensor, and Combination LEDs                        
                        ldr r7, =0x40004C00
                        add r7, #0x21
                        
                        mov r6, #0xF0 ; Sets pins to input and output
                        strb r6, [r7, #0x04] 
                        
                        mov r6, #0x03 ; Enables resistors for Pins
                        strb r6, [r7, #0x06] 
                        
                        mov r6, #0x03 ; Configures Pull-Up Switch for P4.0 and P4.1 and turns off Combination LEDs
                        strb r6, [r7, #0x02]
                                
                        ; strt_pressed: this loop uses a photoresistor to simulate the detection of a person.                
strtpressed mov r1, #0x00 ; Sets bit 1 as low for LED corresponding to P5.0.
                        strb r1, [r0, #0x02] ; Turns off P5.0.


                        ldrb r4, [r7, #0x00] ; Loads the input data from port 4 into register 4.
                        and r4, #0x01 ; Ands the input to isolate the first bit corresponding to P4.0.
                        cmp r4, #0x00 ; If the result is 0, then that implies the button has not been pressed since it always outputs high (pull-up switch).
                        bne strtpressed ; If the result is not equal to zero that means the button was pressed.
                        
                        ;bl delay 
                        
                        ; Notifies the user the Program has started
                        mov r1, #0x01 ; Sets bit 1 as high for LED corresponding to P5.0.
                        strb r1, [r0, #0x02] ; Turns on P5.0.
                        
                        ;bl delay 
                        
                        mov r1, #0x00 ; Sets bit 1 as low for LED corresponding to P5.0.
                        strb r1, [r0, #0x02] ; Turns off P5.0.
                        
                        mov r11, #4 ; Counts the number of attempts. 
                        mov r5, #0x00 ; Used during check to determine if the correct combination was entered.
                        
                        ; user_input: loops through to check tactile switch inputs.
user_input        ldrb r4, [r7, #0x00] ; Checks the input at check button (P4.1).
                        
                        and r4, #0x02 ; Isolates the first bit to determine if the button is still at default
                        cmp r4, #0x02 ; If the button is at default then the result will equal 0. Otherwise, the button was pressed.
                        bne check_ans        
                        
                        ldrb r4, [r2, #0x00] ; Checks the input at button P6.0).
                        
                        mov r10, r4
                        and r10, #0x01 ; Isolates the first bit to determine if the button is still at default
                        cmp r10, #0x01 ; If the button is at default then the result will equal 0. Otherwise, the button was pressed.
                        bne combo_led1
                        
                        mov r10, r4
                        and r10, #0x02 ; Isolates the first bit to determine if the button is still at default
                        cmp r10, #0x02 ; If the button is at default then the result will equal 0. Otherwise, the button was pressed.
                        bne combo_led2


                        mov r10, r4
                        and r10, #0x40 ; Isolates the first bit to determine if the button is still at default
                        cmp r10, #0x40 ; If the button is at default then the result will equal 0. Otherwise, the button was pressed.
                        bne combo_led3
                        
                        mov r10, r4
                        and r10, #0x80 ; Isolates the first bit to determine if the button is still at default
                        cmp r10, #0x80 ; If the button is at default then the result will equal 0. Otherwise, the button was pressed.
                        bne combo_led4
                        
                        b user_input
                        
                        ; Turns on Combination LED1
combo_led1        and r5, #0x01 ; Ensures LED1 can only be turned on once by comparing it with the comparison check register.
                        cmp r5, #0x01 ; If the comparison equals 0, then the LED is already lit. 
                        beq user_input ; Else, move to the next line and light the LED.
                        
                        mov r6, #0x10 ; If it passes the comparison check, then turn on LED1 (P4.4).
                        strb r6, [r7, #0x02] 
                        orr r5, r5, #0x01 ; ORR #0x01 to r5 for check.
                        b user_input
                        
                        ; Turns on Combination LED2
combo_led2        and r5, #0x02 ; Ensures LED2 can only be turned on once.
                        cmp r5, #0x02 ; If the comparison equals 0, then the LED is already lit. 
                        beq user_input ; Else, move to the next line and light the LED.
                        
                        mov r6, #0x20 ; If it passes the comparison check, then turn on LED2 (P4.5).
                        strb r6, [r7, #0x02] 
                        orr r5, r5, #0x02 ; ORR #0x02 to r5 for check.
                        b user_input
                        
                        ; Turns on Combination LED3
combo_led3        and r5, #0x40 ; Ensures LED3 can only be turned on once.
                        cmp r5, #0x40 ; If the comparison equals 0, then the LED is already lit. 
                        beq user_input ; Else, move to the next line and light the LED.
                        
                        mov r6, #0x40 ; If it passes the comparison check, then turn on LED3 (P4.6).
                        strb r6, [r7, #0x02] 
                        orr r5, r5, #0x40 ; ORR #0x40 to r5 for check.
                        b user_input


                        ; Turns on Combination LED4
combo_led4        and r5, #0x80 ; Ensures LED4 can only be turned on once.
                        cmp r5, #0x80 ; If the comparison equals 0, then the LED is already lit. 
                        beq user_input ; Else, move to the next line and light the LED.
                        
                        mov r6, #0x80 ; If it passes the comparison check, then turn on LED4 (P4.7).
                        strb r6, [r7, #0x02]
                        orr r5, r5, #0x80 ; ORR #0x80 to r5 for check.
                        b user_input
                        
                        ; check_ans: checks the combination and determines the next course of action for the user.
check_ans        mov r6, #0x03 ; Resets all combination LEDs to indicate input was received.
                        strb r6, [r7, #0x02]
                        
                        cmp r5, #0xC1 ; Checks the answer
                        beq safe ; If the combination is correct, then branch to safe.
                        
                        mov r5, #0x00 ; If the answer was incorrect, then reset the check comparison.
                        
                        ; Blinks attempt LEDs to indicate an incorrect combinaton.
                        mov r1, #0x16
                        strb r1, [r0, #0x02]
                        
                        ;bl delay
                        
                        mov r1, #0x00
                        strb r1, [r0, #0x02]
                        
                        sub r11, r11, #1 ; If the combination was incorrect subtract 1 out of the three attempts and branch to attempt_check.
                        b attmptCheck


                        ; attmptCheck: loops through turns on the LED based on the number of attempts made.
attmptCheck cmp r11, #3
                        blt redLED2 ; If the value is less then 3 branch to redLED2.
                        mov r1, #0x02 ; Else, turn on the first red LED.
                        strb r1, [r0, #0x02]
                        ;bl delay
                        b user_input ; Turns on the first red LED to indicate attempt #1.
                        
redLED2                cmp r11, #2
                        blt redLED3 ; If the value is less then 2 branch to redLED2.
                        mov r1, #0x06 ; Else, turn on the second red LED.
                        strb r1, [r0, #0x02]
                        ;bl delay
                        b user_input ; Turns on the second red LED to indicate attempt #2.
                        
redLED3                mov r1, #0x16 ; Turn on the third red LED.
                        strb r1, [r0, #0x02]
                        ;bl delay
                        b emergency ; Turns on the third red LED to indicate attempt #3.


                        ; emergency: activates the Red LEDs (P5.1, P5.2, P5.4) indicating the combination was entered 3 times incorrectly.
emergency        mov r1, #0x16 
                        strb r1, [r0, #0x02]
                        
                        ;bl delay
                        
                        mov r1, #0x00
                        strb r1, [r0, #0x02]
                        
                        ;bl delay
                        b emergency


                        ; safe: activates the Green LED (P5.0) indicating the combination was entered correctly.
safe                 mov r1, #0x00 ; Turn off all attempt LEDs
                        strb r1, [r0, #0x02] 
                        
                        ;bl delay
                        
safe_loop
                        mov r1, #0x01 ; Turn on green LED to indicate the code was correct.
                        strb r1, [r0, #0x02]
                        b safe_loop
        
                        endp
                        
                        ; delay: adds a delay to LEDs
delay                function
                        ldr r12, =0xFF00
continue        subs r12, #0x1
                        bne continue
                        bx LR
                        endp
                                
                        end