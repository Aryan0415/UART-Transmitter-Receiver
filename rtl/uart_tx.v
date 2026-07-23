
module uart_transmitter(
    input clk,
    input clr,
    input tx_start,
    input [7:0]data_in,
    output reg tx 
    );reg [2:0]state; reg [2:0]bit_count;
    reg[15:0] counter;
    reg [9:0] data_temp;
    parameter idle=3'd0,start=3'd1,stop=3'd3,data=3'd2,def=3'd4,baud_count=100000000/9600;
    always@(negedge clk , negedge clr)
    begin
    if(!clr)begin
     state<=idle;
     bit_count<=0;
     counter<=0;    
     end
    else begin
     counter<=counter+1; 
    case(state)
     idle:begin tx<=1;bit_count<=0; counter<=0; data_temp<={1'b1,data_in,1'b0}; if (tx_start)begin state<=start;end end
     start:begin tx<=0; if(counter==baud_count)begin state<=data; counter<=0; end end
     data:begin tx<=data_temp[bit_count+1];if(counter==baud_count)begin counter<=0; if(bit_count!=7)begin bit_count <= bit_count + 1;end else if(bit_count==7) begin state<=stop ; bit_count<=0;end end end
     stop:begin tx <= 1;if(counter==baud_count)begin state <= def; counter<=0;end end
     def:begin if(!tx_start) state<=idle;else if(data_temp!={1'b1,data_in,1'b0}) state<=idle;end
    endcase
    end
    end
endmodule
