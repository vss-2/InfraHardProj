module Projeto1 (input logic clk, reset,
				output logic [31:0] PC, MemData, Address, muxMemData_out, WriteDataReg, ALU, AluOut, RegA, SignExt, MDR,
				output logic [5:0] estado,
				output logic [4:0] WriteRegister,
				output logic wr, RegWrite, IRWrite, zero, MeNor, MaioR, IguaL);
	logic [63:0] mult_out;		
	logic [31:0] WriteDataMem, desEsqSinExt_out, dadoReg_1, dadoReg_2, muxMfhi_out, muxMflo_out, muxAluA_out, muxAluB_out, muxDadosReg, conct_out, entradaPC_in, RegDes_out, EpcOut, com2_1_out, com2_2_out, RegMfhi_out, RegMflo_out, Quociente, Resto;
	logic [15:0] ins_15_0;
	logic [26:0] desEsqJmp_out;
	logic [5:0] ins_31_26;
	logic [4:0] ins_25_21, ins_20_16, MuxN_out, MuxRs_out;
	logic [3:0] MuxDadEscr;
	logic [2:0] ALU_controle, MuxALU, shift_regDes, MuxPC, MuxWR;
	logic [1:0] MuxB, MuxMemData, MuxZero, MuxA;	
	logic MuxMfhi, MuxMflo, MuxRs, MuxN, MuxZero_out, IniciarMult, IniciarDiv, LoadRegPC, LoadRegAlu, LoadRegA, LoadRegB, LoadRegMemData, LoadRegEPC, LoadRegMfhi, LoadRegMflo, EscrevePC, EscrevePCcond, And_out, OverFlow, Multiplicando, Dividindo, xor_out;
	
	//Controle			
		Controle contr	(.Clk(clk), .Reset(reset), .opcode(ins_31_26), .instr({ins_25_21,ins_20_16,ins_15_0}), .funct(ins_15_0[5:0]), 
				 .Estado(estado), .muxB(MuxB), .muxALU(MuxALU),.muxA(MuxA), .muxPC(MuxPC), .muxZero(MuxZero), .muxRegEscr(MuxWR),
				.muxDadEscr(MuxDadEscr), .WR(wr), .loadRegALU(LoadRegAlu), .loadRegA(LoadRegA), .loadRegB(LoadRegB),
				 .loadRegMemData(LoadRegMemData), .escreverIR(IRWrite), .escrevePC(EscrevePC),
				.escrevePCcond(EscrevePCcond),	.regBanco(RegWrite), .controleALU(ALU_controle), .muxMemData(MuxMemData), 
				 .Shift_regDes(shift_regDes), .muxN(MuxN), .overflow(OverFlow), .menor(MeNor), .loadRegEPC(LoadRegEPC), 
				 .multiplicando(Multiplicando), .loadRegMfhi(LoadRegMfhi), .loadRegMflo(LoadRegMflo), .iniciarMult(IniciarMult), 
				 .maior(MaioR), .igual(IguaL), .muxRs(MuxRs), .iniciarDiv(IniciarDiv), .dividindo(Dividindo), .muxMfhi(MuxMfhi), 
				 .muxMflo(MuxMflo));
				
	//Memorias
		Memoria Memor	(.Clock(clk), .Address(Address), .Wr(wr), .Datain(muxMemData_out), .Dataout(MemData));	
	
	//Registradores	
		Registrador Pc (.Clk(clk), .Reset(reset), .Load(LoadRegPC), .Entrada(entradaPC_in), .Saida(PC));
		Registrador RegiA (.Clk(clk), .Reset(reset), .Load(LoadRegA), .Entrada(dadoReg_1), .Saida(RegA));		
		Registrador RegiB (.Clk(clk), .Reset(reset), .Load(LoadRegB), .Entrada(dadoReg_2), .Saida(WriteDataMem));		
		Registrador RegAlu (.Clk(clk), .Reset(reset), .Load(LoadRegAlu), .Entrada(ALU), .Saida(AluOut));		
		Registrador MemoriaData (.Clk(clk), .Reset(reset), .Load(LoadRegMemData), .Entrada(MemData), .Saida(MDR));
		Registrador EPC (.Clk(clk), .Reset(reset), .Load(LoadRegEPC), .Entrada(ALU), .Saida(EpcOut));
		Registrador mfhi (.Clk(clk), .Reset(reset), .Load(LoadRegMfhi), .Entrada(muxMfhi_out), .Saida(RegMfhi_out));
		Registrador mflo (.Clk(clk), .Reset(reset), .Load(LoadRegMflo), .Entrada(muxMflo_out), .Saida(RegMflo_out));
		
	//Registrador de Intrucao
		Instr_Reg inReg	(.Clk(clk), .Reset(reset), .Load_ir(IRWrite), .Entrada(MemData), .Instr31_26(ins_31_26), .Instr25_21(ins_25_21), .Instr20_16(ins_20_16), .Instr15_0(ins_15_0));
	
	//Registrador de Deslocamento
		RegDesloc regDes (.Clk(clk), .Reset(reset), .Shift(shift_regDes), .N(MuxN_out), .Entrada(dadoReg_2), . Saida(RegDes_out));
		
	//Deslocamento a esquerda
		desloEsq32 SigEx (.entrada32(SignExt), .saida32(desEsqSinExt_out));	
		desloEsq28 jmp (.entrada26({ins_25_21,ins_20_16,ins_15_0}), .saida28(desEsqJmp_out));
	
	//ALU
		ula32 	Ula	(.A(muxAluA_out), .B(muxAluB_out), .S(ALU), .Seletor(ALU_controle), .z(zero), .Overflow(OverFlow), .Menor(MeNor), .Maior(MaioR), .Igual(IguaL));	
	
	//MUXs
		mux11 WrData(.primeiro(AluOut), .segundo(MDR), .terceiro({ins_15_0,16'b0000000000000000}), .quarto({16'b0000000000000000, MDR[15:0]}), .quinto({24'b000000000000000000000000, MDR[7:0]}), .sexto(PC), .setimo(RegDes_out),
		.oitavo(32'd0), .nono(32'd1), .decimo(RegMfhi_out), .onze(RegMflo_out), .doze(32'd227), .selecao(MuxDadEscr), .saida(WriteDataReg));	
		mux6 muxALU(.primeiro(ALU), .segundo(AluOut), .terceiro(conct_out), .quarto(dadoReg_1), .quinto(EpcOut), .sexto({24'b000000000000000000000000,MemData[31:24]}), .selecao(MuxALU), .saida(entradaPC_in));
		mux5 muxPC (.primeiro(PC), .segundo(AluOut), .terceiro(32'd253), .quarto(32'd254), .quinto(32'd255), .selecao(MuxPC), .saida(Address));
		mux5 muxB (.primeiro(WriteDataMem), .segundo(32'd4), .terceiro(SignExt), .quarto(desEsqSinExt_out), .quinto(32'd1), .selecao(MuxB), .saida(muxAluB_out));
		muX4 #(1) muxZero	(.primeiro(zero), .segundo(~zero), .terceiro(MeNor), .quarto(MaioR), .selecao(MuxZero), .saida(MuxZero_out));
		muX4 #(32) muxMemData(.primeiro(WriteDataMem), .segundo({MemData[31:16],WriteDataMem[15:0]}), .terceiro({MemData[31:8],WriteDataMem[7:0]}), .quarto(dadoReg_2), .selecao(MuxMemData), .saida(muxMemData_out));		
		muX4 #(5) RegWr	(.primeiro(ins_20_16), .segundo(ins_15_0[15:11]), .terceiro(32'd31), .quarto(32'd29), .selecao(MuxWR), .saida(WriteRegister));
		mux3 #(32) muxA	(.primeiro(PC), .segundo(RegA), .terceiro(32), .selecao(MuxA), .saida(muxAluA_out));
		mux2 #(5) muxN	(.primeiro(dadoReg_1[4:0]), .segundo(ins_15_0[10:6]), .selecao(MuxN), .saida(MuxN_out));		
		mux2 #(5) muxRS	(.primeiro(ins_25_21), .segundo(5'd29), .selecao(MuxRs), .saida(MuxRs_out));
		mux2 #(32) muxMFHI (.primeiro(mult_out[63:32]), .segundo(Resto), .selecao(MuxMfhi), .saida(muxMfhi_out));
		mux2 #(32) muxMFLO (.primeiro(mult_out[31:0]), .segundo(Quociente), .selecao(MuxMflo), .saida(muxMflo_out));

	
	//Extensor de sinais
		SinalExtendido sinEx (.Address(ins_15_0), .AddresExt(SignExt));
	
	//Banco de Registradores
		Banco_reg bank	(.Clk(clk), .Reset(reset), .RegWrite(RegWrite), .ReadReg1(MuxRs_out), .ReadReg2(ins_20_16), .WriteReg(WriteRegister), .WriteData(WriteDataReg), .ReadData1(dadoReg_1), .ReadData2(dadoReg_2));
	
	//Concatenar
		concat_jmp concat(.offset(desEsqJmp_out), .pc_3128(ins_31_26[5:2]), .Conct_out(conct_out));
		
	//AND, OR e XOR
		ANND adn (.PCWriteCond(EscrevePCcond), .ZeRo(MuxZero_out), .and_out(And_out));
		ORR orrn (.PCWrite(EscrevePC), .and_out(And_out), .or_out(LoadRegPC));
		XORR Xorrn (.sinal_1(RegA[31]), .sinal_2(WriteDataMem[31]), .Xor_out(xor_out));
		
	//Complemento de 2
		complemento2 com2_1 (.entrada(RegA), .saida(com2_1_out));
		complemento2 com2_2 (.entrada(WriteDataMem), .saida(com2_2_out));
		
	//Multiplicacao
		mult multip	(.Clk(clk), .Reset(reset), .iniciar(IniciarMult), .sinal(xor_out), .cador(com2_1_out), .cando(com2_2_out), .saida(mult_out), .multiplicando(Multiplicando));
		
	//Divisao
		div divis (.Clk(clk), .Reset(reset), .iniciar(IniciarDiv), .sinal(xor_out), .Dvdendo(com2_1_out), .Divsor(com2_2_out), .quociente(Quociente), .resto(Resto), .dividindo(Dividindo));
		
endmodule: Projeto1
