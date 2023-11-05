module not_32bits(inp,out);
	input [31:0]inp;
	output [31:0]out;
	genvar j;
	generate for(j=0; j<32; j=j+1)
		begin: not_loop
			   not n1(out[j],inp[j]);
		end
	endgenerate
endmodule;

module tbnot_32bit;
	reg [31:0] a;
	wire [31:0] Result;
	not_32bits n1(a,Result);
	initial
		$monitor($time," IN=%b, Result=%b",a,Result);
	initial
		begin
		a=32'ha5a5a5a5;
		#200 $finish;
		end
endmodule