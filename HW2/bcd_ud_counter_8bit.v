`timescale 1ns/10ps

module tb_bcd_ud_counter_8bit();
wire [3:0] high, low;
reg ud, clock, reset;

bcd_ud_counter_8bit uut(high, low, ud, clock, reset);

initial
begin
	#00	clock = 1'b0;
	forever #20 clock = ~clock;
end

initial
begin
	#00 ud = 1'b1;
	#1250 ud = 1'b0;
	#1250 ud = 1'b0;
	#1250 $stop
end

initial
begin
	#00 reset = 1'b0;
	#30 reset = 1'b1;
	#2000 reset = 1'b0;
	#30 reset = 1'b1;
end

initial
begin
	$monitor("time=%3d, high=%4b, low=%4b, ud=%b, clock=%b, reset=%b", $time, high, low, ud, clock, reset);
end

initial
begin
	$dumpfile("bcd_ud_counter_8bit.vcd");
	$dumpvars;
end

endmodule


module bcd_ud_counter_8bit(high, low, ud, clock, reset);

output reg [3:0] high, low;

input wire ud, clock ,reset;

parameter limit_msb = 1'd5;

always@*(negedge clock, ~reset)
begin
	if(!reset)
	begin
		if(ud)
		begin
			if(high==limit_msb && low==4'b1001)
			begin
				low = 4'b0000;
				high = 4'b0000;
			end
			else if (high != limit_msb && low==4'b1001)
			begin
				low = 4'b0000;
				high = high + 4'b0001;
			end
			else if(high==limit_msb && low!=4'b1001)
			begin
				low = low+4'b0001;
			end
			else 
			begin
				low = low+4'b0001;	
			end
		end
		else 
		begin
			if(high==4'b0000 && low==4'b0000)
			begin
				low = 4'b1001;
				high = limit_msb;
			end
			else if (high != 4'b0000 && low==4'b0000)
			begin
				low = 4'b1001;
				high = high - 4'b0001;
			end
			else if(high==4'b0000 && low!=4'b0000)
			begin
				low = low-4'b0001;
			end
			else 
			begin
				low = low-4'b0001;	
			end
		end
	end
	else 
	begin
		high = 4'b0000;
		low = 4'b0000;	
	end
end
endmodule