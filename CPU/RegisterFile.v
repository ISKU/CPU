module RegisterFile(clk, nRESET, write_enable, write_addr, write_data, read_addr_A, read_addr_B, read_data_A, read_data_B);

   input clk; // 클럭
   input nRESET; // 리셋
   input write_enable; // 쓰기를 사용할 것인지 나타낼 enable 비트
	
   input [2:0] write_addr; // 쓰기를 할 주소
   input [15:0] write_data; // 쓰기 할 값
   input [2:0] read_addr_A; 
   input [2:0] read_addr_B; // 읽어올 값의 주소 A, B
   output [15:0] read_data_A;
   output [15:0] read_data_B; // 주소에 대해 읽어온 값 A, B

   reg [15:0] reg_0;
   reg [15:0] reg_1;
   reg [15:0] reg_2;
   reg [15:0] reg_3;
   reg [15:0] reg_4;
   reg [15:0] reg_5;
   reg [15:0] reg_6;
   reg [15:0] reg_7; // 각 주소마다의 레지스터 파일에 저장된 실제 값

   wire [7:0] decoder_out; // 주소를 통하여 쓰기할 때 어떤 레지스터 파일을 선택할지 결정할 디코더
   wire [7:0] reg_enable; // 각 레지스터 파일에 연결될 enable 비트 

   assign decoder_out =
      (write_addr == 3'b000) ? 8'd1 :
      (write_addr == 3'b001) ? 8'd2 :
      (write_addr == 3'b010) ? 8'd4 :
      (write_addr == 3'b011) ? 8'd8 :
      (write_addr == 3'b100) ? 8'd16 :
      (write_addr == 3'b101) ? 8'd32 :
      (write_addr == 3'b110) ? 8'd64 :
      (write_addr == 3'b111) ? 8'd128 : 8'bx;
	// 쓰기를 할 때 각 주소(8개) 마다의 레지스터 파일(8개)을 결정한다.
   
   assign reg_enable[0] = write_enable & decoder_out[0];
   assign reg_enable[1] = write_enable & decoder_out[1];
   assign reg_enable[2] = write_enable & decoder_out[2];
   assign reg_enable[3] = write_enable & decoder_out[3];
   assign reg_enable[4] = write_enable & decoder_out[4];
   assign reg_enable[5] = write_enable & decoder_out[5];
   assign reg_enable[6] = write_enable & decoder_out[6];
   assign reg_enable[7] = write_enable & decoder_out[7];
	// 각 레지스터 파일(8개)에 디코더로부터 얻은 신호와 AND연산하여 어떤 레지스터 파일에 쓰기를 할 것인지 enable을 통해 결정
   
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_0 <= 16'b0;
      else if (reg_enable[0])
         reg_0 <= write_data;
	// 첫번째 레지스터 파일에 값을 쓴다.
   
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_1 <= 16'b0;
      else if (reg_enable[1])
         reg_1 <= write_data;
	// 두번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_2 <= 16'b0;
      else if (reg_enable[2])
         reg_2 <= write_data;
	// 세번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_3 <= 16'b0;
      else if (reg_enable[3])
         reg_3 <= write_data;
	// 네번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_4 <= 16'b0;
      else if (reg_enable[4])
         reg_4<= write_data;
 	// 다번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_5 <= 16'b0;
      else if (reg_enable[5])
         reg_5 <= write_data;
	// 여섯번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_6 <= 16'b0;
      else if (reg_enable[6])
         reg_6 <= write_data;
	// 일곱번째 레지스터 파일에 값을 쓴다.
	
   always @ (posedge clk or negedge nRESET)
      if (!nRESET)
         reg_7 <= 16'b0;
      else if (reg_enable[7])
         reg_7 <= write_data;
	// 여덟번째 레지스터 파일에 값을 쓴다.
	
   assign read_data_A =
      (read_addr_A == 3'b000) ? reg_0 :
      (read_addr_A == 3'b001) ? reg_1 :
      (read_addr_A == 3'b010) ? reg_2 :
      (read_addr_A == 3'b011) ? reg_3 :
      (read_addr_A == 3'b100) ? reg_4 :
      (read_addr_A == 3'b101) ? reg_5 :
      (read_addr_A == 3'b110) ? reg_6 :
      (read_addr_A == 3'b111) ? reg_7 : 16'bx;
	// A로부터 주소에 대한 값을 읽어올 때 현재 주소에 저장된 값을 결정
   
   assign read_data_B =
      (read_addr_B == 3'b000) ? reg_0 :
      (read_addr_B == 3'b001) ? reg_1 :
      (read_addr_B == 3'b010) ? reg_2 :
      (read_addr_B == 3'b011) ? reg_3 :
      (read_addr_B == 3'b100) ? reg_4 :
      (read_addr_B == 3'b101) ? reg_5 :
      (read_addr_B == 3'b110) ? reg_6 :
      (read_addr_B == 3'b111) ? reg_7 : 16'bx;
  	// B로부터 주소에 대한 값을 읽어올 때 현재 주소에 저장된 값을 결정
endmodule 