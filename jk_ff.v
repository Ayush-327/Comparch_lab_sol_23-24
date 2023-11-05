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
		