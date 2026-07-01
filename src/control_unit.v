// ============================================================
// MÓDULO: Control Unit - Unidade de Controle Principal
// FUNÇÃO: Gera TODOS os sinais de controle do processador
// TIPO: Módulo COMBINACIONAL (always @*)
// BASE: APENAS no opcode da instrução
// ============================================================

module control_unit(
    input  wire [6:0] opcode,       // Opcode da instrução (7 bits)
    output reg        reg_write,    // Escrever no banco de registradores?
    output reg        alu_src,      // Usar imediato (1) ou rs2 (0)?
    output reg        mem_read,     // Ler da memória de dados?
    output reg        mem_write,    // Escrever na memória de dados?
    output reg        branch,       // É instrução de branch?
    output reg        jump,         // É instrução de jump?
    output reg        mem_to_reg,   // Dado do WB vem da memória?
    output reg  [1:0] alu_op        // Tipo de operação da ULA
);
    
    always @(*) begin
        // ===== VALORES DEFAULT (tudo zero) =====
        reg_write  = 1'b0;
        alu_src    = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        mem_to_reg = 1'b0;
        alu_op     = 2'b00;
        
        // ===== DECODIFICAÇÃO POR OPCODE =====
        case(opcode)
            // R-type: ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
            7'b0110011: begin
                reg_write = 1'b1;
                alu_op    = 2'b10;
            end
            
            // I-type aritmético: ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                alu_op    = 2'b11;
            end
            
            // I-type load: LW
            7'b0000011: begin
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                mem_read   = 1'b1;
                mem_to_reg = 1'b1;
                alu_op     = 2'b00;
            end
            
            // S-type store: SW
            7'b0100011: begin
                alu_src   = 1'b1;
                mem_write = 1'b1;
                alu_op    = 2'b00;
            end
            
            // B-type branch: BEQ, BNE, BLT, BGE, BLTU, BGEU
            7'b1100011: begin
                branch  = 1'b1;
                alu_op  = 2'b01;
            end
            
            // J-type: JAL
            7'b1101111: begin
                reg_write = 1'b1;
                jump      = 1'b1;
            end
            
            // I-type: JALR
            7'b1100111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                jump      = 1'b1;
            end
            
            // U-type: LUI
            7'b0110111: begin
                reg_write = 1'b1;
            end
            
            default: begin
                // Mantém todos os sinais em zero
            end
        endcase
    end

endmodule