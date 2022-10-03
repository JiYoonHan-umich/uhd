module puf2usrp_tb ();

localparam DATA_WIDTH    = 16;
localparam NDATA         = 4096*2;

reg reset;
wire clk;
wire [DATA_WIDTH-1:0] in_itdata, in_qtdata;
wire [DATA_WIDTH-1:0] out_itdata, out_qtdata;

reg [2*DATA_WIDTH-1:0] in_data;
wire [2*DATA_WIDTH-1:0] in_tdata;
assign in_tdata = in_data;
reg [2*DATA_WIDTH-1:0] input_memory [0:NDATA-1];
reg val_memory [0:NDATA-1];

assign in_itdata = in_tdata[2*DATA_WIDTH-1:DATA_WIDTH];
assign in_qtdata = in_tdata[DATA_WIDTH-1:0];

reg in_val;
wire in_tlast, in_tready, out_tvalid, out_tready, out_tlast;
assign in_tvalid = in_val;

assign in_tlast  = 1'b0;
assign out_tready = 1'b1;



reg [2:0] counter;
assign clk = (counter < 3) ? 1'b1 : 1'b0;

always #1 counter <= (counter == 4) ? 0 : counter + 1;

reg [$clog2(NDATA)-1:0] ncount;

always @(posedge clk) begin
  if (reset) begin
    in_data  <= 0;
    ncount   <= 0;
    in_val   <= 1'b0;
  end 
  else begin
    ncount  <= ncount + 1;
    in_data <= input_memory[ncount];
    in_val  <= val_memory[ncount];
  end 
end

puf2usrp #(.DATA_WIDTH(DATA_WIDTH)) 
    P2U_DUT(
      .clk(clk),
      .reset(reset),

      .in_tvalid(in_tvalid), .in_tlast(in_tlast),
      .in_tready(in_tready), .in_tdata(in_tdata),

      .out_tvalid(out_tvalid), .out_tlast(out_tlast), 
      .out_tready(out_tready), .out_tdata({out_itdata, out_qtdata}));


initial begin
  $readmemh("/home/user/programs/usrp/uhd/fpga/dk_hdl/testvec/puf2usrp_dat_tv.mem", input_memory);
  $readmemb("/home/user/programs/usrp/uhd/fpga/dk_hdl/testvec/puf2usrp_val_tv.mem", val_memory);
end
reg stop_write;

initial begin
  counter = 0;
  reset = 1'b1;
  stop_write = 1'b0;
  #100 reset = 1'b0; 
  repeat(NDATA) @(posedge clk);
  @(posedge clk)
  stop_write = 1'b1;
  //$finish();
end

integer file_id;
initial begin
  file_id = $fopen("/home/user/Desktop/data/sim/puf2usrp.txt", "wb");
  $display("Opened file ..................");
  @(negedge reset);
  //@(negedge stop_write);
  $display("start writing ................");
  while (!stop_write) begin
    @(negedge clk); 
    $fwrite(file_id, "%d %d %d %d %d %d %d %d %d %d\n", 
            in_itdata, in_qtdata, in_tvalid, in_tlast, in_tready,
            out_itdata, out_qtdata, out_tvalid, out_tlast, out_tready);    
  end
  $fclose(file_id);
  $display("File closed ..................");
  $finish();    
end

endmodule