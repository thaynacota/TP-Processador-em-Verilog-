// ============================================================
// MÓDULO: ALU - Unidade Lógica e Aritmética
// FUNÇÃO: Executa operações aritméticas e lógicas de 32 bits
// ============================================================

module alu(
    input  wire [31:0] a,          // Operando A
    input  wire [31:0] b,          // Operando B
    input  wire [3:0]  alu_ctrl,   // Código da operação (4 bits)
    output reg  [31:0] result,     // Resultado da operação
    output wire        zero        // Flag: resultado == 0?
);
    
    // Flag zero - indica se o resultado é zero
    assign zero = (result == 32'b0);
    
    // Lógica combinacional da ULA
    always @(*) begin
        case(alu_ctrl)
            4'b0010: result = a + b;                        // ADD
            4'b0110: result = a - b;                        // SUB
            4'b0101: result = a << b[4:0];                  // SLL
            4'b0111: result = a >> b[4:0];                  // SRL
            4'b1100: result = $signed(a) >>> b[4:0];        // SRA
            4'b0100: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;  // SLT
            4'b0011: result = (a < b) ? 32'd1 : 32'd0;      // SLTU
            4'b1000: result = a ^ b;                        // XOR
            4'b1001: result = a | b;                        // OR
            4'b1010: result = a & b;                        // AND
            default: result = 32'b0;
        endcase
    end

endmodule