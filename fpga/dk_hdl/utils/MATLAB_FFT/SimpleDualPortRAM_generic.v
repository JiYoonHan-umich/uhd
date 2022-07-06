// -------------------------------------------------------------
// 
// File Name: hdlsrc\FFTHDLOptimizedExample_Burst\SimpleDualPortRAM_generic.v
// Created: 2022-07-02 22:54:14
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: SimpleDualPortRAM_generic
// Source Path: FFTHDLOptimizedExample_Burst/FFT Burst/FFT/MINRESRX2FFT_MEMORY/SimpleDualPortRAM_generic
// Hierarchy Level: 3
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module SimpleDualPortRAM_generic
          (clk,
           wr_din,
           wr_addr,
           wr_en,
           rd_addr,
           rd_dout);

  parameter integer AddrWidth  = 1;
  parameter integer DataWidth  = 1;

  input   clk;
  input   signed [DataWidth - 1:0] wr_din;  // parameterized width
  input   [AddrWidth - 1:0] wr_addr;  // parameterized width
  input   wr_en;  // ufix1
  input   [AddrWidth - 1:0] rd_addr;  // parameterized width
  output  signed [DataWidth - 1:0] rd_dout;  // parameterized width


  reg  [DataWidth - 1:0] ram [2**AddrWidth - 1:0];
  reg  [DataWidth - 1:0] data_int;
  integer i;

  initial begin
    for (i=0; i<=2**AddrWidth - 1; i=i+1) begin
      ram[i] = 0;
    end
    data_int = 0;
  end


  always @(posedge clk)
    begin : SimpleDualPortRAM_generic_process
      if (wr_en == 1'b1) begin
        ram[wr_addr] <= wr_din;
      end
      data_int <= ram[rd_addr];
    end

  assign rd_dout = data_int;

endmodule  // SimpleDualPortRAM_generic

