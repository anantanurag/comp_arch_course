`timescale 1ns/10ps

module tb_full_adder();

wire fa_out, cout;
reg ain, bin, cin;

full_adder uut(fa_out, cout, ain, bin, cin);

initial
begin
	#00 clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#10 ain = 1'b0; bin = 1'b0; cin = 1'b0;
	#20 ain = 1'b1; bin = 1'b0; cin = 1'b1;
	#20 ain = 1'b0; bin = 1'b1; cin = 1'b0;
	#20 ain = 1'b1; bin = 1'b0; cin = 1'b1;
	#20 ain = 1'b0; bin = 1'b0; cin = 1'b0;
	#20 ain = 1'b1; bin = 1'b0; cin = 1'b1;
	#20 ain = 1'b0; bin = 1'b1; cin = 1'b0;
	#20 ain = 1'b1; bin = 1'b0; cin = 1'b1;
	#20 ain = 1'b0; bin = 1'b1; cin = 1'b0;
	#20 $stop
end

initial
begin
	$monitor("time=%3d, fa_out=%b, cout=%b, ain=%b, bin=%b, cin=%b", $time, fa_out, cout, ain, bin, cin);
end

initial
begin
	$dumpfile("full_adder.vcd");
	$dumpvars;
end

endmodule

module full_adder(fa_out, cout, ain, bin, cin);

output wire fa_out, cout;
input reg ain, bin, cin;

assign {cout, fa_out} = ain + bin + cin;

endmodule