// ============================================================
// MÓDULO: EX Stage - Execute
// FUNÇÃO: Executar operação da ULA e calcular endereços
// ============================================================

module ex_stage(
    input  wire [31:0] rs1_data,
    input  wire [31:0] rs2_data,
    input  wire [31:0] imm,
    input  wire [31:0] pc,
    input  wire [1:0]  alu_op,
    input  wire [2:0]  funct3,
    input  wire        funct7_5,
    input  wire        alu_src,
    
    output wire [31:0] alu_result,
    output wire        zero,
    output wire [31:0] branch_target
);
    
    // ===== MULTIPLEXADOR DO OPERANDO B =====
    wire [31:0] alu_b;
    assign alu_b = alu_src ? imm : rs2_data;
    
    // ===== CONTROLE DA ULA =====
    wire [3:0] alu_ctrl;
    alu_control alu_control_inst(
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .alu_ctrl(alu_ctrl)
    );
    
    // ===== ULA =====
    alu alu_inst(
        .a(rs1_data),
        .b(alu_b),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );
    
    // ===== ENDEREÇO DE BRANCH =====
    assign branch_target = pc + imm;

endmodule