module fadder_beha(a,b,cin,s,cout);
	input a,b,cin;
	output s,cout;
	reg s, cout;
	always @(*)
		begin
		s = a^b^cin;
		cout = (a&b) | (b&cin) | (cin&a) ; 
		end
endmodule

module AddSub_4bit(A,B,M,S,V,C);
	input [3:0] A,B;
	input M;
	output [3:0]S;
	output V,C;
	wire [3:0]b;
	wire c1,c2,c3;
	xor(b[0],B[0],M);
	xor(b[1],B[1],M);
	xor(b[2],B[2],M);
	xor(b[3],B[3],M);
	fadder_beha f0(A[0],b[0],M,S[0],c1);
	fadder_beha f1(A[1],b[1],c1,S[1],c2);
	fadder_beha f2(A[2],b[2],c2,S[2],c3);
	fadder_beha f3(A[3],b[3],c3,S[3],C);
	xor(V,c3,C);
endmodule


module test_bench;
reg [3:0] A,B;
reg M;
wire [3:0]S;
wire V,C;
AddSub_4bit a(A,B,M,S,V,C);
parameter xyz = 4'b1000;
initial
$monitor(,$time," A=%b, B=%b, M=%b, Sum=%b, Carry=%b, Overflow=%b, parameter[3]=%b ",A,B,M,S,C,V,xyz[3]);
initial
begin
#1 A=4'b0000; B=4'b1010; M=1'b0;
#1 A=4'b0111; B=4'b1111; M=1'b1;
#1 A=4'b1010; B=4'b0101; M=1'b0;
#1 A=4'b0011; B=4'b1011; M=1'b1;
#1 A=4'b0101; B=4'b1111; M=1'b0;
end
initial
begin
$dumpfile("add_sub.vcd");
$dumpvars;
end
endmodule

/*
module test_bench;
reg a,b,cin;
wire s, cout;
fadder_beha f(a,b,cin,s,cout);
initial 
$monitor(,$time," a=%b , b=%b , cin=%b , cout=%b , s=%b",a,b,cin,cout,s);
initial
begin
#1 a=1'b0; b=1'b0; cin=1'b0;
#1 a=1'b1; b=1'b0; cin=1'b0;
#1 a=1'b0; b=1'b1; cin=1'b0;
#1 a=1'b0; b=1'b1; cin=1'b1;
#1 a=1'b1; b=1'b1; cin=1'b1;
#1 a=1'b1; b=1'b0; cin=1'b1; 
end
endmodule
*/