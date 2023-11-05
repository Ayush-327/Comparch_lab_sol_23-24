module mux4_1_32bit(regData,q1,q2,q3,q4,reg_no);
	output [31:0]regData;
	reg [31:0] regData;
	input [31:0] q1,q2,q3,q4;
	input [1:0]reg_no;
	always @(reg_no)
		begin 
		if(reg_no==2'b00)
			regData = q1;
		else if(reg_no==2'b01)
			regData = q2;
		else if(reg_no==2'b10)
			regData = q3;
		else 
			regData = q4;
		end
endmodule

module tb_mux;
	wire [31:0] regData;
	reg [1:0] reg_no;
	reg [31:0]q1,q2,q3,q4;
	mux4_1_32bit m1(regData,q1,q2,q3,q4,reg_no);
	initial
		$monitor($time," q1=%b, q2=%b, q3=%b, q4=%b, reg_no=%b, regData=%b",q1,q2,q3,q4,reg_no,regData);
	initial
		begin
		#0 q1 = 32'd1; q2=32'd2; q3=32'd3; q4=32'd4; 
		#1 reg_no = 2'b00; 
		#1 reg_no = 2'b01; 
		#1 reg_no = 2'b10; 
		#1 reg_no = 2'b11; 
		#1 reg_no = 2'b10;
		end
		
endmodule