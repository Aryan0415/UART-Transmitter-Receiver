module uart_receiver(
    input clk,
    input clr,
    input rx,
    output reg[7:0]DATA,
    output reg rx_done
    );reg [1:0]state; reg [2:0]bit_count;
    reg[15:0] counter;
    parameter idle=2'd0,start=2'd1,stop=2'd3,data=2'd2,baud_count=10416;
    always@(posedge clk , posedge clr)
    begin
    if(!clr)begin
     state<=idle;
     DATA<=0;
     bit_count<=0;
     counter<=0;
     rx_done<=0;end
    else begin
     counter<=counter+1; 
    case(state)
     idle:begin bit_count<=0;rx_done<=0; if(rx==0)begin state<=start; counter<=0;end else state<=idle;end
     start:begin if(counter==baud_count/2)begin if(rx==0)begin state<=data; counter<=0;end else begin counter<=0; state<=idle; end end end
     data:begin if(counter==baud_count)begin DATA[bit_count] <= rx;counter<=0; if(bit_count!=7)begin bit_count <= bit_count + 1;end else if(bit_count==7) begin state<=stop ; bit_count<=0;end end end
     stop:begin if(counter==baud_count)begin if(rx == 1)begin state <= idle; counter<=0;rx_done<=1;end else state<=idle;end end
    endcase
    end
    end
endmodule
