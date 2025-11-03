// Code your design here
module and_gate (
input wire a, // Input 1
input wire b, // Input 2
output wire y // Output
);

// Assign the AND operation to the output
assign y = a & b;
  initial $monitor("in drv %d %d %d",a,b,y);
endmodule