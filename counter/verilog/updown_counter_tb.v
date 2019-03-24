module updowncounter_testbench();
//look that we use reg for wires and wires for reg in TB
reg clk, reset, up_down;
wire [3:0] counter;
up_down_counter: dut (clk, reset, up_down, counter);
initial begin
    clk = ;
    forever #5 clk = ~clk;
end
initial begin
    reset = 1;
    up_down = 0;
    #20;
    reset = 0;
    #200;
    up_down = 1;
end
endmodule
