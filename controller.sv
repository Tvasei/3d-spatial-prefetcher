module PrefetcherController(
input logic clk,
input logic reset,
input logic new_addr_ready,
input logic [31:0] addr,
input logic [31:0] adj_addr,
input logic two_side_x, one_side_x0, one_side_xN,
input logic two_side_y, one_side_y0, one_side_yM,
input logic two_side_z, one_side_z0, one_side_zP,
output logic [2:0] sel,
output logic valid
);


typedef enum logic [2:0] {IDLE, X_minus, X_plus, Y_minus, Y_plus, Z_minus, Z_plus} state_t;
state_t current_state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

always_comb begin
    next_state = current_state;
    valid = 0;
    sel = 0;

    case (current_state)
        IDLE: begin
            if (new_addr_ready) begin
                if (two_side_x || one_side_xN) begin
                    next_state = X_minus;
                end else if (one_side_x0) begin
                    next_state = X_plus;
                end
            end
        end

        X_minus: begin
            sel = 0;
            valid = 1;
            if (two_side_x) begin
                next_state = X_plus;
            end else if (two_side_y || one_side_yM) begin
                next_state = Y_minus;
            end else if (one_side_y0) begin
                next_state = Y_plus;
            end
        end

        X_plus: begin
            sel = 1;
            valid = 1;
            if (two_side_y || one_side_yM) begin
                next_state = Y_minus;
            end else if (one_side_y0) begin
                next_state = Y_plus;
            end
        end

        Y_minus: begin
            sel = 2;
            valid = 1;
            if (two_side_y) begin
                next_state = Y_plus;
            end else if (two_side_z || one_side_zP) begin
                next_state = Z_minus;
            end else if (one_side_z0) begin
                next_state = Z_plus;
            end
        end

        Y_plus: begin
            sel = 3;
            valid = 1;
            if (two_side_z || one_side_zP) begin
                next_state = Z_minus;
            end else if (one_side_z0) begin
                next_state = Z_plus;
            end
        end

Z_minus: begin
    sel = 4;
    valid = 1;
    if (two_side_z) begin
        next_state = Z_plus;
    end else begin
        next_state = IDLE; 
    end
end

        Z_plus: begin
            sel = 5;
            valid = 1;
            next_state = IDLE;
        end

    endcase
end
endmodule