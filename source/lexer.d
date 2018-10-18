import std.stdio;
import std.conv;
import std.ascii;

import token;
import tokenTypes;

int loops = 0;

alias tTypes = tokenTypes;

class Lexer {

   char[] script;
   uint position;
   char currentChar;
   Token[] tokens;

   this(string s) {
      script = s.dup; /* convert s input to dchar array */
      position = 0;
      currentChar = script[position];
   }

   bool notEOF() {
      return position < script.length;
   }

   void advance() {
      position++;
      if(notEOF()) currentChar = script[position];
      else currentChar = '\u0004';
   }

   void jumpComments() {
      /*
       * NOTE: context is not checked
       */

      /* Single line comments */
      if (currentChar == '#') do advance(); while(notEOF() && currentChar != '\n');

      /* Multi line comments */

      if (currentChar == '<' && script[position + 1] == '-' && script[position + 2] == '-') {
         do {
            advance();
            if (currentChar == '-' && script[position + 1] == '-' && script[position + 2] == '>')
               break;
         } while(notEOF());
         /* skip last '-->' symbols */
         advance();
         advance();
         advance();
      }

      if (currentChar == '-' && script[position + 1] == '-' && script[position + 2] == '-') {
         advance();
         advance();

         do {
            advance();
            if (isAlphaNum(currentChar) || currentChar == '_') continue; // solve for /[A-z_][A-z_0-9]*/
            break;
         } while(notEOF());
      }
   }

   Token lexNumber() {
      string num = "";
      while(notEOF() && isDigit(currentChar)) {
         num ~= currentChar;
         advance();
      }

      if (currentChar == '.') {
         do {
            num ~= currentChar;
            advance();
         } while(notEOF() && isDigit(currentChar));
      }
      return new Token(tTypes.NUMBER, num);
   }

   Token lexOperator() {
      string type = tTypes.UNKNOWN;
      dchar value = currentChar;

      if(value == '*') type = tTypes.MULT;
      if(value == '+') type = tTypes.PLUS;
      /* if(value == ',') type = tTypes.COMMA; */
      if(value == '-') type = tTypes.MINUS;
      /* if(value == '.') type = tTypes.DOT; */
      if(value == '/') type = tTypes.DIV;

      if (type != tTypes.UNKNOWN) advance();

      return new Token(type, to!string(value));
   }

   Token nextToken() {

      /* see ASCII table http://en.wikipedia.org/wiki/ASCII */

      while(notEOF()) {
         jumpComments();

         if(isWhite(currentChar)) {advance(); continue;} /* skip white spaces */
         if(isDigit(currentChar)) return lexNumber();
         if('*' <= currentChar && currentChar <= '/') return lexOperator();
      }

      return new Token(tTypes.EOF, "null");
   }

   void tokenize() {
      if (tokens.length == 0) tokens = [nextToken()];
      while(notEOF()) tokens ~= [nextToken()]; //this step
   }
}
