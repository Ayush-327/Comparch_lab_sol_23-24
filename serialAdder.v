module shift_reg(in,sin,clk,out);
	input [3:0]in;
	input sin;
	input clk;
	output [3:0]out;
	reg [3:0]out;
	always@(in) 
		begin
		out = in;
		end
	always@(posedge clk)
		begin
		out = {sin,out[3:1]};
		end
endmodule

module fadder(x,y,z,S,C);
	input x,y,z;
	output S,C;
	assign {C,S} = x+y+z;
endmodule

module d_ff(d,q,clk);
	input d,clk;
	output q;
	reg q;
	initial
		q = 1'b0;
	always@(posedge clk)
		q = d;
endmodule

module serialAdder(A,B,clk,sum,cout);
	input [3:0]A,B;
	input clk;
	output cout;
	output [3:0]sum;
	wire [3:0]x,y;
	wire s,cin;
	assign sum=x;
	shift_reg s1(A,s,clk,x);
	shift_reg s2(B,1'b0,clk,y);
	fadder fa(x[0],y[0],cin,s,cout);
	d_ff d1(cout,cin,clk);
endmodule


module test_bench;
	reg clk;
	reg [3:0] A,B;
	wire cout;
	wire [3:0]sum;
	serialAdder sa(A,B,clk,sum,cout);
	initial
		$monitor($time," A=%b, B=%b, clk=%b, Carry=%b, sum=%b",A,B,clk,sa.cin,sum);
	initial
		begin
		#0 A = 4'b1001; B=4'b0111; clk=0;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		#1 clk=~clk;
		end
		initial
begin
$dumpfile("filename.vcd");
$dumpvars;
end
endmodule

