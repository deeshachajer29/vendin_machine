module vending_machine (
    input wire clk,
    input wire rst,
    input wire [1:0] coin,
    output reg dispense
);

parameter S0  = 2'b00;
parameter S5  = 2'b01;
parameter S10 = 2'b10;

reg [1:0] state;
reg [1:0] next_state;


// State register
always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end


// Next-state logic
always @(*) begin

    case(state)

        S0: begin
            if (coin == 2'b01)
                next_state = S5;
            else if (coin == 2'b10)
                next_state = S10;
            else
                next_state = S0;
        end

        S5: begin
            if (coin == 2'b01)
                next_state = S10;
            else if (coin == 2'b10)
                next_state = S0;
            else
                next_state = S5;
        end

        S10: begin
            if (coin == 2'b01)
                next_state = S0;
            else if (coin == 2'b10)
                next_state = S0;
            else
                next_state = S10;
        end

        default: begin
            next_state = S0;
        end

    endcase

end


// Dispense logic
always @(*) begin

    if ((state == S5 && coin == 2'b10) ||
        (state == S10 && coin == 2'b01) ||
        (state == S10 && coin == 2'b10))

        dispense = 1;

    else
        dispense = 0;

end

endmodule