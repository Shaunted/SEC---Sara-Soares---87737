`timescale 1ns / 1ps
`include "xdefs.vh"


// 1 clock = 20ns
// 1 second = 50000000 clocks

module timer(
        input rst,
        input clk,
        //display interface
        output reg [1:0] hour1,
        output reg [3:0] hour0,
        output reg [2:0] min1,
        output reg [3:0] min0,
        //cpu interface
        input sel,
        input [5:0] data_in,
        output [5:0] data_out,
        input  address,
        input write_en
);

reg [25:0] c;
reg [5:0] s;
reg [3:0] m;
reg [1:0] h;

always @(posedge clk) begin
    if (rst) begin
        s <= 0;
        m <= 0;
        h <= 0;
        c <= 0;
    end else begin
        if(c == 50000000 - 1) begin
            c <= 0;
        end
        else begin
            c <=  c + 1;
        end

        if (c == 50000000 - 1) begin
            s <= s + 1;
            if (s == 59) begin
                s <= 0;
            end
        end

        if ( s == 59) begin
            m <= m + 1;
            if ( m == 9) begin
                time[3:0] <= 0;
                time[6:0] <= time[6:0] + 1;
                if (time[6:0] == 5)
                    time[6:0] <= 0;
            end
        end

        if (time[6:0]==5 && time[3:0]==9) begin
            h <= h + 1;
            if ( h == 3) begin
                time[10:7] <= 0;
                time[12:11] <= time[12:11] + 1;
                if(time[12:11] == 2)
                    time[12:11] <= 0;
            end    
        end
    end
end
endmodule