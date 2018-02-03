`timescale 1ns/10ps

module tb_priority_encoder_4x2();
wire [1:0] Y;
wire V;
reg [3:0] I;

initial
begin
	#0 I = 4'b0000;
	#20 I = 4'b0001;
	#20 I = 4'b0010;
	#20 I = 4'b0011;
	#20 I = 4'b0101;
	#20 I = 4'b1011;
	#20 I = 4'b1111;
	#20 $stop;
end

initial
begin
	$monitor("time=%3d, Y=%2b, V=%b, I=%4b", $time, Y, V, I);
end

initial
begin
	$dumpfile("priority_encoder_4x2.vcd");
	$dumpvars;
end


endmodule


module priority_encoder_4x2(Y,V,I);
output wire [1:0] Y;
output wire V;
input wire [3:0] I;

wire i_2_bar, and_out_1, v_interm;

or O1(Y[0], I[3], I[2]);
not N1(i_2_bar, I[2]);
and A1(and_out_1, i_2_bar, I[1]);
or O2(Y[1], and_out_1, I[3]);
or O3(v_interm, Y[0], I[1]);
or O4(V, v_interm, I[0]);

endmodule