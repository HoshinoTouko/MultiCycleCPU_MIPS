module im(
    input	[11:2]  addr,
    output	[31:0]  dout
);

    reg     [31:0]	instrMem[1023:0];
    integer         fd, pointer;
    reg     [31:0]  temp_instr;

    initial begin
        fd=$fopen("src/testbench/instr.txt","r");

        $display("----------------------- IM start read interuction... ----------------------");
        for (pointer = 0; !$feof(fd); pointer = pointer + 1) begin
            $fscanf(fd, "%b\t", temp_instr);
            instrMem[pointer] = temp_instr;
            $display("IM read interuction %d: 0x%x", pointer, temp_instr);
        end
        $display("----------------------- Read interuction complete. ----------------------");
    end

    always @(addr) begin
        dout = instrMem[addr[11:2]][31:0];
        $display("IM get addr: %x, dout: %b", addr, dout);
    end

endmodule
