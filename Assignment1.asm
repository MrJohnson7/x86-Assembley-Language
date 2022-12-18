.data
	str1: .asciiz "Program Description: \t \t"
	str2: .asciiz "Assignment 1 functions" 
	str3: .asciiz "\nAuthor: \t \t \t"
	str4: .asciiz "Nicholas Johnson \n"
	str5: .asciiz "Creation Date: \t \t \t"
	str6: .asciiz "/"
	strInput: .asciiz "\nEnter an integer between 0 - 10\n"
	strSum: .asciiz "\nSum is: \t"
	strNewLine: .asciiz "\n"
	
	strEnterNumber: .asciiz "Please enter the number of item you are purchasing:\n "
	strTooManyItems: .asciiz "Sorry, too many items to purchase!!\n"
	
	strPriceOfItem: .asciiz "Please enter the price of item "
	strSeperation: .asciiz "==================================================\n"
	strSemicollon: .asciiz ":\t"
	strCouponEnterNumber: .asciiz "Please enter the number of coupons that you want to use.\n"
	strTooMuchCoupons: .asciiz "Too many coupons!! "
	strAmountOfCoupon: .asciiz "Please enter the amount of coupon "
	strNonAcceptable: .asciiz "This coupon is not acceptable\n"
	strTotalCharge: .asciiz "Your total charge is:\t $"
	strThankYou: .asciiz "\nThank you for shopping with us."
	strEnterRealPrice: .asciiz "Please enter a Price more than Zero!\n"
	myStoreItems: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	myCoupons: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.text

	main:
	    li $v0, 4    # calling to add
	    la $a0, str1 #program description load
	    syscall
	    
	    li $v0, 4
	    la $a0, str2
	    syscall
	    
	    li $v0, 4
	    la $a0, str3
	    syscall
	    
	    li $v0, 4
	    la $a0, str4
	    syscall
	    
	    li $v0, 4
	    la $a0, str5
	    syscall
	    
	    li $v0, 1
	    li $a0, 1
	    syscall
	    
	    li $v0, 1
	    li $a0, 0
	    syscall
	    
	    li $v0, 4
	    la $a0, str6
	    syscall
	    
	    li $v0, 1
	    li $a0, 1
	    syscall
	    
	    li $v0, 1
	    li $a0, 5
	    syscall
	    
	    li $v0, 4
	    la $a0, str6
	    syscall
	    
	    
	    li $v0, 1
	    li $a0, 2
	    syscall
	    
	    li $v0, 1
	    li $a0, 0
	    syscall
	    
	    li $v0, 1
	    li $a0, 2
	    syscall
	   
	    li $v0, 1
	    li $a0, 0
	    syscall
	    
	    li $v0, 4
	    la $a0, strNewLine
	    syscall
	    
	    li $v0, 4
	    la $a0, strNewLine
	    syscall
	    # end of HEADER///////////////////////////////////////////////////////////////////////
	    li $s1, 20 #loading register s1 with 20 for comparison
	    
	    input:
	
	    li $v0, 4
	    la $a0, strEnterNumber #loading input into the register $a0
	    syscall
	    
	    li $v0, 5  #reads a variable
	    syscall
	    
	    add $a2, $v0, $0 #Putting user number for FUNCTION CALL
	    add $s3, $v0, $0
	    
	    bgt $a2, $s1, errorMessage
	    
	    li $v0, 4
	    la $a0, strSeperation
	    syscall
	   
	    
	    jal FillPriceArray ###Jump to function
	    
	    add $s7, $v1, $0 # Storing value from price of item
	    
	    inputCoupon:
	   
	    li $v0, 4
	    la $a0, strCouponEnterNumber #loading input into the register $a0
	    syscall
	    
	    li $v0, 5  #reads a variable
	    syscall
	    
	    add $a3, $v0, $0 #Putting user number for FUNCTION CALL
	    
	    bgt $a3, $s3, tooManyCoupons
	    
	    li $v0, 4
	    la $a0, strSeperation
	    syscall
	    
	    jal fillCoupon
	    
	    add $s6, $v1, $0 # Storing value from price of item $s7 - $s6
	    
	    li $v0, 4
	    la $a0, strTotalCharge
	    syscall #Output String
	  
	    sub $s3, $s7, $s6 #subtracting the price from discount price
	    
	    li $v0, 1
	    la $a0, ($s3)
	    syscall #outputting final price to screen
	    
	    li $v0, 4
	    la $a0, strThankYou
	    syscall #THANK YOU FOR SHOPPING
	  
	    
	    li $v0, 10 ########################################################################################################3
	    syscall
	
	  fillCoupon:
	  
	    add $t1, $a3, $0 #Pushing the user input from register $a2 to $t1
	    add $t0, $a3, $0 
	    la $t9, myCoupons #array #######################################################
	    la $t8, myStoreItems #array #############################################
	    
	    li $t2, 10 #For comparing coupon
	    li $t3, 1 #####For counter of user input questions number

	    inputLoopCoupons:
	    li $t5, 0 #reset to zero everytime loop iterates
	    beq $t1, $0, itemOutput2 #Branch
         
            li $v0, 4
	    la $a0, strAmountOfCoupon #loading input into the register $a0
	    syscall
	  
	    li $v0, 1
	    add $a0, $t3, $0  #THE number before the semicolon
	    syscall
	  
	    li $v0, 4
	    la $a0, strSemicollon #loading input into the register $a0
	    syscall
          
            li $v0, 5 #Receiving UserInput 
            syscall
            
            add $t4, $v0, $0 #Coupon number discount.
           
            blt $t4, $0, couponError 
            bgt $t4, $t2, couponError
            
           lw $v0, 0($t8) ################################## Array
           
           add $t5, $v0, $t5 #Should I be loading word into v0?????? $t0
           
           bgt $t4, $t5, couponError #Comparing coupon to price, cant be greater than the price
 ##############################################################################################
           ################################################################################ Storing element into array
            sw $t4, 0($t9) #STORING USER INPUT INTO ARRAY 
            
            addi $t9, $t9, 4 #Goin to next place in array
            addi $t8, $t8, 4 #Goin to next place in array
            addi $t1, $t1, -1 #Decrement the counter
            addi $t3, $t3, 1  #Increment the question variable
	    
	    j inputLoopCoupons
            
            
	    
	    li $v0, 10 ########################################################################################################3
	    syscall
	    
	    itemOutput2:
	   la $t9, myCoupons
           li $t6, 0
           
           priceLoop2:
           beq $t0, $0, FinalCouponPriceOutput
           
           lw $v0, 0($t9) ################################## Array
           add $t6, $v0, $t6 #loading element from array
           addi $t0, $t0, -1 #decrement the counter
           addi $t9, $t9, 4 #increment the array
	    
	    j priceLoop2 #jump back to price loop
	    
	    li $v0, 10
	    syscall
	    
	    FinalCouponPriceOutput:
	    li $v0, 4
	    la $a0, strSeperation
	    syscall
	    
	    add $v1, $t6, $0 #$t0 should be one we are returning
	    jr $ra #jump back to main JJJJJJJJJJJJJJUUUUUUUUUUUUUMMMMMMMMMPPPPPPPPP and RRRRREEEEETTTTTTUUURRRNNNNN
	    
	    
	    li $v0, 10 
	    syscall
	   
	     couponError:
	    
	    li $v0, 4
	    la $a0, strNonAcceptable
	    syscall
	    
	    sw $0, 0($t9) #STORING USER INPUT INTO ARRAY zero into the array STORING ZERO
            
            addi $t9, $t9, 4 #Goin to next place in array
            addi $t8, $t8, 4 
            addi $t1, $t1, -1 #Decrement the counter
            addi $t3, $t3, 1  #Increment the question variable
	    
	    
	    j inputLoopCoupons
	    
	   
	    errorMessage:
	    li $v0, 4
	    la $a0, strTooManyItems
	    syscall
	    
	    j input
	    
	    FillPriceArray:
	    add $t1, $a2, $0 #Pushing the user input from register $a2 to $t1
	    add $t0, $a2, $0 ###################
	    la $t9, myStoreItems #array #######################################################
	    
	    li $t3, 1 ###For comaring to make sure there is one item from user input
	    li $t2, 1 #####For counter of user input questions number
	     
	     inputLoop:
          
            beq $t1, $0, itemOutput
         
            li $v0, 4
	    la $a0, strPriceOfItem #loading input into the register $a0
	    syscall
	  
	    li $v0, 1
	    add $a0, $t2, $0  #THE number before the semicolon
	    syscall
	  
	    li $v0, 4
	    la $a0, strSemicollon #loading input into the register $a0
	    syscall
          
            li $v0, 5 #Receiving UserInput 
            syscall  
          
            add $t4, $v0, $0 #User Input in $t4
            blt $t4, $t3, lessThanOne #Branch
          
            sw $v0, 0($t9) #STORING USER INPUT INTO ARRAY 
            addi $t9, $t9, 4 #Goin to next place in array
         
            addi $t1, $t1, -1 #Decrement the counter
            addi $t2, $t2, 1  #Increment the question variable
	    
	    j inputLoop
	    
           itemOutput:
           
           la $t9, myStoreItems 
           li $t5, 0 #loading register with $t5
           
           priceLoop:
           beq $t0, $0, FinalPriceOutput
           
           lw $v0, 0($t9) ################################## Array
           add $t5, $v0, $t5 #Math is being done here
           addi $t0, $t0, -1
           addi $t9, $t9, 4 
           
           j priceLoop
           
  
	    
	    FinalPriceOutput:
	    
	    li $v0, 4
	    la $a0, strSeperation
	    syscall
	    
	    add $v1, $t5, $0 #$t0 should be one we are returning
	    jr $ra #jump back to main
	   
           
           lessThanOne:
           
           li $v0, 4
           la $a0, strEnterRealPrice
           syscall
           
           j inputLoop
           
           tooManyCoupons:
           
           li $v0, 4
           la $a0, strTooMuchCoupons
           syscall
           
           j inputCoupon
           
