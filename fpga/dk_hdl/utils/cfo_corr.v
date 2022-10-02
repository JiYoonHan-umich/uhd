module cfo_corr #(
  parameter DATA_WIDTH    = 16,
  parameter PHASE_WIDTH   = 24,
  parameter SIN_COS_WIDTH = 16
)(
  input   clk,
  input   reset,
  input   run_rx,

  /* IQ input */
  input in_tvalid,
  input in_tlast, 
  output in_tready,
  input [2*DATA_WIDTH-1:0]  in_tdata,
  
  /* phase increment */  
  input [PHASE_WIDTH-1:0]  phase_cfo,

  /* IQ output */
  output  out_tlast,
  output  out_tvalid,
  input   out_tready,
  output [2*DATA_WIDTH-1:0]  out_tdata,

  /* debug signals */
  output [SIN_COS_WIDTH-1:0]  sin,
  output [SIN_COS_WIDTH-1:0]  cos
);



  reg [PHASE_WIDTH-1:0] phase, phase_inc;
  wire [PHASE_WIDTH-1:0] phase_tdata;
  assign phase_tdata = phase;
  always @(posedge clk ) begin
    if (reset | ~run_rx) begin
      phase     <= 0;
      phase_inc <= phase_cfo;
    end
    else begin
      phase     <= phase + phase_inc;
    end
  end

  localparam SCALING_WIDTH = 18;
  localparam DDS_WIDTH     = 24;
  wire [SCALING_WIDTH-1:0] scaling_tdata = {{2{1'b0}}, {(SCALING_WIDTH-2){1'b1}}};

  freq_shift_iq #(
    .DATA_WIDTH(DATA_WIDTH), .SIN_COS_WIDTH(SIN_COS_WIDTH), .DDS_WIDTH(DDS_WIDTH),
    .PHASE_WIDTH(PHASE_WIDTH), .SCALING_WIDTH(SCALING_WIDTH))
      DUT(.clk(clk),
          .reset(reset),

          .iin(in_tdata[2*DATA_WIDTH-1:DATA_WIDTH]),
          .qin(in_tdata[DATA_WIDTH-1:0]),

          .in_tlast(in_tlast),
          .in_tvalid(in_tready),
          .in_tready(in_tready),

          .phase_tdata(phase_tdata),
          .scaling_tdata(scaling_tdata),

          .phase_tlast(in_tlast),
          .phase_tvalid(in_tvalid),
          .phase_tready(),

          .iout(out_tdata[2*DATA_WIDTH-1:DATA_WIDTH]),
          .qout(out_tdata[DATA_WIDTH-1:0]), 
                        
          .out_tready(out_tready),
          .out_tvalid(out_tvalid),
          .out_tlast(out_tlast),

          .sin(sin), 
          .cos(cos));
 

endmodule