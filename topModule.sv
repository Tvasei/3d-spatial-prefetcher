module Prefetcher(
input logic clk,
input logic reset,
input logic [31:0] addr,
input logic [31:0] M,
input logic [31:0] N,
input logic [31:0] P,
input logic new_addr_ready,
output logic [31:0] adj_addr,
output logic valid
);

logic [2:0] sel;
logic two_side_x, one_side_x0, one_side_xN;
logic two_side_y, one_side_y0, one_side_yM;
logic two_side_z, one_side_z0, one_side_zP;

// Datapath
PrefetcherDatapath datapath(
    .addr(addr),
    .M(M),
    .N(N),
    .P(P),
    .sel(sel),
    .adj_addr(adj_addr),
    .two_side_x(two_side_x),
    .one_side_x0(one_side_x0),
    .one_side_xN(one_side_xN),
    .two_side_y(two_side_y),
    .one_side_y0(one_side_y0),
    .one_side_yM(one_side_yM),
    .two_side_z(two_side_z),
    .one_side_z0(one_side_z0),
    .one_side_zP(one_side_zP)
);

//  Controller
PrefetcherController controller(
    .clk(clk),
    .reset(reset),
    .new_addr_ready(new_addr_ready),
    .addr(addr),
    .adj_addr(adj_addr),
    .two_side_x(two_side_x),
    .one_side_x0(one_side_x0),
    .one_side_xN(one_side_xN),
    .two_side_y(two_side_y),
    .one_side_y0(one_side_y0),
    .one_side_yM(one_side_yM), 
    .two_side_z(two_side_z),
    .one_side_z0(one_side_z0),
    .one_side_zP(one_side_zP), 
    .sel(sel),
    .valid(valid)
);
endmodule
