`timescale 1ns/10ps

module tb_u_fa_ha_multiplier_4bit();
wire [7:0] prod;
reg [3:0] a,b;

initial
begin
	#00 a = 4'b0011; b = 4'b0101;
	#20 a = 4'b0101; b = 4'b1010;
	#20 a = 4'b1111; b = 4'b1111;
	#20 $stop;
end

initial
begin
	$monitor("$time=%3d, prod=%8b, a=%4b, b=%4b", $time, prod, a, b);
end

initial
begin
	$dumpfile("u_fa_ha_multiplier_4bit.vcd");
	$dumpvars;
end

endmodule

module u_fa_ha_multiplier_4bit(prod, a, b);

output wire [7:0] prod;
input wire [3:0] a, b;

wire w_cout_1_0;
wire w_cout_2_0, w_cout_2_1;
wire w_cout_3_0, w_cout_3_1, w_cout_3_2;
wire w_cout_4_0, w_cout_4_1;
wire w_cout_5_0;

wire w_and_1_0, w_and_1_1;
wire w_and_2_0, w_and_2_1, w_and_2_2;
wire w_and_3_0, w_and_3_1, w_and_3_2, w_and_3_3;
wire w_and_4_0, w_and_4_1, w_and_4_2;
wire w_and_5_0, w_and_5_1;
wire w_and_6_0;

wire interm_2_0, interm_3_0, interm_3_1, interm_4_0;


half_adder ha_sum_and_0_0(.cout(prod[0]), .a(a[0]), .b(b[0]) );
half_adder ha_and_1_0(.cout(w_and_1_0), .a(a[1]), .b(b[0]));
half_adder ha_and_1_1(.cout(w_and_1_1), .a(a[0]), .b(b[1]));
half_adder ha_and_2_0(.cout(w_and_2_0), .a(a[2]), .b(b[0]));
half_adder ha_and_2_1(.cout(w_and_2_1), .a(a[1]), .b(b[1]));
half_adder ha_and_2_2(.cout(w_and_2_2), .a(a[0]), .b(b[2]));
half_adder ha_and_3_0(.cout(w_and_3_0), .a(a[3]), .b(b[0]));
half_adder ha_and_3_1(.cout(w_and_3_1), .a(a[2]), .b(b[1]));
half_adder ha_and_3_2(.cout(w_and_3_2), .a(a[1]), .b(b[2]));
half_adder ha_and_3_3(.cout(w_and_3_3), .a(a[0]), .b(b[3]));
half_adder ha_and_4_0(.cout(w_and_4_0), .a(a[3]), .b(b[1]));
half_adder ha_and_4_1(.cout(w_and_4_1), .a(a[2]), .b(b[2]));
half_adder ha_and_4_2(.cout(w_and_4_2), .a(a[1]), .b(b[3]));
half_adder ha_and_5_0(.cout(w_and_5_0), .a(a[3]), .b(b[2]));
half_adder ha_and_5_1(.cout(w_and_5_1), .a(a[2]), .b(b[3]));
half_adder ha_and_6_0(.cout(w_and_6_0), .a(a[3]), .b(b[3]));


half_adder ha_sum_1_0(.sum(prod[1]), .cout(w_cout_1_0), .a(w_and_1_0), .b(w_and_1_1) );

full_adder fa_interm_sum_2_0(.sum(interm_2_0), .cout(w_cout_2_0), .a(w_and_2_0), .b(w_and_2_1), .cin(w_cout_1_0));
full_adder fa_sum_2_0(.sum(prod[2]), .cout(w_cout_2_1), .a(w_and_2_2), b(interm_2_0), .cin(w_cout_2_0));

full_adder fa_interm_sum_3_0(.sum(interm_3_0),.cout(w_cout_3_0),.a(w_and_3_0), b(w_and_3_1), .cin(w_cout_2_1));
full_adder fa_interm_sum_3_1(.sum(interm_3_1),.cout(w_cout_3_1),.a(w_cout_3_0), .b(interm_3_0), .cin(w_and_3_2));
full_adder fa_sum_3_0(.sum(prod[3]), .cout(w_cout_3_2), .a(w_and_3_3), .b(interm_3_1), .cin(w_cout_3_1)); 

full_adder fa_interm_sum_4_0(.sum(interm_4_0), .cout(w_cout_4_0), .a(w_and_4_0), .b(w_and_4_1), .cin(w_cout_3_2));
full_adder fa_sum_4_0(.sum(prod[4]), .cout(w_cout_4_1), .a(w_and_4_2), b(interm_4_0), .cin(w_cout_4_0));

full_adder fa_sum_5_0(.sum(prod[5]), .cout(w_cout_5_0), .a(w_and_5_0), .b(w_and_5_1), .cin(w_cout_4_0));

half_adder ha_sum_6_0_7_0(.sum(prod[6]), .cout(prod[7]), .a(w_and_6_0), .b(w_cout_5_0));


endmodule


module full_adder(sum, cout, a, b, cin);
output reg sum, cout;
input wire a, b, cin;

always @(*) begin
	{cout,sum} = a + b + cin;
end

endmodule



module half_adder(sum, cout, a, b);
output wire sum, cout;
input wire a, b;

assign sum = a^b;
assign cout = a&b;

endmodule