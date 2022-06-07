//-----------------------------------------------------------------------------
// GcdUnit
//-----------------------------------------------------------------------------
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module GcdUnit
(
  input  wire [   0:0] clk,
  input  wire [  31:0] req_msg,
  output wire [   0:0] req_rdy,
  input  wire [   0:0] req_val,
  input  wire [   0:0] reset,
  output wire [  15:0] resp_msg,
  input  wire [   0:0] resp_rdy,
  output wire [   0:0] resp_val
);

  // ctrl temporaries
  wire   [   0:0] ctrl$is_b_zero;
  wire   [   0:0] ctrl$resp_rdy;
  wire   [   0:0] ctrl$clk;
  wire   [   0:0] ctrl$is_a_lt_b;
  wire   [   0:0] ctrl$req_val;
  wire   [   0:0] ctrl$reset;
  wire   [   1:0] ctrl$a_mux_sel;
  wire   [   0:0] ctrl$resp_val;
  wire   [   0:0] ctrl$b_mux_sel;
  wire   [   0:0] ctrl$b_reg_en;
  wire   [   0:0] ctrl$a_reg_en;
  wire   [   0:0] ctrl$req_rdy;

  GcdUnitCtrlRTL_0x29124399ca008c5e ctrl
  (
    .is_b_zero ( ctrl$is_b_zero ),
    .resp_rdy  ( ctrl$resp_rdy ),
    .clk       ( ctrl$clk ),
    .is_a_lt_b ( ctrl$is_a_lt_b ),
    .req_val   ( ctrl$req_val ),
    .reset     ( ctrl$reset ),
    .a_mux_sel ( ctrl$a_mux_sel ),
    .resp_val  ( ctrl$resp_val ),
    .b_mux_sel ( ctrl$b_mux_sel ),
    .b_reg_en  ( ctrl$b_reg_en ),
    .a_reg_en  ( ctrl$a_reg_en ),
    .req_rdy   ( ctrl$req_rdy )
  );

  // dpath temporaries
  wire   [   1:0] dpath$a_mux_sel;
  wire   [   0:0] dpath$clk;
  wire   [  15:0] dpath$req_msg_b;
  wire   [  15:0] dpath$req_msg_a;
  wire   [   0:0] dpath$b_mux_sel;
  wire   [   0:0] dpath$reset;
  wire   [   0:0] dpath$b_reg_en;
  wire   [   0:0] dpath$a_reg_en;
  wire   [   0:0] dpath$is_b_zero;
  wire   [  15:0] dpath$resp_msg;
  wire   [   0:0] dpath$is_a_lt_b;

  GcdUnitDpathRTL_0x29124399ca008c5e dpath
  (
    .a_mux_sel ( dpath$a_mux_sel ),
    .clk       ( dpath$clk ),
    .req_msg_b ( dpath$req_msg_b ),
    .req_msg_a ( dpath$req_msg_a ),
    .b_mux_sel ( dpath$b_mux_sel ),
    .reset     ( dpath$reset ),
    .b_reg_en  ( dpath$b_reg_en ),
    .a_reg_en  ( dpath$a_reg_en ),
    .is_b_zero ( dpath$is_b_zero ),
    .resp_msg  ( dpath$resp_msg ),
    .is_a_lt_b ( dpath$is_a_lt_b )
  );

  // signal connections
  assign ctrl$clk        = clk;
  assign ctrl$is_a_lt_b  = dpath$is_a_lt_b;
  assign ctrl$is_b_zero  = dpath$is_b_zero;
  assign ctrl$req_val    = req_val;
  assign ctrl$reset      = reset;
  assign ctrl$resp_rdy   = resp_rdy;
  assign dpath$a_mux_sel = ctrl$a_mux_sel;
  assign dpath$a_reg_en  = ctrl$a_reg_en;
  assign dpath$b_mux_sel = ctrl$b_mux_sel;
  assign dpath$b_reg_en  = ctrl$b_reg_en;
  assign dpath$clk       = clk;
  assign dpath$req_msg_a = req_msg[31:16];
  assign dpath$req_msg_b = req_msg[15:0];
  assign dpath$reset     = reset;
  assign req_rdy         = ctrl$req_rdy;
  assign resp_msg        = dpath$resp_msg;
  assign resp_val        = ctrl$resp_val;



endmodule // GcdUnit
`default_nettype wire

//-----------------------------------------------------------------------------
// GcdUnitCtrlRTL_0x29124399ca008c5e
//-----------------------------------------------------------------------------
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module GcdUnitCtrlRTL_0x29124399ca008c5e
(
  output reg  [   1:0] a_mux_sel,
  output reg  [   0:0] a_reg_en,
  output reg  [   0:0] b_mux_sel,
  output reg  [   0:0] b_reg_en,
  input  wire [   0:0] clk,
  input  wire [   0:0] is_a_lt_b,
  input  wire [   0:0] is_b_zero,
  output reg  [   0:0] req_rdy,
  input  wire [   0:0] req_val,
  input  wire [   0:0] reset,
  input  wire [   0:0] resp_rdy,
  output reg  [   0:0] resp_val
);

  // register declarations
  reg    [   1:0] curr_state__0;
  reg    [   1:0] current_state__1;
  reg    [   0:0] do_sub;
  reg    [   0:0] do_swap;
  reg    [   1:0] next_state__0;
  reg    [   1:0] state$in_;

  // localparam declarations
  localparam A_MUX_SEL_B = 2;
  localparam A_MUX_SEL_IN = 0;
  localparam A_MUX_SEL_SUB = 1;
  localparam A_MUX_SEL_X = 0;
  localparam B_MUX_SEL_A = 0;
  localparam B_MUX_SEL_IN = 1;
  localparam B_MUX_SEL_X = 0;
  localparam STATE_CALC = 1;
  localparam STATE_DONE = 2;
  localparam STATE_IDLE = 0;

  // state temporaries
  wire   [   0:0] state$reset;
  wire   [   0:0] state$clk;
  wire   [   1:0] state$out;

  RegRst_0x9f365fdf6c8998a state
  (
    .reset ( state$reset ),
    .in_   ( state$in_ ),
    .clk   ( state$clk ),
    .out   ( state$out )
  );

  // signal connections
  assign state$clk   = clk;
  assign state$reset = reset;


  // PYMTL SOURCE:
  //
  // @s.combinational
  // def state_transitions():
  //
  //       curr_state = s.state.out
  //       next_state = s.state.out
  //
  //       # Transitions out of IDLE state
  //
  //       if ( curr_state == s.STATE_IDLE ):
  //         if ( s.req_val and s.req_rdy ):
  //           next_state = s.STATE_CALC
  //
  //       # Transitions out of CALC state
  //
  //       if ( curr_state == s.STATE_CALC ):
  //         if ( not s.is_a_lt_b and s.is_b_zero ):
  //           next_state = s.STATE_DONE
  //
  //       # Transitions out of DONE state
  //
  //       if ( curr_state == s.STATE_DONE ):
  //         if ( s.resp_val and s.resp_rdy ):
  //           next_state = s.STATE_IDLE
  //
  //       s.state.in_.value = next_state

  // logic for state_transitions()
  always @ (*) begin
    curr_state__0 = state$out;
    next_state__0 = state$out;
    if ((curr_state__0 == STATE_IDLE)) begin
      if ((req_val&&req_rdy)) begin
        next_state__0 = STATE_CALC;
      end
      else begin
      end
    end
    else begin
    end
    if ((curr_state__0 == STATE_CALC)) begin
      if ((!is_a_lt_b&&is_b_zero)) begin
        next_state__0 = STATE_DONE;
      end
      else begin
      end
    end
    else begin
    end
    if ((curr_state__0 == STATE_DONE)) begin
      if ((resp_val&&resp_rdy)) begin
        next_state__0 = STATE_IDLE;
      end
      else begin
      end
    end
    else begin
    end
    state$in_ = next_state__0;
  end

  // PYMTL SOURCE:
  //
  // @s.combinational
  // def state_outputs():
  //
  //       current_state = s.state.out
  //
  //       # Avoid latches
  //
  //       s.do_swap.value   = 0
  //       s.do_sub .value   = 0
  //
  //       s.req_rdy.value   = 0
  //       s.resp_val.value  = 0
  //       s.a_mux_sel.value = 0
  //       s.a_reg_en.value  = 0
  //       s.b_mux_sel.value = 0
  //       s.b_reg_en.value  = 0
  //
  //       # In IDLE state we simply wait for inputs to arrive and latch them
  //
  //       if current_state == s.STATE_IDLE:
  //         s.req_rdy.value   = 1
  //         s.resp_val.value  = 0
  //         s.a_mux_sel.value = A_MUX_SEL_IN
  //         s.a_reg_en.value  = 1
  //         s.b_mux_sel.value = B_MUX_SEL_IN
  //         s.b_reg_en.value  = 1
  //
  //       # In CALC state we iteratively swap/sub to calculate GCD
  //
  //       elif current_state == s.STATE_CALC:
  //
  //         s.do_swap.value = s.is_a_lt_b
  //         s.do_sub.value  = ~s.is_b_zero
  //
  //         s.req_rdy.value   = 0
  //         s.resp_val.value  = 0
  //         s.a_mux_sel.value = A_MUX_SEL_B if s.do_swap else A_MUX_SEL_SUB
  //         s.a_reg_en.value  = 1
  //         s.b_mux_sel.value = B_MUX_SEL_A
  //         s.b_reg_en.value  = s.do_swap
  //
  //       # In DONE state we simply wait for output transaction to occur
  //
  //       elif current_state == s.STATE_DONE:
  //         s.req_rdy.value   = 0
  //         s.resp_val.value  = 1
  //         s.a_mux_sel.value = A_MUX_SEL_X
  //         s.a_reg_en.value  = 0
  //         s.b_mux_sel.value = B_MUX_SEL_X
  //         s.b_reg_en.value  = 0

  // logic for state_outputs()
  always @ (*) begin
    current_state__1 = state$out;
    do_swap = 0;
    do_sub = 0;
    req_rdy = 0;
    resp_val = 0;
    a_mux_sel = 0;
    a_reg_en = 0;
    b_mux_sel = 0;
    b_reg_en = 0;
    if ((current_state__1 == STATE_IDLE)) begin
      req_rdy = 1;
      resp_val = 0;
      a_mux_sel = A_MUX_SEL_IN;
      a_reg_en = 1;
      b_mux_sel = B_MUX_SEL_IN;
      b_reg_en = 1;
    end
    else begin
      if ((current_state__1 == STATE_CALC)) begin
        do_swap = is_a_lt_b;
        do_sub = ~is_b_zero;
        req_rdy = 0;
        resp_val = 0;
        a_mux_sel = do_swap ? A_MUX_SEL_B : A_MUX_SEL_SUB;
        a_reg_en = 1;
        b_mux_sel = B_MUX_SEL_A;
        b_reg_en = do_swap;
      end
      else begin
        if ((current_state__1 == STATE_DONE)) begin
          req_rdy = 0;
          resp_val = 1;
          a_mux_sel = A_MUX_SEL_X;
          a_reg_en = 0;
          b_mux_sel = B_MUX_SEL_X;
          b_reg_en = 0;
        end
        else begin
        end
      end
    end
  end


endmodule // GcdUnitCtrlRTL_0x29124399ca008c5e
`default_nettype wire

//-----------------------------------------------------------------------------
// RegRst_0x9f365fdf6c8998a
//-----------------------------------------------------------------------------
// dtype: 2
// reset_value: 0
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module RegRst_0x9f365fdf6c8998a
(
  input  wire [   0:0] clk,
  input  wire [   1:0] in_,
  output reg  [   1:0] out,
  input  wire [   0:0] reset
);

  // localparam declarations
  localparam reset_value = 0;



  // PYMTL SOURCE:
  //
  // @s.posedge_clk
  // def seq_logic():
  //       if s.reset:
  //         s.out.next = reset_value
  //       else:
  //         s.out.next = s.in_

  // logic for seq_logic()
  always @ (posedge clk) begin
    if (reset) begin
      out <= reset_value;
    end
    else begin
      out <= in_;
    end
  end


endmodule // RegRst_0x9f365fdf6c8998a
`default_nettype wire

//-----------------------------------------------------------------------------
// GcdUnitDpathRTL_0x29124399ca008c5e
//-----------------------------------------------------------------------------
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module GcdUnitDpathRTL_0x29124399ca008c5e
(
  input  wire [   1:0] a_mux_sel,
  input  wire [   0:0] a_reg_en,
  input  wire [   0:0] b_mux_sel,
  input  wire [   0:0] b_reg_en,
  input  wire [   0:0] clk,
  output wire [   0:0] is_a_lt_b,
  output wire [   0:0] is_b_zero,
  input  wire [  15:0] req_msg_a,
  input  wire [  15:0] req_msg_b,
  input  wire [   0:0] reset,
  output wire [  15:0] resp_msg
);

  // wire declarations
  wire   [  15:0] sub_out;
  wire   [  15:0] b_reg_out;


  // a_reg temporaries
  wire   [   0:0] a_reg$reset;
  wire   [  15:0] a_reg$in_;
  wire   [   0:0] a_reg$clk;
  wire   [   0:0] a_reg$en;
  wire   [  15:0] a_reg$out;

  RegEn_0x68db79c4ec1d6e5b a_reg
  (
    .reset ( a_reg$reset ),
    .in_   ( a_reg$in_ ),
    .clk   ( a_reg$clk ),
    .en    ( a_reg$en ),
    .out   ( a_reg$out )
  );

  // a_lt_b temporaries
  wire   [   0:0] a_lt_b$reset;
  wire   [   0:0] a_lt_b$clk;
  wire   [  15:0] a_lt_b$in0;
  wire   [  15:0] a_lt_b$in1;
  wire   [   0:0] a_lt_b$out;

  LtComparator_0x422b1f52edd46a85 a_lt_b
  (
    .reset ( a_lt_b$reset ),
    .clk   ( a_lt_b$clk ),
    .in0   ( a_lt_b$in0 ),
    .in1   ( a_lt_b$in1 ),
    .out   ( a_lt_b$out )
  );

  // b_zero temporaries
  wire   [   0:0] b_zero$reset;
  wire   [  15:0] b_zero$in_;
  wire   [   0:0] b_zero$clk;
  wire   [   0:0] b_zero$out;

  ZeroComparator_0x422b1f52edd46a85 b_zero
  (
    .reset ( b_zero$reset ),
    .in_   ( b_zero$in_ ),
    .clk   ( b_zero$clk ),
    .out   ( b_zero$out )
  );

  // a_mux temporaries
  wire   [   0:0] a_mux$reset;
  wire   [  15:0] a_mux$in_$000;
  wire   [  15:0] a_mux$in_$001;
  wire   [  15:0] a_mux$in_$002;
  wire   [   0:0] a_mux$clk;
  wire   [   1:0] a_mux$sel;
  wire   [  15:0] a_mux$out;

  Mux_0x683fa1a418b072c9 a_mux
  (
    .reset   ( a_mux$reset ),
    .in_$000 ( a_mux$in_$000 ),
    .in_$001 ( a_mux$in_$001 ),
    .in_$002 ( a_mux$in_$002 ),
    .clk     ( a_mux$clk ),
    .sel     ( a_mux$sel ),
    .out     ( a_mux$out )
  );

  // b_mux temporaries
  wire   [   0:0] b_mux$reset;
  wire   [  15:0] b_mux$in_$000;
  wire   [  15:0] b_mux$in_$001;
  wire   [   0:0] b_mux$clk;
  wire   [   0:0] b_mux$sel;
  wire   [  15:0] b_mux$out;

  Mux_0xdd6473406d1a99a b_mux
  (
    .reset   ( b_mux$reset ),
    .in_$000 ( b_mux$in_$000 ),
    .in_$001 ( b_mux$in_$001 ),
    .clk     ( b_mux$clk ),
    .sel     ( b_mux$sel ),
    .out     ( b_mux$out )
  );

  // sub temporaries
  wire   [   0:0] sub$reset;
  wire   [   0:0] sub$clk;
  wire   [  15:0] sub$in0;
  wire   [  15:0] sub$in1;
  wire   [  15:0] sub$out;

  Subtractor_0x422b1f52edd46a85 sub
  (
    .reset ( sub$reset ),
    .clk   ( sub$clk ),
    .in0   ( sub$in0 ),
    .in1   ( sub$in1 ),
    .out   ( sub$out )
  );

  // b_reg temporaries
  wire   [   0:0] b_reg$reset;
  wire   [  15:0] b_reg$in_;
  wire   [   0:0] b_reg$clk;
  wire   [   0:0] b_reg$en;
  wire   [  15:0] b_reg$out;

  RegEn_0x68db79c4ec1d6e5b b_reg
  (
    .reset ( b_reg$reset ),
    .in_   ( b_reg$in_ ),
    .clk   ( b_reg$clk ),
    .en    ( b_reg$en ),
    .out   ( b_reg$out )
  );

  // signal connections
  assign a_lt_b$clk    = clk;
  assign a_lt_b$in0    = a_reg$out;
  assign a_lt_b$in1    = b_reg$out;
  assign a_lt_b$reset  = reset;
  assign a_mux$clk     = clk;
  assign a_mux$in_$000 = req_msg_a;
  assign a_mux$in_$001 = sub_out;
  assign a_mux$in_$002 = b_reg_out;
  assign a_mux$reset   = reset;
  assign a_mux$sel     = a_mux_sel;
  assign a_reg$clk     = clk;
  assign a_reg$en      = a_reg_en;
  assign a_reg$in_     = a_mux$out;
  assign a_reg$reset   = reset;
  assign b_mux$clk     = clk;
  assign b_mux$in_$000 = a_reg$out;
  assign b_mux$in_$001 = req_msg_b;
  assign b_mux$reset   = reset;
  assign b_mux$sel     = b_mux_sel;
  assign b_reg$clk     = clk;
  assign b_reg$en      = b_reg_en;
  assign b_reg$in_     = b_mux$out;
  assign b_reg$reset   = reset;
  assign b_reg_out     = b_reg$out;
  assign b_zero$clk    = clk;
  assign b_zero$in_    = b_reg$out;
  assign b_zero$reset  = reset;
  assign is_a_lt_b     = a_lt_b$out;
  assign is_b_zero     = b_zero$out;
  assign resp_msg      = sub$out;
  assign sub$clk       = clk;
  assign sub$in0       = a_reg$out;
  assign sub$in1       = b_reg$out;
  assign sub$reset     = reset;
  assign sub_out       = sub$out;



endmodule // GcdUnitDpathRTL_0x29124399ca008c5e
`default_nettype wire

//-----------------------------------------------------------------------------
// RegEn_0x68db79c4ec1d6e5b
//-----------------------------------------------------------------------------
// dtype: 16
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module RegEn_0x68db79c4ec1d6e5b
(
  input  wire [   0:0] clk,
  input  wire [   0:0] en,
  input  wire [  15:0] in_,
  output reg  [  15:0] out,
  input  wire [   0:0] reset
);



  // PYMTL SOURCE:
  //
  // @s.posedge_clk
  // def seq_logic():
  //       if s.en:
  //         s.out.next = s.in_

  // logic for seq_logic()
  always @ (posedge clk) begin
    if (en) begin
      out <= in_;
    end
    else begin
    end
  end


endmodule // RegEn_0x68db79c4ec1d6e5b
`default_nettype wire

//-----------------------------------------------------------------------------
// LtComparator_0x422b1f52edd46a85
//-----------------------------------------------------------------------------
// nbits: 16
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module LtComparator_0x422b1f52edd46a85
(
  input  wire [   0:0] clk,
  input  wire [  15:0] in0,
  input  wire [  15:0] in1,
  output reg  [   0:0] out,
  input  wire [   0:0] reset
);



  // PYMTL SOURCE:
  //
  // @s.combinational
  // def comb_logic():
  //       s.out.value = s.in0 < s.in1

  // logic for comb_logic()
  always @ (*) begin
    out = (in0 < in1);
  end


endmodule // LtComparator_0x422b1f52edd46a85
`default_nettype wire

//-----------------------------------------------------------------------------
// ZeroComparator_0x422b1f52edd46a85
//-----------------------------------------------------------------------------
// nbits: 16
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module ZeroComparator_0x422b1f52edd46a85
(
  input  wire [   0:0] clk,
  input  wire [  15:0] in_,
  output reg  [   0:0] out,
  input  wire [   0:0] reset
);



  // PYMTL SOURCE:
  //
  // @s.combinational
  // def comb_logic():
  //       s.out.value = s.in_ == 0

  // logic for comb_logic()
  always @ (*) begin
    out = (in_ == 0);
  end


endmodule // ZeroComparator_0x422b1f52edd46a85
`default_nettype wire

//-----------------------------------------------------------------------------
// Mux_0x683fa1a418b072c9
//-----------------------------------------------------------------------------
// dtype: 16
// nports: 3
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module Mux_0x683fa1a418b072c9
(
  input  wire [   0:0] clk,
  input  wire [  15:0] in_$000,
  input  wire [  15:0] in_$001,
  input  wire [  15:0] in_$002,
  output reg  [  15:0] out,
  input  wire [   0:0] reset,
  input  wire [   1:0] sel
);

  // localparam declarations
  localparam nports = 3;


  // array declarations
  wire   [  15:0] in_[0:2];
  assign in_[  0] = in_$000;
  assign in_[  1] = in_$001;
  assign in_[  2] = in_$002;

  // PYMTL SOURCE:
  //
  // @s.combinational
  // def comb_logic():
  //       assert s.sel < nports
  //       s.out.v = s.in_[ s.sel ]

  // logic for comb_logic()
  always @ (*) begin
    out = in_[sel];
  end


endmodule // Mux_0x683fa1a418b072c9
`default_nettype wire

//-----------------------------------------------------------------------------
// Mux_0xdd6473406d1a99a
//-----------------------------------------------------------------------------
// dtype: 16
// nports: 2
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module Mux_0xdd6473406d1a99a
(
  input  wire [   0:0] clk,
  input  wire [  15:0] in_$000,
  input  wire [  15:0] in_$001,
  output reg  [  15:0] out,
  input  wire [   0:0] reset,
  input  wire [   0:0] sel
);

  // localparam declarations
  localparam nports = 2;


  // array declarations
  wire   [  15:0] in_[0:1];
  assign in_[  0] = in_$000;
  assign in_[  1] = in_$001;

  // PYMTL SOURCE:
  //
  // @s.combinational
  // def comb_logic():
  //       assert s.sel < nports
  //       s.out.v = s.in_[ s.sel ]

  // logic for comb_logic()
  always @ (*) begin
    out = in_[sel];
  end


endmodule // Mux_0xdd6473406d1a99a
`default_nettype wire

//-----------------------------------------------------------------------------
// Subtractor_0x422b1f52edd46a85
//-----------------------------------------------------------------------------
// nbits: 16
// dump-vcd: False
// verilator-xinit: zeros
`default_nettype none
module Subtractor_0x422b1f52edd46a85
(
  input  wire [   0:0] clk,
  input  wire [  15:0] in0,
  input  wire [  15:0] in1,
  output reg  [  15:0] out,
  input  wire [   0:0] reset
);



  // PYMTL SOURCE:
  //
  // @s.combinational
  // def comb_logic():
  //       s.out.value = s.in0 - s.in1

  // logic for comb_logic()
  always @ (*) begin
    out = (in0-in1);
  end


endmodule // Subtractor_0x422b1f52edd46a85
`default_nettype wire

`default_nettype none
`define MPRJ_IO_PADS 38

module user_proj_example #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wire wb_clk_i,
    input wire wb_rst_i,
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_dat_i,
    input wire [31:0] wbs_adr_i,
    output wire wbs_ack_o,
    output wire [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  wire [127:0] la_data_in,
    output wire [127:0] la_data_out,
    input  wire [127:0] la_oenb,

    // IOs
    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout wire [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input wire user_clock2,

    // User maskable interrupt signals
    output wire [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/
  wire [15:0] resp_msg;
  assign io_out = 38'd0;
  assign io_oeb = 32'd0;
  assign user_irq = 3'd0;
  assign la_data_out = 128'd0;

  wire gcd_req_rdy;
  wire gcd_resp_rdy;
  wire enq;
  wire deq;
  reg ack;

  assign enq = wbs_cyc_i && wbs_stb_i && wbs_we_i && gcd_req_rdy;
  assign deq = wbs_cyc_i && wbs_stb_i && (!wbs_we_i) && gcd_resp_rdy;
  assign wbs_dat_o[31:16] = 16'h0000;
  assign wbs_dat_o[15:0] = resp_msg[15:0];
  
  GcdUnit GcdUnit_inst
  (
    .clk(wb_clk_i),
    .req_msg(wbs_dat_i),
    .req_rdy(gcd_req_rdy),
    .req_val(enq),
    .reset(wb_rst_i),
    .resp_msg(resp_msg),
    .resp_rdy(deq),
    .resp_val(gcd_resp_rdy)
  );

  always @ (posedge wb_clk_i) begin
    if (wb_rst_i) begin
      ack <= 1'b0;
    end else begin
      ack <= enq || deq;
    end
  end
  
  assign wbs_ack_o = ack;

endmodule

`default_nettype wire
