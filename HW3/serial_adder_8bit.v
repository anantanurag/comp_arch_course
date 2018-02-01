`timescale 1ns/10ps

`include "piso_8bit.v"
`include "full_adder.v"
`include "d_flip_flop.v"
`include "sipo_8bit.v"

module tb_serial_adder_8bit();
wire sum;
reg a, b, clock, reset;

serial_adder_8bit uut(sum, a, b, clock, reset);

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
	#10 a = 8'b0000_0000; b = 8'b0000_0000;
	#20 a = 8'b0000_0000; b = 8'b0000_0000;
	#20 a = 8'b0010_0000; b = 8'b0000_0010;
	#20 a = 8'b1010_1010; b = 8'b1010_0101;
	#20 a = 8'b1111_1111; b = 8'b0111_0100;
	#20 a = 8'b1111_1111; b = 8'b1111_1111;
	#20 a = 8'b0000_1000; b = 8'b0100_0000;
	#20 $stop;
end

initial
begin
	$monitor("time=%3d, sum=%8b, a=%8b, b=%8b, clock=%b, reset=%b", $time, sum, a, b, clock, reset);
end

initial
begin
	$dumpfile("serial_adder_8bit.vcd");
	$dumpvars;
end

endmodule




module serial_adder_8bit(sum, a, b, clock, reset);

output wire [7:0] sum;
input wire [7:0] a, b;
input wire clock, reset;

wire piso_1_out, piso_2_out;
wire q, d;
wire cout, fa_out;

piso_8bit piso_1(piso_1_out, a, clock, reset);
piso_8bit piso_2(piso_2_out, b, clock, reset);
full_adder fa(fa_out, cout, piso_1_out, piso_2_out, q);
d_flip_flop dff(q, d, clock, reset);
sipo_8bit sipo(sum, fa_out, clock, reset);

endmodule