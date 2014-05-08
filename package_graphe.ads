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
   type Node_Id_Array is array (Integer range <>) of Integer;
   
   package Node_List is new Ada.Containers.Doubly_Linked_Lists(Integer);
   
   type Vertex is record
      Source : Integer;
      Destination : Integer;
      Line : Unbounded_String;
      Cost : float;
   end record;
   
   type P_Vertex is access Vertex;
   type Vertex_Id_Array is array (Integer range <>) of Integer;
    
   package V_List is new Ada.Containers.Doubly_Linked_Lists(Integer);
       
   type Graphe is array (Integer range <>, Integer range <>) of P_vertex; 
   
   procedure Get_Out_Put_Vertex (Input_graphe: Graphe ; Id_Node : integer; List_Dest : out Node_List.List);
   
end;

