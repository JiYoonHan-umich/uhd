module  usrp2puf#(
  parameter DATA_WIDTH    = 16
)(
  input clk,
  input reset,

  /* IQ input */
  input  in_tvalid,
  input  in_tlast, 
  output in_tready,
  input [2*DATA_WIDTH-1:0]  in_tdata,

  /*output tdata*/
  output  out_tlast,
  output  out_tvalid,
  input   out_tready,
  output  [2*DATA_WIDTH-1:0]  out_tdata
);


  reg [2:0] state;
  reg [2*DATA_WIDTH-1:0] in0_tdata, in1_tdata;
  reg [DATA_WIDTH-1:0] scale0_tdata, scale1_tdata;
  reg  o_tvalid;
  wire lin_tready, lin_tlast, lin_tvalid;

  localparam SZERO  = 3'b000;
  localparam SONE   = 3'b001;
  localparam STWO   = 3'b010;
  localparam STHREE = 3'b011;
  localparam SFOUR  = 3'b100;
  localparam SFIVE  = 3'b101;

  localparam DROP_TOP_P = 6;

  lin1D #(
  .DATA_WIDTH(DATA_WIDTH), .DROP_TOP_P(DROP_TOP_P)) 
    LI(
      .clk(clk),
      .reset(reset),

      .in_tvalid(in_tvalid), .in_tready(in_tready), .in_tlast(in_tlast),

      .scale0_tdata(scale0_tdata), .scale1_tdata(scale1_tdata),
      .in0_tdata(in0_tdata), .in1_tdata(in1_tdata),

      .out_tvalid(lin_tvalid), .out_tlast(lin_tlast), .out_tready(lin_tready),
      .out_tdata(out_tdata));

  always @(posedge clk ) begin
    if (reset) begin
        in0_tdata    <= 0;
        in1_tdata    <= 0;
        scale0_tdata <= 0;
        scale1_tdata <= 0;
        state        <= SZERO;
        o_tvalid     <= 1'b0;
    end
    else if (in_tvalid) begin
        case (state)
          SZERO: begin
            in0_tdata    <= in1_tdata;
            in1_tdata    <= in_tdata;
            scale0_tdata <= 0;
            scale1_tdata <= 32767;
            state        <= SONE;
            o_tvalid     <= 1'b0;
          end
          SONE: begin
            in0_tdata    <= in1_tdata;
            in1_tdata    <= in_tdata;
            scale0_tdata <= 32767;
            scale1_tdata <= 0;
            state        <= STWO;
            o_tvalid     <= 1'b1;
          end
          STWO: begin
            in0_tdata    <= in1_tdata;
            in1_tdata    <= in_tdata;
            scale0_tdata <= 24576;
            scale1_tdata <= 8192;
            state        <= STHREE;
            o_tvalid     <= 1'b1;
          end
          STHREE: begin
            in0_tdata    <= in1_tdata;
            in1_tdata    <= in_tdata;
            scale0_tdata <= 16384;
            scale1_tdata <= 16384;
            state        <= SFOUR;
            o_tvalid     <= 1'b1;
          end
          SFOUR: begin
            in0_tdata    <= in1_tdata;
            in1_tdata    <= in_tdata;
            scale0_tdata <= 8192;
            scale1_tdata <= 24576;
            state        <= SZERO;
            o_tvalid     <= 1'b1;
          end 
          default: state <= SZERO;
        endcase
    end 
    else begin
      state <= SZERO;
    end  
    
  end

  assign out_tvalid = o_tvalid & lin_tvalid;
  assign out_tlast  = lin_tlast;
  assign lin_tready = out_tready;

endmodule