module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
input x,y,z;
output d0,d1,d2,d3,d4,d5,d6,d7;
wire x0,y0,z0;
not n1(x0,x);
not n2(y0,y);
not n3(z0,z);
and a0(d0,x0,y0,z0);
and a1(d1,x0,y0,z);
and a2(d2,x0,y,z0);
and a3(d3,x0,y,z);
and a4(d4,x,y0,z0);
and a5(d5,x,y0,z);
and a6(d6,x,y,z0);
and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
input x,y,z;
wire d0,d1,d2,d3,d4,d5,d6,d7;
output s,c;
DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
assign s = d1 | d2 | d4 | d7,
 c = d3 | d5 | d6 | d7;
endmodule

module FADDER_8(s,c,x,y);
	input [0:7]x;
	input [0:7]y;
	wire a,b,d,e,f,g,h,i;
	output [0:7]s;
	output c;
	FADDER f0(s[0],a,x[0],y[0],1'b0);
	FADDER f1(s[1],b,x[1],y[1],a);
	FADDER f2(s[2],d,x[2],y[2],b);
	FADDER f3(s[3],e,x[3],y[3],d);
	FADDER f4(s[4],f,x[4],y[4],e);
	FADDER f5(s[5],g,x[5],y[5],f);
	FADDER f6(s[6],h,x[6],y[6],g);
	FADDER f7(s[7],c,x[7],y[7],h);
endmodule

module testbench;
 reg [7:0]x;
 reg [7:0]y;
 wire [7:0]s;
 wire c;
 FADDER_8 f(s,c,x,y);
 initial
 $monitor(,$time," x=%b,y=%b,,s=%b,c=%b",x,y,s,c);
 initial
 begin
 #0 x=7;y=8'b00000000;
 #2 x=8'b00011111;y=8'b00101010;
 #2 x=8'b00000000;y=8'b11111111;
 #2 x=8'b01010101;y=8'b00000001;
 #2 x=8'b00111011;y=8'b10100000;
 #2 x=8'b11111111;y=8'b11111111;
 end
endmodule
