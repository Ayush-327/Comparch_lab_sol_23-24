module decoder2_4 (register,reg_no);
	input [1:0]register;
	output [3:0]reg_no;
	reg [3:0] reg_no;
	always @(register)
		begin
		if(register==2'b00)
			reg_no = 4'b0001;
		else if (register==2'b01)
			reg_no = 4'b0010;
		else if (register==2'b10)
			reg_no = 4'b0100;
		else
			reg_no = 4'b1000;
		end
endmodule

module tb_decoder2_4;
	reg [1:0]register;
	wire [3:0] reg_no;
	decoder2_4 d1(register,reg_no);
	initial
		$monitor($time, "register=%b, reg_no=%b\n",register,reg_no);
	initial
		begin
		#0 register = 2'b00;
		#1 register = 2'b01;
		#1 register = 2'b10;
		#1 register = 2'b11;
		#1 register = 2'b01;
		#2 $finish;
		end
endmodule
		