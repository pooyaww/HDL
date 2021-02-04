// PWM without comparitor
module PWM(
    input clk,
    input [3:0] PWM_in,
    output PWM_out
);

reg [3:0] cnt;
reg cnt_dir; // 0 to count up, 1 to count down
wire [3:0] cnt_next = cnt_dir ? cnt - 1'b1 : cnt + 1'1b;
wire cnt_end = cnt_dir ? cnt == 4'b0000 : cnt == 4'b1111;

// run the counter
always @(posedge clk) cnt <= cnt_end ? PWM_in : cnt_next;
// check whether the coubte ends or not with respect to counter direction
// if counter ends reverse the counter direction
always @(posedge clk) cnt_dir = cnt_dir ^ cnt_end;
//use counter reversion time for PMM generation
assign PWM_out = cnt_dir;
endmodule

