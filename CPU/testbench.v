module testbench;
	reg clk, nRESET;
	integer i;

	/* clock generator */
	always begin
		#2.5 clk = ~clk;
		
		// 레지스터에 저장된 결과 값 확인
		$display("0: %b", icpu.ireg_file.reg_0);
		$display("1: %b", icpu.ireg_file.reg_1);
		$display("2: %b", icpu.ireg_file.reg_2);
		$display("3: %b", icpu.ireg_file.reg_3);
		$display("4: %b", icpu.ireg_file.reg_4);
		$display("5: %b", icpu.ireg_file.reg_5);
		$display("6: %b", icpu.ireg_file.reg_6);
		$display("7: %b", icpu.ireg_file.reg_7);
	end
	
	/* tiny cpu */
	CPU icpu(clk, nRESET);

	initial begin
		$readmemb("machine_code.txt", icpu.imem.mem); // program code given in txt file
		clk = 1'b0;
		nRESET = 1'b1;
		#5 nRESET = 1'b0;
		#5 nRESET = 1'b1;
		
		// Memory에 instruction 코드 저장 확인
		for (i=0; i<20; i = i + 1)
			$display("mem: %b", icpu.imem.mem[i]);
			
		#1000
		$finish;
	end
endmodule 