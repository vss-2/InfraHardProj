//Recebe como entrada endereço de tamanho 16, e devolve saida tamanho 32
//existem 2 possibilidades, ser negativo ou positivo.
module SinalExtendido (input logic [15:0] Address, output logic [31:0] AddressExt);
	always_comb begin
		if(Address[15] == 1'b1)
			AddressExt = 32'b11111111111111110000000000000000 + Address; //Caso negativo
		else
			AddressExt = 32'b00000000000000000000000000000000 + Address; //Caso positivo
	end
endmodule: SinalExtendido
