// initial state
`define Si 4'b0000

// correct code states (even)
`define Sc1 4'b0010
`define Sc2 4'b0100
`define Sc3 4'b0110
`define Sc4 4'b1000
`define Sc5 4'b1010
`define Sc6 4'b1100

// incorrect (erroneous) code states (odd)
`define Se1 4'b0001
`define Se2 4'b0011
`define Se3 4'b0101
`define Se4 4'b0111
`define Se5 4'b1001
`define Se6 4'b1011

// 7 segment outputs
`define blank 7'b1111111

`define C 7'b0110001
`define D 7'b1000010
`define E 7'b0110000
`define L 7'b1110001
`define N 7'b1101010
`define O 7'b1100010
`define P 7'b0011000
`define R 7'b1111010
`define S 7'b0100100
