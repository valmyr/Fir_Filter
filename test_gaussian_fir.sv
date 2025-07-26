`timescale 1us/1us
module tb;
    parameter WIDTH= 32, NCOEFS = 29,SIZE_SIN=1000;
    logic clock, nreset;
    logic [WIDTH-1:0] xn, yn,coun;
    logic [WIDTH-1:0] sinal [SIZE_SIN-1:0];
    gaussian_fir #(.WIDTH(WIDTH), .NCOEFS(NCOEFS)) fir(
                        .clock(clock),
                        .nreset(nreset),
                        .xn(xn),
                        .yn(yn)    
    );
    initial begin
        $readmemh("sin.txt",sinal);
        clock = 0;
        nreset = 1;
        #100us
        clock = 1;
        nreset =0;
        #100us
        clock = 1;
        nreset =1;

        #400000us $finish;
    end

    always #100us clock =~clock;
    always_ff@(posedge clock, negedge nreset)begin
        if(!nreset) begin xn <=0;
            coun <= 0;
        end
        else begin
             xn <= sinal[coun];
             coun <= coun +1;
             if(coun==1000)$finish;
        end
    end

endmodule