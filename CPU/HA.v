// Half Adder
module HA(cout, sum, a, b);
	input a, b;
	output cout, sum;
	assign {cout, sum} = a + b;
endmodule 