`include "defines.v"

/*
TODO:   接总线接口 -> 接缓存
*/

module if_stage
(
    input if_valid,
    input clk,
    input rst_n,
    
    //bj
    input bj_flag,
    input [`XLEN - 1 : 0] bj_addr,

    //pipe
    input  pipe_stall,
    
    //iram_interface
    output iram_en,
    output [`XLEN - 3 : 0] inst_raddr,
    input [`XLEN - 1 : 0] inst,

    output [`XLEN - 1 : 0] if_pc,
    output [`XLEN - 1 : 0] if_inst,
    
    input int_flag,
    output if_int_flag,
    output if_exp_flag,
    // output if_exp_int_flag,
    
    output if_inst_addr_misal
);

    wire [`XLEN - 1 : 0] pc;
    
    assign if_inst_addr_misal = ((pc[1 : 0] != 2'b00) & if_valid);
    
    assign if_int_flag = int_flag;
    assign if_exp_flag = if_inst_addr_misal;
    // assign if_exp_int_flag = if_int_flag | if_exp_flag;


    
    pc_reg pc_reg_inst
    (
        .if_valid(if_valid),
        .clk(clk),
        .rst_n(rst_n),
        
        .bj_flag(bj_flag),
        .bj_addr(bj_addr),
        
        .pipe_stall(pipe_stall),
        
        .iram_en(iram_en),
        .pc_o(pc)
    );
    
    

    
    assign inst_raddr = pc[`IRAM_RADDR_BASE];
    
    
    assign if_pc = pc;
    
    assign if_inst = inst;  //未来可能会有总线读取的外部存储器的指令，在到缓存读取的指令
    






endmodule 