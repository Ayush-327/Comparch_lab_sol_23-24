module encoder_8to3(function_code, op_code);
	input [7:0] function_code;
	output [2:0] op_code;
	reg [2:0] temp;
	always @(function_code)
		begin
		if(function_code==0)
			temp = 3'b000;    //add
		if(function_code==1)
			temp = 3'b001;    //sub
		if(function_code==2)
			temp = 3'b010;    //xor
		if(function_code==3)
			temp = 3'b011;    //or
		if(function_code==4)
			temp = 3'b100;    //and
		if(function_code==5)
			temp = 3'b101;    //nor
		if(function_code==6)
			temp = 3'b110;    //nand
		if(function_code==7)
			temp = 3'b111;    //xnor
		end
	assign op_code = temp;
endmodule


module alu(A,B,opcode,X);
	input [3:0]A,B;
	input [2:0]opcode;
	output [3:0]X;
	reg [3:0] temp;
	always @(*)
		begin
		if(opcode==0) //add
			temp=A+B;
		if(opcode==1) //sub
			temp=A-B;
		if(opcode==2) //xor
			temp=A^B;
		if(opcode==3) //or
			temp=A|B;
		if(opcode==4) //and
			temp=A&B;
		if(opcode==5) //nor
			temp=A~|B;
		if(opcode==6) //nand
			temp=~(A&B);
		if(opcode==7) //xnor
			temp=A~^B;
		end
	assign X = temp;
endmodule


module even_parity(a,parity);
	input [3:0]a;
	output parity;
	integer c;
	reg parity;
	always @(*)
		begin
		parity = 1'b0;
		c=1'b0;
		while(c<4)
			begin
			if(a[c]==1)
				parity = ~parity;
			c = c+1;
			end
		end
endmodule


module register_3bit(q,d,clk,reset);
	input [2:0]d;
	input clk, reset;
	output [2:0]q;
	reg [2:0]q;
	always @(posedge clk or negedge reset)
		begin
		if(reset ==0)
			q= 3'd0;
		else
			q=d;
		end
endmodule


module register_4bit(q,d,clk,reset);
	input [3:0]d;
	input clk, reset;
	output [3:0]q;
	reg [3:0]q;
	always @(posedge clk or negedge reset)
		begin
		if(reset ==0)
			q= 4'd0;
		else
			q=d;
		end
endmodule


module pipeline(A,B,operation,out,clk);
	input [3:0]A,B;
	input [7:0]operation;
	input clk;
	output out;
	wire [2:0]opcode,ctrl_alu;
	wire [3:0]A_alu,B_alu,X_parity,X;
	encoder_8to3 e1(operation,opcode);
	register_3bit Ctrl(ctrl_alu,opcode,clk,1'b1);
	register_4bit A1(A_alu,A,clk,1'b1);
	register_4bit B1(B_alu,B,clk,1'b1);
	alu a1(A_alu,B_alu,ctrl_alu,X);
	register_4bit X1(X_parity,X,clk,1'b1);
	even_parity e2(X_parity,out);
endmodule
	
module tb_pipeline;
	reg [3:0]A,B;
	reg [7:0]operation;
	reg clk;
	wire out;
	pipeline p1(A,B,operation,out,clk);
	initial 
		$monitor($time,", clk=%b, Operation=%b, A=%b, B=%b, Output=%b",clk,operation,A,B,out);
	always
		#1 clk = ~clk;
	initial
		begin
		#0 clk=1'b0; operation=8'd0; A =4'd4; B=4'd3;
		#2 operation=8'd0; A =4'd4; B=4'd5;
		#10 $finish; 
		end
endmodule