module Slt(
    input   [31:0]  Data,

    output  [31:0]  Result
);

    always@(Data) begin
        Result = Data << 2;
    end

endmodule
