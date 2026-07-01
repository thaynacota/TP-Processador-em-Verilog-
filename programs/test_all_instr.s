# ============================================================
# PROGRAMA DE TESTE: TODAS as 30 instruções RV32I
# ============================================================

.text
.globl _start

_start:
    # ===== U-type (1) =====
    lui x1, 0x12345          # x1 = 0x12345000
    
    # ===== I-type aritméticos (9) =====
    addi x2, x0, 100         # x2 = 100
    slti x3, x2, 200         # x3 = 1
    sltiu x4, x2, 50         # x4 = 0
    xori x5, x2, 0xFF        # x5 = 155
    ori x6, x2, 0xF0         # x6 = 244
    andi x7, x2, 0x0F        # x7 = 4
    slli x8, x2, 2           # x8 = 400
    srli x9, x2, 1           # x9 = 50
    srai x10, x2, 1          # x10 = 50
    
    # ===== R-type (10) =====
    add x11, x2, x8          # x11 = 500
    sub x12, x8, x2          # x12 = 300
    sll x13, x2, x2          # x13 = 0
    slt x14, x2, x8          # x14 = 1
    sltu x15, x8, x2         # x15 = 0
    xor x16, x2, x6          # x16 = 144
    srl x17, x8, x2          # x17 = 0
    sra x18, x8, x2          # x18 = 0
    or x19, x2, x6           # x19 = 244
    and x20, x2, x7          # x20 = 4
    
    # ===== Load/Store (2) =====
    addi x21, x0, 256        # x21 = 256
    sw x2, 0(x21)            # Mem[256] = 100
    lw x23, 0(x21)           # x23 = 100
    
    # ===== Branches (6) =====
    addi x24, x0, 5          # x24 = 5
    addi x25, x0, 5          # x25 = 5
    
    # BEQ
    beq x24, x25, eq
    addi x26, x0, 1          # NÃO executa
eq:
    addi x26, x0, 0          # x26 = 0
    
    # BNE
    bne x24, x26, neq
    addi x27, x0, 1          # NÃO executa
neq:
    addi x27, x0, 2          # x27 = 2
    
    # BLT
    blt x24, x25, lt
    addi x28, x0, 1          # Executa: x28 = 1
    jal x0, skip_lt
lt:
    addi x28, x0, 0          # NÃO executa
skip_lt:
    
    # BGE
    bge x24, x25, ge
    addi x30, x0, 1          # NÃO executa
ge:
    addi x30, x0, 0          # x30 = 0
    
    # ===== Jumps (2) =====
    jal x29, target
    addi x31, x0, 1          # NÃO executa
target:
    jalr x31, x29, 0         # x31 = PC+4
    
    # ===== FIM =====
    addi x31, x0, 0xFF       # x31 = 255
    
fim:
    nop
    jal x0, fim

.end