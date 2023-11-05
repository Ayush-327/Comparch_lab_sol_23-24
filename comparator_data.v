module comparator_data(a3,a2,a1,a0,b3,b2,b1,b0,x,y,z); // x: b is greater, y: b is smaller, z is equal
input a3,a2,a1,a0,b3,b2,b1,b0;
output x,y,z;
	assign x = (((b3&(~a3)) | (a3~^b3)&(b2&~a2)) | (a3~^b3)&(a2~^b2)&(b1&~a1)) | (a3~^b3)&(a2~^b2)&(a1~^b1)&(b0&~a0);
	assign y = ~b3&a3 | (a3~^b3)&(~b2&a2) | (a3~^b3)&(a2~^b2)&(~b1&a1) | (a3~^b3)&(a2~^b2)&(a1~^b1)&(~b0&a0);
	assign z = (a3~^b3)&(a2~^b2)&(a1~^b1)&(a0~^b0);
endmodule


module tb_comparator_data;
reg a3,a2,a1,a0,b3,b2,b1,b0;
wire x,y,z;
comparator_data comp(a3,a2,a1,a0,b3,b2,b1,b0,x,y,z);
initial
begin
	$monitor(,$time," a3=%b, a2=%b, a1=%b a0=%b b3=%b b2=%b b1=%b b0=%b x=%b y=%b z=%b",a3,a2,a1,a0,b3,b2,b1,b0,x,y,z);
	#0 a3=1'b0;a2=1'b0; a1=1'b0; a0=1'b0; b3=1'b0;b2=1'b0; b1=1'b0; b0=1'b0;
	#1 a3=1'b0;a2=1'b0; a1=1'b0; a0=1'b0; b3=1'b0;b2=1'b0; b1=1'b0; b0=1'b1;
	#2 a3=1'b0;a2=1'b0; a1=1'b1; a0=1'b0; b3=1'b0;b2=1'b0; b1=1'b0; b0=1'b0;
	#3 a3=1'b1;a2=1'b0; a1=1'b1; a0=1'b0; b3=1'b1;b2=1'b1; b1=1'b0; b0=1'b0;
	#2 a3=1'b1;a2=1'b1; a1=1'b0; a0=1'b1; b3=1'b1;b2=1'b1; b1=1'b0; b0=1'b1;
	#10 $finish;
end
endmodule