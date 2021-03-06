module PWM(
    input clk,
    input [3:0] PWM_in,
    output PWM_out
);

reg [3:0] cnt;
always @(posedge clk) cnt <= cnt + 1'b1; // free-running counter

assign PWM_out = (PWM_in > cnt); // comparator, this statement replace an if-condition statement

endmodule
