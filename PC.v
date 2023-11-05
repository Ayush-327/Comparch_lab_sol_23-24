module PC_32bit(q,d,clk,reset);
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
