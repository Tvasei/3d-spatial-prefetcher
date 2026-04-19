module PrefetcherDatapath(
input logic [31:0] addr,
input logic [31:0] M,
input logic [31:0] N,
input logic [31:0] P,
input logic [2:0] sel, 
output logic [31:0] adj_addr,
output logic two_side_x, one_side_x0, one_side_xN,
output logic two_side_y, one_side_y0, one_side_yM,
output logic two_side_z, one_side_z0, one_side_zP
);


logic [31:0] x, y, z;
logic [31:0] adj_addr_array[5:0];

always_comb begin
    // position calculator
    x = addr % M;
    y = (addr / M) % N;
    z = addr / (M * N);

    // side signal calculator
    two_side_x = (x > 0 && x < M-1);
    one_side_x0 = (x == 0);
    one_side_xN = (x == M-1);

    two_side_y = (y > 0 && y < N-1);
    one_side_y0 = (y == 0);
    one_side_yM = (y == N-1);
     
    two_side_z = (z > 0 && z < P-1);
    one_side_z0 = (z == 0);
    one_side_zP = (z == P-1);

    //  adjacent addresses calculator
    adj_addr_array[0] = (x > 0) ? addr - 1 : addr;
    adj_addr_array[1] = (x < M-1) ? addr + 1 : addr;
    adj_addr_array[2] = (y > 0) ? addr - M : addr;
    adj_addr_array[3] = (y < N-1) ? addr + M : addr;
    adj_addr_array[4] = (z > 0) ? addr - M * N : addr;
    adj_addr_array[5] = (z < P-1) ? addr + M * N : addr;
    
    adj_addr = adj_addr_array[sel];
end
endmodule
