module Alu #(
    parameter bus_width = 8
)(
    input  [bus_width-1:0] A,
    input  [bus_width-1:0] B,
    input  [3:0] opcode,
    input  car_in,
    output reg [bus_width-1:0] y,
    output reg Car_out,
    output reg borrow,
    output zero,
    output parity,
    output reg invalid_op
);

    // Opcode definitions
    localparam op_add             = 4'd1;
    localparam op_add_with_carry = 4'd2;
    localparam op_sub            = 4'd3;
    localparam op_inc            = 4'd4;
    localparam op_dec            = 4'd5;
    localparam op_and            = 4'd6;
    localparam op_not            = 4'd7;
    localparam op_rol            = 4'd8;
    localparam op_ror            = 4'd9;

    always @(*) begin
    
        y = 0;
        Car_out = 0;
        borrow = 0;
        invalid_op = 0;

        case (opcode)
            // ADD
            op_add: begin
                {Car_out, y} = A + B; 
            end

            // ADD with carry
            op_add_with_carry: begin
                {Car_out, y} = A + B + (car_in & 1'b1); 
            end

            // SUBTRACT
            op_sub: begin
                y = A - B;
                borrow = (A < B);
            end

            // INCREMENT
            op_inc: begin
                {Car_out, y} = A + 1;
            end

            // DECREMENT
            op_dec: begin
                y = A - 1;
                borrow = (A == 0);
            end

            // AND
            op_and: begin
                y = A & B;
            end

            // NOT
            op_not: begin
                y = ~A;
            end

            // ROTATE LEFT
            op_rol: begin
                y = {A[bus_width-2:0], A[bus_width-1]};
            end

            // ROTATE RIGHT
            op_ror: begin
                y = {A[0], A[bus_width-1:1]};
            end


            default: begin
                invalid_op = 1;
            end
        endcase
    end

    assign zero   = (y == 0);
    assign parity = ^y; 

endmodule
