with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Graph is
   
   type Graphe is array (0 .. J) of P_node; 
   
   type Node is record
      Id : Integer;
      Station_Name : String;
   end record;
   
   type P_Node is access Node;
   
   type vertex is record
      Source : P_Node;
      Destination : P_Node;
      Ligne : Characters;
      Cout : integer
   end record;
   
   
end;
