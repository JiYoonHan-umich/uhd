module cfo_corr_tb ();

localparam NDATA         = 32768;


localparam DATA_WIDTH    = 16;
localparam PHASE_WIDTH   = 24;
localparam SIN_COS_WIDTH = 16;

reg reset;
wire clk;
wire [DATA_WIDTH-1:0] in_itdata, in_qtdata;
wire [DATA_WIDTH-1:0] out_itdata, out_qtdata;

reg [2*DATA_WIDTH-1:0] in_tdata;
reg [2*DATA_WIDTH-1:0] input_memory [0:NDATA-1];

assign in_itdata = in_tdata[2*DATA_WIDTH-1:DATA_WIDTH];
assign in_qtdata = in_tdata[DATA_WIDTH-1:0];

wire in_tvalid, in_tlast, in_tready, out_tvalid, out_tready, out_tlast;
assign in_tvalid = 1'b1;
assign in_tlast  = 1'b0;
assign out_tready = 1'b1;



reg [2:0] counter;
assign clk = (counter < 3) ? 1'b1 : 1'b0;

always #1 counter <= (counter == 4) ? 0 : counter + 1;

reg [$clog2(NDATA)-1:0] ncount;

always @(posedge clk) begin
  if (reset) begin
    in_tdata <= 0;
    ncount   <= 0;
  end 
  else begin
    ncount   <= ncount + 1;
    in_tdata <= input_memory[ncount];
  end 
end

wire run_rx = 1'b1;
wire [PHASE_WIDTH-1:0] phase_cfo = 8192;
wire [SIN_COS_WIDTH-1:0] sin, cos;

cfo_corr #(.DATA_WIDTH(DATA_WIDTH), .PHASE_WIDTH(PHASE_WIDTH), .SIN_COS_WIDTH(SIN_COS_WIDTH)) 
    FOC_DUT(
      .clk(clk),
      .reset(reset), .run_rx(run_rx),

      .in_tvalid(in_tvalid), .in_tlast(in_tlast),
      .in_tready(in_tready), .in_tdata(in_tdata),

      .phase_cfo(phase_cfo),

      .out_tvalid(out_tvalid), .out_tlast(out_tlast), 
      .out_tready(out_tready), .out_tdata({out_itdata, out_qtdata}),
      .sin(sin), .cos(cos));


initial begin
  $readmemh("/home/user/programs/usrp/uhd/fpga/dk_hdl/testvec/test_vec.mem", input_memory);
end
reg stop_write;

initial begin
  counter = 0;
  reset = 1'b1;
  stop_write = 1'b0;
  #100 reset = 1'b0; 
  repeat(2*NDATA) @(posedge clk);
  @(posedge clk)
  stop_write = 1'b1;
  //$finish();
end

integer file_id;
initial begin
  file_id = $fopen("/home/user/Desktop/data/sim/cfo_corr.txt", "wb");
  $display("Opened file ..................");
  @(negedge reset);
  //@(negedge stop_write);
  $display("start writing ................");
  while (!stop_write) begin
    @(negedge clk); 
    $fwrite(file_id, "%d %d %d %d %d %d %d %d %d %d %d\n", 
            in_itdata, in_qtdata, phase_cfo, in_tvalid, in_tlast, in_tready,
            out_itdata, out_qtdata, out_tvalid, out_tlast, out_tready);    
  end
  $fclose(file_id);
  $display("File closed ..................");
  $finish();    
end

endmodule