`timescale 1ns/10ps

module tb_df_comparator_8b();

wire AeqB, AgtB, AltB;
reg [7:0] A, B;
reg s;

df_comparator_8b uut(AeqB, AgtB, AltB, A, B, s);

initial
begin
	#00 A = 8'b0000_0000; B = 8'b0000_0000; s = 1'b0;
	#20 A = 8'b0000_0001; B = 8'b0000_0000; s = 1'b0;
	#20 A = 8'b0000_0000; B = 8'b0001_0000; s = 1'b0;
	#20 A = 8'b1100_0000; B = 8'b0100_0000; s = 1'b1;
	#20 A = 8'b0001_0000; B = 8'b1000_0000; s = 1'b1;
	#20 $stop;
end

initial
begin
	$monitor("time=%3d, AeqB=%b, AgtB=%b, AltB=%b, A=%b, B=%b. s=%b", $time, AeqB, AgtB, AltB, A, B, s);
end

initial
begin
	$dumpfile("df_comparator_8b.vcd");
	$dumpvars;
end

endmodule




module df_comparator_8b(AeqB, AgtB, AltB, A, B, s);

output wire AeqB, AgtB, AltB;
input wire [7:0] A, B;
input wire s;


wire sign_AeqB, sign_AgtB, sign_AltB; 
wire unsign_AeqB, unsign_AgtB, unsign_AltB;

wire signed [7:0] A_s, B_s;

assign A_s = A;
assign B_s = B;


assign unsign_AeqB = A==B?1'b1:1'b0;
assign unsign_AgtB = A>B?1'b1:1'b0;
assign unsign_AltB = A<B?1'b1:1'b0;

assign sign_AeqB = A_s==B_s?1'b1:1'b0;
assign sign_AgtB = A_s>B_s?1'b1:1'b0;
assign sign_AltB = A_s<B_s?1'b1:1'b0;

assign AeqB = (s&sign_AeqB)|((~s)&unsign_AeqB); 
assign AgtB = (s&sign_AgtB)|((~s)&unsign_AgtB); 
assign AltB = (s&sign_AltB)|((~s)&unsign_AltB); 

endmodule