// ============================================================
// MÓDULO: IF Stage - Instruction Fetch
// FUNÇÃO: Buscar instrução da memória e calcular próximo PC
// ============================================================

module if_stage(
    input  wire        clk,           // Clock
    input  wire        reset,         // Reset (zera o PC)
    input  wire        branch_taken,  // Branch foi tomado?
    input  wire        jump,          // É instrução de jump?
    input  wire [31:0] branch_target, // Endereço alvo do branch
    input  wire [31:0] jump_target,   // Endereço alvo do jump
    output reg  [31:0] pc,            // Program Counter atual
    output wire [31:0] pc_plus_4,     // PC + 4
    output wire [31:0] instr          // Instrução buscada
);
    
    // ===== MEMÓRIA DE INSTRUÇÕES =====
    // 256 palavras de 32 bits (1 KB)
    reg [31:0] instr_mem [0:255];
    
    // ===== LÓGICA DO PRÓXIMO PC =====
    wire [31:0] next_pc_seq;
    wire [31:0] pc_after_branch;
    wire [31:0] next_pc;
    
    assign pc_plus_4 = pc + 32'd4;
    assign next_pc_seq = pc_plus_4;
    
    // Mux do branch
    assign pc_after_branch = branch_taken ? branch_target : next_pc_seq;
    
    // Mux do jump
    assign next_pc = jump ? jump_target : pc_after_branch;
    
    // ===== ATUALIZAÇÃO DO PC =====
    always @(posedge clk) begin
        if(reset) begin
            pc <= 32'b0;
        end else begin
            pc <= next_pc;
        end
    end
    
    // ===== LEITURA DA MEMÓRIA =====
    assign instr = instr_mem[pc[31:2]];

endmodule