module bcd_to_gray(a,b,c,d,w,x,y,z);
input a,b,c,d;
output w,x,y,z;
	assign w = a;
	assign x = (a&~b)|(~a&b);
	assign y = (c&~b)|(~c&b);
	assign z = (c&~d)|(~c&d);
endmodule

module tb_bcd_to_gray;
reg a,b,c,d;
wire w,x,y,z;
bcd_to_gray btg(a,b,c,d,w,x,y,z);
initial
begin
	$monitor(,$time," a=%b, b=%b, c=%b d=%b w=%b x=%b y=%b z=%b",a,b,c,d,w,x,y,z);
	#0 a=1'b0;b=1'b0; c=1'b0; d=1'b0;
	#1 a=1'b0;b=1'b0; c=1'b0; d=1'b1;
	#2 a=1'b0;b=1'b0; c=1'b1; d=1'b0;
	#3 a=1'b0;b=1'b0; c=1'b1; d=1'b1;
	#4 a=1'b0;b=1'b1; c=1'b0; d=1'b0;
	#5 a=1'b0;b=1'b1; c=1'b0; d=1'b1;
	#6 a=1'b0;b=1'b1; c=1'b1; d=1'b0;
	#7 a=1'b0;b=1'b1; c=1'b1; d=1'b1;
	#8 a=1'b1;b=1'b0; c=1'b0; d=1'b0;
	#9 a=1'b1;b=1'b0; c=1'b0; d=1'b1;
	#10 $finish;
end
endmodule