module Prefetcher_tb;

// Inputs
logic clk;
logic reset;
logic [31:0] addr;
logic [31:0] M;
logic [31:0] N;
logic [31:0] P;
logic new_addr_ready;

// Outputs
logic [31:0] adj_addr;
logic valid;


Prefetcher uut (
    .clk(clk),
    .reset(reset),
    .addr(addr),
    .M(M),
    .N(N),
    .P(P),
    .new_addr_ready(new_addr_ready),
    .adj_addr(adj_addr),
    .valid(valid)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; 
end


initial begin

    reset = 1;
    addr = 0;
    M = 3;
    N = 3;
    P = 3;
    new_addr_ready = 0;


    #10;
    reset = 0;

    // Test case 1
    #10;
    addr = 8;
    new_addr_ready = 1;
    
    #10;
    new_addr_ready = 0;
    #50; 

    // Test case 2
    addr = 2;
    new_addr_ready = 1;
    
    #10;
    new_addr_ready = 0;
    #50;

    // Test case 3
    addr = 26;
    new_addr_ready = 1;
    
    #10;
    new_addr_ready = 0;
    #50; 

    $stop;
end
endmodule


