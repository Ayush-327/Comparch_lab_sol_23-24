module jk_ff(J,K,q,clk);
	input J,K,clk;
	output q;
	reg q;
	initial 
		q = 1'b0;
	always@(posedge clk)
		case({J,K})
		2'b00:q<=q;
		2'b01:q<=1'b0;
		2'b10:q<=1'b1;
		2'b11:q<=~q;
		endcase
endmodule


module syncCounter(counterEn,clk,Q);
	input clk, counterEn;
	output [3:0]Q;
	wire w0,w1,w2;
	jk_ff j0(counterEn,counterEn,Q[0],clk);
	and(w2,Q[0],counterEn);
	jk_ff j1(w2,w2,Q[1],clk);
	and (w0,w2,Q[1]);
	jk_ff j2(w0,w0,Q[2],clk);
	and (w1,w0,Q[2]);
	jk_ff j3(w1,w1,Q[3],clk);
endmodule

module syncCounter_test;
	reg clk,counterEn;
	wire [3:0]q;
	syncCounter sc(counterEn,clk,q);
	initial
		begin
		$monitor($time," output=%b", q);
		#0 clk=1'b0; counterEn=1'b0;
		#10 counterEn=1'b1;
		#165 $finish;
		end
	always
		#5 clk=~clk;
		initial
	begin
$dumpfile("filename.vcd");
$dumpvars;
end
endmodule