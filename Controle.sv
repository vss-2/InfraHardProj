module Controle (input logic Clk, Reset, overflow, menor, maior, igual, multiplicando, dividindo,
				input logic [5:0]opcode, funct,
				input logic [25:0] instr,
				output logic [5:0] Estado,
				output logic [3:0] muxDadEscr,
				output logic [2:0] muxALU, controleALU, Shift_regDes, muxPC, muxRegEscr,
				output logic [1:0]muxB, muxMemData, muxZero, muxA,
				output logic muxMfhi, muxMflo, muxRs, muxN, WR, loadRegALU, loadRegA, loadRegB, loadRegMemData, loadRegEPC, escreverIR, escrevePC, escrevePCcond, regBanco, loadRegMfhi, loadRegMflo, iniciarMult, iniciarDiv);
		
	enum logic [5:0] {INICIO/*0*/, PC_MEMORIA_SOMA4/*1*/, ESPERA_PC_MEM4_1/*2*/, DECOD/*3*/, BREAK/*4*/, ARIT_1/*5*/, ARIT_2/*6*/, ARIT_3/*7*/,
					 BEQ_1/*8*/, BEQ_2/*9*/, BNE_1/*10*/, BNE_2/*11*/, BLE_1/*12*/, BLE_2/*13*/, BGT_1/*14*/, BGT_2/*15*/, LW_1 /*16*/, LW_2 /*17*/, ESPERA_LW/*18*/, LW_3 /*19*/, LW_4 /*20*/,SW_1/*21*/,
					 SW_2/*22*/, SW_3/*23*/, LUI_1/*24*/, LUI_2/*25*/, JMP/*26*/, LB/*27*/, LH/*28*/, ESPERA_SH_SB/*29*/, SH/*30*/, SB/*31*/, JAL/*32*/,
					 JR/*33*/, SHIFT_1/*34*/, SHIFT_2/*35*/, ARIT_IMM_1/*36*/, ARIT_IMM_2/*37*/, ARIT_IMM_3/*38*/, EXCES_1/*39*/, EXCES_2/*40*/, EXCES_3/*41*/,
					 RTE/*42*/, SLT_1/*43*/, SLT_2/*44*/, MUL_1/*45*/, MUL_2/*46*/, DIV_1/*47*/,DIV_2/*48*/, MFHI/*49*/, MFLO/*50*/, RESET/*51*/, INCDEC/*52*/, INC_1, INC_2, DEC_1, DEC_2}estado, prox_estado;
	
	assign Estado = estado;
	
	always_ff@(posedge Clk, posedge Reset)
	if(Reset)
	begin
		estado <= RESET;
	end	
	else estado <= prox_estado;
		
always_comb
case(estado)
	INICIO: begin
		muxA = 0;
		muxB = 0;
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
		loadRegALU = 0;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = PC_MEMORIA_SOMA4;
	end
	PC_MEMORIA_SOMA4: begin
		muxA = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxB = 1; // seleciona o valor 4(add)
		muxALU = 0;
		muxPC = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0 ;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU =  3'b001; // 001 = Alu realiza a soma
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = ESPERA_PC_MEM4_1;
	end
	ESPERA_PC_MEM4_1: begin
		muxA = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxB =0 ; // seleciona o valor 4(add)
		muxALU = 0;
		muxPC = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 1;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU =  3'b000; 
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = DECOD;
	end
	DECOD: begin
		muxA = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxB = 1; // seleciona o valor 4(add)
		muxALU = 0;
		muxPC = 0; //seleciona a entrada 1 (valor que vem do registrador PC)
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 1;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU =  3'b001; 
		Shift_regDes = 3'b001;
		regBanco = 0;
		case(opcode) 
				6'h0:begin
					case(funct)
						6'hd: prox_estado <= BREAK; //BREAK
						6'h2a: prox_estado <= SLT_1;//SLT
						6'h0: begin
							if(instr == 25'd0)
								prox_estado <= INICIO; //NOP
							else
								prox_estado <= SHIFT_1;// SLL
						end
						6'h8: prox_estado <= JR; //JR
						6'h4: prox_estado <= SHIFT_1; //SLLV
						6'h3: prox_estado <= SHIFT_1; //SRA
						6'h7: prox_estado <= SHIFT_1; //SRAV
						6'h2: prox_estado <= SHIFT_1; //SRL
						6'h18: prox_estado <= MUL_1; //MULT
						6'h10: prox_estado <= MFHI; //MFHI
						6'h12: prox_estado <= MFLO; //MFLO
						6'h13: prox_estado <= RTE; //RTE
						6'h1a: prox_estado <= DIV_1; //DIV
						default: prox_estado <= ARIT_1; // AND, SUB, ADD
					endcase
				end
				6'h3: prox_estado <= JAL; //JAL
				6'h4: prox_estado <= BEQ_1; //BEQ
				6'h5: prox_estado <= BNE_1; //BNE
				6'h23: prox_estado <= LW_1; //LW
				6'h2b: prox_estado <= SW_1;//SW
				6'hf: prox_estado <= LUI_1;//LUI
				6'h2: prox_estado <= JMP;//JUMP
				6'h20: prox_estado <= LW_1;//LB
				6'h21: prox_estado <= LW_1;//LH
				6'h28: prox_estado <= SW_1;//SB
				6'h29: prox_estado <= SW_1;//SH
				6'h6: prox_estado <= BLE_1; //BLE
				6'h7: prox_estado <= BGT_1; //BGT
				6'h8: prox_estado <= ARIT_IMM_1; //ADDI
				6'h9: prox_estado <= ARIT_IMM_1; //ADDIU
				6'ha: prox_estado <= SLT_1;//SLTI
				default: prox_estado <= EXCES_1;
			endcase
	end
	ARIT_IMM_1:begin
		muxA = 1;
		muxB = 2;
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
		loadRegA = 1;
		loadRegB = 1;
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
			6'h8: controleALU = 3'b001;//add
			6'h9: controleALU = 3'b001;//add
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = ARIT_IMM_2;
	end
	
	ARIT_IMM_2:begin
		muxA = 1;
		muxB = 2;
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
			6'h8: controleALU = 3'b001;//add
			6'h9: controleALU = 3'b001;//add
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(overflow == 1'b1)
		begin
			case(opcode)
				6'h9: prox_estado = ARIT_IMM_3;//addiu
				default: prox_estado = EXCES_1;	//EXCESS�O!!!!!
			endcase
		end
		else	
			prox_estado = ARIT_IMM_3;
	end
	ARIT_IMM_3:begin
		muxA = 1;
		muxB = 2;
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
		loadRegA = 1;
		loadRegB = 1;
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
			6'h8: controleALU = 3'b001;//add
			6'h9: controleALU = 3'b001;//add
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	ARIT_1:begin
		muxA = 1;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(funct)
			6'h20: controleALU = 3'b001;//add
			6'h24: controleALU = 3'b011;//and
			6'h22: controleALU = 3'b010;//sub
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = ARIT_2;
	end
	
	ARIT_2:begin
		muxA = 1;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
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
		case(funct)
			6'h20: controleALU = 3'b001;//add
			6'h24: controleALU = 3'b011;//and
			6'h22: controleALU = 3'b010;//sub
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(overflow == 1'b1)begin			
			prox_estado = EXCES_1;	//EXCESS�O!!!!!			
		end
		else	
			prox_estado = ARIT_3;
	end
	ARIT_3:begin
		muxA = 1;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		case(funct)
			6'h20: controleALU = 3'b001;//add
			6'h24: controleALU = 3'b011;//and
			6'h22: controleALU = 3'b010;//sub
			default: controleALU = 3'b111;//
		endcase
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	LUI_1:begin
		muxA = 1;//0
		muxB = 2;//0
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 2;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;//0
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = LUI_2;
	end
	LUI_2:begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 2;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	BEQ_1:begin
		muxA = 0;
		muxB = 3;
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
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b001; //faz o add
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = BEQ_2;
	end
	BEQ_2:begin
		muxA = 1;
		muxB = 0;
		muxALU = 1;
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
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 1;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	BNE_1:begin
		muxA = 0;
		muxB = 3;
		muxALU = 0;
		muxPC = 0;
		muxZero = 1;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b001; //faz o add
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = BNE_2;
	end
	BNE_2:begin
		muxA = 1;
		muxB = 0;
		muxALU = 1;
		muxPC = 0;
		muxZero = 1;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 1;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	BLE_1:begin
		muxA = 0;
		muxB = 3;
		muxALU = 0;
		muxPC = 0;
		if(menor == 1'b1) 
			muxZero = 2;
		else if (igual == 1'b1)
			muxZero = 0;
		else
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
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b001; //faz o add
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = BLE_2;
	end
	BLE_2:begin
		muxA = 1;
		muxB = 0;
		muxALU = 1;
		muxPC = 0;
		if(menor == 1'b1) 
			muxZero = 2;
		else if (igual == 1'b1)
			muxZero = 0;
		else
			muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 1;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	BGT_1:begin
		muxA = 0;
		muxB = 3;
		muxALU = 0;
		muxPC = 0;
		muxZero = 3;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 1;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b001; //faz o add
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = BGT_2;
	end
	BGT_2:begin
		muxA = 1;
		muxB = 0;
		muxALU = 1;
		muxPC = 0;
		muxZero = 3;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 1;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	JAL:begin
		muxA = 0;
		muxB = 0;
		muxALU = 2;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 2;
		muxDadEscr = 5;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = JMP;
	end
	JR:begin
		muxA = 0;
		muxB = 0;
		muxALU = 3;
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
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	JMP:begin
		muxA = 0;
		muxB = 0;
		muxALU = 2;
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
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	SW_1: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
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
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = SW_2;
	end
	SW_2: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		if (opcode == 6'h28)
			prox_estado = ESPERA_SH_SB;
		else if (opcode == 6'h29)
			prox_estado = ESPERA_SH_SB;
		else
			prox_estado = SW_3;
	end
	SW_3: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 1;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	ESPERA_SH_SB: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		if (opcode == 6'h28)
			prox_estado = SB;
		else if (opcode == 6'h29)
			prox_estado = SH;
		else
			prox_estado = INICIO;
	end
	SH: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 1;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 1;
		loadRegALU = 1;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	SB: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 2;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 1;
		loadRegALU = 1;
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	LW_1: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
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
		loadRegA = 1;
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
		controleALU = 3'b001;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = LW_2;
	end
	LW_2: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = ESPERA_LW;
	end
	ESPERA_LW: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = LW_3;
	end
	LW_3: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 1;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 1;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(opcode == 6'h20)
			prox_estado = LB;
		else if(opcode == 6'h21)
			prox_estado = LH;
		else 
			prox_estado = LW_4;
	end
	LW_4: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 1;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	LH: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 3;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	LB: begin
		muxA = 1;
		muxB = 2;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 6;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	SHIFT_1: begin
		muxA = 0;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 6;
		muxMemData = 0;
		case(funct)
			6'h0: muxN = 1;
			6'h4: muxN = 0;
			6'h3: muxN = 1;
			6'h7: muxN = 0;
			6'h2: muxN = 1;
			default: muxN = 0;	
		endcase		
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
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
		controleALU = 3'b000;
		case(funct)
			6'h0: Shift_regDes = 3'b010;
			6'h4: Shift_regDes = 3'b010;
			6'h3: Shift_regDes = 3'b100;
			6'h7: Shift_regDes = 3'b100;
			6'h2: Shift_regDes = 3'b011;
			default: Shift_regDes = 3'b000;
		endcase
		regBanco = 0;
		prox_estado = SHIFT_2;
	end
	SHIFT_2: begin
		muxA = 0;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 6;
		muxMemData = 0;
		case(funct)
			6'h0: muxN = 1;
			6'h4: muxN = 0;
			6'h3: muxN = 1;
			6'h7: muxN = 0;
			6'h2: muxN = 1;
			default: muxN = 0;	
		endcase		
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;	
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		case(funct)
			6'h0: Shift_regDes = 3'b010;
			6'h4: Shift_regDes = 3'b010;
			6'h3: Shift_regDes = 3'b100;
			6'h7: Shift_regDes = 3'b100;
			6'h2: Shift_regDes = 3'b011;
			default: Shift_regDes = 3'b000;
		endcase
		regBanco = 0;
		prox_estado = INICIO;
	end
	EXCES_1: begin
		muxA = 0;
		muxB = 1;
		muxALU = 5;
		case(opcode)
			6'h0: begin
				if (funct == 6'h1a)
					muxPC = 4;
				else 
					
					muxPC = 3;
			end
			6'h8: muxPC = 3;
			6'hc: muxPC = 3;
			6'he: muxPC = 3;
			default: muxPC = 2;
		endcase
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 1;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b010;//sub
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = EXCES_2;
	end
	EXCES_2: begin
		muxA = 0;
		muxB = 1;
		muxALU = 5;
		case(opcode)
			6'h0: begin
				if (funct == 6'h1a)
					muxPC = 4;
				else 
					
					muxPC = 3;
			end
			6'h8: muxPC = 3;
			6'hc: muxPC = 3;
			6'he: muxPC = 3;
			default: muxPC = 2;
		endcase
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU = 3'b000;//sub
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = EXCES_3;
	end
	EXCES_3: begin
		muxA = 0;
		muxB = 1;
		muxALU = 5;
		case(opcode)
			6'h0: begin
				if (funct == 6'h1a)
					muxPC = 4;
				else 
					
					muxPC = 3;
			end
			6'h8: muxPC = 3;
			6'hc: muxPC = 3;
			6'he: muxPC = 3;
			default: muxPC = 2;
		endcase
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU = 3'b000;//sub
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	BREAK: begin
		muxA = 0;
		muxB = 0;
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
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = BREAK;
	end
	RTE: begin
		muxA = 0;
		muxB = 0;
		muxALU = 4;
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
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 1;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	SLT_1: begin
		muxA = 1;
		if(opcode == 6'h0)
			muxB = 0;
		else
			muxB = 2;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		if(opcode == 6'h0)
			muxRegEscr = 1;
		else
			muxRegEscr = 0;
		if(menor == 1'b1)			
			muxDadEscr = 8;
		else
			muxDadEscr = 7;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = SLT_2;
	end
	SLT_2: begin
		muxA = 1;
		if(opcode == 6'h0)
			muxB = 0;
		else
			muxB = 2;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		if(opcode == 6'h0)
			muxRegEscr = 1;
		else
			muxRegEscr = 0;
		if(menor == 1'b1)			
			muxDadEscr = 8;
		else
			muxDadEscr = 7;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	MUL_1: begin
		muxA = 0;
		muxB = 0;
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
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 1;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(multiplicando == 1)
			prox_estado = MUL_1;
		else
			prox_estado = MUL_2;
	end
	MUL_2: begin
		muxA = 0;
		muxB = 0;
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
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 1;
		loadRegMflo = 1;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	DIV_1: begin
		muxA = 2;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 1;
		muxMflo = 1;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 0;
		loadRegMflo = 0;
		iniciarMult = 0;
		iniciarDiv = 1;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		if(igual == 1)
			prox_estado = EXCES_1;
		else begin
			if (dividindo == 1)
				prox_estado = DIV_1;
			else
				prox_estado = DIV_2;
		end
	end
	DIV_2: begin
		muxA = 2;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 0;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 1;
		muxMflo = 1;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 1;
		loadRegB = 1;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 1;
		loadRegMflo = 1;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b010;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	MFHI: begin
		muxA = 0;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 9;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	MFLO: begin
		muxA = 0;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 1;
		muxDadEscr = 10;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
		loadRegA = 0;
		loadRegB = 0;
		loadRegMemData = 0;
		loadRegEPC = 0;
		loadRegMfhi = 1;
		loadRegMflo = 1;
		iniciarMult = 0;
		iniciarDiv = 0;
		escreverIR = 0;
		escrevePC = 0;
		escrevePCcond = 0;
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	RESET: begin
		muxA = 0;
		muxB = 0;
		muxALU = 0;
		muxPC = 0;
		muxZero = 0;
		muxRegEscr = 3;
		muxDadEscr = 11;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 0;
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 1;
		prox_estado = INICIO;
	end
	default: begin
		muxA = 0;
		muxB = 0;
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
		loadRegALU = 0;
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
		controleALU = 3'b000;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
	end
	
	
	INCDEC:begin
        	case(opcode) 
                6'ha: prox_estado = INC_1;
                6'hb: prox_estado = DEC_1;
            endmodule
end

INC_1:begin

        //Nesse primeiro ciclo, estendemos o valor de 26 para 32
        //Efetuamos operacao na ALU, salvamos em ALUOUT
        //E guardamos o valor na memória

  		muxA = 3;   //Recebe número estendido 26->32
		muxB = 0;
		muxALU = 0;
		muxPC = 1;
		muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 6;
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
		controleALU = 3'b111;
		Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INC_2;
end

INC_2:begin

        //Pega da memoria
        //Soma 1 do MUXB
        //Joga no MUXMEMDATA 4

  		muxA = 0;   //Recebe número estendido 26->32
		muxB = 4;
		muxALU = 5;
		muxPC = 0;
        muxZero = 0;
		muxRegEscr = 0;
		muxDadEscr = 6;
		muxMemData = 0;
		muxN = 0;
		muxRs = 0;
		muxMfhi = 0;
		muxMflo = 0;
		WR = 1; //Grava na memoria
		loadRegALU = 0;
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
        controleALU = 3'b001; //Faz soma
        Shift_regDes = 3'b000;
		regBanco = 0;
		prox_estado = INICIO;
end
	
endcase
	
	
	
endmodule: Controle
