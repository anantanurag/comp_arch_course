module s_divider_8bit(quotient, remainder, eop, dividend, divisor, clock, reset);

output reg [7:0] remainder, quotient;
output reg eop;

input wire [7:0] dividend, divisor;
input wire clock, reset;

always @(posedge clock or reset) begin
	eop = 1'b0;
	quotient = dividend;
	remainder = 8'b0000_0000;
	if (reset) begin
		quotient = 8'b0000_0000;
		remainder = 8'b0000_0000;
		eop = 1'b0;
	end
	else begin
		quotient = quotient - (dividend[7] ? divisor>>0 : 8'b0000_0000);
		quotient = quotient - (dividend[6] ? divisor>>1 : 8'b0000_0000);
		quotient = quotient - (dividend[5] ? divisor>>2 : 8'b0000_0000);
		quotient = quotient - (dividend[4] ? divisor>>3 : 8'b0000_0000);
		quotient = quotient - (dividend[3] ? divisor>>4 : 8'b0000_0000);
		quotient = quotient - (dividend[2] ? divisor>>5 : 8'b0000_0000);
		quotient = quotient - (dividend[1] ? divisor>>6 : 8'b0000_0000);
		quotient = quotient - (dividend[0] ? divisor>>7 : 8'b0000_0000);
		eop = 1'b1;
	end
end

endmodule