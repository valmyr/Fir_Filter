module gaussian_fir #(parameter WIDTH = 8, NCOEFS = 300)(
                        input logic clock,
                        input logic nreset,
                        input logic [WIDTH-1:0] xn,
                        output logic [WIDTH-1:0] yn    
);

    logic [WIDTH-1:0] coefs [NCOEFS-1:0];
    logic [WIDTH-1:0] yn_inter [NCOEFS-1:0];
    logic [WIDTH-1:0] soma [NCOEFS-1:0];


    initial $readmemh("txt/coefs_ponto_fixo_q8.txt",coefs);
    assign yn_inter[0] = xn;
    assign soma[0] = 0;
    generate
        genvar i;
        for(i = 1; i < NCOEFS; i++)begin: FFD
            ffd #(.WIDTH(WIDTH)) ffd1s(.clock(clock),.nreset(nreset),.xn(yn_inter[i-1]),.yn(yn_inter[i]));
        end
    endgenerate

    generate
        for(i = 1; i < NCOEFS; i++)begin: SUM
            sum #(.WIDTH(WIDTH)) sum1s(.A(soma[i-1]),.B(yn_inter[i-1]*coefs[i-1]),.C(soma[i]));
        end
    endgenerate
 assign yn = soma[NCOEFS-1];

    
    
endmodule

module sum#(parameter WIDTH = 8)(input logic [WIDTH-1:0] A,input logic [WIDTH-1:0]B, output logic [WIDTH-1:0] C);
    assign C = A+B;
endmodule