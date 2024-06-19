//  (c) Copyright 2017 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
`ifndef _RST_VIP_IF_SV_
`define _RST_VIP_IF_SV_
`timescale 1ps/1ps

interface rst_vip_if #(
  int C_ASYNCHRONOUS              = 0,
      C_RST_POLARITY              = 1
  );
  logic                            rst =  C_RST_POLARITY ? 0 :1 ;
  wire                             RST;
  wire                             CLK;
  logic intf_is_master =0;
  /*
  *  Function: set_intf_master
  *  Sets interface to master mode
  */
  function void set_intf_master();
    intf_is_master = 1;
  endfunction : set_intf_master

  /*
  *  Function: set_intf_monitor
  *  Sets interface to monitor mode
  */
  function void set_intf_monitor();
    intf_is_master = 0;
  endfunction : set_intf_monitor

  /*
    Functon: set_initial_reset 
    To initialise rst signal
  */
  function void set_initial_reset (input logic initial_value_rst);
    rst = initial_value_rst;
  endfunction

  /*
    Function: assert_reset
    if RST_POLARITY of rst vip is high, set rst to be 1, else, set rst to be 0
  */
  task assert_reset();
    if(!C_ASYNCHRONOUS) begin
      @(posedge CLK);
    end  
    if(C_RST_POLARITY) begin 
      rst = 1;
    end else begin
      rst =0;
    end
  endtask

   /*
    Function: deassert_reset
    if RST_POLARITY of rst vip is high, set rst to be 0, else, set rst to be 1
  */
  task deassert_reset();
    if(!C_ASYNCHRONOUS) begin
      @(posedge CLK);
    end 
    if(C_RST_POLARITY) begin 
      rst = 0;
    end else begin
      rst = 1;
    end
  endtask

  
  assign RST = intf_is_master ? rst : 'z;
endinterface : rst_vip_if

`endif
