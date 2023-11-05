module FA_dataflow (Cout, Sum,In1,In2,Cin);
 input [31:0]In1,In2;
 input Cin;
 output  Cout;
 output  [31:0]Sum;
 assign {Cout,Sum}=In1+In2+Cin;
endmodule

module FA;
 reg [31:0] IN1,IN2;
 reg Cin;
 wire [31:0] SUM;
 wire Cout;
 FA_dataflow a1(Cout,SUM,IN1,IN2,Cin);
 initial
 $monitor($time," IN1=%b, IN2=%b, Cin=%b, Cout=%b, Sum=%b",IN1, IN2,Cin,Cout,SUM);
 initial
 begin
 IN1=32'b10000000000000000000000000000001;
 IN2=32'b10000000000000000000000000000001;
 Cin = 1'b0;
 
 #400 $finish;
 end
endmodule