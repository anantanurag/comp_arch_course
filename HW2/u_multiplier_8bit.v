`timescale 1ns/10ps

module tb_u_multiplier_8bit();
wire [15:0] prod;
wire eop;

reg [7:0] a,b;
reg clock, reset;

u_multiplier_8bit uut(prod, eop, a, b, clock, reset);

initial
begin
	#0 clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#00 a = 8'b0000_0000; b = 8'b0000_0000;
	#20 a = 8'b0000_0000; b = 8'b0000_0000;
	#20 a = 8'b1111_1111; b = 8'b1111_1111;
	#20 a = 8'b1111_0000; b = 8'b0000_1111;
	#20 a = 8'b1010_1010; b = 8'b0101_0101;
	#20 a = 8'b1111_0000; b = 8'b0000_1111;
	#20 $stop;
end

initial
begin
	#00 reset = 1'b0;
	#90 reset = 1'b1;
	#95 reset = 1'b0;
end

initial
begin
	$monitor("time=3d, prod=16b, eop=1b, a=8b,b=8b,clock=1b, reset=1b",$time, prod, eop, a, b, clock, reset);
end

initial
begin
	$dumpfile("u_multiplier_8bit.vcd");
	$dumpvars;
end

endmodule

module u_multiplier_8bit(prod, eop, a, b, clock, reset);

output reg [15:0] prod;
output reg eop;

input wire [7:0] a,b;
input wire clock, reset;



always@(negedge clock, reset)
begin
	eop = 1'b0;
	prod = 16'b0000_0000_0000_0000;
	if (reset) 
	begin
		prod = 16'b0000_0000_0000_0000;
		eop = 1'b0;
	end
	else 
	begin
		prod = prod + (a[0] ? {8'b0000_0000, b} : 16'b0000_0000_0000_0000);
		prod = prod + (a[1] ? {7'b000_0000, b, 1'b0} : 16'b0000_0000_0000_0000);
		prod = prod + (a[2] ? {6'b00_0000, b, 2'b00} : 16'b0000_0000_0000_0000);
		prod = prod + (a[3] ? {5'b0_0000, b, 3'b000} : 16'b0000_0000_0000_0000);
		prod = prod + (a[4] ? {4'b0000, b, 4'b0000} : 16'b0000_0000_0000_0000);
		prod = prod + (a[5] ? {3'b000, b, 5'b0_0000} : 16'b0000_0000_0000_0000);
		prod = prod + (a[6] ? {2'b00, b, 6'b00_0000} : 16'b0000_0000_0000_0000);
		prod = prod + (a[7] ? {1'b0, b, 7'b000_0000} : 16'b0000_0000_0000_0000);
		eop = 1'b1;
	end
end

endmodule