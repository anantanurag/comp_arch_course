// module comparator_8bit(AeqB, AgtB, AltB, A, B, msb_signed);
	
// 	output wire AeqB, AgtB, AltB;
// 	input wire [7:0] A, B;
// 	input wire msb_signed;

// 	wire [7:0] AeqB_internal, AgtB_internal, AltB_internal;

// 	integer i;
// 	for(i = 0; i <=7; i=i+1)
// 	begin
// 		assign AeqB_internal[i] = ~(A[i]^B[i]);
// 		assign AgtB_internal[i] = A[i]&(~B[i]);
// 		assign AltB_internal[i] = (~A[i]&B[i]);
// 	end

// 	i = 7;
// 	while(AeqB_internal[i] == 1)
// 	begin
		
// 	end

// endmodule
`timescale 1ns/10ps

module tb_comparator_1bit();
	wire AeqB, AgtB, AltB;
	reg AeqB_LSB, AgtB_LSB, AltB_LSB, A, B;

	comparator_1bit uut(AeqB, AgtB, AltB, AeqB_LSB, AgtB_LSB, AltB_LSB, A, B);

	initial
	begin
		#00	AeqB_LSB = 1'b1; AgtB_LSB = 1'b0; AltB_LSB = 1'b0;
		#20 A = 1'b0; B = 1'b0;
		#20 A = 1'b0; B = 1'b1;
		#20 A = 1'b1; B = 1'b0;
		#20 A = 1'b1; B = 1'b1;

		#20	AeqB_LSB = 1'b0; AgtB_LSB = 1'b1; AltB_LSB = 1'b0;
		#20 A = 1'b0; B = 1'b0;
		#20 A = 1'b0; B = 1'b1;
		#20 A = 1'b1; B = 1'b0;
		#20 A = 1'b1; B = 1'b1;

		#20	AeqB_LSB = 1'b0; AgtB_LSB = 1'b0; AltB_LSB = 1'b1;
		#20 A = 1'b0; B = 1'b0;
		#20 A = 1'b0; B = 1'b1;
		#20 A = 1'b1; B = 1'b0;
		#20 A = 1'b1; B = 1'b1;

		#20 $stop;
	end
	
	initial
	begin
		$monitor("time=%3d, AeqB=%b, AgtB=%b, AltB=%b, AeqB_LSB=%b, AgtB_LSB=%b, AltB_LSB=%b, A=%b, B=%b", $time, AeqB, AgtB, AltB, AeqB_LSB, AgtB_LSB, AltB_LSB, A, B);
	end

	initial
	begin
		$dumpfile("comparator_1bit.vcd");
		$dumpvars;
	end
endmodule
	


module comparator_1bit(AeqB, AgtB, AltB, AeqB_LSB, AgtB_LSB, AltB_LSB, A, B);
	
	output reg AeqB, AgtB, AltB;
	input wire AeqB_LSB, AgtB_LSB, AltB_LSB, A, B;

	wire AeqB_temp;
	assign AeqB_temp = ~(A^B);
	
	always@(*)
	begin
		if ((AeqB_temp == 1'b1)&&(AeqB_LSB == 1'b1))
		begin
			 AeqB = 1'b1;
			 AgtB = 1'b0;
			 AltB = 1'b0;
		end
		else if (AeqB_temp == 1'b1 && AgtB_LSB == 1'b1) 
		begin
			 AgtB = 1'b1;
			 AeqB = 1'b0;
			 AltB = 1'b0;
		end
		else if (AeqB_temp == 1'b1 && AltB_LSB == 1'b1) 
		begin
			 AltB = 1'b1;
			 AeqB = 1'b0;
			 AgtB = 1'b0;	
		end
		else if (A&(~B) == 1'b1)
		begin
			 AgtB = 1'b1;
			 AeqB = 1'b0;
			 AltB = 1'b0;
		end
		else 
		begin
			 AltB = 1'b1;	
			 AeqB = 1'b0;
			 AgtB = 1'b0;
		end
	end
endmodule