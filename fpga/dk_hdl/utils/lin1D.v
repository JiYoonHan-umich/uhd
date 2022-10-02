module  lin1D#(
  parameter DATA_WIDTH    = 16,
  parameter DROP_TOP_P    = 6 
)(
  input clk,
  input reset,

  /* IQ input */
  input  in_tvalid,
  input  in_tlast, 
  output in_tready,
  input [DATA_WIDTH-1:0]  scale0_tdata,
  input [DATA_WIDTH-1:0]  scale1_tdata,
  input [2*DATA_WIDTH-1:0]  in0_tdata,
  input [2*DATA_WIDTH-1:0]  in1_tdata,

  /*output tdata*/
  output  out_tlast,
  output  out_tvalid,
  input   out_tready,
  output  [2*DATA_WIDTH-1:0]  out_tdata
);


  wire [2*DATA_WIDTH-1:0] out0_scaled, out1_scaled, a2c_tdata;
  wire scaled_tvalid, scaled_tlast, scaled_tready;
  reg o_tready, o_tlast, o_tvalid;
  reg [2*DATA_WIDTH-1:0] o_tdata;

  assign out_tdata  = o_tdata;
  assign out_tvalid = o_tvalid;
  assign out_tlast  = o_tlast;
  assign scaled_tready = o_tready;

  mult_rc #(
  .WIDTH_REAL(DATA_WIDTH), .WIDTH_CPLX(DATA_WIDTH),
  .WIDTH_P(DATA_WIDTH), .DROP_TOP_P(DROP_TOP_P)) 
    K0(
      .clk(clk),
      .reset(reset),

      .real_tlast(in_tlast),
      .real_tvalid(in_tvalid),
      .real_tready(in_tready),
      .real_tdata(scale0_tdata),

      .cplx_tlast(in_tlast),
      .cplx_tvalid(in_tvalid),
      .cplx_tready(),
      .cplx_tdata(in0_tdata),

      .p_tvalid(scaled_tvalid),
      .p_tlast(scaled_tlast),
      .p_tready(scaled_tready),
      .p_tdata(out0_scaled));

  mult_rc #(
    .WIDTH_REAL(DATA_WIDTH), .WIDTH_CPLX(DATA_WIDTH),
    .WIDTH_P(DATA_WIDTH), .DROP_TOP_P(DROP_TOP_P)) 
      K1(
        .clk(clk),
        .reset(reset),

        .real_tlast(in_tlast),
        .real_tvalid(in_tvalid),
        .real_tready(),
        .real_tdata(scale1_tdata),

        .cplx_tlast(in_tlast),
        .cplx_tvalid(in_tvalid),
        .cplx_tready(),
        .cplx_tdata(in1_tdata),

        .p_tvalid(),
        .p_tlast(),
        .p_tready(scaled_tready),
        .p_tdata(out1_scaled));

  add2_and_clip #(.WIDTH(DATA_WIDTH))
    ACI(
      .in1(out0_scaled[2*DATA_WIDTH-1:DATA_WIDTH]),
      .in2(out1_scaled[2*DATA_WIDTH-1:DATA_WIDTH]),
      .sum(a2c_tdata[2*DATA_WIDTH-1:DATA_WIDTH])
    );

  add2_and_clip #(.WIDTH(DATA_WIDTH))
    ACQ(
      .in1(out0_scaled[DATA_WIDTH-1:0]),
      .in2(out1_scaled[DATA_WIDTH-1:0]),
      .sum(a2c_tdata[DATA_WIDTH-1:0])
    );

  always @(posedge clk ) begin
    if (reset) begin
      o_tdata  <= 0;
      o_tready <= out_tready;
      o_tvalid <= 1'b0;
      o_tlast  <= 1'b0;
    end
    else begin
      o_tdata  <= a2c_tdata;
      o_tready <= out_tready;
      o_tvalid <= scaled_tvalid;
      o_tlast  <= scaled_tlast;
      
    end
    
  end

endmodule