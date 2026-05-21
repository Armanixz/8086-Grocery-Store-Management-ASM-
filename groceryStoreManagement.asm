.MODEL SMALL
.STACK 200H

.DATA

; PRODUCT DATA----------------
; Product Categories
Category1 DB 'STAPLES', 0
Category2 DB 'SPICES', 0
Category3 DB 'DAIRY', 0
Category4 DB 'DRY FOODS', 0

; Staples Products (Code: 1)
StaplesProducts DB '1-Rice 150TK  2-Flour 80TK  3-Sugar 120TK', 0DH, 0AH, '$'
StaplesCount DB 3

; Spices Products (Code: 2)
SpicesProducts DB '1-Turmeric 200TK  2-Cumin 180TK  3-Chili 150TK', 0DH, 0AH, '$'
SpicesCount DB 3

; Dairy Products (Code: 3)
DairyProducts DB '1-Milk 60TK  2-Yogurt 90TK  3-Cheese 250TK', 0DH, 0AH, '$'
DairyCount DB 3

; Dry Foods Products (Code: 4)
DryFoodsProducts DB '1-Lentils 140TK  2-Chickpeas 160TK  3-Beans 130TK', 0DH, 0AH, '$'
DryFoodsCount DB 3

; Product prices for calculations
StaplesPrices DB 150, 80, 120
SpicesPrices DB 200, 180, 150
DairyPrices DB 60, 90, 250
DryFoodsPrices DB 140, 160, 130

;  MAIN MENU 
WelcomeMsg DB 0DH, 0AH, '===== GROCERY STORE MANAGEMENT SYSTEM =====', 0DH, 0AH, 0DH, 0AH, '$'
MainMenu DB 'MAIN MENU:', 0DH, 0AH,
          DB '1 - Browse & Select Products', 0DH, 0AH,
          DB '2 - View Cart & Checkout', 0DH, 0AH,
          DB '3 - Search Products', 0DH, 0AH,
          DB '4 - Rate Your Experience', 0DH, 0AH,
          DB '5 - View Daily Report', 0DH, 0AH,
          DB '6 - Exit', 0DH, 0AH,
          DB 'Enter Your Choice [1-6]: $'

;  CATEGORY SELECTION 
CategoryMenu DB 0DH, 0AH, 'SELECT CATEGORY:', 0DH, 0AH,
            DB '1 - STAPLES', 0DH, 0AH,
            DB '2 - SPICES', 0DH, 0AH,
            DB '3 - DAIRY', 0DH, 0AH,
            DB '4 - DRY FOODS', 0DH, 0AH,
            DB 'Enter Category [1-4]: $'

InvalidInput DB 0DH, 0AH, 'Invalid Input! Please try again.', 0DH, 0AH, '$'

;  SHOPPING CART 
Cart DB 50 DUP(0)              ; Store selected items 
CartPrices DW 50 DUP(0)        ; Store prices of each item in cart
CartCount DB 0                 ; Number of items in cart
CartTotal DW 0                 ; Total amount

AddItemPrompt DB 0DH, 0AH, 'Enter Item Number to Add: $'
ItemAddedMsg DB ' - Item Added to Cart!', 0DH, 0AH, '$'
CurrentTotal DB 0DH, 0AH, 'Current Total: $'

;  REMOVE ITEM 
RemovePrompt DB 0DH, 0AH, 'Remove Last Item? (Y/N): $'
ItemRemovedMsg DB 'Item Removed! Updated Total: $'
CartEmptyMsg DB 0DH, 0AH, 'Your cart is now empty! Returning to Main Menu...', 0DH, 0AH, '$'

;  DISCOUNT SECTION 
DiscountMenu DB 0DH, 0AH, '=== DISCOUNT ELIGIBILITY ===', 0DH, 0AH,
             DB 'Total is: $'
EligibleDiscount DB 0DH, 0AH, 'Congratulations! You are eligible for discount!', 0DH, 0AH,
                 DB 'Enter Discount Code (4 digits): $'
ValidCode DB '2345'
DiscountCode DB 5 DUP(0)
ValidDiscount DB 'Valid Discount Code Applied! 10% OFF', 0DH, 0AH, '$'
InvalidDiscount DB 'Invalid Discount Code!', 0DH, 0AH, '$'
TKLabel DB ' TK', 0DH, 0AH, '$'

;  PAYMENT 
PaymentMenu DB 0DH, 0AH, '=== PAYMENT METHOD ===', 0DH, 0AH,
            DB '1 - Online Payment', 0DH, 0AH,
            DB '2 - Cash on Delivery', 0DH, 0AH,
            DB 'Select Payment [1-2]: $'
CashPaid DB 'Payment Received! Thank you for shopping!', 0DH, 0AH, '$'
COD DB 'Order Placed! Will be delivered soon!', 0DH, 0AH, '$'

;  SEARCH  
SearchMenu DB 0DH, 0AH, '=== PRODUCT SEARCH ===', 0DH, 0AH,
           DB '1 - Search by First Letter', 0DH, 0AH,
           DB '2 - Search by Category', 0DH, 0AH,
           DB 'Enter Search Option [1-2]: $'
CodePrompt DB 0DH, 0AH, 'Enter Product Code: $'
LetterPrompt DB 0DH, 0AH, 'Enter First Letter: $'
CategorySearchPrompt DB 0DH, 0AH, 'Enter Category Code [1-4]: $'
NoMatch DB 'No Products Found!', 0DH, 0AH, '$'
SearchAgain DB 0DH, 0AH, 'Search Again? (Y/N): $'

;  RATING SECTION 
RatingMenu DB 0DH, 0AH, '=== CUSTOMER REVIEW & RATING ===', 0DH, 0AH,
           DB 'Rate your experience (1-5 stars): $'
RatingStored DB 0DH, 0AH, 'Thank you for your rating!', 0DH, 0AH,
             DB 'Average Store Rating: $'
Ratings DB 10 DUP(0)           ; Store up to 10 ratings
RatingCount DB 0

;  ADMIN PANEL 
AdminPrompt DB 0DH, 0AH, '=== DAILY REPORT ===', 0DH, 0AH, '$'
ReportTxn DB 0DH, 0AH, 'Total Transactions: $'
ReportRevenue DB 0DH, 0AH, 'Total Revenue: $'
ReportAvgRating DB 0DH, 0AH, 'Average Customer Rating: $'
ReportRaters DB 0DH, 0AH, 'Customers Who Rated: $'
TransactionCount DB 0
TotalRevenue DW 0
ReportPINPrompt DB 0DH, 0AH, 'Enter PIN (4digits): $'
ReportPIN DB 5 DUP(0)
ValidReportPIN DB '1234'
WrongReportPIN DB 0DH, 0AH, 'Wrong PIN! Access Denied.', 0DH, 0AH, '$'

;  EXIT   
ExitMsg DB 0DH, 0AH, '===== THANK YOU FOR SHOPPING! =====', 0DH, 0AH, '$'

;  VARIABLES 
UserChoice DB 0
CategoryChoice DB 0
ItemNumber DB 0
SearchOption DB 0
AdminPIN DB 5 DUP(0)
DiscountApplied DB 0
CurrentPrice DW 0
TempTotal DW 0
LastItemPrice DW 0

.CODE

;  MACRO FOR DISPLAYING STRINGS 
PrintString MACRO StringAddr
    MOV DX, OFFSET StringAddr
    MOV AH, 9
    INT 21H
ENDM

;  MACRO FOR PRINTING NEW LINES 
NewLine MACRO
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
ENDM

;  MACRO FOR INPUT 
GetInput MACRO
    MOV AH, 1
    INT 21H
    SUB AL, '0'
ENDM

;  PROCEDURE TO DISPLAY PRICE WITH MULTI-DIGIT DIVISION 
PrintNumber PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX, 10
    MOV CX, 0
    
DivideLoop:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNZ DivideLoop
    
PrintLoop:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PrintLoop
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PrintNumber ENDP

;  MAIN PROCEDURE 
Main PROC
    MOV AX, @DATA
    MOV DS, AX
    
    PrintString WelcomeMsg
    
MainLoop:
    PrintString MainMenu
    GetInput
    MOV UserChoice, AL
    
    CMP AL, 1
    JE BrowseProducts
    CMP AL, 2
    JE ViewCart
    CMP AL, 3
    JE SearchProducts
    CMP AL, 4
    JE RateExperience
    CMP AL, 5
    JE AdminAccess
    CMP AL, 6
    JE ExitProgram
    
    PrintString InvalidInput
    JMP MainLoop
    
BrowseProducts:
    CALL CategorySelection
    JMP MainLoop
    
ViewCart:
    CALL CheckoutProcess
    JMP MainLoop
    
SearchProducts:
    CALL SearchProduct
    JMP MainLoop
    
RateExperience:
    CALL CustomerRating
    JMP MainLoop
    
AdminAccess:
    CALL ViewDailyReport
    JMP MainLoop
    
ExitProgram:
    PrintString ExitMsg
    MOV AH, 4CH
    INT 21H
    
Main ENDP

;  CATEGORY SELECTION & PRODUCT DISPLAY 
CategorySelection PROC
    NewLine
    PrintString CategoryMenu
    GetInput
    MOV CategoryChoice, AL
    
    CMP AL, 1
    JE ShowStaples
    CMP AL, 2
    JE ShowSpices
    CMP AL, 3
    JE ShowDairy
    CMP AL, 4
    JE ShowDryFoods
    
    PrintString InvalidInput
    RET
    
ShowStaples:
    PrintString StaplesProducts
    CALL AddToCart
    RET
    
ShowSpices:
    PrintString SpicesProducts
    CALL AddToCart
    RET
    
ShowDairy:
    PrintString DairyProducts
    CALL AddToCart
    RET
    
ShowDryFoods:
    PrintString DryFoodsProducts
    CALL AddToCart
    RET
    
CategorySelection ENDP

;  ADD  TO CART 
AddToCart PROC
AddItemLoop:
    PrintString AddItemPrompt
    GetInput
    MOV ItemNumber, AL
    
    ; Validate item number is between 1-3
    CMP AL, 1
    JL InvalidItemNum
    CMP AL, 3
    JG InvalidItemNum
    
    ; Store item in cart
    MOV AL, CartCount
    INC AL
    MOV CartCount, AL
    
    ; Get price based on category n item
    CALL CalculatePrice
    
    ; Store current price in CartPrices array (use CartCount-1 as index)
    MOV AL, CartCount
    DEC AL
    SUB AH, AH
    MOV SI, AX
    SHL SI, 1               ; Multiply by 2 (word is 2 bytes)
    LEA BX, CartPrices
    MOV AX, CurrentPrice
    MOV [BX + SI], AX
    
    ; Store last item price for  removal when needed
    MOV AX, CurrentPrice
    MOV LastItemPrice, AX
    
    PrintString ItemAddedMsg
    
    ; Update cart total
    MOV AX, CartTotal
    ADD AX, CurrentPrice
    MOV CartTotal, AX
    
    PrintString CurrentTotal
    MOV AX, CartTotal
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 'T'
    INT 21H
    MOV DL, 'K'
    INT 21H
    NewLine
    
    RET

InvalidItemNum:
    PrintString InvalidInput
    JMP AddItemLoop
    
AddToCart ENDP

;  CALCULATE PRICE 
CalculatePrice PROC
    MOV AX, 0
    
    CMP CategoryChoice, 1
    JE GetStaplesPrice
    CMP CategoryChoice, 2
    JE GetSpicesPrice
    CMP CategoryChoice, 3
    JE GetDairyPrice
    CMP CategoryChoice, 4
    JE GetDryFoodsPrice
    
    RET
    
GetStaplesPrice:
    LEA BX, StaplesPrices
    MOV AL, ItemNumber
    SUB AH, AH
    MOV SI, AX
    DEC SI
    MOV AL, [BX + SI]
    SUB AH, AH
    MOV CurrentPrice, AX
    RET
    
GetSpicesPrice:
    LEA BX, SpicesPrices
    MOV AL, ItemNumber
    SUB AH, AH
    MOV SI, AX
    DEC SI
    MOV AL, [BX + SI]
    SUB AH, AH
    MOV CurrentPrice, AX
    RET
    
GetDairyPrice:
    LEA BX, DairyPrices
    MOV AL, ItemNumber
    SUB AH, AH
    MOV SI, AX
    DEC SI
    MOV AL, [BX + SI]
    SUB AH, AH
    MOV CurrentPrice, AX
    RET
    
GetDryFoodsPrice:
    LEA BX, DryFoodsPrices
    MOV AL, ItemNumber
    SUB AH, AH
    MOV SI, AX
    DEC SI
    MOV AL, [BX + SI]
    SUB AH, AH
    MOV CurrentPrice, AX
    RET
    
CalculatePrice ENDP

;  CHECKOUT & DISCOUNT  
CheckoutProcess PROC
    CMP CartCount, 0
    JE EmptyCart
    
    NewLine
    PrintString DiscountMenu
    MOV AX, CartTotal
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 'T'
    INT 21H
    MOV DL, 'K'
    INT 21H
    NewLine
    
RemoveLoop:
    ; Ask if wants to remove last item
    PrintString RemovePrompt
    MOV AH, 1
    INT 21H
    CMP AL, 'Y'
    JE RemoveLastItem
    CMP AL, 'y'
    JE RemoveLastItem
    JMP SkipRemove
    
RemoveLastItem:
    CMP CartCount, 0
    JLE SkipRemove              ; Can't remove if cart is empty
    
    ; Get price of last item from CartPrices array
    MOV AL, CartCount
    SUB AH, AH
    MOV SI, AX
    DEC SI
    SHL SI, 1                   ; Multiply by 2 (word is 2 bytes)
    LEA BX, CartPrices
    MOV AX, [BX + SI]
    MOV LastItemPrice, AX
    
    ; Remove last item
    MOV AX, CartTotal
    SUB AX, LastItemPrice
    MOV CartTotal, AX
    MOV AL, CartCount
    DEC AL
    MOV CartCount, AL
    
    PrintString ItemRemovedMsg
    MOV AX, CartTotal
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 'T'
    INT 21H
    MOV DL, 'K'
    INT 21H
    NewLine
    
    ; Check if cart is now empty after this removal
    CMP CartCount, 0
    JE SkipRemove
    
    ; Ask again if they want to remove another item
    JMP RemoveLoop
    
SkipRemove:
    ; Check if cart is now empty after removals
    CMP CartCount, 0
    JE CartNowEmpty
    
    ; Check discount eligibility (min 500 TK)
    CMP CartTotal, 500
    JL SkipDiscount
    
    PrintString EligibleDiscount
    CALL GetDiscountCode
    
SkipDiscount:
    NewLine
    PrintString PaymentMenu
    GetInput
    
    CMP AL, 1
    JE CashPayment
    CMP AL, 2
    JE CashOnDelivery
    
    PrintString InvalidInput
    RET
    
CashPayment:
    PrintString CashPaid
    MOV AL, TransactionCount
    INC AL
    MOV TransactionCount, AL
    MOV AX, CartTotal
    ADD TotalRevenue, AX
    MOV CartCount, 0
    MOV CartTotal, 0
    MOV DiscountApplied, 0
    RET
    
CashOnDelivery:
    PrintString COD
    MOV AL, TransactionCount
    INC AL
    MOV TransactionCount, AL
    MOV AX, CartTotal
    ADD TotalRevenue, AX
    MOV CartCount, 0
    MOV CartTotal, 0
    MOV DiscountApplied, 0
    RET
    
EmptyCart:
    PrintString InvalidInput
    RET
    
CartNowEmpty:
    PrintString CartEmptyMsg
    MOV CartCount, 0
    MOV CartTotal, 0
    RET
    
CheckoutProcess ENDP

;  GET DISCOUNT CODE 
GetDiscountCode PROC
    MOV CX, 4
    LEA BX, DiscountCode
    
ReadCode:
    MOV AH, 1
    INT 21H
    MOV [BX], AL
    INC BX
    LOOP ReadCode
    
    ; Check if code matches
    MOV SI, OFFSET DiscountCode
    MOV DI, OFFSET ValidCode
    MOV CX, 4
    
CompareCode:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE InvalidCodeEntered
    INC SI
    INC DI
    LOOP CompareCode
    
    ; Valid apply 10% discount
    MOV DiscountApplied, 1
    PrintString ValidDiscount
    MOV AX, CartTotal
    MOV DX, 0
    MOV BX, 10
    DIV BX
    SUB CartTotal, AX
    ; Display final total after discount
    MOV AX, CartTotal
    CALL PrintNumber
    PrintString TKLabel
    RET
    
InvalidCodeEntered:
    PrintString InvalidDiscount
    RET
    
GetDiscountCode ENDP

;  SEARCH  
SearchProduct PROC
    NewLine
    PrintString SearchMenu
    GetInput
    MOV SearchOption, AL
    
    CMP AL, 1
    JE SearchByLetter
    CMP AL, 2
    JE SearchByCategory
    
    PrintString InvalidInput
    RET
    
SearchByLetter:
    PrintString LetterPrompt
    MOV AH, 1
    INT 21H
    MOV ItemNumber, AL
    ; Search for products starting with letter raw input
    CMP AL, 'R'
    JE ShowRice
    CMP AL, 'r'
    JE ShowRice
    CMP AL, 'F'
    JE ShowFlour
    CMP AL, 'f'
    JE ShowFlour
    CMP AL, 'S'
    JE ShowSugar
    CMP AL, 's'
    JE ShowSugar
    CMP AL, 'M'
    JE ShowMilk
    CMP AL, 'm'
    JE ShowMilk
    CMP AL, 'T'
    JE ShowTurmeric
    CMP AL, 't'
    JE ShowTurmeric
    CMP AL, 'C'
    JE ShowChili
    CMP AL, 'c'
    JE ShowChili
    CMP AL, 'Y'
    JE ShowYogurt
    CMP AL, 'y'
    JE ShowYogurt
    CMP AL, 'U'
    JE ShowYogurt
    CMP AL, 'u'
    JE ShowYogurt
    CMP AL, 'L'
    JE ShowLentils
    CMP AL, 'l'
    JE ShowLentils
    CMP AL, 'B'
    JE ShowBeans
    CMP AL, 'b'
    JE ShowBeans
    PrintString NoMatch
    JMP SearchAgainPrompt
    
ShowRice:
    MOV CategoryChoice, 1
    PrintString StaplesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowFlour:
    MOV CategoryChoice, 1
    PrintString StaplesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowSugar:
    MOV CategoryChoice, 1
    PrintString StaplesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowMilk:
    MOV CategoryChoice, 3
    PrintString DairyProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowTurmeric:
    MOV CategoryChoice, 2
    PrintString SpicesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowChili:
    MOV CategoryChoice, 2
    PrintString SpicesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowYogurt:
    MOV CategoryChoice, 3
    PrintString DairyProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowLentils:
    MOV CategoryChoice, 4
    PrintString DryFoodsProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowBeans:
    MOV CategoryChoice, 4
    PrintString DryFoodsProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
SearchByCategory:
    PrintString CategoryMenu
    GetInput
    MOV CategoryChoice, AL
    CMP AL, 1
    JE ShowSearchStaples
    CMP AL, 2
    JE ShowSearchSpices
    CMP AL, 3
    JE ShowSearchDairy
    CMP AL, 4
    JE ShowSearchDry
    
    PrintString InvalidInput
    RET
    
ShowSearchStaples:
    MOV CategoryChoice, 1
    PrintString StaplesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowSearchSpices:
    MOV CategoryChoice, 2
    PrintString SpicesProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowSearchDairy:
    MOV CategoryChoice, 3
    PrintString DairyProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
ShowSearchDry:
    MOV CategoryChoice, 4
    PrintString DryFoodsProducts
    CALL AddToCart
    JMP SearchAgainPrompt
    
SearchAgainPrompt:
    PrintString SearchAgain
    MOV AH, 1
    INT 21H
    CMP AL, 'Y'
    JE SearchProduct
    CMP AL, 'y'
    JE SearchProduct
    RET
    
SearchProduct ENDP

;  CUSTOMER RATING 
CustomerRating PROC
    PrintString RatingMenu
    MOV AH, 1
    INT 21H
    SUB AL, '0'
    MOV ItemNumber, AL
    
    CMP AL, 1
    JL InvalidRating
    CMP AL, 5
    JG InvalidRating
    
    ; Store rating
    LEA BX, Ratings
    MOV AL, RatingCount
    SUB AH, AH
    MOV SI, AX
    MOV AL, ItemNumber
    MOV [BX + SI], AL
    INC RatingCount
    
    PrintString RatingStored
    CALL CalculateAverageRating
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 's'
    INT 21H
    MOV DL, 't'
    INT 21H
    MOV DL, 'a'
    INT 21H
    MOV DL, 'r'
    INT 21H
    MOV DL, 's'
    INT 21H
    NewLine
    
    RET
    
InvalidRating:
    PrintString InvalidInput
    RET
    
CalculateAverageRating PROC
    MOV AX, 0
    MOV DX, 0
    MOV BL, RatingCount
    
    CMP BL, 0
    JE NoRatings
    
    LEA BX, Ratings
    MOV SI, 0
    MOV CX, 0
    MOV CL, RatingCount
    
SumRatings:
    ADD AL, [BX + SI]
    INC SI
    CMP SI, CX
    JL SumRatings
    
    MOV CX, 0
    MOV CL, RatingCount
    MOV DX, 0
    DIV CL
    MOV AH, 0
    
    RET
    
NoRatings:
    MOV AX, 0
    RET
    
CalculateAverageRating ENDP

;  VIEW DAILY REPORT 
ViewDailyReport PROC
    NewLine
    PrintString ReportPINPrompt
    
    MOV CX, 4
    LEA BX, ReportPIN
    
ReadReportPIN:
    MOV AH, 1
    INT 21H
    MOV [BX], AL
    INC BX
    LOOP ReadReportPIN
    
    ; Check PIN
    MOV SI, OFFSET ReportPIN
    MOV DI, OFFSET ValidReportPIN
    MOV CX, 4
    
CheckReportPIN:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE WrongReportPINEntered
    INC SI
    INC DI
    LOOP CheckReportPIN
    
    ; PIN correct show report
    NewLine
    PrintString AdminPrompt
    NewLine
    
    PrintString ReportTxn
    MOV AL, TransactionCount
    SUB AH, AH
    MOV AX, 0
    MOV AL, TransactionCount
    CALL PrintNumber
    NewLine
    
    PrintString ReportRevenue
    MOV AX, TotalRevenue
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 'T'
    INT 21H
    MOV DL, 'K'
    INT 21H
    NewLine
    
    PrintString ReportAvgRating
    CMP RatingCount, 0
    JE NoRatingData
    CALL CalculateAverageRating
    CALL PrintNumber
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, 's'
    INT 21H
    MOV DL, 't'
    INT 21H
    MOV DL, 'a'
    INT 21H
    MOV DL, 'r'
    INT 21H
    MOV DL, 's'
    INT 21H
    NewLine
    JMP ShowRaters
    
NoRatingData:
    PrintString InvalidInput
    NewLine
    
ShowRaters:
    PrintString ReportRaters
    MOV AL, RatingCount
    SUB AH, AH
    MOV AX, 0
    MOV AL, RatingCount
    CALL PrintNumber
    NewLine
    
    RET
    
WrongReportPINEntered:
    PrintString WrongReportPIN
    RET
    
ViewDailyReport ENDP

END Main
