`timescale 1ns/10ps

module tb_sipo_8bit();
wire [7:0] sum;
reg in_bit, clock, reset;

sipo_8bit uut(sum, in_bit, clock, reset);

initial
begin
	#00 clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#00 reset = 1'b1;
	#50 reset = 1'b0;
end

initial
begin
	#10 in_bit = 1'b0;
	#20 in_bit = 1'b0;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b0;
	#20 in_bit = 1'b0;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b0;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b0;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 in_bit = 1'b1;
	#20 $stop;
end


initial
begin
	$monitor("time=%3d, sum=%8b, in_bit=%b, clock=%b, reset=%b");
end
initial
begin
	$dumpfile("sipo_8bit.vcd");
	$dumpvars;
end

endmodule

module sipo_8bit(sum, in_bit, clock, reset);

output reg [7:0] sum;
input wire in_bit, clock, reset;

always @(posedge clock or reset) begin
	if (reset) begin
		sum = 8'b0000_0000;		
	end
	else begin
		sum << 1;
		sum[0] = in_bit;
	end
end

endmodule