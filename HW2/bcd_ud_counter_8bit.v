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