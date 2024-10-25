`include "macros.sv"

module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
  input [9:0] SW;
  input [3:0] KEY;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;   // optional: use these outputs for debugging on your DE1-SoC

  wire clk = ~KEY[0];  // this is your clock
  wire rst_n = KEY[3]; // this is your reset;

  reg [3:0] currentState;
  reg [3:0] nextState;
  reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

// put your solution code here!
  always_comb begin 
     if (currentState != `Sc6 & currentState != `Se6) begin
      case (SW[3:0])
        4'd0: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0000001;
        end
        4'd1: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b1001111;
        end
        4'd2: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0010010;
        end
        4'd3: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0000110;
        end
        4'd4: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b1001100;
        end
        4'd5: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0100100;
        end
        4'd6: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
              HEX0 = 7'b0100000;
        end
        4'd7: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
              HEX0 = 7'b0001111;
        end
        4'd8: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0000000;
        end
        4'd9: begin
          {HEX5, HEX4, HEX3, HEX2, HEX1} = {5{`blank}};
          HEX0 = 7'b0001100;
        end
        default: begin
          HEX5 = `blank;
          HEX4 = `E;
          HEX3 = `R;
          HEX2 = `O;
          HEX1 = `R;
          HEX0 = `R;
        end
      endcase
    end else begin
      case (currentState) 
        `Sc6: begin
          {HEX5, HEX4} = {2{`blank}};
          HEX3 = `O;
          HEX2 = `P;
          HEX1 = `E;
          HEX0 = `N;
        end
        `Se6: begin
          HEX5 = `C;
          HEX4 = `L;
          HEX3 = `O;
          HEX2 = `S;
          HEX1 = `E;
          HEX0 = `D;
        end

        default: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {6{`blank}};
      endcase
    end
    
    if (~rst_n) begin
      nextState = `Si;
    end else begin
      case (currentState)
        `Si:  if (SW[3:0] == 4'd2)
                nextState = `Sc1;
              else 
                nextState = `Se1;
        `Sc1:  if (SW[3:0] == 4'd1)
                nextState = `Sc2;
              else 
                nextState = `Se2;
        `Sc2: if (SW[3:0] == 4'd1)
                nextState = `Sc3;
              else 
                nextState = `Se3;
        `Sc3: if (SW[3:0] == 4'd5)
                nextState = `Sc4;
              else 
                nextState = `Se4;
        `Sc4: if (SW[3:0] == 4'd2)
                nextState = `Sc5;
              else 
                nextState = `Se5;
        `Sc5: if (SW[3:0] == 4'd5)
                nextState = `Sc6;
              else 
                nextState = `Se6;
        `Sc6: nextState = `Sc6;
        
        `Se1: nextState = `Se2;
        `Se2: nextState = `Se3;
        `Se3: nextState = `Se4;
        `Se4: nextState = `Se5;
        `Se5: nextState = `Se6;
        `Se6: nextState = `Se6;
        
        default: nextState = 4'bXXXX;
      endcase
    end
  end

  always_ff @(posedge clk) begin
    currentState = nextState;
  end
endmodule
