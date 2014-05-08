with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;

package Graphe is
  
   
   
   type Vertex_List is private;
   
   type Node is record
      Id : Integer;
      Station_Name : String;
      
   end record;
   
   type P_Node is access Node;
   
   type vertex is record
      Source : P_Node;
      Destination : P_Node;
      Ligne : String;
      Cout : Integer;
   end record;
   
   package List is new Ada.Containers.Doubly_Linked_Lists(vertex);
   type Vertex_List is new List.List;
      
   type Graphe is array (Integer range <>) of P_node; 
   
end;
