with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;

package Package_Graphe is
        
   type Node is record
      Id : Integer;
      Station_Name : Unbounded_String;
   end record;
     

   
   type P_Node is access Node;
   
   type vertex is record
      Source : P_Node;
      Destination : P_Node;
      Line : Unbounded_String;
      Cost : float;
   end record;
   
   type P_vertex is access vertex;
   
   
 
 --  package List is new Ada.Containers.Doubly_Linked_Lists(vertex);
  -- type Vertex_Lt is new List.List;
      
   type Graphe is array (Integer range <>, Integer range <>) of P_vertex; 
   
end;
