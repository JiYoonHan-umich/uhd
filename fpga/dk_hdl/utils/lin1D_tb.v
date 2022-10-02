module lin1D_tb ();

localparam DATA_WIDTH   = 16;
localparam NDATA        = 32768;
/*DROP_TOP_P = 6 for Inputs FP(16, 15) -> Output FP(16, 15)*/
localparam DROP_TOP_P    = 6; 

reg reset;
wire clk;
wire [DATA_WIDTH-1:0] in0_itdata, in0_qtdata, in1_itdata, in1_qtdata;
reg [DATA_WIDTH-1:0] scale0_tdata, scale0, scale1_tdata, scale1;
wire [DATA_WIDTH-1:0] out_itdata, out_qtdata;
wire [2*DATA_WIDTH-1:0] out_tdata;

assign out_itdata = out_tdata[2*DATA_WIDTH-1:DATA_WIDTH];
assign out_qtdata = out_tdata[DATA_WIDTH-1:0];

reg [2*DATA_WIDTH-1:0] in0_data, in1_data;
reg [2*DATA_WIDTH-1:0] input_memory [0:NDATA-1];

assign in0_itdata = in0_data[2*DATA_WIDTH-1:DATA_WIDTH];
assign in0_qtdata = in0_data[DATA_WIDTH-1:0];

assign in1_itdata = in1_data[2*DATA_WIDTH-1:DATA_WIDTH];
assign in1_qtdata = in1_data[DATA_WIDTH-1:0];
wire in_tvalid, in_tlast, in_tready, out_tvalid, out_tready, out_tlast;
assign in_tvalid = 1'b1;
assign in_tlast  = 1'b0;
assign out_tready = 1'b1;

reg [2:0] counter;
assign clk = (counter < 3) ? 1'b1 : 1'b0;

always #1 counter <= (counter == 4) ? 0 : counter + 1;

reg [$clog2(NDATA)-1:0] ncount, ncount1;

always @(posedge clk) begin
  if (reset) begin
    in0_data <= 0;
    in1_data <= 0;
    ncount <= 0;
    ncount1 <= 8192;
  end 
  else begin
    ncount  <= ncount + 1;
    ncount1  <= ncount1 + 1;
    in0_data <= input_memory[ncount];
    in1_data <= input_memory[ncount1];
  end 
  scale0_tdata <= scale0;
  scale1_tdata <= scale1;
end

lin1D #(
  .DATA_WIDTH(DATA_WIDTH), .DROP_TOP_P(DROP_TOP_P)) 
    LI(
      .clk(clk),
      .reset(reset),

      .in_tvalid(in_tvalid), .in_tready(in_tready), .in_tlast(in_tlast),

      .scale0_tdata(scale0_tdata), .scale1_tdata(scale1_tdata),
      .in0_tdata(in0_data), .in1_tdata(in1_data),

      .out_tvalid(out_tvalid), .out_tlast(out_tlast), .out_tready(out_tready),
      .out_tdata(out_tdata));


initial begin
  $readmemh("/home/user/programs/usrp/uhd/fpga/dk_hdl/testvec/mult_rc.mem", input_memory);
end
reg stop_write;

initial begin
  counter = 0;
  reset = 1'b1;
  stop_write = 1'b0;
  scale0 = 16384; scale1 = 16384;
  #100 reset = 1'b0; 
  repeat(NDATA) @(posedge clk);
  scale0 = 24576; scale1 = 8192;
  repeat(NDATA) @(posedge clk);
  scale0 = 8192; scale1 = 24576;
  repeat(NDATA) @(posedge clk);
  @(posedge clk)
  stop_write = 1'b1;
  //$finish();
end

integer file_id;
initial begin
  file_id = $fopen("/home/user/Desktop/data/sim/lin1D.txt", "wb");
  $display("Opened file ..................");
  @(negedge reset);
  //@(negedge stop_write);
  $display("start writing ................");
  while (!stop_write) begin
    @(negedge clk); 
    $fwrite(file_id, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", 
            in_tvalid, in_tlast, in_tready, 
            in0_itdata, in0_qtdata, in1_itdata, in1_qtdata,
            scale0_tdata, scale1_tdata, 
            out_tvalid, out_tlast, out_tready,
            out_itdata, out_qtdata);    
  end
  $fclose(file_id);
  $display("File closed ..................");
  $finish();    
end

endmodule