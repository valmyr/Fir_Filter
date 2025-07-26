module ffd#(parameter WIDTH = 32)(
                        input logic clock,
                        input logic nreset,
                        input logic [WIDTH-1:0] xn,
                        output logic [WIDTH-1:0] yn    
);


    always_ff@(posedge clock, negedge nreset)begin
        if(!nreset)begin
            yn <= 0;
        end
        else begin
            yn <=  xn;
        end

    end

    
    
endmodule