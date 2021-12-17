module mtx_single_tone #(
  parameter SIN_COS_WIDTH = 16,
  parameter PHASE_WIDTH   = 24 ,
  parameter NSYMB_WIDTH   = 16,
  parameter [PHASE_WIDTH-1:0] NSIG         = 32768,
  parameter [PHASE_WIDTH-1:0] DPH_INC      = 16384,
  parameter [PHASE_WIDTH-1:0] START_PH_INC = 16384,
  parameter [PHASE_WIDTH-1:0] START_PH     = 24'h000000
)(
  input   clk,
  input   reset,

  /* phase data*/
  input  phase_tvalid, 
  input  phase_tlast, 
  output phase_tready,

  /* IQ output */
  output  out_tlast,
  output  out_tvalid,
  input   out_tready,
  output [SIN_COS_WIDTH-1:0]  sin,
  output [SIN_COS_WIDTH-1:0]  cos,

  /*debug*/
  output [PHASE_WIDTH-1:0] ph,
  output [PHASE_WIDTH-1:0] sigN
);

reg  [PHASE_WIDTH-1:0]  ncount;

reg  [PHASE_WIDTH-1:0]  phase_inc, phase;
wire [PHASE_WIDTH-1:0]  phase_tdata = phase;




assign ph       = phase;
assign sigN     = ncount;


dds_sin_cos_lut_only dds_inst (
    .aclk(clk),                                // input wire aclk
    .aresetn(~reset),            // input wire aresetn active low rst
    .s_axis_phase_tvalid(phase_tvalid),  // input wire s_axis_phase_tvalid
    .s_axis_phase_tready(phase_tready),  // output wire s_axis_phase_tready
    .s_axis_phase_tlast(phase_tlast),    //tlast
    .s_axis_phase_tdata(phase_tdata),    // input wire [23 : 0] s_axis_phase_tdata
    .m_axis_data_tvalid(out_tvalid),    // output wire m_axis_data_tvalid
    .m_axis_data_tready(out_tready),    // input wire m_axis_data_tready
    .m_axis_data_tlast(out_tlast),      // output wire m_axis_data_tready
    .m_axis_data_tdata({sin, cos})      // output wire [31 : 0] m_axis_data_tdata
);

always @(posedge clk) begin
    if (reset) begin
      phase  <= START_PH;
      ncount <= 1;
      phase_inc <= START_PH_INC;
    end 
    else if (ncount == NSIG) begin 
      ncount <= 1;
      phase  <= START_PH; 
    end
    else begin
      phase  <= phase + phase_inc;
      ncount <= ncount + 1;
    end
end

endmodule