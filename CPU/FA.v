// Full Adder
module FA(cout, sum, a, b, c);
	input a, b, c;
	output cout, sum;
	assign {cout, sum} = a + b + c;
endmodule 