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

module tb_mux3to1_32bit;
 reg [31:0] INP1, INP2,INP3;
 reg [1:0]SEL;
 wire [31:0] out;
 mux3to1_32bit M1(SEL,INP1,INP2,INP3,out);
 initial
 $monitor($time," sel=%b, output=%b",SEL,out);
 initial
 begin
 INP1=32'b00000000000000000000000000000010;
 INP2=32'b11111111111111111111111111111010;
 INP3=32'b01010101101010101010101010101010;
 SEL=2'b00;
 #100 SEL=2'b10;
 #100 SEL=2'b01;
 #1000 $finish;
 end
endmodule


/*
module tb_mux3to1;
 reg  INP1, INP2, INP3;
 reg [1:0]SEL;
 wire  out;
 mux3to1 M1(SEL,INP1,INP2,INP3,out);
 initial
 $monitor($time," sel=%b, output=%b",SEL,out);
 initial
 begin
 INP1=1'b1;
 INP2=1'b0;
 INP3=1'b1;
 SEL=2'b00;
 #100 SEL=2'b01;
 #100 SEL=2'b10;
 #1000 $finish;
 end
endmodule
*/