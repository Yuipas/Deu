import std.conv;
import token, tokenTypes;

alias tTypes = tokenTypes;

class AST {
   this() {}

   float solve() {return 0;}
}

class ASTBinOperator : AST {

   AST leftBranch;
   AST rightBranch;
   Token token;

   this(AST lb, AST rb, Token t) {
      super();

      leftBranch = lb;
      rightBranch = rb;
      token = t;
   }

   override float solve() {
      auto left = leftBranch.solve();
      auto right = rightBranch.solve();

      switch(token.type) {
         case tTypes.PLUS: return left + right;
         case tTypes.MINUS: return left - right;
         case tTypes.MULT: return left * right;
         case tTypes.DIV: return left / right;
         default: assert(0);
      }
   }
}

class ASTNumber : AST {

   Token token;
   float value;

   this(Token token) {
      this.token = token;
      this.value = to!float(token.value);
   }

   override float solve() {
      return value;
   }
}
