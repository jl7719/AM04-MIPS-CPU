/* Questions/Todos:

-how to implement mult signed vs unsigned?
-Need to clarify How many ALU ctrl flags there are
-Need to go through & check special cases for each instruction
-In the process of manually checking if every instruction has been accounted for in the actual enum
-Right what your final set of different opeators each do (easy but somewhat tedious) :(
*/




module mips_cpu_alu(
   input logic[31:0] A, B,//alu_in1, alu_in2 -The two ALU inputs

   input logic [5:0] ALUFlags, //Output from ALU control - 6bits as there are 48 different instructions in our ISA that we need to implement

    /*  The ALU Flags is 6 bits for now update when reduced */

   output logic ALUZero, //Is the output of the ALU 0? - used to check result

   output logic[31:0] ALUOut, // The ouput of the ALU 


);

 /* 
 
 I have listed all of the instructions - reducing this set to figure out the size 
 of ALUFlag/enum also need to go through the IS again and find special cases
 (like over/underflow) for each instruction & to note them 
 
 i.e. for the instruction  SLT (set on less than): 
 ALUOut is '32'h000000001' if A < B
 
  */

// Instructions commented out have been accounted for 

    /* Using an enum to define constants */
    //typedef enum logic[5:0] {
        //ADDIU = 6'd0, //Add immediate unsigned (no overflow)
        //ADDU = 6'd1, 	//Add unsigned (no overflow)
       //AND = 6'd2, 	//Bitwise and
        //ANDI = 6'd3, 	//Bitwise and immediate
        BEQ	 = 6'd4,    //Branch on equal
        BGEZ = 6'd5, 	//Branch on greater than or equal to zero
        BGEZAL = 6'd6, 	//Branch on non-negative (>=0) and link
        BGTZ = 6'd7, 	//Branch on greater than zero
        BLEZ = 6'd8, 	//Branch on less than or equal to zero
        BLTZ = 6'd9, 	//Branch on less than zero
        BLTZAL = 6'd10, //Branch on less than zero and link
        BNE = 6'd11,    //Branch on not equal
        //DIV = 6'd12, 	//Divide
        //DIVU = 6'd13, 	//Divide unsigned
        J = 6'd14, 	    //Jump
        JALR = 6'd15, 	//Jump and link register
        JAL = 6'd16, 	//Jump and link
        JR = 6'd17, 	//Jump register
        LB = 6'd18, 	//Load byte
        LBU = 6'd19,   	//Load byte unsigned
        LH = 6'd20, 	//Load half-word
        LHU = 6'd21, 	//Load half-word unsigned
        LUI = 6'd22, 	//Load upper immediate
        LW = 6'd23, 	//Load word
        LWL = 6'd24, 	//Load word left
        LWR	= 6'd25,    //Load word right
        MTHI = 6'd26, 	//Move to HI
        MTLO = 6'd27, 	//Move to LO
        //MULT = 6'd28, 	//Multiply
        //MULTU = 6'd29, 	//Multiply unsigned
        //OR = 6'd30, 	//Bitwise or
        //ORI	= 6'd31,    //Bitwise or immediate
        SB = 6'd32, 	//Store byte
        SH = 6'd33, 	//Store half-word
        SLL = 6'd34,    //Shift left logical
        SLLV = 6'd35, 	//Shift left logical variable
        SLT = 6'd36, 	//Set on less than (signed)
        SLTI = 6'd37, 	//Set on less than immediate (signed)
        SLTIU = 6'd38, 	//Set on less than immediate unsigned
        SLTU = 6'd39, 	//Set on less than unsigned
        SRA = 6'd40, 	//Shift right arithmetic
        SRAV = 6'd41, 	//Shift right arithmetic
        SRL = 6'd42, 	//Shift right logical
        SRLV = 6'd43, 	//Shift right logical variable
       //SUBU = 6'd44, 	//Subtract unsigned
        SW = 6'd45, 	//Store word
        XOR  = 6'd46,   //Bitwise exclusive or
        XORI = 6'd47, 	//Bitwise exclusive or immediate
    //} ALUFlags;

/* This is how I believe our ctrl flags should be arranged */

    typedef enum logic [/* ? */ : 0]{
        ADD = 
        SUB = 
        MULT =
        DIV = 
        //logical
        AND = 'd
        OR = 'd
        SLL = 'd

    } ALUFlags;

    always @(alu_in1, alu_in2, ALUFlags)
    begin
      case(ALUFlags)
        ADD: begin
            ALUOut = A & B; // is it = or <= ??
        end

        OR: begin
            ALUOut = A | B;
        end

        SLL: begin
            ALUOut = b >> shamt //Shamt is instruction read data [10:6]
        end





    end

endmodule