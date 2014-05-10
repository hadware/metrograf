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
   type Node_Array is array (Integer range <>) of P_Node;

   package Node_List is new Ada.Containers.Doubly_Linked_Lists(Integer);

   type Vertex is record
      Source : Natural; --id de la source de cette arête
      Destination : Natural; --id de la destination de cette arête
      Line : Unbounded_String;
      Cost : Float;
   end record;

   type P_Vertex is access Vertex;
   type Vertex_Array is array (Integer range <>) of Vertex;

   package V_List is new Ada.Containers.Doubly_Linked_Lists(Integer);

   type Graphe is array (Integer range <>, Integer range <>) of P_Vertex;


   procedure Get_Output_Vertex (Input_graphe: Graphe ; Id_Node : integer; List_Dest : out Node_List.List);

end;

