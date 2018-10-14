const ASCII = [" ","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",
  "0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?","@",
  "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q",
  "R","S","T","U","V","W","X","Y","Z","[","~","]","^","_","a","b","c",
  "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t",
  "u","v","w","x","y","z","{","}"];

class Brainfuck {

  constructor(file, memorySize, pointers) {
    this.text = file;
    this.pointers = (pointers || new Array(memorySize).fill(0));
    this.pointer = 3;
    this.position = 0;
    this.memorySize = (memorySize || 20);
    this.loops = 0;
    this.loopStart = [];
  }

  toString() {
    let content = "";
    let p = this.pointer;
    let l = this.pointers.length - 1;

    this.pointers.forEach((v, i) => content += (p === i ? ("*" + (v.toString()) + "*") : v.toString()) + (i < l ? ", " : ""));
    return "[" + content + "]";
  }

  nextToken() {
    let char = this.text[this.position++];
    return char;
  }

  jumpLoop() {
    let char = this.text[this.position];
    let amout = 0;

    if (char !== "[") {
      return
    }

    while (this.position < this.text.length) {
      this.position++;
      char = this.text.charAt(this.position);

      if (char === "]") {
        amout--;

        if (amout < 0) {
          this.position++;
          break;
        }
      } else if (char === "[") {
        amout++;
      }
    }
  }

  parseToken() {
    let char = this.nextToken();

    /* Assigment */
    if (char === "+") {this.pointers[this.pointer]++;}
    else if (char === "-") {this.pointers[this.pointer]--;}
    else if (char === ",") {this.pointers[this.pointer] = 10;}

    /* Change pointers */
    if (char === "<") {this.pointer = Math.max(this.pointer - 1, 0);}
    else if (char === ">") {this.pointer = Math.min(this.pointer + 1, this.memorySize);}

    /* Control */
    if (char === "[") {

      if (this.pointers[this.pointer] !== 0) {
        this.loops++;
        this.loopStart.push(this.position);
      } else {
        this.jumpLoop();
      }
    } else if (char === "]") {
      if (this.pointers[this.pointer] === 0) {
        this.loops--;
        this.loopStart.pop();
      } else {
        this.position = this.loopStart[this.loopStart.length - 1];
      }
    }

    if (char === ".") {console.log("[BF]: " + ASCII[this.pointers[this.pointer]]);}
  }

  parse() {
    while (this.position < this.text.length) {
      this.parseToken();
    }
  }
}

(function() {
  let cmd = ">>,[<++++>-],<.>[<<+>+++>-]<--.<---[>+<-]>..+++.>.,+[>+++++<-]>.[-]<<.+++.<,[>-<--]>-.++>,[<->-]<.[-]<<<<+.-"; // prints "Hello World!"
  let parser = new Brainfuck(cmd, 10);


  // ASCII.forEach((v, i) => console.log(i + ": \"" + v + "\""));

  parser.parse();
  console.log("[EXTRA]: ", parser.toString());
})();
