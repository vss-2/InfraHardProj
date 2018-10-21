INC_1:begin
    		muxA = 3; 		//Mux A recebe 3, que é o valor do registrador estendido paga 32.
		muxB = 4; 		//Mux B recebe 4, que é 1.
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;		//Resultado armazenado na ULA
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b001;	//Adicao
			6'h9: controleALU = 3'b001;	//Adicao
			default: controleALU = 3'b111;
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INC_2;
end

INC_2:begin
		muxA = 3;
		muxB = 4;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0; 
		muxDadEscr = 0; 
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b001;	//Ambos fazem adicao
			6'h9: controleALU = 3'b001;
			default: controleALU = 3'b111;
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(overflow == 1'b1)
		begin
			case(opcode)
				6'h9: prox_estado = INC_3;  //Addiu 
				default: prox_estado = EXCES_1;	 //Excecao de overflow
			endcase
		end
		else	
		prox_estado = INC_3;
end

INC_3:begin
		muxA = 3;
		muxB = 4;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0; 	//Esse Mux será usado para gravar no registrador
		muxDadEscr = 0; 	//Esse Mux será usado para gravar o dado
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b001;    	//Ambos fazem add
			6'h9: controleALU = 3'b001;    	
			default: controleALU = 3'b111;
		endcase
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
end

DEC_1:begin
    		muxA = 3; 		//Mux A recebe 3, que é o valor do registrador estendido paga 32.
		muxB = 4; 		//Mux B recebe 4, que é 1.
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;		//Resultado armazenado na ULA
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b010;    //Sub
			6'h9: controleALU = 3'b010;    //Sub
			default: controleALU = 3'b111;
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = DEC_2;
end

DEC_2:begin
		muxA = 3;
		muxB = 4;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0; 
		muxDadEscr = 0; 
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b010;	//Ambos fazem subtracao
			6'h9: controleALU = 3'b010;
			default: controleALU = 3'b111;   
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(overflow == 1'b1)
		begin
			case(opcode)
				6'h9: prox_estado = DEC_3;  //Subi 
				default: prox_estado = EXCES_1;	 //Excecao de overflow
			endcase
		end
		else	
		prox_estado = DEC_3;
end

DEC_3:begin
		muxA = 3;
		muxB = 4;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0; 	//Esse Mux será usado para gravar no registrador
		muxDadEscr = 0; 	//Esse Mux será usado para gravar o dado
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(opcode)
			6'h8: controleALU = 3'b010;    	//Ambos fazem sub
			6'h9: controleALU = 3'b010;    	
			default: controleALU = 3'b111;
		endcase
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
end
