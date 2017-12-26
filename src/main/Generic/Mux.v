module Mux(
    input   [1:0]       Select, // Write data signal

    input   [31:0]      Data1,
    input   [31:0]      Data2,
    input   [31:0]      Data3,
    input   [31:0]      Data4,

    output  reg[31:0]   Result
);

    always@(*) begin
        case(Select)
            2'b00:
                Result = Data1;
            2'b01:
                Result = Data2;
            2'b10:
                Result = Data3;
            2'b11:
                Result = Data4;
            default:
                Result = 0;
        endcase
    end

endmodule
