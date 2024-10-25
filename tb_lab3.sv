`include "macros.sv"

module tb_lab3();
	reg [9:0] in;
	reg [3:0] ctl;
    reg error, clock, reset;
	 
	 
	assign ctl[0] = clock;
	assign ctl[3] = reset;

    wire [6:0] r0,r1,r2,r3,r4,r5;

    lab3_top dut(.SW(in),.KEY(ctl),.HEX0(r0),.HEX1(r1),.HEX2(r2),.HEX3(r3),.HEX4(r4),.HEX5(r5));

    task stateCheck; // task layout taken from slide 44 of slide set 7 (verilog for FSMs)
            input [3:0] expectedState;
            input [6:0] expectedOutput;
        begin
                if (tb_lab3.dut.currentState !== expectedState) begin
                $display("ERROR: State is %b, expected %b", tb_lab3.dut.currentState, expectedState);
                error = 1'b1;
                end 
                if (tb_lab3.dut.HEX0 !== expectedOutput) begin 
                    $display("ERROR: output HEX0 is %b, expected %b", tb_lab3.dut.HEX0, expectedOutput);
                    error = 1'b1;
                end
        end
    endtask // end

    initial begin
        reset = 1'b0; in[3:0] = 4'b0000; error = 1'b0; clock = 1'b1; #5;
        clock = 1'b0; #5; clock = 1'b1;
	
        // initial state
        stateCheck(`Si, 7'b0000001);
        reset = 1'b1; #5;

        /* correct input checks(211525) */
        // 2
        in[3:0] = 4'd2; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc1, 7'b0010010);

        // 1
        in[3:0] = 4'd1; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc2, 7'b1001111);

        // 1
        in[3:0] = 4'd1; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc3, 7'b1001111);

        // 5
        in[3:0] = 4'd5; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc4, 7'b0100100);

        // 2
        in[3:0] = 4'd2; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc5, 7'b0010010);

        // 5
        in[3:0] = 4'd5; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc6, `N);
        
        // OPEN
        in[3:0] = 4'd0; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc6, `N);

        // reset
        reset = 1'b0; #5;
        clock = 1'b0; #5; clock = 1'b1; reset = 1'b1;
        stateCheck(`Si, 7'b0000001);

        /* incorrect input on state 3 test case */
        // 2
        in[3:0] = 4'd2; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc1, 7'b0010010);

        // 1
        in[3:0] = 4'd1; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc2, 7'b1001111);

        // 0 
        in[3:0] = 4'd0; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se3, 7'b0000001);

        // 0 
        in[3:0] = 4'd0; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se4, 7'b0000001);

        // 2
        in[3:0] = 4'd2; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se5, 7'b0010010);

        // 0 
        in[3:0] = 4'd0; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se6, `D);

        // 0 
        in[3:0] = 4'd0; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se6, `D);

        // reset
        reset = 1'b0; #5;
        clock = 1'b0; #5; clock = 1'b1; reset = 1'b1;
        stateCheck(`Si, 7'b0000001);

        // invalid input on state 2 test case
        // 2
        in[3:0] = 4'd2; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Sc1, 7'b0010010);

        // 12 (invalid)
        in[3:0] = 4'd12; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se2, `R);

        // 1
        in[3:0] = 4'd1; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se3, 7'b1001111);

        // 12 (invalid)
        in[3:0] = 4'd12; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se4, `R);

        // 12 (invalid)
        in[3:0] = 4'd12; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se5, `R);

        // CLOSED
        in[3:0] = 4'd12; #5;
        clock = 1'b0; #5; clock = 1'b1;
        stateCheck(`Se6, `D);

        if (~error) begin
            $display("passed");
            $stop;
        end
    end
endmodule: tb_lab3
