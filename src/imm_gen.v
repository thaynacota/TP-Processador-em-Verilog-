// ============================================================
// MÓDULO: Immediate Generator - Gerador de Imediatos
// FUNÇÃO: Extrai e estende o imediato da instrução
// ============================================================

module imm_gen(
    input  wire [31:0] instr,
    output reg  [31:0] imm
);
    
    wire [6:0] opcode = instr[6:0];
    
    always @(*) begin
        case(opcode)
            // ===== I-type =====
            7'b0010011,  // ADDI, SLLI, SRLI, SRAI, SLTI, SLTIU, XORI, ORI, ANDI
            7'b0000011,  // LW
            7'b1100111: begin // JALR
                imm = {{20{instr[31]}}, instr[31:20]};
            end
            
            // ===== S-type =====
            7'b0100011: begin // SW
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
            
            // ===== B-type =====
            7'b1100011: begin // BEQ, BNE, BLT, BGE, BLTU, BGEU
                imm = {{19{instr[31]}}, instr[31], instr[7], 
                       instr[30:25], instr[11:8], 1'b0};
            end
            
            // ===== U-type =====
            7'b0110111: begin // LUI
                imm = {instr[31:12], 12'b0};
            end
            
            // ===== J-type =====
            7'b1101111: begin // JAL
                imm = {{11{instr[31]}}, instr[31], instr[19:12], 
                       instr[20], instr[30:21], 1'b0};
            end
            
            default: begin
                imm = 32'b0;
            end
        endcase
    end

endmodule