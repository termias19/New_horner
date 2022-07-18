// Code your design here

module mul32ff #(parameter W = 31)
  ( input clk,
    input reset,
   input [W:0] x, y,
   output reg [W:0] z );
  
   // {c,z} = x*y
  always @(posedge clk) begin
    if (reset)
      z <=0;
    else 
    	z <= x*y;
  
  end
endmodule 



module add32ff 
  (input clk,
   input reset,
    input [31:0] x,y,
   output reg [31:0] z);
  //assign z = x+y;
  always @(posedge clk) begin
    if (reset) begin
      z <= 0;
      
    end
    
    else begin
       z  <= x+y;
    end 
  end
  
endmodule 

module for_horner
  (input clk,
   input reset,
    input [31:0]c0,c1,c2, 
    input [31:0] x,
   output wire [31:0] z);
  
  wire [31:0] z1, z2, z3;
  wire [31:0] b = x*x;
  
  mul32ff u1(clk,reset,x,c1,z1);
  mul32ff u2(clk,reset,b,c2,z2);
  add32ff u3(clk,reset,z1,c0,z3);
  add32ff u4(clk,reset,z3,z2,z);
  
  
endmodule


//testbench

// Code your testbench here
// or browse Examples
`timescale 1ns / 1ns
`include "squ_r.v"

module f_adder_test();
  reg clk, reset;
  reg [31:0] c0,c1,c2,z1,z2,z3,x;
  wire [31:0] z;
  
  //mul32ff a1(x,c1, z);
  //add32ff a1(x,y, z);
  for_horner a1(.clk(clk), 
                .reset(reset),
                .c0(c0),
                .c1(c1),
                .c2(c2),
                .x(x),.z(z));
  
    initial begin
    clk = 0;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
  end
   initial
  	 begin
	  $dumpfile("sq.tb.vcd"); $dumpvars(0,f_adder_test);
      reset=0;
      c0=0; c1 = 0;c2=0;z1=0; z2=0; z3=0; x=0;
       
      #2 reset =0;
       #5 c0=4'ha; c1 = 4'h1;c2=4'h1;z1=4'h1; z2=4'h1; z3=4'h1; x=1;
      #3reset=0;
      #10c0=4'ha; c1 = 4'h1;c2=4'h1;z1=4'h1; z2=4'h1; z3=4'h1; x=2;
      
      
    end
endmodule 
