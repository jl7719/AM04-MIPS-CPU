/*  
Memory for Harvard Interface
- RAM Size: 32 x 2^32 = 32 x 4294967296
- Instructions in binaries or hex -> RAM_INIT_FILE
- combinatorial read/fetch of instruction via instr_ port
- combinatorial read and single cycle write of data via data_ port

Instantiation of Memory Module
- mips_cpu_memory #(RAM_INIT_FILE) ramInst(clk, data_address, data_write, data_read, data_writedata, data_readdata, instr_address, instr_readdata);

Special Memory Locations
- Whether a particular address maps to RAM, ROM, or something else is entirely down to the top-level circuit outside your CPU.
- special memory locations: 0x00000000 (CPU halt), 0xBFC00000 (start execution after reset)
- PC should be 0xBFC00000 at the start and 0x00000000 at the end

Needs checking with:
-- clk or clk_enable?
-- whether there is a more efficient way of initialising memory to zero (line 32)
*/

module mips_cpu_memory(
    input logic clk,

    //Data Memory
    input logic[31:0] data_address,
    input logic data_write,
    input logic data_read,
    input logic[31:0] data_writedata,
    output logic[31:0] data_readdata,

    //Instruction Memory
    input logic[31:0] instr_address,
    output logic[31:0] instr_readdata

);
    parameter RAM_INIT_FILE = "";

    reg [31:0] memory [4294967295:0];   // 2^32 memory locations of 32 bits size

    initial begin
        integer i;
        //Initialise to zero by default
        for (i=0; i<4294967296; i++) begin
            memory[i]=0;
        end
        //Load contents from file if specified
        if (RAM_INIT_FILE != "") begin
            $display("RAM : INIT : Loading RAM contents from %s", RAM_INIT_FILE);
            $readmemh(RAM_INIT_FILE, memory);
        end
    end

    //Combinatorial read path for data and instruction.
    assign data_readdata = data_read ? memory[data_address] : 16'hxxxx;
    assign instr_readdata = memory[instr_address]

    //Synchronous write path
    always_ff @(posedge clk) begin
        //$display("RAM : INFO : data_read=%h, data_addr = %h, mem=%h", data_read, data_address, memory[data_address]);
        if (!data_read & data_write) begin  //cannot read and write to memory in the same cycle
            memory[data_address] <= data_writedata;
        end
    end
endmodule