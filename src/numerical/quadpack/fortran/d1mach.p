      DOUBLE PRECISION FUNCTION D1MACH(I)
      INTEGER I
      INTEGER SMALL(2)
      INTEGER LARGE(2)
      INTEGER RIGHT(2)
      INTEGER DIVER(2)
      INTEGER LOG10(2)
      INTEGER SC, CRAY1(38 ), J
      COMMON /D9MACH/ CRAY1
      SAVE SMALL, LARGE, RIGHT, DIVER, LOG10, SC
      DOUBLE PRECISION DMACH(5)
      EQUIVALENCE (DMACH(1),SMALL(1))
      EQUIVALENCE (DMACH(2),LARGE(1))
      EQUIVALENCE (DMACH(3),RIGHT(1))
      EQUIVALENCE (DMACH(4),DIVER(1))
      EQUIVALENCE (DMACH(5),LOG10(1))
      DATA SC/0/
      IF (SC  ><  987 ) THEN
         DMACH(1) = 1.0D13 
         IF (      SMALL(1)  EQUAL  1117925532 AND  SMALL(2)  EQUAL  -448790528 ) THEN
            SMALL(1) = 1048576 
            SMALL(2) = 0
            LARGE(1) = 2146435071 
            LARGE(2) = -1 
            RIGHT(1) = 1017118720 
            RIGHT(2) = 0
            DIVER(1) = 1018167296 
            DIVER(2) = 0
            LOG10(1) = 1070810131 
            LOG10(2) = 1352628735 
         ELSE IF ( SMALL(2)  EQUAL  1117925532 AND  SMALL(1)  EQUAL  -448790528 ) THEN
            SMALL(2) = 1048576 
            SMALL(1) = 0
            LARGE(2) = 2146435071 
            LARGE(1) = -1 
            RIGHT(2) = 1017118720 
            RIGHT(1) = 0
            DIVER(2) = 1018167296 
            DIVER(1) = 0
            LOG10(2) = 1070810131 
            LOG10(1) = 1352628735 
         ELSE IF ( SMALL(1)  EQUAL  -2065213935 AND  SMALL(2)  EQUAL  10752 ) THEN
            SMALL(1) = 128 
            SMALL(2) = 0
            LARGE(1) = -32769 
            LARGE(2) = -1 
            RIGHT(1) = 9344 
            RIGHT(2) = 0
            DIVER(1) = 9472 
            DIVER(2) = 0
            LOG10(1) = 546979738 
            LOG10(2) = -805796613 
         ELSE IF ( SMALL(1)  EQUAL  1267827943 AND  SMALL(2)  EQUAL  704643072 ) THEN
            SMALL(1) = 1048576 
            SMALL(2) = 0
            LARGE(1) = 2147483647 
            LARGE(2) = -1 
            RIGHT(1) = 856686592 
            RIGHT(2) = 0
            DIVER(1) = 873463808 
            DIVER(2) = 0
            LOG10(1) = 1091781651 
            LOG10(2) = 1352628735 
         ELSE IF ( SMALL(1)  EQUAL  1120022684 AND  SMALL(2)  EQUAL  -448790528 ) THEN
            SMALL(1) = 1048576 
            SMALL(2) = 0
            LARGE(1) = 2147483647 
            LARGE(2) = -1 
            RIGHT(1) = 1019215872 
            RIGHT(2) = 0
            DIVER(1) = 1020264448 
            DIVER(2) = 0
            LOG10(1) = 1072907283 
            LOG10(2) = 1352628735 
         ELSE IF ( SMALL(1)  EQUAL  815547074 AND  SMALL(2)  EQUAL  58688 ) THEN
            SMALL(1) = 16 
            SMALL(2) = 0
            LARGE(1) = -32769 
            LARGE(2) = -1 
            RIGHT(1) = 15552 
            RIGHT(2) = 0
            DIVER(1) = 15568 
            DIVER(2) = 0
            LOG10(1) = 1142112243 
            LOG10(2) = 2046775455 
         ELSE
            DMACH(2) = 1.0D27 + 1
            DMACH(3) = 1.0D27 
            LARGE(2) = LARGE(2) - RIGHT(2)
            IF (LARGE(2)  EQUAL  64 AND  SMALL(2)  EQUAL  0) THEN
               CRAY1(1) = 67291416 
               DO 10 J = 1, 20 
                  CRAY1(J+1) = CRAY1(J) + CRAY1(J)
 10               CONTINUE
               CRAY1(22 ) = CRAY1(21 ) + 321322 
               DO 20 J = 22 , 37 
                  CRAY1(J+1) = CRAY1(J) + CRAY1(J)
 20               CONTINUE
               IF (CRAY1(38 )  EQUAL  SMALL(1)) THEN
                  CALL I1MCRY(SMALL(1), J, 8285 , 8388608 , 0)
                  SMALL(2) = 0
                  CALL I1MCRY(LARGE(1), J, 24574 , 16777215 , 16777215 )
                  CALL I1MCRY(LARGE(2), J, 0, 16777215 , 16777214 )
                  CALL I1MCRY(RIGHT(1), J, 16291 , 8388608 , 0)
                  RIGHT(2) = 0
                  CALL I1MCRY(DIVER(1), J, 16292 , 8388608 , 0)
                  DIVER(2) = 0
                  CALL I1MCRY(LOG10(1), J, 16383 , 10100890 , 8715215 )
                  CALL I1MCRY(LOG10(2), J, 0, 16226447 , 9001388 )
               ELSE
                  WRITE(*,9000 )
                  STOP 779 
                  END IF
            ELSE
               WRITE(*,9000 )
               STOP 779 
               END IF
            END IF
         SC = 987 
         END IF
      IF (DMACH(4)  >=  1.0D0 ) STOP 778 
      IF (I  <  1  OR  I  >  5) THEN
         WRITE(*,*) "D1MACH(I): I =",I," is out of bounds."
         STOP
         END IF
      D1MACH = DMACH(I)
      RETURN
 9000 FORMAT(/" Adjust D1MACH by uncommenting data statements"/" appropriate for your machine.")
      END
      SUBROUTINE I1MCRY(A, A1, B, C, D)
      INTEGER A, A1, B, C, D
      A1 = 16777216 *B + C
      A = 16777216 *A1 + D
      END
