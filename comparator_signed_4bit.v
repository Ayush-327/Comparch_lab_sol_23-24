module signa(A,neg);
	input [3:0] A;
	output neg;
	reg neg;
	always@(A)
		begin
		if(A[3]==1)
			begin
			neg = 1;
			end
		else
			begin
			neg =0;
			end
		end
endmodule

module compar(A,B,signA, signB,AgtB, AeqB, AltB);
	input [3:0]A,B;
	input signA, signB;
	output AgtB, AeqB, AltB;
	reg AgtB, AeqB, AltB;
	signa s1(A,signA);
	signa s2(B,signB);
	always@(A or B or signA or signB)
		begin
		if(signA==1 && signB==0)
			begin
			AgtB = 0;
			AeqB = 0;
			AltB = 1;
			end
		else if(signA==0 && signB==1)
			begin
			AgtB = 1;
			AeqB = 0;
			AltB = 0;
			end
		else if(A>B)
			begin
			AgtB = 1;
			AeqB = 0;
			AltB = 0;
			end
		else if(A==B)
			begin
			AgtB = 0;
			AeqB = 1;
			AltB = 0;
			end
		else
			begin
			AgtB = 0;
			AeqB = 0;
			AltB = 1;
			end
		end 
endmodule 

module testbench;
 reg [3:0]x;
 reg [3:0]y;
 wire AgtB, AeqB, AltB;
 wire signA, signB;
 compar c1(x,y,signA, signB, AgtB, AeqB, AltB);
 initial
 $monitor(,$time," A=%b , B=%b , AgtB=%b , AeqB=%b , AltB=%b",x,y,AgtB,AeqB,AltB);
 initial
 begin
 #0 x=4'b1011;y=4'b0111;
 #1 x=4'b0111;y=4'b1001;
 #2 x=-7;y=-3;
 #1 x=-3;y=-3;
 #3 $finish;
 end
endmodule
