with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with BellmanFord;
use BellmanFord;
with Package_Graphe;
use Package_Graphe;


procedure Test_Bell is
   G : Graphe(1..3,1..3);
   V : P_Vertex;
   I : Node_List.List;
 
   
begin
   for I in 1..G'Length loop
      for J in 1..G'Length loop
	 V := new Vertex;
	 V.Source := I;Put("cool");
	 V.Destination := J;
	 --V.Line := To_Unbounded_String("pffff");
	 V.Cost := 10.0;
	 G(I,J):= V;
      end loop;
   end loop;
   
   Get_Out_Put_Vertex(G,1,I);
     
end;
