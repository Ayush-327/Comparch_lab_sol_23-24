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

module tb_mux2to1_32bit;
 reg [31:0] INP1, INP2;
 reg SEL;
 wire [31:0] out;
 mux2to1_32bit M1(SEL,INP1,INP2,out);
 initial
 $monitor($time," sel=%b, output=%b",SEL,out);
 initial
 begin
 INP1=32'b10101010101010101010101010101010;
 INP2=32'b01010101101010101010101010101010;
 SEL=1'b0;
 #100 SEL=1'b1;
 #100 SEL=1'b0;
 #1000 $finish;
 end
endmodule