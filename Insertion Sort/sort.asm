 .386
.model flat
.code
public _sort
_sort proc

	;The registers are initialised below
	;reg ecx -> i
	;reg edx -> length
	;reg ebx -> j
	;reg esi -> address of A[0]
			
	push ebp											;push ebp to the stack
	mov ebp, esp										;points esp to ebp
	mov esi,[ebp+8]										;esi <- &buffer[0]
	mov	edx,[ebp+12]									;edx <- length
	mov	ecx,1											;  i <- 1

	;Below is the outer while loop 
	Outerloop:	cmp	ecx,edx								;while i < length(A)
				jae	finished							; jump if ecx is greater than or equal to edx 
				mov edi,ecx								; j <- i

		;The inner while loop 
		Innerloop:	cmp	edi,0							;check if J>0
					jle	exitInnerLoop					;jump short if less or equal,moves execution to the exitInnerLoop
			
					mov al, [esi + edi - 1]				;AL <- A[j-1]
					mov ah, [esi + edi]					;AH <- A[j]
					
					bt eax,5							;bit test the least significant fifth bit for lowercase
					jae	zeroFirst						;if the bit is 0 then jump to zeroFirst, that is, it checks if the C flag=0
								
														;1 and 0/1, this is executed if AL is lowercase and AH is an upper/lower case 											
					check:	bt eax,13					;bit test the most significant 2nd bit of the eax register 
							jae	swap					;if it is 0 then jump to swap else comapre if AH is greater than AL
							cmp ah,al					;This line will excute if AL and AH are lower case characters (i.e. 1 and 1)
							ja	exitInnerLoop			;if AH > AL then jump to exitInnerLoop
							jmp doSwap					;if AH < AL jump to doSwap
							
														;This will be executed if AL is lowercase and AH is uppercase (i.e. 1 and 0)		
					swap:	mov	bl,al					;moves AL into a temporary register BL
							sub	bl,20H					;subtracts 32 from BL  
							cmp ah,bl					;compares AH with AL
							ja	exitInnerLoop			;if AH > BL jump to exitInnerLoop
							jmp doSwap					;if AH < BL jump to doSwap

														;This is executed if AL is uppercase and AH is upper/lowercase (i.e. 0 and 1/0)
				zeroFirst:	bt eax,13					;bit test the most significant 2nd bit of the eax register 
							jae	compare					;if it is 0 then jump to comp
							mov bh,al					;this is executed if AL is uppercase and AH is lowercase i.e. (0 and 1)
							add	bh,20H					;adds 32 to BH after moving AL into it
							cmp	ah,bh					;compares AH with BH
							ja	exitInnerLoop			;if AH > BH jump to exitInnerLoop
							jmp doSwap					;if AH < BH jump to doSwap
														
				compare:	cmp ah,al					;compares AH and AL			
							ja	exitInnerLoop			;jump if AH > AL
						
					doSwap:	mov	[esi + edi - 1],ah		;swap A[j] with A[j-1]
							mov [esi + edi], al			;swap A[j-1] with A[j]
							sub	edi,1					;j = j-1, decrements j
							jmp Innerloop				;continues the inner loop

		exitInnerLoop:	add	ecx,1						;i=i+1, increments i		
						jmp Outerloop					;continues the outer loop

	finished:	pop ebp									;pops ebp off the stack		
				ret 0									;returns 0 at the end

				

_sort endp
end


;mov [esi+edi],0
