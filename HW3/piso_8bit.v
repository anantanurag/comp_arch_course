`timescale 1ns/10ps

module tb_piso_8bit();

wire piso_out;
reg [7:0] a;
reg clock, reset;

piso_8bit uut(piso_out, a, clock, reset);

initial
begin
	#00 clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#00 reset = 1'b1;
	#50 reset = 1'b0;
	#500 reset = 1'b1;
end

initial
begin
	#10 a = 8'b0101_1100;
	#110 a = 8'b0000_0000;
	#110 a = 8'b1100_1100;
	#110 $stop;
end

initial
begin
	$monitor("time=%3d, piso_out=%b, a=%8b, clock=%1b, reset=%1b", $time, piso_out, a, clock, reset);
end

initial
begin
	$dumpfile("piso_8bit.vcd");
	$dumpvars;
end

endmodule

module piso_8bit(piso_out, a, clock, reset);

output reg piso_out;
input wire [7:0] a;
input wire clock, reset;

always @(posedge clock or reset) begin
	if (reset) begin
		i = 0;
		piso_out = 1'b0;
	end
	else begin
		piso_out = a[0];
		a >> 1;
	end
end

endmodule