//'include "mux4to1_32bit.v"
//'include "decoder2_4.v"
//'include "register_32bit.v"

module mux4to1_32bit(regData,q1,q2,q3,q4,reg_no);
	output [31:0]regData;
	reg [31:0] regData;
	input [31:0] q1,q2,q3,q4;
	input [1:0]reg_no;
	always @(reg_no)
		begin 
		if(reg_no==2'b00)
			regData = q1;
		else if(reg_no==2'b01)
			regData = q2;
		else if(reg_no==2'b10)
			regData = q3;
		else 
			regData = q4;
		end
endmodule

module decoder2_4 (register,reg_no);
	input [1:0]register;
	output [3:0]reg_no;
	reg [3:0] reg_no;
	always @(register)
		begin
		if(register==2'b00)
			reg_no = 4'b0001;
		else if (register==2'b01)
			reg_no = 4'b0010;
		else if (register==2'b10)
			reg_no = 4'b0100;
		else
			reg_no = 4'b1000;
		end
endmodule

module reg_32bit(q,d,clk,reset);
	input [31:0]d;
	input reset, clk;
	output [31:0]q;
	reg [31:0]q;
	always @(negedge reset or posedge clk)
		begin
		if(!reset)
			begin
			q<=32'd0;
			end
		else
			begin
			q<=d;
			end
		end
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg, RegWrite,ReadData1,ReadData2);
	input clk, reset, RegWrite;
	input [1:0] ReadReg1, ReadReg2, WriteReg;
	input [31:0] WriteData;
	output [31:0] ReadData1, ReadData2;	
	wire [3:0]reg_no;
	decoder2_4 d1(WriteReg,reg_no);
	wire [3:0] a; // a will be the and of clock, reg_no, write and will go as input to clock of the registers  
	wire [127:0] reg_resutls;
	genvar j;
	generate for(j=0; j<4; j=j+1)
		begin: and_loop
			   and a1(a[j],clk,RegWrite,reg_no[j]);
			   reg_32bit r1(reg_resutls[(j+1)*32-1:j*32],WriteData,a[j],reset);
		end
	endgenerate
	mux4to1_32bit m1(ReadData1,reg_resutls[31:0],reg_resutls[63:32],reg_resutls[95:64],reg_resutls[127:96],ReadReg1);
	mux4to1_32bit m2(ReadData2,reg_resutls[31:0],reg_resutls[63:32],reg_resutls[95:64],reg_resutls[127:96],ReadReg2);
endmodule


module tb_register_file;
	reg clk,reset,RegWrite;
	reg [1:0] ReadReg1, ReadReg2, WriteReg;
	reg [31:0] WriteData;
	wire [31:0] ReadData1, ReadData2;
	RegFile r1(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg, RegWrite,ReadData1,ReadData2);
	always @( clk)
		begin
		$display($time," clk=%b, reset=%b, ReadReg1=%b, ReadReg2=%b, ReadData1=%b, ReadData2=%b\n", clk, reset, ReadReg1, ReadReg2, ReadData1, ReadData2);
		end
	always @(clk)
		#2 clk<=~clk;
	initial
		begin
		clk= 1'b0;
		reset=1'b0;//reset the registers
		#4 RegWrite=1'b0; reset=1'b1;ReadReg1=2'b00; ReadReg2=2'b10;
		#4 ReadReg1=2'b00; ReadReg2=2'b01;
		#4 RegWrite=1'b1; WriteData=32'ha5a5a5a5; WriteReg=2'b11;
		#4 ReadReg1 = 2'b11;
		#4 WriteData=32'ha5a5a5a4; WriteReg=2'b00;
		#4 ReadReg2 = 2'b00;
		#4 WriteData=32'h0; WriteReg=2'b01;
		#4 ReadReg2 = 2'b01;
		#4 WriteData=32'hffffffff; WriteReg=2'b10;
		#4 ReadReg1 = 2'b10;
		#4 ReadReg1=2'b00; ReadReg2=2'b11;
		#10 $finish;
		end
endmodule