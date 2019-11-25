`timescale 1ns / 1ps

module sense_amplifier (
    inout   bl,
    inout   blb
);

assign bl = ~blb;
assign blb = ~bl;

endmodule


module mc_tb();

wire bl, blb;

sense_amplifier mc(
    .bl(bl),
    .blb(blb)
);

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;

    drive_bl = 'Z';
    drive_blb = 'Z';
    
    #100 drive_bl = 1;
    drive_blb = 1;
    $finish;
end
endmodule

