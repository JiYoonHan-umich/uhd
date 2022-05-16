// -------------------------------------------------------------
// 
// File Name: hdlsrc\FFTHDLOptimizedExample_Burst\MINRESRX2FFT_CTRL.v
// Created: 2022-03-29 12:17:07
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: MINRESRX2FFT_CTRL
// Source Path: FFTHDLOptimizedExample_Burst/FFT Burst/FFT/MINRESRX2FFT_CTRL
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module MINRESRX2FFT_CTRL
          (clk,
           reset,
           din_1_re,
           din_1_im,
           validIn,
           stgOut1_re,
           stgOut1_im,
           stgOut2_re,
           stgOut2_im,
           stgOut_vld,
           dMemIn1_re,
           dMemIn1_im,
           dMemIn2_re,
           dMemIn2_im,
           wrEnb1,
           wrEnb2,
           wrEnb3,
           rdEnb1,
           rdEnb2,
           rdEnb3,
           dMemOut_vld,
           vldOut,
           stage,
           rdy,
           initIC,
           unLoadPhase);


  input   clk;
  input   reset;
  input   signed [24:0] din_1_re;  // sfix25_En13
  input   signed [24:0] din_1_im;  // sfix25_En13
  input   validIn;
  input   signed [24:0] stgOut1_re;  // sfix25_En13
  input   signed [24:0] stgOut1_im;  // sfix25_En13
  input   signed [24:0] stgOut2_re;  // sfix25_En13
  input   signed [24:0] stgOut2_im;  // sfix25_En13
  input   stgOut_vld;
  output  signed [24:0] dMemIn1_re;  // sfix25_En13
  output  signed [24:0] dMemIn1_im;  // sfix25_En13
  output  signed [24:0] dMemIn2_re;  // sfix25_En13
  output  signed [24:0] dMemIn2_im;  // sfix25_En13
  output  wrEnb1;
  output  wrEnb2;
  output  wrEnb3;
  output  rdEnb1;
  output  rdEnb2;
  output  rdEnb3;
  output  dMemOut_vld;
  output  vldOut;
  output  [3:0] stage;  // ufix4
  output  rdy;
  output  initIC;
  output  unLoadPhase;


  reg  minResRX2FFTCtrl_rdyReg;
  reg [8:0] minResRX2FFTCtrl_inSampleCnt;  // ufix9
  reg [8:0] minResRX2FFTCtrl_outSampleCnt;  // ufix9
  reg [3:0] minResRX2FFTCtrl_state;  // ufix4
  reg [3:0] minResRX2FFTCtrl_stageReg;  // ufix4
  reg [7:0] minResRX2FFTCtrl_procCnt;  // ufix8
  reg [2:0] minResRX2FFTCtrl_waitCnt;  // ufix3
  reg  minResRX2FFTCtrl_wrEnb1_Reg;
  reg  minResRX2FFTCtrl_wrEnb2_Reg;
  reg  minResRX2FFTCtrl_wrEnb3_Reg;
  reg  minResRX2FFTCtrl_rdEnb1_Reg;
  reg  minResRX2FFTCtrl_rdEnb2_Reg;
  reg  minResRX2FFTCtrl_rdEnb3_Reg;
  reg signed [24:0] minResRX2FFTCtrl_dOut1Re_Reg;  // sfix25
  reg signed [24:0] minResRX2FFTCtrl_dOut2Re_Reg;  // sfix25
  reg signed [24:0] minResRX2FFTCtrl_dOut1Im_Reg;  // sfix25
  reg signed [24:0] minResRX2FFTCtrl_dOut2Im_Reg;  // sfix25
  reg signed [24:0] minResRX2FFTCtrl_xSample_re;  // sfix25
  reg signed [24:0] minResRX2FFTCtrl_xSample_im;  // sfix25
  reg  minResRX2FFTCtrl_xSampleVld;
  reg  minResRX2FFTCtrl_unLoadReg;
  reg  minResRX2FFTCtrl_btfInVld_Reg;
  reg  minResRX2FFTCtrl_vldOut_Reg_1;
  reg  minResRX2FFTCtrl_initICReg;
  reg [1:0] minResRX2FFTCtrl_memWait;  // ufix2
  reg  minResRX2FFTCtrl_activeMem;
  reg  minResRX2FFTCtrl_rdyReg_next;
  reg [8:0] minResRX2FFTCtrl_inSampleCnt_next;  // ufix9
  reg [8:0] minResRX2FFTCtrl_outSampleCnt_next;  // ufix9
  reg [3:0] minResRX2FFTCtrl_state_next;  // ufix4
  reg [3:0] minResRX2FFTCtrl_stageReg_next;  // ufix4
  reg [7:0] minResRX2FFTCtrl_procCnt_next;  // ufix8
  reg [2:0] minResRX2FFTCtrl_waitCnt_next;  // ufix3
  reg  minResRX2FFTCtrl_wrEnb1_Reg_next;
  reg  minResRX2FFTCtrl_wrEnb2_Reg_next;
  reg  minResRX2FFTCtrl_wrEnb3_Reg_next;
  reg  minResRX2FFTCtrl_rdEnb1_Reg_next;
  reg  minResRX2FFTCtrl_rdEnb2_Reg_next;
  reg  minResRX2FFTCtrl_rdEnb3_Reg_next;
  reg signed [24:0] minResRX2FFTCtrl_dOut1Re_Reg_next;  // sfix25_En13
  reg signed [24:0] minResRX2FFTCtrl_dOut2Re_Reg_next;  // sfix25_En13
  reg signed [24:0] minResRX2FFTCtrl_dOut1Im_Reg_next;  // sfix25_En13
  reg signed [24:0] minResRX2FFTCtrl_dOut2Im_Reg_next;  // sfix25_En13
  reg signed [24:0] minResRX2FFTCtrl_xSample_re_next;  // sfix25_En13
  reg signed [24:0] minResRX2FFTCtrl_xSample_im_next;  // sfix25_En13
  reg  minResRX2FFTCtrl_xSampleVld_next;
  reg  minResRX2FFTCtrl_unLoadReg_next;
  reg  minResRX2FFTCtrl_btfInVld_Reg_next;
  reg  minResRX2FFTCtrl_vldOut_Reg_next;
  reg  minResRX2FFTCtrl_initICReg_next;
  reg [1:0] minResRX2FFTCtrl_memWait_next;  // ufix2
  reg  minResRX2FFTCtrl_activeMem_next;
  reg signed [24:0] dMemIn1_re_1;  // sfix25_En13
  reg signed [24:0] dMemIn1_im_1;  // sfix25_En13
  reg signed [24:0] dMemIn2_re_1;  // sfix25_En13
  reg signed [24:0] dMemIn2_im_1;  // sfix25_En13
  reg  wrEnb1_1;
  reg  wrEnb2_1;
  reg  wrEnb3_1;
  reg  rdEnb1_1;
  reg  rdEnb2_1;
  reg  rdEnb3_1;
  reg  dMemOut_vld_1;
  reg  vldOut_1;
  reg [3:0] stage_1;  // ufix4
  reg  rdy_1;
  reg  initIC_1;
  reg  unLoadPhase_1;
  reg  minResRX2FFTCtrl_stageLSB;
  reg  minResRX2FFTCtrl_vldOut_Reg;
  reg  minResRX2FFTCtrl_vldOut_Reg_0;


  // minResRX2FFTCtrl
  always @(posedge clk or posedge reset)
    begin : minResRX2FFTCtrl_process
      if (reset == 1'b1) begin
        minResRX2FFTCtrl_state <= 4'b0000;
        minResRX2FFTCtrl_rdyReg <= 1'b1;
        minResRX2FFTCtrl_inSampleCnt <= 9'b000000000;
        minResRX2FFTCtrl_outSampleCnt <= 9'b000000000;
        minResRX2FFTCtrl_procCnt <= 8'b00000000;
        minResRX2FFTCtrl_waitCnt <= 3'b000;
        minResRX2FFTCtrl_memWait <= 2'b00;
        minResRX2FFTCtrl_wrEnb1_Reg <= 1'b0;
        minResRX2FFTCtrl_wrEnb2_Reg <= 1'b0;
        minResRX2FFTCtrl_wrEnb3_Reg <= 1'b0;
        minResRX2FFTCtrl_stageReg <= 4'b0000;
        minResRX2FFTCtrl_dOut1Re_Reg <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_dOut2Re_Reg <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_dOut1Im_Reg <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_dOut2Im_Reg <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_rdEnb1_Reg <= 1'b0;
        minResRX2FFTCtrl_rdEnb2_Reg <= 1'b0;
        minResRX2FFTCtrl_rdEnb3_Reg <= 1'b0;
        minResRX2FFTCtrl_xSample_re <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_xSample_im <= 25'sb0000000000000000000000000;
        minResRX2FFTCtrl_xSampleVld <= 1'b0;
        minResRX2FFTCtrl_vldOut_Reg_1 <= 1'b0;
        minResRX2FFTCtrl_btfInVld_Reg <= 1'b0;
        minResRX2FFTCtrl_initICReg <= 1'b0;
        minResRX2FFTCtrl_unLoadReg <= 1'b0;
        minResRX2FFTCtrl_activeMem <= 1'b0;
      end
      else begin
        minResRX2FFTCtrl_rdyReg <= minResRX2FFTCtrl_rdyReg_next;
        minResRX2FFTCtrl_inSampleCnt <= minResRX2FFTCtrl_inSampleCnt_next;
        minResRX2FFTCtrl_outSampleCnt <= minResRX2FFTCtrl_outSampleCnt_next;
        minResRX2FFTCtrl_state <= minResRX2FFTCtrl_state_next;
        minResRX2FFTCtrl_stageReg <= minResRX2FFTCtrl_stageReg_next;
        minResRX2FFTCtrl_procCnt <= minResRX2FFTCtrl_procCnt_next;
        minResRX2FFTCtrl_waitCnt <= minResRX2FFTCtrl_waitCnt_next;
        minResRX2FFTCtrl_wrEnb1_Reg <= minResRX2FFTCtrl_wrEnb1_Reg_next;
        minResRX2FFTCtrl_wrEnb2_Reg <= minResRX2FFTCtrl_wrEnb2_Reg_next;
        minResRX2FFTCtrl_wrEnb3_Reg <= minResRX2FFTCtrl_wrEnb3_Reg_next;
        minResRX2FFTCtrl_rdEnb1_Reg <= minResRX2FFTCtrl_rdEnb1_Reg_next;
        minResRX2FFTCtrl_rdEnb2_Reg <= minResRX2FFTCtrl_rdEnb2_Reg_next;
        minResRX2FFTCtrl_rdEnb3_Reg <= minResRX2FFTCtrl_rdEnb3_Reg_next;
        minResRX2FFTCtrl_dOut1Re_Reg <= minResRX2FFTCtrl_dOut1Re_Reg_next;
        minResRX2FFTCtrl_dOut2Re_Reg <= minResRX2FFTCtrl_dOut2Re_Reg_next;
        minResRX2FFTCtrl_dOut1Im_Reg <= minResRX2FFTCtrl_dOut1Im_Reg_next;
        minResRX2FFTCtrl_dOut2Im_Reg <= minResRX2FFTCtrl_dOut2Im_Reg_next;
        minResRX2FFTCtrl_xSample_re <= minResRX2FFTCtrl_xSample_re_next;
        minResRX2FFTCtrl_xSample_im <= minResRX2FFTCtrl_xSample_im_next;
        minResRX2FFTCtrl_xSampleVld <= minResRX2FFTCtrl_xSampleVld_next;
        minResRX2FFTCtrl_unLoadReg <= minResRX2FFTCtrl_unLoadReg_next;
        minResRX2FFTCtrl_btfInVld_Reg <= minResRX2FFTCtrl_btfInVld_Reg_next;
        minResRX2FFTCtrl_vldOut_Reg_1 <= minResRX2FFTCtrl_vldOut_Reg_next;
        minResRX2FFTCtrl_initICReg <= minResRX2FFTCtrl_initICReg_next;
        minResRX2FFTCtrl_memWait <= minResRX2FFTCtrl_memWait_next;
        minResRX2FFTCtrl_activeMem <= minResRX2FFTCtrl_activeMem_next;
      end
    end

  always @(din_1_im, din_1_re, minResRX2FFTCtrl_activeMem, minResRX2FFTCtrl_btfInVld_Reg,
       minResRX2FFTCtrl_dOut1Im_Reg, minResRX2FFTCtrl_dOut1Re_Reg,
       minResRX2FFTCtrl_dOut2Im_Reg, minResRX2FFTCtrl_dOut2Re_Reg,
       minResRX2FFTCtrl_inSampleCnt, minResRX2FFTCtrl_initICReg,
       minResRX2FFTCtrl_memWait, minResRX2FFTCtrl_outSampleCnt,
       minResRX2FFTCtrl_procCnt, minResRX2FFTCtrl_rdEnb1_Reg,
       minResRX2FFTCtrl_rdEnb2_Reg, minResRX2FFTCtrl_rdEnb3_Reg,
       minResRX2FFTCtrl_rdyReg, minResRX2FFTCtrl_stageReg,
       minResRX2FFTCtrl_state, minResRX2FFTCtrl_unLoadReg,
       minResRX2FFTCtrl_vldOut_Reg_1, minResRX2FFTCtrl_waitCnt,
       minResRX2FFTCtrl_wrEnb1_Reg, minResRX2FFTCtrl_wrEnb2_Reg,
       minResRX2FFTCtrl_wrEnb3_Reg, minResRX2FFTCtrl_xSampleVld,
       minResRX2FFTCtrl_xSample_im, minResRX2FFTCtrl_xSample_re, stgOut1_im,
       stgOut1_re, stgOut2_im, stgOut2_re, stgOut_vld, validIn) begin
    minResRX2FFTCtrl_vldOut_Reg = 1'b0;
    minResRX2FFTCtrl_vldOut_Reg_0 = 1'b0;
    minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt;
    minResRX2FFTCtrl_rdyReg_next = minResRX2FFTCtrl_rdyReg;
    minResRX2FFTCtrl_outSampleCnt_next = minResRX2FFTCtrl_outSampleCnt;
    minResRX2FFTCtrl_state_next = minResRX2FFTCtrl_state;
    minResRX2FFTCtrl_stageReg_next = minResRX2FFTCtrl_stageReg;
    minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt;
    minResRX2FFTCtrl_waitCnt_next = minResRX2FFTCtrl_waitCnt;
    minResRX2FFTCtrl_wrEnb1_Reg_next = minResRX2FFTCtrl_wrEnb1_Reg;
    minResRX2FFTCtrl_wrEnb2_Reg_next = minResRX2FFTCtrl_wrEnb2_Reg;
    minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_wrEnb3_Reg;
    minResRX2FFTCtrl_rdEnb1_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
    minResRX2FFTCtrl_rdEnb2_Reg_next = minResRX2FFTCtrl_rdEnb2_Reg;
    minResRX2FFTCtrl_rdEnb3_Reg_next = minResRX2FFTCtrl_rdEnb3_Reg;
    minResRX2FFTCtrl_dOut1Re_Reg_next = minResRX2FFTCtrl_dOut1Re_Reg;
    minResRX2FFTCtrl_dOut2Re_Reg_next = minResRX2FFTCtrl_dOut2Re_Reg;
    minResRX2FFTCtrl_dOut1Im_Reg_next = minResRX2FFTCtrl_dOut1Im_Reg;
    minResRX2FFTCtrl_dOut2Im_Reg_next = minResRX2FFTCtrl_dOut2Im_Reg;
    minResRX2FFTCtrl_xSample_re_next = minResRX2FFTCtrl_xSample_re;
    minResRX2FFTCtrl_xSample_im_next = minResRX2FFTCtrl_xSample_im;
    minResRX2FFTCtrl_xSampleVld_next = minResRX2FFTCtrl_xSampleVld;
    minResRX2FFTCtrl_unLoadReg_next = minResRX2FFTCtrl_unLoadReg;
    minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_btfInVld_Reg;
    minResRX2FFTCtrl_vldOut_Reg_next = minResRX2FFTCtrl_vldOut_Reg_1;
    minResRX2FFTCtrl_initICReg_next = minResRX2FFTCtrl_initICReg;
    minResRX2FFTCtrl_memWait_next = minResRX2FFTCtrl_memWait;
    minResRX2FFTCtrl_activeMem_next = minResRX2FFTCtrl_activeMem;
    minResRX2FFTCtrl_stageLSB = minResRX2FFTCtrl_stageReg[0] != 1'b0;
    case ( minResRX2FFTCtrl_state)
      4'b0000 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0000;
          minResRX2FFTCtrl_rdyReg_next = 1'b1;
          minResRX2FFTCtrl_stageReg_next = 4'b0000;
          minResRX2FFTCtrl_inSampleCnt_next = 9'b000000000;
          minResRX2FFTCtrl_outSampleCnt_next = 9'b000000000;
          minResRX2FFTCtrl_waitCnt_next = 3'b000;
          minResRX2FFTCtrl_memWait_next = 2'b00;
          minResRX2FFTCtrl_procCnt_next = 8'b00000000;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut2Re_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut1Im_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut2Im_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSample_re_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSample_im_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSampleVld_next = 1'b0;
          minResRX2FFTCtrl_vldOut_Reg_next = 1'b0;
          minResRX2FFTCtrl_btfInVld_Reg_next = 1'b0;
          minResRX2FFTCtrl_unLoadReg_next = 1'b0;
          minResRX2FFTCtrl_activeMem_next = 1'b0;
          if (validIn) begin
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_dOut1Re_Reg_next = din_1_re;
            minResRX2FFTCtrl_dOut1Im_Reg_next = din_1_im;
            minResRX2FFTCtrl_inSampleCnt_next = 9'b000000001;
            minResRX2FFTCtrl_initICReg_next = 1'b1;
            minResRX2FFTCtrl_state_next = 4'b0001;
          end
        end
      4'b0001 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0001;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = din_1_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = din_1_im;
          minResRX2FFTCtrl_initICReg_next = 1'b0;
          if (validIn) begin
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            if (minResRX2FFTCtrl_inSampleCnt == 9'b011111111) begin
              minResRX2FFTCtrl_state_next = 4'b0010;
              minResRX2FFTCtrl_stageReg_next = 4'b0000;
              minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000001;
            end
            else begin
              minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000001;
            end
          end
          minResRX2FFTCtrl_vldOut_Reg_next = (minResRX2FFTCtrl_rdEnb1_Reg || minResRX2FFTCtrl_rdEnb2_Reg) || minResRX2FFTCtrl_rdEnb3_Reg;
          if (minResRX2FFTCtrl_outSampleCnt == 9'b111111111) begin
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          end
          else begin
            minResRX2FFTCtrl_rdEnb1_Reg_next =  ! minResRX2FFTCtrl_rdEnb1_Reg;
          end
          if (minResRX2FFTCtrl_outSampleCnt > 9'b011111111) begin
            minResRX2FFTCtrl_unLoadReg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = ( ! minResRX2FFTCtrl_rdEnb2_Reg) && ( ! minResRX2FFTCtrl_activeMem);
            minResRX2FFTCtrl_rdEnb3_Reg_next = ( ! minResRX2FFTCtrl_rdEnb3_Reg) && minResRX2FFTCtrl_activeMem;
            minResRX2FFTCtrl_outSampleCnt_next = minResRX2FFTCtrl_outSampleCnt + 9'b000000001;
          end
          else begin
            minResRX2FFTCtrl_unLoadReg_next = 1'b0;
            minResRX2FFTCtrl_vldOut_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
          end
        end
      4'b0010 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0010;
          minResRX2FFTCtrl_rdyReg_next = 1'b1;
          minResRX2FFTCtrl_unLoadReg_next = 1'b0;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_initICReg_next = 1'b0;
          if (validIn) begin
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            if (minResRX2FFTCtrl_inSampleCnt == 9'b111111111) begin
              minResRX2FFTCtrl_rdyReg_next = 1'b0;
              minResRX2FFTCtrl_state_next = 4'b0011;
            end
            minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000001;
          end
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
          minResRX2FFTCtrl_vldOut_Reg = minResRX2FFTCtrl_rdEnb2_Reg || minResRX2FFTCtrl_rdEnb3_Reg;
          minResRX2FFTCtrl_vldOut_Reg_next = minResRX2FFTCtrl_vldOut_Reg;
          if (minResRX2FFTCtrl_outSampleCnt > 9'b011111111) begin
            minResRX2FFTCtrl_rdEnb2_Reg_next = ( ! minResRX2FFTCtrl_rdEnb2_Reg) && ( ! minResRX2FFTCtrl_activeMem);
            minResRX2FFTCtrl_rdEnb3_Reg_next = ( ! minResRX2FFTCtrl_rdEnb3_Reg) && minResRX2FFTCtrl_activeMem;
            minResRX2FFTCtrl_outSampleCnt_next = minResRX2FFTCtrl_outSampleCnt + 9'b000000001;
          end
          else begin
            minResRX2FFTCtrl_vldOut_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
            minResRX2FFTCtrl_activeMem_next = 1'b0;
          end
        end
      4'b0011 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0011;
          minResRX2FFTCtrl_unLoadReg_next = 1'b0;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_vldOut_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          if (validIn && ( ! minResRX2FFTCtrl_xSampleVld)) begin
            minResRX2FFTCtrl_xSample_re_next = din_1_re;
            minResRX2FFTCtrl_xSample_im_next = din_1_im;
            minResRX2FFTCtrl_xSampleVld_next = 1'b1;
          end
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            if (minResRX2FFTCtrl_procCnt == 8'b11111111) begin
              minResRX2FFTCtrl_state_next = 4'b0110;
            end
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
        end
      4'b0100 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0100;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_initICReg_next = 1'b0;
          if (minResRX2FFTCtrl_inSampleCnt == 9'b111111110) begin
            minResRX2FFTCtrl_state_next = 4'b0101;
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_rdEnb3_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_inSampleCnt_next = 9'b000000000;
          end
          else begin
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_rdEnb3_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000010;
          end
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
        end
      4'b0101 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0101;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            if (minResRX2FFTCtrl_procCnt == 8'b11111111) begin
              minResRX2FFTCtrl_state_next = 4'b0110;
            end
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
        end
      4'b0110 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0110;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (minResRX2FFTCtrl_memWait == 2'b10) begin
            if (minResRX2FFTCtrl_stageReg == 4'b0111) begin
              minResRX2FFTCtrl_state_next = 4'b0111;
            end
            else begin
              minResRX2FFTCtrl_state_next = 4'b0100;
            end
            minResRX2FFTCtrl_initICReg_next = 1'b1;
            minResRX2FFTCtrl_stageReg_next = minResRX2FFTCtrl_stageReg + 4'b0001;
            minResRX2FFTCtrl_memWait_next = 2'b00;
          end
          else begin
            minResRX2FFTCtrl_memWait_next = minResRX2FFTCtrl_memWait + 2'b01;
          end
        end
      4'b0111 :
        begin
          minResRX2FFTCtrl_state_next = 4'b0111;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_initICReg_next = 1'b0;
          if (minResRX2FFTCtrl_inSampleCnt == 9'b111111110) begin
            minResRX2FFTCtrl_state_next = 4'b1000;
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_rdEnb3_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_inSampleCnt_next = 9'b000000000;
          end
          else begin
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_rdEnb3_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000010;
          end
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
        end
      4'b1000 :
        begin
          minResRX2FFTCtrl_state_next = 4'b1000;
          minResRX2FFTCtrl_btfInVld_Reg_next = minResRX2FFTCtrl_rdEnb1_Reg;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = stgOut1_re;
          minResRX2FFTCtrl_dOut2Re_Reg_next = stgOut2_re;
          minResRX2FFTCtrl_dOut1Im_Reg_next = stgOut1_im;
          minResRX2FFTCtrl_dOut2Im_Reg_next = stgOut2_im;
          if (stgOut_vld) begin
            if (minResRX2FFTCtrl_procCnt == 8'b11111111) begin
              minResRX2FFTCtrl_state_next = 4'b1010;
              minResRX2FFTCtrl_unLoadReg_next = 1'b1;
              minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
              minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
              minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
              minResRX2FFTCtrl_vldOut_Reg_next = 1'b1;
              minResRX2FFTCtrl_activeMem_next = minResRX2FFTCtrl_stageLSB;
            end
            minResRX2FFTCtrl_procCnt_next = minResRX2FFTCtrl_procCnt + 8'b00000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_wrEnb2_Reg_next =  ! minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_wrEnb3_Reg_next = minResRX2FFTCtrl_stageLSB;
          end
        end
      4'b1001 :
        begin
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          if (minResRX2FFTCtrl_waitCnt == 3'b011) begin
            minResRX2FFTCtrl_state_next = 4'b1010;
            minResRX2FFTCtrl_unLoadReg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b1;
            minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
            minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
            minResRX2FFTCtrl_vldOut_Reg_next = 1'b0;
            minResRX2FFTCtrl_activeMem_next = minResRX2FFTCtrl_stageLSB;
            minResRX2FFTCtrl_outSampleCnt_next = minResRX2FFTCtrl_outSampleCnt + 9'b000000001;
            minResRX2FFTCtrl_waitCnt_next = 3'b000;
          end
          else begin
            minResRX2FFTCtrl_waitCnt_next = minResRX2FFTCtrl_waitCnt + 3'b001;
          end
        end
      4'b1010 :
        begin
          minResRX2FFTCtrl_state_next = 4'b1010;
          minResRX2FFTCtrl_btfInVld_Reg_next = 1'b0;
          minResRX2FFTCtrl_unLoadReg_next = 1'b1;
          minResRX2FFTCtrl_vldOut_Reg_0 = (minResRX2FFTCtrl_rdEnb1_Reg || minResRX2FFTCtrl_rdEnb2_Reg) || minResRX2FFTCtrl_rdEnb3_Reg;
          minResRX2FFTCtrl_vldOut_Reg_next = minResRX2FFTCtrl_vldOut_Reg_0;
          if (minResRX2FFTCtrl_outSampleCnt < 9'b100000000) begin
            minResRX2FFTCtrl_rdEnb1_Reg_next =  ! minResRX2FFTCtrl_rdEnb1_Reg;
            minResRX2FFTCtrl_rdEnb2_Reg_next = ( ! minResRX2FFTCtrl_rdEnb2_Reg) && ( ! minResRX2FFTCtrl_activeMem);
            minResRX2FFTCtrl_rdEnb3_Reg_next = ( ! minResRX2FFTCtrl_rdEnb3_Reg) && minResRX2FFTCtrl_activeMem;
          end
          else begin
            minResRX2FFTCtrl_rdyReg_next = 1'b1;
            minResRX2FFTCtrl_stageReg_next = 4'b0000;
            minResRX2FFTCtrl_rdEnb1_Reg_next =  ! minResRX2FFTCtrl_rdEnb1_Reg;
            minResRX2FFTCtrl_rdEnb2_Reg_next = ( ! minResRX2FFTCtrl_rdEnb2_Reg) && ( ! minResRX2FFTCtrl_activeMem);
            minResRX2FFTCtrl_rdEnb3_Reg_next = ( ! minResRX2FFTCtrl_rdEnb3_Reg) && minResRX2FFTCtrl_activeMem;
            minResRX2FFTCtrl_state_next = 4'b0001;
            minResRX2FFTCtrl_initICReg_next = 1'b1;
          end
          minResRX2FFTCtrl_outSampleCnt_next = minResRX2FFTCtrl_outSampleCnt + 9'b000000001;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          if (minResRX2FFTCtrl_xSampleVld) begin
            minResRX2FFTCtrl_dOut1Re_Reg_next = minResRX2FFTCtrl_xSample_re;
            minResRX2FFTCtrl_dOut1Im_Reg_next = minResRX2FFTCtrl_xSample_im;
            minResRX2FFTCtrl_xSampleVld_next = 1'b0;
            minResRX2FFTCtrl_inSampleCnt_next = minResRX2FFTCtrl_inSampleCnt + 9'b000000001;
            minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b1;
          end
        end
      default :
        begin
          minResRX2FFTCtrl_state_next = 4'b0000;
          minResRX2FFTCtrl_rdyReg_next = 1'b1;
          minResRX2FFTCtrl_stageReg_next = 4'b0000;
          minResRX2FFTCtrl_inSampleCnt_next = 9'b000000000;
          minResRX2FFTCtrl_procCnt_next = 8'b00000000;
          minResRX2FFTCtrl_waitCnt_next = 3'b000;
          minResRX2FFTCtrl_wrEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_wrEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb1_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb2_Reg_next = 1'b0;
          minResRX2FFTCtrl_rdEnb3_Reg_next = 1'b0;
          minResRX2FFTCtrl_dOut1Re_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut2Re_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut1Im_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_dOut2Im_Reg_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSample_re_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSample_im_next = 25'sb0000000000000000000000000;
          minResRX2FFTCtrl_xSampleVld_next = 1'b0;
          minResRX2FFTCtrl_btfInVld_Reg_next = 1'b0;
          minResRX2FFTCtrl_unLoadReg_next = 1'b0;
        end
    endcase
    dMemIn1_re_1 = minResRX2FFTCtrl_dOut1Re_Reg;
    dMemIn1_im_1 = minResRX2FFTCtrl_dOut1Im_Reg;
    dMemIn2_re_1 = minResRX2FFTCtrl_dOut2Re_Reg;
    dMemIn2_im_1 = minResRX2FFTCtrl_dOut2Im_Reg;
    wrEnb1_1 = minResRX2FFTCtrl_wrEnb1_Reg;
    wrEnb2_1 = minResRX2FFTCtrl_wrEnb2_Reg;
    wrEnb3_1 = minResRX2FFTCtrl_wrEnb3_Reg;
    rdEnb1_1 = minResRX2FFTCtrl_rdEnb1_Reg;
    rdEnb2_1 = minResRX2FFTCtrl_rdEnb2_Reg;
    rdEnb3_1 = minResRX2FFTCtrl_rdEnb3_Reg;
    dMemOut_vld_1 = minResRX2FFTCtrl_btfInVld_Reg;
    vldOut_1 = minResRX2FFTCtrl_vldOut_Reg_1;
    stage_1 = minResRX2FFTCtrl_stageReg;
    rdy_1 = minResRX2FFTCtrl_rdyReg;
    initIC_1 = minResRX2FFTCtrl_initICReg;
    unLoadPhase_1 = minResRX2FFTCtrl_unLoadReg;
  end



  assign dMemIn1_re = dMemIn1_re_1;

  assign dMemIn1_im = dMemIn1_im_1;

  assign dMemIn2_re = dMemIn2_re_1;

  assign dMemIn2_im = dMemIn2_im_1;

  assign wrEnb1 = wrEnb1_1;

  assign wrEnb2 = wrEnb2_1;

  assign wrEnb3 = wrEnb3_1;

  assign rdEnb1 = rdEnb1_1;

  assign rdEnb2 = rdEnb2_1;

  assign rdEnb3 = rdEnb3_1;

  assign dMemOut_vld = dMemOut_vld_1;

  assign vldOut = vldOut_1;

  assign stage = stage_1;

  assign rdy = rdy_1;

  assign initIC = initIC_1;

  assign unLoadPhase = unLoadPhase_1;

endmodule  // MINRESRX2FFT_CTRL

