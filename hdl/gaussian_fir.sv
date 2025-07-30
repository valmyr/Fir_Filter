module gaussian_fir #(parameter WIDTH = 8, NCOEFS = 300)(
                        input logic clock,
                        input logic nreset,
                        input logic [WIDTH-1:0] xn,
                        output logic [WIDTH-1:0] yn    
);

    logic [WIDTH-1:0] coefs         [NCOEFS-1:0]    ;
    logic [WIDTH-1:0] zn_delay      [NCOEFS-1:0]    ;
    logic [WIDTH-1:0] accumulator   [NCOEFS-1:0]    ;
    logic [WIDTH-1:0] product                       ;   


    initial $readmemh("txt/coefs_ponto_fixo_q8gauss.txt",coefs);

    //Continuos assigment
    assign zn_delay[0] = xn;
    assign accumulator[0] = zn_delay[0]*coefs[0];
    assign yn = accumulator[NCOEFS-1];

    //Auto instances
    generate
        genvar i;
        for(i = 0; i < NCOEFS - 1; i++)begin: FFD
            ffd #(.WIDTH(WIDTH)) ffd1s(.clock(clock),.nreset(nreset),.xn(zn_delay[i]),.yn(zn_delay[i+1]));
        end
    endgenerate

    generate
        for(i = 0; i < NCOEFS - 1; i++)begin: SUM
            sum #(.WIDTH(WIDTH)) sum1s(.A(accumulator[i]),.B(zn_delay[i+1]*coefs[i+1]),.C(accumulator[i+1]));
        end
    endgenerate
    
    
endmodule

module sum#(parameter WIDTH = 8)(input logic [WIDTH-1:0] A,input logic [WIDTH-1:0]B, output logic [WIDTH-1:0] C);
    assign C = A+B;
endmodule