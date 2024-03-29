.data

    ROK: .word 2, 3, 4, 5, 6, 2, 3, 4, 5, 6
    R0:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    V0:  .word 1, 2, 3, 4, 5, 1, 2, 3, 4, 5
    V1:  .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1


.text

    main:
      la $a0 R0
      la $a1 V0
      la $a2 V1
      li $a3 10

      jal addv_1

      jal seqv_1

      jal addv_1_test1



    addv_1:   bge $a3 $0 continue1
              li $a0 -1
              jr $ra

  continue1:  lw $t0 ($a0) # Result Vector (R0)
              lw $t1 ($a1) # V0
              lw $t2 ($a2) # V1

              li $t6 0 # COUNTER FOR LOOP (i)
              li $t7 4 # OFFSET TO ITERATE THROUGH THE ARRAY
              li $t8 1 # STEP TO BE ADDED TO THE COUNTER EACH ITERATION

       for1:  bge $t6 $a3 end1

              lw $t3 ($t0) # R0[x]
              lw $t4 ($t1) # V0[x]
              lw $t5 ($t2) # V1[x]

              add $t3 $t4 $t5 # R0[x] = V0[x]+V1[x]

              sw $t3 ($t0)

              add $t0 $t0 $t7 # R0[x+1]
              add $t1 $t1 $t7 # V0[x+1]
              add $t2 $t2 $t7 # V1[x+1]

              add $t6 $t6 $t8 #i++

              b for1

        end1: jr $ra

      seqv_1: bge $a3 $0 continue2
              li $a0 -1
              jr $ra

   continue2: lw $t0 ($a1) # V0
              lw $t1 ($a2) # V1

              li $t4 0 # COUNTER FOR LOOP (i)
              li $t5 4 # OFFSET TO ITERATE THROUGH THE ARRAY
              li $t6 1 # STEP TO BE ADDED TO THE COUNTER EACH ITERATION

        for2: bge $t4 $a3 end2

              lw $t2 ($t0) # V0[x]
              lw $t3 ($t1) # V1[x]

              bne $t2 $t3 else2

              add $t0 $t0 $t5 # V0[x+1]
              add $t1 $t1 $t5 # V1[x+1]

              add $t4 $t4 $t6 #i++

              b for2

        end2: li $a0 1
              jr $ra

       else2: li $a0 0
              jr $ra



addv_1_test1: li $s0 100 # LOOP LIMIT
              li $s1 0 # COUNTER FOR LOOP (i)
              li $s2 1 # STEP TO BE ADDED TO THE COUNTER EACH ITERATION
              li $s3 4 # OFFSET

        for3: bge $s1 $s0 end3

              sub $sp $sp $s3
              sw $ra ($sp)

              la $a0 R0
              la $a1 V0
              la $a2 V1
              li $a3 10

              jal addv_1

              lw $ra ($sp)
              add $sp $sp $s3

              add $s1 $s1 $s2

              b for3
        end3: jr $ra



addv_2_test2: # (TODO: procedure addv_2_test2)
              #
              # for (i=0; i<100; i++)
              #      addv_2 R0 V0 V1 10
              #

              jr $ra
