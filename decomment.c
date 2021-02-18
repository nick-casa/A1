/*--------------------------------------------------------------------*/
/* decomment.c                                                        */
/* Author: Nickolas Casalinuovo                                       */
/*--------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

/*--------------------------------------------------------------------*/
/* Function declarations */
/*--------------------------------------------------------------------*/


/* enum that holds all states */
enum Statetype {START, MAYBECOMMENT, MAYBENOTCOMMENT, INCOMMENT, 
   INCHAR, INLITERAL, RETURNSTRING, RETURNCHAR};

/* enum with pointers to control error handling */
enum Statetype handleMaybeNotCommentState(int c, 
   int *lineDifferenceCount, int *lineCount);

/* Declaration of state enums */
enum Statetype handleStartState(int c);
enum Statetype handleMaybeCommentState(int c);
enum Statetype handleInCommentState(int c);
enum Statetype handleInCharState(int c);
enum Statetype handleInLiteralState(int c);
enum Statetype handleReturnStringState(int c);
enum Statetype handleReturnCharState(int c);
enum Statetype handleStartState(int c);

/*--------------------------------------------------------------------*/
/* Function definitions */
/*--------------------------------------------------------------------*/

/*----------------------------------------------------------------------
   decomment.c takes in standard input in the form of a series of 
   chars, which it reads. It is designed to read programs, more 
   specifically. After reading the chars, the series of chars
   go through a DFA to remove comments. If the user input a 
   valid program with all comments closed, this function will return 0
   along with the series of chars, removing all comments. If there are
   unclosed comments, the program will return 1 (error) with a code
   specifying which line started the unclosed comment. 
----------------------------------------------------------------------*/

int main(void){
   
   /*--------------------- initiate variables ---------------------*/
   /* int that holds input char */
   int c;
   /* char that holds the last char input */
   char lastChar;
   /* int that tracks line count */
   int lineCount = 1;
   /* int that holds difference between current point 
   and where the line count stopped */
   int lineDifferenceCount = 0;
   
   /* enums of Statetype to hold current and last state */
   enum Statetype state = START;
   enum Statetype lastState = START;

   /* Read characters while input is not exhausted */

   while ((c = getchar()) != EOF){ 
      /* set previous conditions */
      lastChar = (char)c;
      lastState = state;
      
      /* switch that controls DFA */
      switch (state){ 
         case START:
            state = handleStartState(c);
            break;
         case MAYBECOMMENT:
            state = handleMaybeCommentState(c);
            break;
         case MAYBENOTCOMMENT:
            /* create a new line if there is 
            a new line within a comment */
            if((char)c=='\n'){printf("%c",'\n');}
            state = handleMaybeNotCommentState(c,
               &lineDifferenceCount,&lineCount);
            break;
         case INCOMMENT:
            /* create a new line if there is 
            a new line within a comment */
            if((char)c=='\n'){printf("%c",'\n');}
            state = handleInCommentState(c);
            break;
         case INCHAR:
            state = handleInCharState(c);
            break;
         case INLITERAL:
            state = handleInLiteralState(c);
            break;
         case RETURNSTRING:
            state = handleReturnStringState(c);
            break;
         case RETURNCHAR:
            state = handleReturnCharState(c);
            break;
      }

      /* increment the counter when not in a comment*/
      if((char)c == '\n' && (state!=INCOMMENT)){
         lineCount+=1; 
      }
      /*increment the line difference counter 
      when not in a comment*/
      else if((char)c == '\n' && state==INCOMMENT){
         lineDifferenceCount+=1; 
      }
      /*Output valid characters*/
      if((state==START || state==INLITERAL || state==INCHAR) && 
         lastState!=MAYBENOTCOMMENT){
         printf("%c",(char)c);
      }

   /* final character handling */
   }
   if(state==MAYBECOMMENT){printf("%c",'/');   
   }
   else if(state==RETURNSTRING||state==RETURNCHAR){printf("%c",lastChar);   
   }
   
   /* error handling */
   if(state==INCOMMENT||state==MAYBENOTCOMMENT){
      fprintf(stderr,"Error: line %i: unterminated comment\n",lineCount);
      exit(EXIT_FAILURE);
   }
   else{
      exit(EXIT_SUCCESS);   
   }
   return 0;
   
}
   
/* enum that controls the flow of the start state */
enum Statetype handleStartState(int c){ 
   enum Statetype state;
   if ((char)c=='/'){ 
      state = MAYBECOMMENT;
   }
   else if ((char)c=='\''){ 
      state = INCHAR;
   }
   else if ((char)c=='\"'){ 
      state = INLITERAL;
   }
   else{ 
      state = START;
   }
   return state;
}
/* enum that controls the flow of the maybe comment state */
/* controls printing necessary (/) slashes */
enum Statetype handleMaybeCommentState(int c){ 
   enum Statetype state;
   if ((char)c=='*'){ 
      printf(" ");
      state = INCOMMENT;
   }
   else if ((char)c=='/'){ 
      state = MAYBECOMMENT;
      printf("/");
   
   }
   else if ((char)c=='\''){ 
      state = INCHAR;
      printf("/");
   }
   else if ((char)c=='\"'){ 
      state = INLITERAL;
      printf("/");
   }
   else{ 
      printf("/");
      state = START;
   }
   return state;
}

/* enum that controls the flow of the in comment state */
enum Statetype handleInCommentState(int c){ 
   enum Statetype state;
   if ((char)c=='*'){ 
      state = MAYBENOTCOMMENT;
   }
   else{ 
      state = INCOMMENT;
   }
   return state;
}

/* enum that controls the flow of the maybe no comment state */
/* controls error handling with pointers */
enum Statetype handleMaybeNotCommentState(int c, 
   int *lineDifferenceCount, int *lineCount){ 
   enum Statetype state;
   if ((char)c=='*'){ 
      state = MAYBENOTCOMMENT;
   }
   else if ((char)c=='/'){ 
      *lineCount = *lineCount+*lineDifferenceCount;
      *lineDifferenceCount=0;
      state = START;
   }
   else{ 
      state = INCOMMENT;
   }
   return state;
}

/* enum that controls the flow of the in char state */
enum Statetype handleInCharState(int c){ 
   enum Statetype state;
   if ((char)c=='\\'){ 
      state = RETURNCHAR;
   }
   else if ((char)c=='\''){ 
      state = START;
   }
   return state;
}
/* enum that controls the flow of the in literal state */
enum Statetype handleInLiteralState(int c){ 
   enum Statetype state;
   if ((char)c=='\\'){ 
      state = RETURNSTRING;
   }
   else if ((char)c=='\"'){ 
      state = START;
   }
   return state;
}
/* enum that controls the flow of the return char state */
enum Statetype handleReturnCharState(int c){ 
   enum Statetype state = INCHAR;
   printf("%c",'\\');
   return state;
}

/* enum that controls the flow of the return string state */
enum Statetype handleReturnStringState(int c){ 
   enum Statetype state = INLITERAL;
   printf("%c",'\\');
   return state;
}

