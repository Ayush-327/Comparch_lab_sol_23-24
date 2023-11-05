module mux2to1(sel,inp1,inp2,out);
	input sel,inp1,inp2;
	output out;
	wire not_sel,a1,a2;
	not(not_sel,sel);
	and(a1,not_sel,inp1);
	and(a2,sel,inp2);
	or(out,a1,a2);
endmodule;
	