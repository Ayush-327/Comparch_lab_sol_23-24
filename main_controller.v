module ANDarray (RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp0,ALUOp1,Op);
	input [5:0] Op;
	output RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp0,ALUOp1;
	wire Rformat,lw,sw,beq;
	assign Rformat= (~Op[0])& (~Op[1])& (~Op[2])& (~Op[3])& (~Op[4])& (~Op[5]);
	assign lw =(Op[0])& (Op[1])& (~Op[2])& (~Op[3])& (~Op[4])& (Op[5]);
	assign sw =(Op[0])& (Op[1])& (~Op[2])& (Op[3])& (~Op[4])& (Op[5]);
	assign beq =(~Op[0])& (~Op[1])& (Op[2])& (~Op[3])& (~Op[4])& (~Op[5]);
	assign RegDst = Rformat;
	assign ALUSrc = lw | sw;
	assign MemtoReg = lw ;
	assign RegWrite = Rformat | lw;
	assign MemRead = lw;
	assign MemWrite = sw;
	assign Branch = beq;
	assign ALUOp0 = Rformat;
	assign ALUOp1 = beq;
endmodule

module tb_main_controller;
	reg [5:0] op;
	wire RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp0,ALUOp1;
	ANDarray a1(RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp0,ALUOp1,op);
	initial
		$monitor($time," Opcode=%b, RegDst=%b,ALUSrc=%b,MemtoReg=%b, RegWrite=%b, MemRead=%b, MemWrite=%b,Branch=%b,ALUOp0=%b,ALUOp1=%b",op,RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp0,ALUOp1);
	initial
		begin
		#0  op= 6'b000000;
		#10 op= 6'b100011;
		#10 op= 6'b101011;
		#10 op= 6'b000100;
		#200 $finish;
		end
endmodule