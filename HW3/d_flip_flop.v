`timescale 1ns/10ps

module tb_d_flip_flop();

reg q;
wire d, clock, reset;

d_flip_flop uut(q, d, clock, reset);

initial
begin
	#00 clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#00 reset = 1'b1;
	#40 reset = 1'b0;
end

initial
begin
	#10 d = 1'b1;
	#10 d = 1'b0;
	#10 d = 1'b1;
	#10 d = 1'b0;
	#10 d = 1'b1;
	#10 d = 1'b0;
	#10 d = 1'b1;
	#10 d = 1'b0;
	#10 d = 1'b1;
	#10 $stop;
end

initial
begin
	$monitor("time=%3d, q=%b, d=%b, clock=%b, reset=%b", $time, q, d, clock, reset);
end

initial
begin
	$dumpfile("d_flip_flop.vcd");
	$dumpvars;
end
endmodule



module d_flip_flop(q, d, clock, reset);
output wire q;
input reg d, clock, reset;

always @(posedge clock or reset) begin
	if (reset) begin
		q = 1'b0;
	end
	else begin
		q = d;
	end
end
endmodule