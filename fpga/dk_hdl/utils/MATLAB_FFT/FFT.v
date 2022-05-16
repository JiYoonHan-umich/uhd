// -------------------------------------------------------------
// 
// File Name: hdlsrc\FFTHDLOptimizedExample_Burst\FFT.v
// Created: 2022-03-29 12:17:07
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: FFT
// Source Path: FFTHDLOptimizedExample_Burst/FFT Burst/FFT
// Hierarchy Level: 1
// 
// FFT
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module FFT
          (clk,
           reset,
           dataIn_re,
           dataIn_im,
           validIn,
           dataOut_re,
           dataOut_im,
           validOut,
           ready);


  input   clk;
  input   reset;
  input   signed [15:0] dataIn_re;  // sfix16_En13
  input   signed [15:0] dataIn_im;  // sfix16_En13
  input   validIn;
  output  signed [24:0] dataOut_re;  // sfix25_En13
  output  signed [24:0] dataOut_im;  // sfix25_En13
  output  validOut;
  output  ready;


  wire signed [24:0] dataIn_1_cast_re;  // sfix25_En13
  wire signed [24:0] dataIn_1_cast_im;  // sfix25_En13
  wire syncReset;
  wire dMemOut_vld;
  reg  dMemOutDly_vld;
  wire [3:0] stage;  // ufix4
  wire initIC;
  wire signed [24:0] twdl_re;  // sfix25_En23
  wire signed [24:0] twdl_im;  // sfix25_En23
  wire signed [24:0] dMemIn1_re;  // sfix25_En13
  wire signed [24:0] dMemIn1_im;  // sfix25_En13
  wire signed [24:0] dMemIn2_re;  // sfix25_En13
  wire signed [24:0] dMemIn2_im;  // sfix25_En13
  wire wrEnb1;
  wire wrEnb2;
  wire wrEnb3;
  wire rdEnb1;
  wire rdEnb2;
  wire rdEnb3;
  wire unLoadPhase;
  wire signed [24:0] dMemOut1_re;  // sfix25_En13
  wire signed [24:0] dMemOut1_im;  // sfix25_En13
  wire signed [24:0] dMemOut2_re;  // sfix25_En13
  wire signed [24:0] dMemOut2_im;  // sfix25_En13
  wire rdy;
  wire signed [24:0] btfIn1_re;  // sfix25_En13
  wire signed [24:0] btfIn1_im;  // sfix25_En13
  wire signed [24:0] btfIn2_re;  // sfix25_En13
  wire signed [24:0] btfIn2_im;  // sfix25_En13
  wire btfIn_vld;
  wire signed [24:0] btfOut1_re;  // sfix25_En13
  wire signed [24:0] btfOut1_im;  // sfix25_En13
  wire signed [24:0] btfOut2_re;  // sfix25_En13
  wire signed [24:0] btfOut2_im;  // sfix25_En13
  wire btfOut_vld;
  wire signed [24:0] stgOut1_re;  // sfix25_En13
  wire signed [24:0] stgOut1_im;  // sfix25_En13
  wire signed [24:0] stgOut2_re;  // sfix25_En13
  wire signed [24:0] stgOut2_im;  // sfix25_En13
  wire stgOut_vld;
  wire vldOut;
  wire signed [24:0] dOut_re;  // sfix25_En13
  wire signed [24:0] dOut_im;  // sfix25_En13
  wire dout_vld;


  assign dataIn_1_cast_re = {{9{dataIn_re[15]}}, dataIn_re};
  assign dataIn_1_cast_im = {{9{dataIn_im[15]}}, dataIn_im};



  assign syncReset = 1'b0;



  always @(posedge clk or posedge reset)
    begin : intdelay_process
      if (reset == 1'b1) begin
        dMemOutDly_vld <= 1'b0;
      end
      else begin
        if (syncReset == 1'b1) begin
          dMemOutDly_vld <= 1'b0;
        end
        else begin
          dMemOutDly_vld <= dMemOut_vld;
        end
      end
    end



  TWDLROM u_MinResRX2FFT_TWDLROM (.clk(clk),
                                  .reset(reset),
                                  .dMemOutDly_vld(dMemOutDly_vld),
                                  .stage(stage),  // ufix4
                                  .initIC(initIC),
                                  .twdl_re(twdl_re),  // sfix25_En23
                                  .twdl_im(twdl_im)  // sfix25_En23
                                  );

  MINRESRX2FFT_MEMORY u_MinResRX2FFT_MEMORY (.clk(clk),
                                             .reset(reset),
                                             .dMemIn1_re(dMemIn1_re),  // sfix25_En13
                                             .dMemIn1_im(dMemIn1_im),  // sfix25_En13
                                             .dMemIn2_re(dMemIn2_re),  // sfix25_En13
                                             .dMemIn2_im(dMemIn2_im),  // sfix25_En13
                                             .wrEnb1(wrEnb1),
                                             .wrEnb2(wrEnb2),
                                             .wrEnb3(wrEnb3),
                                             .rdEnb1(rdEnb1),
                                             .rdEnb2(rdEnb2),
                                             .rdEnb3(rdEnb3),
                                             .stage(stage),  // ufix4
                                             .initIC(initIC),
                                             .unLoadPhase(unLoadPhase),
                                             .dMemOut1_re(dMemOut1_re),  // sfix25_En13
                                             .dMemOut1_im(dMemOut1_im),  // sfix25_En13
                                             .dMemOut2_re(dMemOut2_re),  // sfix25_En13
                                             .dMemOut2_im(dMemOut2_im)  // sfix25_En13
                                             );

  MINRESRX2FFT_BTFSEL u_MinResRX2FFT_BTFSEL (.clk(clk),
                                             .reset(reset),
                                             .din_1_re(dataIn_1_cast_re),  // sfix25_En13
                                             .din_1_im(dataIn_1_cast_im),  // sfix25_En13
                                             .validIn(validIn),
                                             .rdy(rdy),
                                             .dMemOut1_re(dMemOut1_re),  // sfix25_En13
                                             .dMemOut1_im(dMemOut1_im),  // sfix25_En13
                                             .dMemOut2_re(dMemOut2_re),  // sfix25_En13
                                             .dMemOut2_im(dMemOut2_im),  // sfix25_En13
                                             .dMemOut_vld(dMemOut_vld),
                                             .stage(stage),  // ufix4
                                             .initIC(initIC),
                                             .btfIn1_re(btfIn1_re),  // sfix25_En13
                                             .btfIn1_im(btfIn1_im),  // sfix25_En13
                                             .btfIn2_re(btfIn2_re),  // sfix25_En13
                                             .btfIn2_im(btfIn2_im),  // sfix25_En13
                                             .btfIn_vld(btfIn_vld)
                                             );

  MINRESRX2_BUTTERFLY u_MinResRX2FFT_BUTTERFLY (.clk(clk),
                                                .reset(reset),
                                                .btfIn1_re(btfIn1_re),  // sfix25_En13
                                                .btfIn1_im(btfIn1_im),  // sfix25_En13
                                                .btfIn2_re(btfIn2_re),  // sfix25_En13
                                                .btfIn2_im(btfIn2_im),  // sfix25_En13
                                                .btfIn_vld(btfIn_vld),
                                                .twdl_re(twdl_re),  // sfix25_En23
                                                .twdl_im(twdl_im),  // sfix25_En23
                                                .btfOut1_re(btfOut1_re),  // sfix25_En13
                                                .btfOut1_im(btfOut1_im),  // sfix25_En13
                                                .btfOut2_re(btfOut2_re),  // sfix25_En13
                                                .btfOut2_im(btfOut2_im),  // sfix25_En13
                                                .btfOut_vld(btfOut_vld)
                                                );

  MINRESRX2FFT_MEMSEL u_MinResRX2FFT_MEMSEL (.clk(clk),
                                             .reset(reset),
                                             .btfOut1_re(btfOut1_re),  // sfix25_En13
                                             .btfOut1_im(btfOut1_im),  // sfix25_En13
                                             .btfOut2_re(btfOut2_re),  // sfix25_En13
                                             .btfOut2_im(btfOut2_im),  // sfix25_En13
                                             .btfOut_vld(btfOut_vld),
                                             .stage(stage),  // ufix4
                                             .initIC(initIC),
                                             .stgOut1_re(stgOut1_re),  // sfix25_En13
                                             .stgOut1_im(stgOut1_im),  // sfix25_En13
                                             .stgOut2_re(stgOut2_re),  // sfix25_En13
                                             .stgOut2_im(stgOut2_im),  // sfix25_En13
                                             .stgOut_vld(stgOut_vld)
                                             );

  MINRESRX2FFT_CTRL u_MinResRX2FFT_CTRL (.clk(clk),
                                         .reset(reset),
                                         .din_1_re(dataIn_1_cast_re),  // sfix25_En13
                                         .din_1_im(dataIn_1_cast_im),  // sfix25_En13
                                         .validIn(validIn),
                                         .stgOut1_re(stgOut1_re),  // sfix25_En13
                                         .stgOut1_im(stgOut1_im),  // sfix25_En13
                                         .stgOut2_re(stgOut2_re),  // sfix25_En13
                                         .stgOut2_im(stgOut2_im),  // sfix25_En13
                                         .stgOut_vld(stgOut_vld),
                                         .dMemIn1_re(dMemIn1_re),  // sfix25_En13
                                         .dMemIn1_im(dMemIn1_im),  // sfix25_En13
                                         .dMemIn2_re(dMemIn2_re),  // sfix25_En13
                                         .dMemIn2_im(dMemIn2_im),  // sfix25_En13
                                         .wrEnb1(wrEnb1),
                                         .wrEnb2(wrEnb2),
                                         .wrEnb3(wrEnb3),
                                         .rdEnb1(rdEnb1),
                                         .rdEnb2(rdEnb2),
                                         .rdEnb3(rdEnb3),
                                         .dMemOut_vld(dMemOut_vld),
                                         .vldOut(vldOut),
                                         .stage(stage),  // ufix4
                                         .rdy(rdy),
                                         .initIC(initIC),
                                         .unLoadPhase(unLoadPhase)
                                         );

  MINRESRX2FFT_OUTMux u_MinResRX2FFT_OUTMUX (.clk(clk),
                                             .reset(reset),
                                             .rdEnb1(rdEnb1),
                                             .rdEnb2(rdEnb2),
                                             .rdEnb3(rdEnb3),
                                             .dMemOut1_re(dMemOut1_re),  // sfix25_En13
                                             .dMemOut1_im(dMemOut1_im),  // sfix25_En13
                                             .dMemOut2_re(dMemOut2_re),  // sfix25_En13
                                             .dMemOut2_im(dMemOut2_im),  // sfix25_En13
                                             .vldOut(vldOut),
                                             .dOut_re(dOut_re),  // sfix25_En13
                                             .dOut_im(dOut_im),  // sfix25_En13
                                             .dout_vld(dout_vld)
                                             );

  assign dataOut_re = dOut_re;

  assign dataOut_im = dOut_im;

  assign validOut = dout_vld;

  assign ready = rdy;

endmodule  // FFT

