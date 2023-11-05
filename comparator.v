module comparator(a3,a2,a1,a0,b3,b2,b1,b0,x,y,z); // x: b is greater, y: b is smaller, z is equal
input a3,a2,a1,a0,b3,b2,b1,b0;
output x,y,z;
wire c3,c2,c1,c0, d3,d2,d1,d0;
	not(c3,a3);
	not(c2,a2);
	not(c1,a1);
	not(c0,a0);
	not(d3,b3);
	not(d2,b2);
	not(d1,b1);
	not(d0,b0);
wire e,f,g,h,i,j,k,l;
	and(e,c3,b3);
	and(f,a3,d3);
	and(g,c2,b2);
	and(h,a2,d2);
	and(i,c1,b1);
	and(j,a1,d1);
	and(k,c0,b0);
	and(l,a0,d0);
wire m,n,o,p;
	nor(m,e,f);
	nor(n,g,h);
	nor(o,i,j);
	nor(p,k,l);
wire q,r,s,t,u,v;
	and(q,m,g);
	and(r,m,h);
	and(s,m,n,i);
	and(t,m,n,j);
	and(u,m,n,o,k);
	and(v,m,n,o,l);
	
	or(x,e,q,s,u);
	or(y,f,r,t,v);
	and(z,m,n,o,p);
endmodule


module tb_comparator;
reg a3,a2,a1,a0,b3,b2,b1,b0;
wire x,y,z;
comparator comp(a3,a2,a1,a0,b3,b2,b1,b0,x,y,z);
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