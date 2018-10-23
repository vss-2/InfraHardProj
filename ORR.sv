//Modulo simples o qual recebe como entrada 2 valores (PCWrite e and_out) e sua saida e o XOR deles
module ORR (input logic PCWrite, and_out, output logic or_out);	
		assign or_out = PCWrite | and_out;	
endmodule: ORR
