// Baud Generator
module baud_gen(
    input clk,
    input clr,
    output reg baud_tick
);

reg [13:0] count;

always @(posedge clk or negedge clr)
begin
    if(!clr)
    begin
        count <= 0;
        baud_tick <= 0;
    end
    else
    begin
        if(count == 10415)
        begin
            count <= 0;
            baud_tick <= 1;   // pulse for 1 clock
        end
        else
        begin
            count <= count + 1;
            baud_tick <= 0;
        end
    end
end

endmodule
