import std.stdio;
import std.conv;

class Token {
   string type;
   string value;

   this(string type, string value) {
      this.type = type;
      this.value = value;
   }

   void print() {
      writeln("<" ~ type ~ ": " ~ value ~ ">");
   }
}

void print(Token[] ts) {
   foreach(i, t; ts) {
      write("["~ to!string(i) ~"]: ");
      t.print();
   }
}
