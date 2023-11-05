module mux2to1(sel,inp1,inp2,out);
	input sel,inp1,inp2;
	output out;
	wire not_sel,a1,a2;
	not(not_sel,sel);
	and(a1,not_sel,inp1);
	and(a2,sel,inp2);
	or(out,a1,a2);
endmodule;
	
module mux2to1_8bit(sel,inp1,inp2,out);
	input sel;
	input [7:0]inp1,inp2;
	output [7:0]out;
	genvar j;
	generate for(j=0; j<8; j=j+1)
		begin: mux_loop
			   mux2to1 m1(sel,inp1[j],inp2[j],out[j]);
		end
	endgenerate
endmodule

module mux2to1_32bit(sel,inp1,inp2,out);
	input sel;
	input [31:0]inp1,inp2;
	output[31:0]out;
	genvar j;
	generate for(j=0; j<4; j=j+1)
		begin: mux_loop
			   mux2to1_8bit m1(sel,inp1[(j+1)*8-1:j*8],inp2[(j+1)*8-1:j*8],out[(j+1)*8-1:j*8]);
		end
	endgenerate
endmodule

module mux3to1(sel,inp1,inp2,inp3,out);
	input [1:0]sel;
	input inp1,inp2,inp3;
	output out;
	wire [1:0]not_sel;
	wire a1,a2,a3;
	not(not_sel[0],sel[0]);
	not(not_sel[1],sel[1]);
	and(a1,not_sel[1],not_sel[0],inp1);
	and(a2,not_sel[1],sel[0],inp2);
	and(a3,sel[1],not_sel[0],inp3);
	or(out,a1,a2,a3);
endmodule

module mux3to1_32bit(sel,inp1,inp2,inp3,out);
	input [1:0]sel;
	input [31:0]inp1,inp2,inp3;
	output [31:0]out;
	genvar j;
	generate for(j=0; j<32; j=j+1)
		begin: mux_loop
			   mux3to1 m1(sel,inp1[j],inp2[j],inp3[j],out[j]);
		end
	endgenerate
endmodule

module bit32AND (out,in1,in2);
 input [31:0] in1,in2;
 output [31:0] out;
 assign out=in1 &in2;
endmodule

module bit32OR (out,in1,in2);
 input [31:0] in1,in2;
 output [31:0] out;
 assign out=in1 | in2;
endmodule

module FA_dataflow (Cout, Sum,In1,In2,Cin);
 input [31:0]In1,In2;
 input Cin;
 output  Cout;
 output  [31:0]Sum;
 assign {Cout,Sum}=In1+In2+Cin;
endmodule

module not_32bits(inp,out);
	input [31:0]inp;
	output [31:0]out;
	genvar j;
	generate for(j=0; j<32; j=j+1)
		begin: not_loop
			   not n1(out[j],inp[j]);
		end
	endgenerate
endmodule

module ALU (a,b,Binvert,CarryIn,Operation,Result,CarryOut);
	input CarryIn, Binvert;
	input [1:0]Operation;
	input [31:0]a,b;
	output CarryOut;
	output [31:0]Result;
	wire [31:0]bneg,mux1_out, or_out, and_out, sum_out;
	not_32bits n1(b,bneg);
	mux2to1_32bit m1(Binvert,b,bneg,mux1_out);
	bit32AND a1(and_out,a,mux1_out);
	bit32OR o1(or_out,a, mux1_out);
	FA_dataflow fa1(CarryOut, sum_out,a,mux1_out,CarryIn);
	mux3to1_32bit m2(Operation,and_out,or_out,sum_out,Result);
endmodule

module tbALU;
	reg Binvert, Carryin;
	reg [1:0] Operation;
	reg [31:0] a,b;
	wire [31:0] Result;
	wire CarryOut;
	ALU alu(a,b,Binvert,Carryin,Operation,Result,CarryOut);
	initial
		$monitor($time," IN1=%b, IN2=%b, Cin=%b, Operation=%b, Cout=%b, Result=%b",a, b,Carryin,Operation,CarryOut,Result);
	initial
		begin
		a=32'ha5a5a5a5;
		b=32'h5a5a5a5a;
		Operation=2'b00;
		Binvert=1'b0;
		Carryin=1'b0; //must perform AND resulting in zero
		#100 Operation=2'b01; //OR
		#100 Operation=2'b10; //ADD
		#100 Binvert=1'b1; Carryin=1'b1;//SUB
		#200 $finish;
		end
endmodule
