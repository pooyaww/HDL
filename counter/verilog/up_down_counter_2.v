module up_down_counter (clk, reset, enable, up_down, counter);
input clk, reset, enable, up_down;
output [3:0] counter;
reg [3:0] counter_up_down = 4'h0;

always @(posedge clk)
begin
    if (reset)
        counter_up_down <= 4'h0;
    else if (enable)
        counter_up_down <= up_down ? counter_up_down + 1 : counter_up_down - 1;
end
assign counter = counter_up_down;
endmodule
