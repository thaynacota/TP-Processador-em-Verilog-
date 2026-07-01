// ============================================================
// MÓDULO: WB Stage - Write Back
// FUNÇÃO: Selecionar qual dado será escrito no registrador
// ============================================================

module wb_stage(
    input  wire [31:0] alu_result,
    input  wire [31:0] mem_read_data,
    input  wire [31:0] pc_plus_4,
    input  wire        mem_to_reg,
    input  wire        jump,
    input  wire [31:0] lui_imm,
    input  wire        is_lui,
    output wire [31:0] write_data
);
    
    wire [31:0] alu_or_mem;
    wire [31:0] with_jump;
    
    assign alu_or_mem = mem_to_reg ? mem_read_data : alu_result;
    assign with_jump = jump ? pc_plus_4 : alu_or_mem;
    assign write_data = is_lui ? lui_imm : with_jump;

endmodule