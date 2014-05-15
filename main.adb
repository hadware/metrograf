with Bellmanford;
use Bellmanford;
--with Dijkstra;
--use Dijkstra;
with Package_Graphe;
use Package_Graphe;
with Ada.Command_Line;
use Ada.Command_Line;
with Parser;
use Parser;
with Ada.Text_Io;
use Ada.Text_Io;

procedure Main is
   PGraphe : P_Graphe;
   Node_A : P_Node_Array;
   vertex_A : P_Vertex_Array; 
   Way_List : L_Node.List;
   
begin
 
   
   if Argument(2) = "b" then 
      Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
      AffichageBellmanFord(PGraphe.all, Node_A.all(5), Node_A.all(40),Node_A);
   elsif Argument(2) = "d" then
      Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
      AffichageDijkstra(PGraphe.all, Node_A.all(5), Node_A.all(40));
   else
      Put("erreur");
   end if;
      
      
   
end;
