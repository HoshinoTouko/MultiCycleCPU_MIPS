module dm(
    input               clk,
    input   [11:2]      addr,
    input   [3:0]       BE,
    input   [31:0]      din,
    input               DMWr,
    input               MemReadSigned,
    
    output  reg[31:0]   dout
) ;

    reg[31:0]           MainMem[1023:0];
    integer             i;

    initial
    begin
        for (i = 0; i < 1024; i = i + 1)
            MainMem[i] = 0;
    end

    always@(negedge clk)
    begin
        if(DMWr) begin
            $display("DM set addr: %x, dout: %b, BE: %b", addr, din, BE);
            case (BE)
                4'b1111:
                    MainMem[addr]           =   din;
                4'b1100:
                    MainMem[addr][31:16]    =   din[15:0];
                4'b0011:
                    MainMem[addr][15:0]     =   din[15:0];
                4'b0001:
                    MainMem[addr][7:0]      =   din[7:0];
                4'b0010:
                    MainMem[addr][15:8]     =   din[7:0];
                4'b0100:
                    MainMem[addr][23:16]    =   din[7:0];
                4'b1000:
                    MainMem[addr][31:24]    =   din[7:0];
                default:
                    MainMem[addr]           =   2'hffffffff;
            endcase
        end

        $display("------------------------------- DM info -------------------------------");
        for (i = 0; i < 1024; i = i + 1) begin
            if(MainMem[i] != 0)
                $display("DM %d: %x", i, MainMem[i]);
        end
        $display("------------------------------- DM fin -------------------------------");

    end

    always@(*) begin
        dout = MainMem[addr];
        if(MemReadSigned) begin
            case (BE)
                4'b1111:
                    dout    =   MainMem[addr];
                4'b1100:
                    dout    =   {{16{MainMem[addr][31]}}, MainMem[addr][31:16]};
                4'b0011:
                    dout    =   {{16{MainMem[addr][15]}}, MainMem[addr][15:0]};
                4'b0001:
                    dout    =   {{24{MainMem[addr][7]}}, MainMem[addr][7:0]};
                4'b0010:
                    dout    =   {{24{MainMem[addr][15]}}, MainMem[addr][15:8]};
                4'b0100:
                    dout    =   {{24{MainMem[addr][23]}}, MainMem[addr][23:16]};
                4'b1000:
                    dout    =   {{24{MainMem[addr][31]}}, MainMem[addr][31:24]};
                default:
                    dout    =   MainMem[addr];
            endcase
        end
        else begin
            case (BE)
                4'b1111:
                    dout    =   MainMem[addr];
                4'b1100:
                    dout    =   {16'h0000, MainMem[addr][31:16]};
                4'b0011:
                    dout    =   {16'h0000, MainMem[addr][15:0]};
                4'b0001:
                    dout    =   {24'h0000, MainMem[addr][7:0]};
                4'b0010:
                    dout    =   {24'h0000, MainMem[addr][15:8]};
                4'b0100:
                    dout    =   {24'h0000, MainMem[addr][23:16]};
                4'b1000:
                    dout    =   {24'h0000, MainMem[addr][31:24]};
                default:
                    dout    =   MainMem[addr];
            endcase
        end
    end
endmodule
