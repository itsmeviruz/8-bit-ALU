module alu_tb;
    reg  [7:0] A, B;
    reg  [3:0] opcode;
    reg        car_in;
    wire [7:0] y;
    wire       Car_out, borrow, zero, parity;
    wire       invalid_op;

    Alu uut (
        .A(A), .B(B),
        .opcode(opcode),
        .car_in(car_in),
        .y(y),
        .Car_out(Car_out),
        .borrow(borrow),
        .zero(zero),
        .parity(parity),
        .invalid_op(invalid_op)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        A = 8'd10; B = 8'd5; car_in = 0; opcode = 4'd1; #10;
        $display("ADD     : A=%d B=%d Y=%d Car_out=%b", A, B, y, Car_out);

        A = 8'd200; B = 8'd100; car_in = 1; opcode = 4'd2; #10;
        $display("ADC     : A=%d B=%d Y=%d Car_out=%b", A, B, y, Car_out);

        A = 8'd5; B = 8'd10; car_in = 0; opcode = 4'd3; #10;
        $display("SUB     : A=%d B=%d Y=%d Borrow=%b", A, B, y, borrow);

        A = 8'd255; B = 8'd0; car_in = 0; opcode = 4'd4; #10;
        $display("INC     : A=%d Y=%d Car_out=%b", A, y, Car_out);

        A = 8'd0; B = 8'd0; car_in = 0; opcode = 4'd5; #10;
        $display("DEC     : A=%d Y=%d Borrow=%b", A, y, borrow);

        A = 8'd170; B = 8'd85; car_in = 0; opcode = 4'd6; #10;
        $display("AND     : A=%b B=%b Y=%b", A, B, y);

        A = 8'd170; B = 8'd0; car_in = 0; opcode = 4'd7; #10;
        $display("NOT     : A=%b Y=%b", A, y);

        A = 8'b10011001; B = 8'd0; car_in = 0; opcode = 4'd8; #10;
        $display("ROL     : A=%b Y=%b", A, y);

        A = 8'b10011001; B = 8'd0; car_in = 0; opcode = 4'd9; #10;
        $display("ROR     : A=%b Y=%b", A, y);

        A = 8'd0; B = 8'd0; car_in = 0; opcode = 4'd15; #10;
        $display("INVALID : Opcode=%d Invalid_op=%b", opcode, invalid_op);

        $finish;
    end
endmodule
