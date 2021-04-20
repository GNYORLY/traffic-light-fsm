module debouncer(clk, button, o_b);
	input clk;
  	input button;
  	output o_b;
  
   reg [15:0] clk_dv = 0;
  	reg inst_vld;
   
    always @ (posedge clk) begin
        if (button == 0) begin
        	clk_dv <= 0;
			inst_vld <= 0;
       	end
    	else if (button == 1) begin
        	clk_dv <= clk_dv + 1'b1;
			if (clk_dv == 16'hffff) begin
				clk_dv <= 0;
				inst_vld <= 1; 
			end
       	end
    end
   
   	assign o_b = inst_vld;
  
endmodule