`include "comparator_1bit.v"

module comparator_7bit(AeqB, AgtB, AltB, AeqB_LSB, AgtB_LSB, AltB_LSB, A, B);

	output reg AeqB, AgtB, AltB;
	input wire AeqB_LSB, AgtB_LSB, AltB_LSB, A, B;

endmodule

