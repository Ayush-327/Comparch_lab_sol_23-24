module instruction_memory(PC, instruction);
	input [4:0]PC;
	output [31:0]instruction;
	always @(PC)
		begin
		if(PC==5'd0)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd1)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd2)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd3)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd4)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd5)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd6)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd7)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd8)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd9)
			instruction = 32'b00000000000000000000000000000000;
		else if(PC==5'd10)
			instruction = 32'b00000000000000000000000000000000;
		end
endmodule