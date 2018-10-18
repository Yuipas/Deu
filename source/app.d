import std.stdio;
import token, tokenTypes;
import lexer, ast;

void main() {
	Lexer l = new Lexer("2 + 81<-- \nhey this is a comment-->\n\n#this is also a comment\n\n---this_is_also_a_comment\n\n * 2 / 4"); //"(1 + 1 / 100) * 100"); //("using std;");
	l.tokenize();
	print(l.tokens);



	/*
	auto mul_token = new Token(tokenTypes.MULT, "*");
	auto plus_token = new Token(tokenTypes.PLUS, "+");
	auto left_num = new ASTNumber(new Token(tokenTypes.NUMBER, "1"));
	auto right_num = new ASTNumber(new Token(tokenTypes.NUMBER, "1"));

	auto mul_node = new ASTBinOperator(left_num, right_num, mul_token);

	auto add_node = new ASTBinOperator(mul_node, new ASTNumber(new Token(tokenTypes.NUMBER, "1")), plus_token);

	writeln(add_node.solve());
	*/

	/*
	while(true) {
		">> ".write;
		auto line = readln();
	}
	// */
}
