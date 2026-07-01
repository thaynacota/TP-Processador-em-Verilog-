// ============================================================
// MÓDULO: MEM Stage - Memory Access
// FUNÇÃO: Acessar memória de dados (LW e SW)
// ============================================================

module mem_stage(
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] alu_result,
    input  wire [31:0] store_data,
    output wire [31:0] mem_read_data
);
    
    // ===== MEMÓRIA DE DADOS =====
    reg [31:0] data_mem [0:255];
    
    // ===== LEITURA COMBINACIONAL =====
    assign mem_read_data = mem_read ? data_mem[alu_result[31:2]] : 32'b0;
    
    // ===== ESCRITA SÍNCRONA =====
    always @(posedge clk) begin
        if(mem_write) begin
            data_mem[alu_result[31:2]] <= store_data;
        end
    end

endmodule