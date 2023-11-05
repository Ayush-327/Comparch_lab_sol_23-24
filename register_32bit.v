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

module tb32reg;
	reg [31:0] d;
	reg clk,reset;
	wire [31:0] q;
	reg_32bit R(q,d,clk,reset);
	always @( clk)
		begin
		$display($time," d=%b, clk=%b, rst=%b, q=%b\n", d, clk, reset, q);
		end
	always @(clk)
		#5 clk<=~clk;
	initial
		begin
		clk= 1'b1;
		reset=1'b0;//reset the register
		#20 reset=1'b1;
		#20 d=32'hAFAFAFAF;
		#10 $finish;
		end
endmodule