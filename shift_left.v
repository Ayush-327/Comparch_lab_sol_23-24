module shiftLeft(inp,out);
	input [25:0] inp;
	output [27:0] out;
	assign out = {inp[25:0], 2'b00};
endmodule;

module tb;
	reg [25:0]inp;
	wire [27:0]out;
	shiftLeft s1(inp,out);
	initial
		$monitor($time," ,input=%b, output=%b",inp,out);
	initial
		begin
		#0 inp = 26'b11001111111111111111110000;
		#2 inp = 26'b00111111111111111111111111;
		#5 $finish;
		end
endmodule