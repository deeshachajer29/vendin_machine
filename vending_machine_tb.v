`timescale 1ns/1ps

module vending_machine_tb;

    reg clk;
    reg rst;
    reg [1:0] coin;

    wire dispense;

    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        coin = 2'b00;

        $dumpfile("vending_machine.vcd");
        $dumpvars(0, vending_machine_tb);

        // Reset
        #10;
        rst = 0;

        // Insert ₹5
        coin = 2'b01;
        #10;

        // Insert ₹5
        coin = 2'b01;
        #10;

        // Insert ₹10
        coin = 2'b10;
        #10;

        $finish;

    end

endmodule