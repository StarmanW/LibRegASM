.model small
.stack 64
.data
    ;------------------------------------------------------------------------------------------------------------------------------------------;
    ;--------------------------------------------------------- LOGIN DATA DECLARATION ---------------------------------------------------------;
    ;------------------------------------------------------------------------------------------------------------------------------------------;
	;Data structure for login string input
    login_KB_INPUT	        LABEL	BYTE            ;Parameter list name
    login_MAX_LEN	        DB	    10		        ;Max no of chars
    login_ACT_LEN	        DB	    ?		        ;Actual no of chars
    login_KB_DATA	        DB	    10 DUP(' ')     ;Data area to store

	;All the login variables
    loginHeader             DB      "-------------------------",13,10,"|         LOGIN         |",13,10,"-------------------------$"
    loginIDMsg              DB      13,10,"Enter login ID: $"
    loginPassMsg            DB      13,10,"Enter password: $"
    logPass                 DB      10 DUP(' ')
    loginIDVal              DB      "admin"
    loginPassVal            DB      "12345"
    invalidLogin            DB      13,10,"Invalid login ID or password, please try agian or contact the system admin",13,10,13,10,'$'  
    loginSuccessMsg         DB      13,10,13,10,"Login succeed!$"
    passwordCount           DB      0
    
    ;------------------------------------------------------------------------------------------------------------------------------------------;
    ;------------------------------------------------------- MAIN MENU DATA DECLARATION -------------------------------------------------------;
    ;------------------------------------------------------------------------------------------------------------------------------------------;
    main_menu               DB      13,"-------------------------------------",13,10,"|                Menu               |",10,13,"-------------------------------------",13,10, "1. New librarian qualification test",10,13, "2. Register new librarian",10,13,"3. Exit program",13,10,"-------------------------------------$"
    menu_optMsg             DB      13,10,"Select an option > $"
    invalidMenuOptMsg       DB      13,10,"Invalid menu option, please try again with only 1,2 or 3 as input choice.",13,10,"$" 
    msg_cont                DB      13,10,"Do you with to continue? (Y/N) > $"
    invalidContInput        DB      13,10,"Invalid input, please try again with only 'y' or 'n' as input choice.",13,10,13,10,"$"
    programTerminateMsg     DB      13,10,"Program successfully terminated!$"

    ;------------------------------------------------------------------------------------------------------------------------------------------;
    ;------------------------------------------------------ LIBRARIAN QUALIFICATION TEST ------------------------------------------------------;
    ;------------------------------------------------------------------------------------------------------------------------------------------;
    quesHeader              DB      "---------------------------------------------------------------  --------",13,10,"|                       QUALIFICATION TEST                    |  |ANSWER|",13,10,"---------------------------------------------------------------  --------$"    
    ques1                   DB      13,10,"1. Does the new candidate have bachelor degree on librarianship", 13,10,"qualification?                                                   (Y/N): $"
    ques2                   DB      13,10,13,10,"2. Does the new candidate have previous experience in the same",13,10,"field?                                                           (Y/N): $"
    ques3                   DB      13,10,13,10,"3. Does the new candidate have at least 3 years of experience as",13,10,"a librarian?                                                     (Y/N): $"
    ques4                   DB      13,10,13,10,"4. Does the new candidate have TOEFL/IELTS band 6 qualification? (Y/N): $"
    ques5                   DB      13,10,13,10,"5. Does the new candidate have experience IN using any library",13,10,"computer system?                                                 (Y/N): $"
    notQualifiedMsg         DB      13,10,13,10,"Sorry, the candidate is not qualified to be the new librarian.$"
    qualifiedMsg            DB      13,10,13,10,"The candidate is qualified to be the new librarian!$"

    
    ;------------------------------------------------------------------------------------------------------------------------------------------;
    ;----------------------------------------------------- ADD NEW LIBRARIAN DECLARATION ------------------------------------------------------;
    ;------------------------------------------------------------------------------------------------------------------------------------------;
	;Data structure for new librarian name string input
    newLibName_KB_INPUT	    LABEL	BYTE            ;Parameter list name
    newLibName_MAX_LEN	    DB	    20		        ;Max no of chars
    newLibName_ACT_LEN	    DB	    ?		        ;Actual no of chars
    newLibName_KB_DATA	    DB	    20 DUP(' ')     ;Data area to store 
    
	;Data structure for new librarian ID string input
    newLibID_KB_INPUT	    LABEL	BYTE            ;Parameter list name
    newLibID_MAX_LEN	    DB	    7		        ;Max no of chars
    newLibID_ACT_LEN	    DB	    ?		        ;Actual no of chars
    newLibID_KB_DATA	    DB	    7 DUP(' ')      ;Data area to store
    
	;Data structure for date joined string input
    dateJoined_KB_INPUT	    LABEL	BYTE            ;Parameter list name
    dateJoined_MAX_LEN	    DB	    11		        ;Max no of chars
    dateJoined_ACT_LEN	    DB	    ?		        ;Actual no of chars
    dateJoined_KB_DATA	    DB	    11 DUP(' ')     ;Data area to store
    
    newLibHeader            DB      13,"----------------------------------------------------------------",13,10,"|                         New Librarian                        |",13,10,"----------------------------------------------------------------$"        
    newLibNameMsg           DB      13,10,"Enter new librarian name (e.g. John Smith): $"
    newLibIDMsg             DB      13,10,"Enter new librarian ID   (e.g. LIB001)     : $"
    dateJoinedMsg           DB      13,10,"Enter date joined        (e.g.25-02-2017)  : $"
    promptAddMoreLib        DB      13,10,13,10,"Do you wish to add more librarian? (Y/N): $"
    successAddMsg           DB      " new librarian(s) has been successfully added into the system!",13,10,"$" 
    newLibrarianCount       DB      0
    newLibrarianCountFinal  DB      0
    libCountFinalMsg        DB      13,10,13,10,"Total of $"
    libCountFinalMsg2       DB      " new librarian added$"
    
    libIDvalidation         DB      "LIB"
    invalidLibIDMsg         DB      13,10,"Invalid librarian ID format, please try again with the correct format (e.g. LIB001)",13,10,13,10,"$" 
          
.code
;---------------------------------------------------------------------; 
;-------------------------- MAIN PROCEDURE ---------------------------;
;---------------------------------------------------------------------;
MAIN PROC FAR
    MOV AX,@data
    MOV DS,AX
    
  	CALL login                              ;Call login function

    ;START DISPLAY THE MAIN MENU     
start:  
        CALL clearScreen     				;Call clearScreen to clear the screen after login
        LEA DX,main_menu                    ;LEA main menu into DX to display
        CALL displayString                  ;Call the display string procedure to display the main menu
    
MainMenuChoice:                             
        LEA DX,menu_optMsg                  ;LEA menu option message into DX to display
        CALL displayString                  ;Call the display string procedure to display the menu option message
        CALL promptSingle                   ;Call the prompt single character to accept user input choice of the menu
        CMP AL,'1'                          ;Compare if the choice is 1 or not
        JE libQualificationTestProc         ;Jump to libQualificationTestProc if menu choice is 1
        CMP AL,'2'                          ;Compare if the choice is 2 or not
        JE addNewLibProc                    ;Jump to addlib if menu choice is 2
        CMP AL,'3'                          ;Compare if the choice is 3 or not
        JE exit                             ;Jump to exit to end program if menu choice is 3
        JNE invalidMenuOption               ;If its none of the choice above, jump to invalidMenuOption to display invalid input message

libQualificationTestProc:
        CALL libQulificationTest			;Call libQulificationTest procedure to display qualification question	
        JMP continue						;Jump to continue after the procedure
                        
addNewLibProc:
        CALL addNewLibrarian                ;Call the add new librarian procedure
        JMP continue                        ;Jump to continue message after the procedure has completed
        
invalidMenuOption:
        LEA DX,invalidMenuOptMsg            ;LEA invalidMenuOptMsg into DX to display invalid menu option message
        CALL displayString                  ;Display the invalid menu option message
        JMP MainMenuChoice                  ;Repeat the input of menu choice

continue:
        LEA DX,msg_cont                     ;LEA msg_cont into DX to display "continue?" message
        CALL displayString                  ;Display the continue message
        CALL promptSingle                   ;Prompt the user to enter single character
        CMP AL,'n'                          ;Compare whether AL is lowercase 'n'
        JE exit                             ;Jump to exit if it is 'n'
        CMP AL,'N'                          ;Compare whether AL is uppercase 'N'
        JE exit                             ;Jump to exit if it is 'N'
        CMP AL,'y'                          ;Compare whether AL is lowercase 'y'
        JE start                            ;Jump to start if it is 'y'
        CMP AL,'Y'                          ;Compare whether AL is uppercase 'Y'
        JE start                            ;Jump to start if it is 'Y'
        JNE invalidCont                     ;If it's none of the above, jump to invalidCont to display invalid message

invalidCont:
        LEA DX,invalidContInput             ;LEA invalidContInput into DX to display invalid "continue?" input message
        CALL displayString                  ;Display the invalid "continue?" message
        JMP continue                        ;Jump back to continue to repeat the input process    
    
exit:                                                      
        LEA DX,libCountFinalMsg				;Display the counter message1
        CALL displayString
        MOV DL,newLibrarianCountFinal		;Move the values of "newLibrarianCountFinal" into AL for display
        ADD DL,30h							;Convert the value into ASCII
        CALL displaySingle					;Display the value
        LEA DX,libCountFinalMsg2
        CALL displayString					;Display the counter message2
        LEA DX,programTerminateMsg          ;LEA programTerminateMsg into DX to display system termination message
        CALL displayString                  ;Displays system termination message
        MOV AX,4C00H                        ;Terminates the program
        INT 21H
MAIN ENDP
;---------------------------------------------------------------------; 
;------------------------- MAIN PROCEDURE END ------------------------;
;---------------------------------------------------------------------;

;---------------------------------------------------------------------; 
;-------------------------- LOGIN PROCEDURE --------------------------;
;---------------------------------------------------------------------; 
login PROC
    ;Login header1
    LEA DX,loginHeader						
    CALL displayString						;Display login header
    
;Start of login process    
LoginStart:
        ;Login ID prompt 
        LEA DX,loginIDMsg                   ;LEA loginIDMsg into DX to prompt user to input for login ID
        CALL displayString                  ;Display the login ID prompt message
    	LEA DX,login_KB_INPUT               ;LEA login_KB_INPUT into DX
        CALL promptString
                
        ;Login password prompt
        LEA DX,loginPassMsg                 ;LEA loginPassMsg into DX to prompt user to input for password
        CALL displayString                  ;Display the password prompt message        
        
        LEA SI,logPass                      ;LEA logPass - (Empty string holder for password)
        MOV CX,10                           ;initialize cx with 10, this allows the user to enter 10 char for password
loopPasswordInput:        
        MOV AH,07h                          ;Input single char without echo
        INT 21h
        CMP AL,0Dh                          ;Check if user pressed "Enter" key or not
        JE StartChecking                    ;Jump to "StartChecking" if user pressed "Enter" key
        MOV [SI],AL                         ;Move the entered character password into SI
        INC SI                              ;Increment SI
        INC passwordCount                   ;Increment the password count (To count the number of characters entered)
        MOV AH,02h                          ;Display single character function
        MOV DL,"*"                          ;Display the "*" after each password input
        INT 21h                             ;Interrupt service - display single character function
        LOOP loopPasswordInput              ;Loop the single char input (No-echo) 

StartChecking:            
        LEA SI,login_KB_DATA                ;LEA entered login ID into SI
        LEA DI,loginIDVal                   ;LEA hardcoded login ID into DI for validation
        MOV CX,5                            ;Initialize counter with 5 because login ID is "sys"
LoginIDCheck:
        MOV AL,[SI]                         ;Move content of SI (Entered login ID) into AL - index by index
        CMP AL,[DI]                         ;Compare the content of AL with DI - Validate character by character
        JNE WrongLogin                      ;If one of the login ID does not match, jump to "WrongLogin" for invalid login message 
        INC SI                              ;Increment SI - Entered login ID
        INC DI                              ;Increment DI - Hardcoded login ID
        LOOP LoginIDCheck                   ;Repeat the validation process

        ;Check the login password
        CMP passwordCount,5                 ;Compare the length of password, check whether it is 5 or not
        JNE WrongLogin                      ;If its not equal to 5, jump to "WrongLogin" for invalid login message
        LEA SI,logPass                      ;LEA entered password) into SI
        LEA DI,loginPassVal                 ;LEA hardcoded password into DI
        MOV CX,5                            ;Initialize counter with 5 because password is "12345"
PasswordCheck:
        MOV AL,[SI]                         ;Move content of SI (Entered password) into AL - index by index
        CMP AL,[DI]                         ;Compare the content of AL with DI - Validate character by character
        JNE WrongLogin                      ;If one of the password does not match, jump to "WrongLogin" for invalid login message
        INC SI                              ;Increment SI - Entered password
        INC DI                              ;Increment DI - Hardcoded password
        LOOP PasswordCheck                  ;Repeat the validation process
        JMP LoginSuccess                    ;Jump to "LoginSuccess" if both login ID and password are valid

;Display invalid login message                 
WrongLogin:
        LEA DX,invalidLogin                 ;LEA invalid login message into DX
        CALL displayString                  ;Display invalid login message
        MOV passwordCount,0000h             ;Reser the password length counter to 0
        LOOP LoginStart                     ;Repeat the login process

;Login successed, proceed to menu
LoginSuccess:
        LEA DX,loginSuccessMsg              ;LEA loginSuccessMsg into DX to display login success message
        CALL displayString                  ;Display login success message
        RET                                 ;Return to main procedure
login ENDP
;---------------------------------------------------------------------; 
;------------------------ LOGIN PROCEDURE END ------------------------; 
;---------------------------------------------------------------------; 

;---------------------------------------------------------------------; 
;------------ NEW LIBRARIAN QUALIFICATION TEST PROCEDURE -------------; 
;---------------------------------------------------------------------; 
libQulificationTest PROC
    CALL clearScreen

    LEA DX,quesHeader
    CALL displayString						;Display header

;---------------- QUESTION 1 ----------------;        
question1:
        LEA DX,ques1
        CALL displayString                  ;Display question 1
        CALL promptSingle                   ;Prompt for user input
        CMP AL,'Y'                          ;Compare answer with uppercase 'Y'
        JE incCount1                        ;Jump to intCount1 to increment counter
        CMP AL,'y'
        JE incCount1
        CMP AL,'N'                          ;If answer if 'N'
        JE question2                        ;Jump to question 2
        CMP AL,'n'
        JE question2
        JNE invalidAns1                     ;If input answer is none of the above, jump to invalidAns1 for invalid message
                
invalidAns1:
        LEA DX,invalidContInput
        CALL displayString                  ;Display the invalid input message
        JMP question1
        
incCount1:
        INC CL                              ;increment the qualification counter
          
;---------------- QUESTION 2 ----------------;        
question2:
        LEA DX,ques2                        
        CALL displayString                  ;Display question 2
        CALL promptSingle                   ;Prompt for user input
        CMP AL,'Y'                          ;Compare answer with uppercase 'Y'
        JE incCount2                        ;Jump to intCount2 to increment counter
        CMP AL,'y'
        JE incCount2
        CMP AL,'N'                          ;If answer if 'N'
        JE question3                        ;Jump to question 3
        CMP AL,'n'
        JE question3
        JNE invalidAns2                     ;If input answer is none of the above, jump to invalidAns1 for invalid message
                
invalidAns2:
        LEA DX,invalidContInput
        CALL displayString                  ;Display the invalid input message
        JMP question2
        
incCount2:
        INC CL                              ;increment the qualification counter
 
;---------------- QUESTION 3 ----------------;                
question3:
        LEA DX,ques3
        CALL displayString                  ;Display question 3
        CALL promptSingle                   ;Prompt for user input
        CMP AL,'Y'                          ;Compare answer with uppercase 'Y'
        JE incCount3                        ;Jump to intCount3 to increment counter
        CMP AL,'y'
        JE incCount3
        CMP AL,'N'                          ;If answer if 'N'
        JE question4                        ;Jump to question 4
        CMP AL,'n'
        JE question4
        JNE invalidAns3                     ;If input answer is none of the above, jump to invalidAns1 for invalid message
                       
invalidAns3:
        LEA DX,invalidContInput
        CALL displayString                  ;Display the invalid input message
        JMP question3
        
incCount3:
        INC CL                              ;increment the qualification counter
        
;---------------- QUESTION 4 ----------------;                  
question4:
        LEA DX,ques4                        
        CALL displayString                  ;Display question 4
        CALL promptSingle                   ;Prompt for user input
        CMP AL,'Y'                          ;Compare answer with uppercase 'Y'
        JE incCount4                        ;Jump to intCount4 to increment counter
        CMP AL,'y'
        JE incCount4
        CMP AL,'N'                          ;If answer if 'N'
        JE question5                        ;Jump to question 5
        CMP AL,'n'
        JE question5                       
        JNE invalidAns4                     ;If input answer is none of the above, jump to invalidAns1 for invalid message

invalidAns4:
        LEA DX,invalidContInput
        CALL displayString                  ;Display the invalid input message
        JMP question4
                
incCount4:
        INC CL                              ;increment the qualification counter
        
;---------------- QUESTION 5 ----------------;        
question5:
        LEA DX,ques5
        CALL displayString                  ;Display question 5
        CALL promptSingle                   ;Prompt for user input
        CMP AL,'Y'                          ;Compare answer with uppercase 'Y'
        JE incCount5                        ;Jump to intCount4 to increment counter
        CMP AL,'y'
        JE incCount5
        CMP AL,'N'                          ;If answer if 'N'
        JE finalResult                      ;Jump to finalResult to display the final result
        CMP AL,'n'
        JE finalResult        
        JNE invalidAns1                     ;If input answer is none of the above, jump to invalidAns1 for invalid message

invalidAns5:
        LEA DX,invalidContInput
        CALL displayString                  ;Display the invalid input message
        JMP question5

incCount5:
        INC CL                              ;increment the qualification counter

;------------ CHECK FINAL RESULT -------------;        
finalResult:
        CMP CL,5
        JNE notQualified
        LEA DX,qualifiedMsg
        CALL displayString
        JMP returnToMainProc

notQualified:
        LEA DX,notQualifiedMsg
        CALL displayString

returnToMainProc:        
        RET
libQulificationTest ENDP
;---------------------------------------------------------------------; 
;---------- NEW LIBRARIAN QUALIFICATION TEST PROCEDURE END -----------; 
;---------------------------------------------------------------------; 

;---------------------------------------------------------------------; 
;---------------------- NEW LIBRARIAN PROCEDURE ----------------------; 
;---------------------------------------------------------------------; 
addNewLibrarian PROC        
addNewLib:
        CALL clearScreen                    ;Clear the screen
        LEA DX,newLibHeader                 ;LEA newLibHeader into DX to display the header
        CALL displayString                  ;Display the header for new librarian registration                          
        
        LEA DX,newLibNameMsg                ;LEA newLibNameMsg into DX to display prompt message for new librarian name 
        CALL displayString                  ;Display the prompt new librarian name message
        LEA DX,newLibName_KB_INPUT          ;LEA string data structure into DX
        CALL promptString                   ;Prompt user for new librarian name

newlibID:                                
        LEA DX,newLibIDMsg                  ;LEA newLibIDMsg into DX to display prompt message for new librarian ID
        CALL displayString                  ;Display the prompt new librarian ID message
        LEA DX,newLibID_KB_INPUT            ;LEA string data structure into DX
        CALL promptString                   ;Prompt user for new librarian ID
        
        LEA SI,newLibID_KB_DATA				;LEA "newLibID_KB_DATA" into SI for format validation
        LEA DI,libIDvalidation				;LEA "libIDvalidation" into DI for format validation
        MOV CX,3							;Initialise counter with 3
validateLibID:
        MOV AL,[SI]							;Move content of SI into AL for comparison
        CMP [DI],AL							;Compare the content of AL with the content of DI 
        JNE invalidLibID					;Jump to invalidLibID if it is not equal
        INC SI								;Increment SI
        INC DI								;Increment SI
        LOOP validateLibID					;Repeat the process
        JMP promptDateJoined				;After loop has ended, jump to promptDateJoined
        
invalidLibID:
        LEA DX,invalidLibIDMsg				
        CALL displayString					;Display invalid format message
        JMP newlibID                   		;Jump back to newLibID to prompt user to re-enter

promptDateJoined:        
        LEA DX,dateJoinedMsg                ;LEA dateJoinedMsg into DX to display prompt message for date joined
        CALL displayString                  ;Display the prompt date joined message
        LEA DX,dateJoined_KB_INPUT          ;LEA string data structure into DX
        CALL promptString                   ;Prompt user for date joined of the new librarian                
        INC newLibrarianCount               ;Increase CL - Counter for new librarian

promptMoreNewLib:        
        LEA DX,promptAddMoreLib             ;LEA promptAddMoreLib into DX to be displayed
        CALL displayString                  ;Display add more librarian message
        CALL promptSingle                   ;Get user input - either "Y", "y", "N", "n"
        CMP AL,'n'                          ;Compare whether AL is lowercase 'n'
        JE endAddNewLib                     ;Jump to endAddNewLib if it is 'n'
        CMP AL,'N'                          ;Compare whether AL is uppercase 'N'
        JE endAddNewLib                     ;Jump to endAddNewLib if it is 'N'
        CMP AL,'y'                          ;Compare whether AL is lowercase 'y'
        JE addNewLib                        ;Jump to start if it is 'y'
        CMP AL,'Y'                          ;Compare whether AL is uppercase 'Y'
        JE addNewLib                        ;Jump to start if it is 'Y'
        JNE invalidInput                    ;If input is none of the above, jump to invalid message
        
invalidInput:
        LEA DX,invalidContInput             ;LEA invalidContInput into DX to display invalid "continue?" input message
        CALL displayString                  ;Display the invalid "continue?" message
        JMP promptMoreNewLib                ;Jump back to continue to repeat the input process  
                  
endAddNewLib:        
        CALL newline                        ;Display newline
        CALL newline
        MOV AL,newLibrarianCount            ;Move the value of the counter into AL for display
        ADD AL,30h                          ;Convert the value into ASCII by adding 30H
        MOV DL,AL                           ;Move AL into DL for display single character
        CALL displaySingle                  ;Display single character
        LEA DX,successAddMsg                ;LEA numbers of successfully added message
        CALL displayString                  ;Display the message
        MOV AL,newLibrarianCount            ;Move values of counter into AL register for adding
        ADD newLibrarianCountFinal,AL       ;Add the values of counter into "newLibrarianCountFinal" for displaying the total new librarian
        MOV newLibrarianCount,0000h         ;Reset the new librarian counter
        RET                                 ;Return to main procedure
addNewLibrarian ENDP    
;---------------------------------------------------------------------; 
;-------------------- NEW LIBRARIAN PROCEDURE END --------------------; 
;---------------------------------------------------------------------; 

;---------------------------------------------------------------------; 
;------------------------- UTILITY PROCEDURE -------------------------; 
;---------------------------------------------------------------------;
clearScreen PROC
        MOV AX,0600h                        ;Clear full screen 06 = scroll, 00 = full screen
        MOV BH,07h                          ;Set the color after clearing screen, 0 = black background, 7 = white color text
        MOV CX,0000h                        ;Clear starting from row 00, column 00 (Top left corner)
        MOV DX,6464h                        ;Clear ending at row 64, column 64 (Bottom right corner)
        INT 10h                             ;Call intrrupt service
        
        MOV AH,02h                          ;Request to set the cursor
        MOV BH,00                           ;Page number set to 0
        MOV DX,0000h                        ;Reset the cursor to row 00, column 00
        INT 10h                             ;Call interrupt service
        RET                                 ;Return to main procedure
clearScreen ENDP

;Code to display a single character
displaySingle PROC
    MOV AH,02H
    INT 21H
    RET
displaySingle ENDP

;Code to display a String
displayString PROC
    ;Requires to LEA DX, <@message variable here>
    MOV AH,09H
    INT 21H
    RET
displayString ENDP

;Code to prompt for single character input
promptSingle PROC
    MOV AH,01H
    INT 21H
    RET
promptSingle ENDP

;Code to prompt for String input
promptString PROC
    ;Requires LEA DX,KB_INPUT
    MOV AH,0AH
    INT 21H
    RET
promptString ENDP

;Code for newline
newline PROC
    MOV DL, 10    ;Newline
    CALL displaySingle
    
    MOV DL, 13    ;Carriage return
    CALL displaySingle

    RET
newline ENDP
;---------------------------------------------------------------------; 
;----------------------- UTILITY PROCEDURE END -----------------------; 
;---------------------------------------------------------------------;
END MAIN