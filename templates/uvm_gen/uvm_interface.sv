`ifndef _{:UPPERNAME:}_IF_SV_
`define _{:UPPERNAME:}_IF_SV_

interface {:NAME:}_if #(
    parameter INPUT_SKEW = 1,
    parameter OUTPUT_SKEW = 1
)
    (bit clk, bit reset_b);

    typedef virtual {:NAME:}_if #( 
        .INPUT_SKEW(INPUT_SKEW),
        .OUTPUT_SKEW(OUTPUT_SKEW)
    ) V_{:UPPERNAME:}_IF_T;

    //add you signals here

    clocking driver_cb @(posedge clk);
    default input #INPUT_SKEW output #OUTPUT_SKEW;
    //add your signals here
    input reset_b;
    endclocking

    clocking target_cb @(posedge clk);
    default input #INPUT_SKEW output #OUTPUT_SKEW;
    //add your signals here
    input reset_b;
    endclocking

    clocking monitor_cb @(posedge clk);
    default input #INPUT_SKEW output #OUTPUT_SKEW;
    //add your signals here
    input reset_b;
    endclocking

    modport driver_mp  (clocking driver_cb);
    modport target_mp  (clocking target_cb);
    modport monitor_mp (clocking monitor_cb);

endinterface

`endif
