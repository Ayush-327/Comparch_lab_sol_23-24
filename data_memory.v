module data_memory(address, writeData, ReadData, MemWrite, MemRead);
	input [31:0]address,writeData;
	input MemRead, MemWrite;
	output [31:0] ReadData;
	reg [31:0]ReadData;
	reg [31:0] memLoc[0:31];
	always @(MemRead or MemWrite)
		begin
		if(MemRead==1)
			ReadData = memLoc[address];
		else if(MemWrite==1)
			memLoc[address] = writeData;
		end
endmodule

module tb_data_memory;
	reg [31:0]address,writeData;
	reg MemRead, MemWrite;
	wire [31:0] ReadData;
	data_memory d1(address, writeData, ReadData, MemWrite, MemRead);
	initial
		$monitor($time,"MemRead=%b, MemWrite=%b, address=%b, writeData=%b, ReadData=%b",MemRead, MemWrite, address, writeData, ReadData);
	initial
		begin
		#0 MemRead = 1'b1; address=5'b00000;
		#2 MemRead = 1'b0; MemWrite=1'b1; address=5'b00000; writeData=5'b01010;
		#2 MemRead = 1'b1; address=5'b00000;
//		#0 MemRead = 1'b1; address=5'b00000;
	//	#0 MemRead = 1'b1; address=5'b00000;
		//#0 MemRead = 1'b1; address=5'b00000;
		#5 $finish;
		end
endmodule
		