
/*--------------------------------------------------------------------*/
/* decomment.c                                                        */
/* Author: Nickolas Casalinuovo                                       */
/*--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
/*--------------------------------------------------------------------*/
/* Function declarations */
/*--------------------------------------------------------------------*/

static int isAccepted(int iState, int lineCount);
static int changeState(int iState, int *lineCount, int iChar);

/*--------------------------------------------------------------------*/
/* Function definitions */
/*--------------------------------------------------------------------*/

/* Read two positive integers from stdin. Return EXIT_FAILURE if stdin
contains bad data. Otherwise compute the greatest common divisor
and least common multiple of the two positive integers, write those
two values to stdout, and return 0. */
    
int main(void){

   
   int inputChar;
   int currentState = 0;
   int lineCount = 1;
   int lastState;
   
   while((inputChar=getchar())!=EOF){
      lastState = currentState;
      /*printf("pastState: %d \n",currentState);*/
      currentState = changeState(currentState,&lineCount,inputChar);
      /*printf("char: %c ", inputChar);
        printf("newState: %d ",currentState); */
      if(lastState==1 && currentState!=4){
         printf("/%c",inputChar);
      }
      
      if(currentState != 3 && currentState != 4 && currentState != 1){
         if(lastState != 3){printf("%c",inputChar);}
         else{printf(" ");}
      }
      
   }            
   printf("Total Lines: %d",lineCount);
   isAccepted(currentState, lineCount);
   return 0;
}
   


int changeState(int iState,int *lineCount, int iChar){
   if(iChar == '\n'){*lineCount+=1;}
   
   
   if(iState == 0){
      if(iChar==(char)'/'){iState = 1;}
      else{iState = 2;}
   }
   else if(iState == 2){
      if(iChar==(char)'/'){iState = 1;}
      if(iChar==(char)'\'' || iChar==(char)'\"'){iState = 5;}
      if(iChar==(char)'\\'){iState = 6;}
   }
   else if(iState == 1){
      if(iChar==(char)'*'){iState = 4;}
      else{iState = 2;}
   }
   else if(iState == 3){
      if(iChar==(char)'/'){iState =2;}
      else{iState = 4;}
   }
   else if(iState == 4){
      if(iChar==(char)'*'){iState=3;}
   }
   else if(iState == 5){
      if(iChar==(char)'\'' || iChar==(char)'\"'){iState=2;}
      else{iState=5;}
   }
   else if(iState==6){
      if(iChar==(char)'*'){iState=4;}
      if(iChar==(char)'/'){iState=1;}
      else{iState=2;}
   }
   
   return iState;
}

int isAccepted(int iState, int lineCount){
   if(iState == 0 || iState == 1 || iState  == 2){
      printf("SUCCESS: %d",iState);
      exit(EXIT_SUCCESS);
   }
   else{
      fprintf(stderr,"Line %d: Unterminated Comment.",lineCount);
      exit(EXIT_FAILURE);}
}
