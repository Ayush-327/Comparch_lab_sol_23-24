module alu_control_unit(ALUop, funct, Operation);
	input [1:0] ALUop;
	input [5:0] funct;
	output [2:0] Operation;
	assign Operation[0] = ALUop[1] & (funct[0] | funct[3]);
	assign Operation[1] = (~ALUop[1]) | (~funct[2]);
	assign Operation[2] = ALUop[0] | (ALUop[1] & funct[1]);
endmodule

module tb_alu_control;
	reg [1:0]ALUop;
	reg [5:0]funct;
	wire [2:0] Operation;
	alu_control_unit a1(ALUop, funct, Operation);
	initial
		$monitor($time," ALUOp=%b, Funct Field=%b, Operation=%b",ALUop, funct,Operation);
	initial
		begin
		#0  ALUop= 2'b00; funct = 6'b000000;
		#1  ALUop= 2'b00; funct = 6'b011110;
		#1  ALUop= 2'b01; funct = 6'b001010;
		#1  ALUop= 2'b10; funct = 6'b000000;
		#2  ALUop= 2'b10; funct = 6'b010000;
		#3  ALUop= 2'b10; funct = 6'b000010;
		#4  ALUop= 2'b10; funct = 6'b100010;
		#5  ALUop= 2'b10; funct = 6'b010100;
		#6  ALUop= 2'b11; funct = 6'b110100;
		#7  ALUop= 2'b11; funct = 6'b000101;
		#1  ALUop= 2'b10; funct = 6'b100101;
		#1  ALUop= 2'b10; funct = 6'b001010;
		#1  ALUop= 2'b11; funct = 6'b011010;
		#200 $finish;
		end
endmodule