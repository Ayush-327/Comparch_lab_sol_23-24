module concat(a,b,c);
	input [27:0]a;
	input [3:0]b;
	output [31:0]c;
	assign c = {b[3:0],a[27:0]};
endmodule;

module tb;
	reg [27:0]a;
	reg [3:0]b;
	wire [31:0]c;
	concat c1(a,b,c);
	initial
		$monitor($time," ,a=%b, b=%b, c=%b",a,b,c);
	initial
		begin
		#0 a = 28'b0011001111111111111111110000;b=4'b1111;
		#2 a = 28'b0011111111111111111111111100;b=4'b0001;
		#5 $finish;
		end
endmodule