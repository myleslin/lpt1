`define Sa 3'b000
`define Sb 3'b001
`define Sc 3'b010
`define Sd 3'b011
`define Se 3'b100

module top_module(clk,reset,in,out);
    input clk, reset;
    input [1:0] in;
    output reg [1:0] out;

    reg [2:0] currentState;
    reg [2:0] nextState;

    always_comb begin 
        case (currentState)
            `Sa: out = 2'b00;
            `Sb: out = 2'b01;
            `Sc: out = 2'b11;
            `Sd: out = 2'b10;
            `Se: out = 2'b01;
            default: out = 2'bXX;
        endcase

        if (reset) begin
            nextState = `Sc;
        end else begin
            case (currentState)
            `Sa: if (in == 2'b10) begin
                    nextState = `Sb;
                end else begin
                    nextState = `Sa;
                end
            `Sb: if (in == 2'b00) begin
                    nextState = `Sc;
                end else if (in == 2'b01) begin
                    nextState = `Sa;
                end else begin
                    nextState = `Sb;
                end
            `Sc: if (in == 2'b01) begin
                    nextState = `Se;
                end else if (in == 2'b11) begin
                    nextState = `Sb;
                end else begin
                    nextState = `Sc;
                end
            `Sd: if (in == 2'b10) begin
                    nextState = `Se;
                end else if (in == 2'b01) begin
                    nextState = `Sc;
                end else begin
                    nextState = `Sd;
                end
            `Se: nextState = `Sd;
            default: nextState = 3'bXXX;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        currentState = nextState;
    end
endmodule
