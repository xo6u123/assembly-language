.data
str1: .string "Please enter the strokes of the second character of the last name="
str5: .string "Please enter the strokes of the first character of the last name="
str3: .string "Please enter the strokes of the first character of the first name ="
str4: .string "Please enter the strokes of the second character of the first name ="
here: .string "here"

sky: .string "Sky="
people: .string "People="
land: .string "Land="
outside: .string "Outside="
total: .string "Total="

skystr: .string "Sky "
peoplestr: .string "People "
landstr: .string "Land "
outsidestr: .string "Outside "
totalstr: .string "Total "
printfstr: .string "\n"

str2: .string "s1111506\n"
wood: .string " Wood\n"
fire: .string " Fire\n"
earth: .string " Earth\n"
metal: .string " Metal\n"
water: .string " Water\n"

restraint: .string "restraint "
equal: .string "equal "
generate: .string "generate " 



.text
main:	

    li s9,0
    jal printMsg2
    jal printMsg5
    jal inputA 

    add s9,s9,a0
    beq a0,zero,addone
    
    mv s11,a0 
    
    jal printMsg1
    jal inputM    # return the result a0
    
   
    mv t0,a0
    mv s2,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printsky
    mv a0,s1
    
   
    add a0,a0,s11

    mv s5,a0
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0 
    jal printResult # printResult(a0)

    jal printMsg3
    jal inputN    # return the result a0
   
    mv t1,a0
    mv s3,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printpeople
    mv a0,s1
    
    add a0, a0, s2
    mv s6,a0 
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0
    
    jal printResult # printResult(a0)
    #block 3
    jal printMsg4
    jal inputO    # return the result a0
    
    add s9,s9,a0
    beq a0,zero,addone
    
    mv t2,a0
    mv s4,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printland
    mv a0,s1
    
   
    add a0, a0, s3
   
    mv s7,a0 #s5~s9 
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0
    mv s8,a0 #s5~s9 
    jal printResult # printResult(a0)
    
    jal printoutside
    
    add a0,s4,s11
    
    
    mv s8,a0 #s5~s9 
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0  
    jal printResult # printResult(a0)
    
    jal printtotal
   
    
    add a0,s2,s3
    add a0,a0,s9

    mv s9,a0 
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0  
    jal printResult # printResult(a0)
    
    mv a0,s5 #put s5 to a0 and identify s5 
    jal identify
    li s2,1
    li t3,2
    li t4,3
    li t5,4
    li t6,5
    #find s5~s9 is wood 
    beq a0,s2,wood_2345 #know that s5 is wood check s6~s9 if it is fire or earth or wood 
    
    mv a0,s6
    jal identify
    beq a0,s2,wood_1345
    
    mv a0,s7
    jal identify
    beq a0,s2,wood_1245
    
    mv a0,s8
    jal identify
    beq a0,s2,wood_1235
    
    mv a0,s9
    jal identify
    beq a0,s2,wood_1234
    
   #find fire 
   
   
    j end
    
wood_1234:
	addi sp,sp,-4
	sw ra,0(sp)
        
        mv a0,s5
        jal identify 
        jal printNumber
        la a0,printfstr
        li a7,4
        ecall
        mv a0,t3
        jal printNumber
      
        beq a0,t3,total_wood_generate_fire_sky
        j endcomputeWuXin
      

total_wood_generate_fire_sky:
    la a0, totalstr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, skystr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    li a0,10
    j endcomputeWuXin
        
    
    
    
wood_1235:
	addi sp,sp,-4
	sw ra,0(sp)
        	

        mv a0,s5
        jal identify #look s6 (fire?earth?wood?)
        beq a0,t3,outside_wood_generate_fire_sky
        beq a0,t4,outside_wood_restraint_earth_sky

        mv a0,s6
        jal identify #look s7 (fire?earth?wood?)
        beq a0,t3,outside_wood_generate_fire_people
        beq a0,t4,outside_wood_restraint_earth_people

        mv a0,s7
        jal identify
        beq a0,t3,outside_wood_generate_fire_land
        beq a0,t4,outside_wood_restraint_earth_land

        mv a0,s9
        jal identify
        beq a0,t3,outside_wood_generate_fire_total
        beq a0,t4,outside_wood_restraint_earth_total
        beq a0,s2,outside_wood_equal_wood_total
        j endcomputeWuXin


outside_wood_generate_fire_sky:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, skystr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
outside_wood_restraint_earth_sky:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, restraint        
    li a7, 4            # print string
    ecall
    la a0, skystr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
outside_wood_generate_fire_people:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, peoplestr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
outside_wood_restraint_earth_people:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, restraint    
    li a7, 4            # print string
    ecall
    la a0, peoplestr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret

outside_wood_generate_fire_land:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, landstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
outside_wood_restraint_earth_land:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, restraint        
    li a7, 4            # print string
    ecall
    la a0, landstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret

outside_wood_generate_fire_total:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin
outside_wood_restraint_earth_total:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, restraint
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin
outside_wood_equal_wood_total:
    la a0, outsidestr          
    li a7, 4    
    ecall       
    la a0, equal    
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin

    
  
wood_1245:
	addi sp,sp,-4
	sw ra,0(sp)
	

        mv a0,s5
        jal identify #look s6 (fire?earth?wood?)
        beq a0,t3,land_wood_generate_fire_sky
        beq a0,t4,land_wood_restraint_earth_sky
        
        mv a0,s6
        jal identify #look s7 (fire?earth?wood?)
        beq a0,t3,land_wood_generate_fire_people
        beq a0,t4,land_wood_restraint_earth_people
     
        
        mv a0,s8
        jal identify
        beq a0,t3,land_wood_generate_fire_outside
        beq a0,t4,land_wood_restraint_earth_outside
        beq a0,s2,land_wood_equal_wood_outside
        
        mv a0,s9
        jal identify
        beq a0,t3,land_wood_generate_fire_total
        beq a0,t4,land_wood_restraint_earth_total
        beq a0,s2,land_wood_equal_wood_total
        j endcomputeWuXin
        
land_wood_generate_fire_sky:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, skystr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_restraint_earth_sky:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, restraint        
    li a7, 4            # print string
    ecall
    la a0, skystr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_generate_fire_people:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, landstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_restraint_earth_people:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, restraint    
    li a7, 4            # print string
    ecall
    la a0, landstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret

land_wood_generate_fire_outside:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, outsidestr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_restraint_earth_outside:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, restraint        
    li a7, 4            # print string
    ecall
    la a0, outsidestr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_equal_wood_outside:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, equal        
    li a7, 4            # print string
    ecall
    la a0, outsidestr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    ret
land_wood_generate_fire_total:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, generate        
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin
land_wood_restraint_earth_total:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, restraint
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin
land_wood_equal_wood_total:
    la a0, landstr          
    li a7, 4    
    ecall       
    la a0, equal    
    li a7, 4            # print string
    ecall
    la a0, totalstr          
    li a7, 4            # print string
    ecall
    la a0, printfstr           
    li a7, 4            # print string
    ecall
    j endcomputeWuXin
        
        
        
        

    
    
    
    
wood_1345:
	addi sp,sp,-4
	sw ra,0(sp)
	

        mv a0,s5
        jal identify #look s6 (fire?earth?wood?)
        beq a0,t3,people_wood_generate_fire_sky
        beq a0,t4,people_wood_restraint_earth_sky
        
        mv a0,s7
        jal identify #look s7 (fire?earth?wood?)
        beq a0,t3,people_wood_generate_fire_land
        beq a0,t4,people_wood_restraint_earth_land
        beq a0,s2,people_wood_equal_wood_land
        
        mv a0,s8
        jal identify
        beq a0,t3,people_wood_generate_fire_outside
        beq a0,t4,people_wood_restraint_earth_outside
        beq a0,s2,people_wood_equal_wood_outside
        
        mv a0,s9
        jal identify
        beq a0,t3,people_wood_generate_fire_total
        beq a0,t4,people_wood_restraint_earth_total
        beq a0,s2,people_wood_equal_wood_total
        j endcomputeWuXin

        
people_wood_generate_fire_sky:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, skystr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_restraint_earth_sky:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, restraint		
	li a7, 4			# print string
	ecall
	la a0, skystr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_generate_fire_land:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_restraint_earth_land:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, restraint	
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_equal_wood_land:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, equal	
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_generate_fire_outside:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_restraint_earth_outside:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, restraint		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_equal_wood_outside:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, equal		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
people_wood_generate_fire_total:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin
people_wood_restraint_earth_total:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, restraint
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin
people_wood_equal_wood_total:
	la a0, peoplestr			
	li a7, 4	
	ecall		
	la a0, equal	
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin
    
    
    
    
    
    
    
    
wood_2345:

	addi sp,sp,-4
	sw ra,0(sp)
	

        mv a0,s6
        jal identify #look s6 (fire?earth?wood?)
        beq a0,t3,wood_generate_fire
        beq a0,t4,wood_restraint_earth
        beq a0,s2,wood_equal_wood
        
        
        mv a0,s7
        jal identify #look s7 (fire?earth?wood?)
        beq a0,t3,wood_generate_fire_land
        beq a0,t4,wood_restraint_earth_land
        beq a0,s2,wood_equal_wood_land
        
        mv a0,s8
        jal identify
        beq a0,t3,wood_generate_fire_outside
        beq a0,t4,wood_restraint_earth_outside
        beq a0,s2,wood_equal_wood_outside
        
        mv a0,s9
        jal identify
        beq a0,t3,wood_generate_fire_total
        beq a0,t4,wood_restraint_earth_total
        beq a0,s2,wood_equal_wood_total
        j endcomputeWuXin

      
        
wood_generate_fire_total:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin

wood_restraint_earth_total:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, restraint	
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin
wood_equal_wood_total:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, equal	
	li a7, 4			# print string
	ecall
	la a0, totalstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	j endcomputeWuXin
 	
 	
wood_generate_fire_outside:
        la a0, skystr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
wood_restraint_earth_outside:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, restraint		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
wood_equal_wood_outside:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, equal		
	li a7, 4			# print string
	ecall
	la a0, outsidestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
        
wood_generate_fire_land:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, generate		
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
 	
wood_restraint_earth_land:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, restraint		
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
wood_equal_wood_land:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, equal		
	li a7, 4			# print string
	ecall
	la a0, landstr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret

        
        
        
wood_equal_wood:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, equal		
	li a7, 4			# print string
	ecall
	la a0, peoplestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
 	
wood_restraint_earth:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, restraint		
	li a7, 4			# print string
	ecall
	la a0, peoplestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret

wood_generate_fire:
	la a0, skystr			
	li a7, 4	
	ecall		
	la a0, generate			
	li a7, 4			# print string
	ecall
	la a0, peoplestr			
	li a7, 4			# print string
	ecall
	la a0, printfstr			
	li a7, 4			# print string
 	ecall
 	ret
    
identify:
	mv t1,a0

	addi sp,sp,-4
	sw ra,0(sp)
	
	li t2,10
	rem t1,t1,t2
	
	blez t1,watermode #12(Wood),34(Fire),56(Earth),78(Metal),90(Water)	
	li a2,2	 
	ble t1,a2,woodmode 
	li a2,4
	ble t1,a2,firemode
	li a2,6	 
	ble t1,a2,earthmode
	li a2,8
	ble t1,a2,metalmode
	li a2,9
	ble t1,a2,watermode

watermode:
	li a0,5
	j endcomputeWuXin
woodmode:
	li a0,1
	j endcomputeWuXin
firemode:
	li a0,2
	j endcomputeWuXin
earthmode:
	li a0,3
	j endcomputeWuXin
metalmode:
	li a0,4
	j endcomputeWuXin	

	

addone:
	addi a0,a0,1
	addi s9,s9,-1
	ret
	

	
	
computeWuXin: 
	mv t1,a0

	addi sp,sp,-4
	sw ra,0(sp)
	
	li t2,10
	rem t1,t1,t2
	
	blez t1,ModeWater #12(Wood),34(Fire),56(Earth),78(Metal),90(Water)	
	li a2,2	 
	ble t1,a2,ModeWood
	li a2,4
	ble t1,a2,ModeFire
	li a2,6	 
	ble t1,a2,ModeEarth
	li a2,8
	ble t1,a2,ModeMetal
	li a2,9
	ble t1,a2,ModeWater


endcomputeWuXin: 
	lw ra,0(sp)
	addi sp,sp,4
	ret  #return (a0)

ModeWood:
	la a0,wood
	j endcomputeWuXin
	
ModeFire:
	la a0,fire
	j endcomputeWuXin

ModeEarth:
	la a0,earth
	j endcomputeWuXin

ModeMetal:
	la a0,metal
	j endcomputeWuXin

ModeWater:
	la a0,water
	j endcomputeWuXin

printResult:
	li a7, 4			# print string
 	ecall
 	ret
printNumber:
	li a7, 1			# print Number
 	ecall
 	ret
 	
inputM:
	li a7,5
	ecall
	ret
inputN:
	li a7,5
	ecall
	ret
inputO:
	li a7,5
	ecall
	ret	
inputA:
	li a7,5
	ecall
	ret	
printMsg1:
	la a0, str1			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg2:
	la a0, str2			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg3:
	la a0, str3			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg4:
	la a0, str4			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg5:
	la a0, str5			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printsky:
	la a0, sky			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printpeople:
	la a0, people			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printland:
	la a0, land			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printoutside:
	la a0, outside			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printtotal:
	la a0, total			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
end:
	li a7, 10			
 	ecall
