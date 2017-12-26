module mips(
    input   clk,
    input   rst
);
    // Instruction
    wire    [31:0]  Instr;

    // Data stream
    // ALU
    wire    [31:0]  DataALUOut;
    wire    [31:0]  DataALUOutReg;
    wire    [31:0]  DataALUSrcA;
    wire    [31:0]  DataALUSrcB;
    // PC
    wire    [31:0]  DataNextPC;
    wire    [31:0]  DataPCReg;
    // IM
    wire    [31:0]  DataIMOutput;
    wire    [31:0]  DataIMRegInput;
    wire    [31:0]  DataIMRegOutput;
    // DM
    wire    [31:0]  DataDMRead;
    wire    [31:0]  DataDMReadReg;
    // RF
    wire    [4:0]  DataRFRead1;
    wire    [4:0]  DataRFRead2;
    wire    [4:0]  DataRFWriteAddr;
    wire    [31:0]  DataRFWriteData;
    // Sign Extend
    wire    [31:0]  DataSignExt;
    wire    [31:0]  DataSignExtSL2;


    // Signals
    // Clock and reset
    //wire            clk;
    //wire            rst;
    // About PC Write
    wire            SignalPCWriteCond;
    wire            SignalPCWrite;
    wire    [1:0]   SignalPCSource;
    wire            SignalPCNext;
    // About Memory
    wire    [3:0]   SignalBE;
    wire            SignalMemRead;
    wire            SignalMemWrite;
    // About Register
    wire            SignalMem2Reg;
    wire            SignalIRWrite;
    wire            SignalRegDst;
    wire            SignalRegWrite;
    // About ALU
    wire    [1:0]   SignalALUSrcA;
    wire    [1:0]   SignalALUSrcB;
    // About branch
    wire            SignalBranch;
    // About ALUControl
    wire    [5:0]   SignalALUOp;
    wire    [1:0]   SignalALUCtrlOp;
    // Some other signals
    wire            SignalBranchResult;
    wire            SignalPCWriteResult;

    assign SignalBranchResult   =   SignalBranch & SignalPCWriteCond;
    assign SignalPCWriteResult  =   SignalBranchResult | SignalPCWrite;

    // PC
    SReg PCSReg(
        .clk(clk),
        .RegWrite(SignalPCWriteResult),

        .Data(DataNextPC),
        .Result(DataPCReg)
    );
    // IM
    im IM(
        .addr(DataPCReg[11:2]),
        .dout(DataIMOutput)
    );
    // DM
    dm DM(
        .clk(clk),
        .addr(DataALUOutReg),
        .write_data(DataRFRead2),
        .MemWrite(SignalMemWrite),
        // Output
        .read_data(DataDMRead)
    );
    SReg DMReg(
        .clk(clk),
        .RegWrite(1),
        // Output
        .Data(DataDMRead),
        .Result(DataDMReadReg)
    );
    // Mux before ALU
    Mux ALUSrcAMux(
        // Input
        .Select(SignalALUSrcA),
        .Data1(DataPCReg),
        .Data2(DataRFRead1),
        // Output
        .Result(DataALUSrcA)
    );
    Mux ALUSrcBMux(
        // Input
        .Select(SignalALUSrcB),
        .Data1(DataPCReg),
        .Data2(4),
        .Data3(DataSignExt),
        .Data4({DataSignExt[29:0], 2'b00}),
        // Output
        .Result(DataALUSrcB)
    );
    // RF Mux
    Mux RFWriteAddr(
        // Input
        .Select(SignalRegDst),
        .Data1(Instr[20:16]),
        .Data2(Instr[15:11]),
        // Output
        .Result(DataRFWriteAddr)
    );
    Mux RFWriteData(
        // Input
        .Select(DataDMReadReg),
        .Data1(DataALUOutReg),
        .Data2(Instr[15:11]),
        // Output
        .Result(DataRFWriteData)
    );
    // Register File
    RF rf(
        .clk(clk),
        .RegWrite(SignalRegWrite),
        .ReadAddr1(Instr[25:21]),
        .ReadAddr2(Instr[20:16]),
        .WriteAddr(DataRFWriteAddr),
        .WriteData(DataRFWriteData),
        // Output
        .ReadData1(DataRFRead1),
        .ReadData2(DataRFRead2)
    );
    // ALU and ALUCtrl
    ALUCtrl ALUCtrl(
        .funct(Instr[5:0]),
        .ALUCtrlOp(SignalALUCtrlOp),
        // Output
        .ALUOp(SignalALUOp)
    );
    ALU alu(
        .SrcA(DataALUSrcA),
        .SrcB(DataALUSrcB),
        .ALUOp(SignalALUOp),
        // Output
        .ALUResult(DataALUOut)
    );
    SReg ALUReg(
        .clk(clk),
        .RegWrite(1),

        .Data(DataALUOut),
        .Result(DataALUOutReg)
    );

    // PCSource Mux
    Mux PCSourceMux(
        .Select(SignalPCSource),
        .Data1(DataALUOut),
        .Data2(DataALUOutReg),
        .Data3({DataPCReg[31:28], Instr[25:0], 2'b00})
    );
    // Branch
    Branch branch(
        .SrcA(DataRFRead1),
        .SrcB(DataRFRead2),
        .OP(Instr[31:26]),
        .Branch_funct(Instr[20:16]),
        // Output
        .BranchSucceed(SignalBranch)
    );

    always @(clk) begin
        if (!clk) begin
            $stop;
        end
    end

endmodule
