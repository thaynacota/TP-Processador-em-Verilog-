// ============================================================
// MÓDULO: ID Stage - Instruction Decode
// FUNÇÃO: Decodificar instrução, ler registradores, gerar imediato
// ============================================================

module id_stage(
    input  wire        clk,
    input  wire [31:0] instr,        // Instrução do IF
    input  wire [31:0] write_data,   // Dado do WB
    input  wire [4:0]  rd_addr,      // Endereço destino do WB
    input  wire        reg_write,    // Sinal de escrita do WB
    
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,
    output wire [31:0] imm,
    output wire        alu_src,
    output wire        mem_read,
    output wire        mem_write,
    output wire        branch,
    output wire        jump,
    output wire        mem_to_reg,
    output wire [1:0]  alu_op
);
    
    // ===== EXTRAIR CAMPOS =====
    wire [4:0] rs1_addr = instr[19:15];
    wire [4:0] rs2_addr = instr[24:20];
    wire [6:0] opcode   = instr[6:0];
    
    // ===== BANCO DE REGISTRADORES =====
    reg_file reg_file_inst(
        .clk(clk),
        .reg_write(reg_write),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .write_data(write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );
    
    // ===== GERADOR DE IMEDIATO =====
    imm_gen imm_gen_inst(
        .instr(instr),
        .imm(imm)
    );
    
    // ===== UNIDADE DE CONTROLE =====
    control_unit control_unit_inst(
        .opcode(opcode),
        .reg_write(),       // Não usado aqui (vai para WB)
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op)
    );

endmodule