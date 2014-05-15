with Bellmanford;
use Bellmanford;
with Dijkstra;
use Dijkstra;
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
   error_command : Exception;
   
   procedure Display_Help is
   begin
      Put_Line("****** Erreur dans la ligne de commande ******");
      Put_Line("Arguments : ");
      Put_Line("            - Nom du fichier en .graph");
      Put_Line("            - b ou d pour utiliser Bellman ou Dijkstra");
   end;
   
begin
 
   if Argument_Count = 2 then
      if Argument(2) = "b" then 
	 Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
	 AffichageBellmanFord(PGraphe.all, Node_A.all(5), Node_A.all(40),Node_A);
      elsif Argument(2) = "d" then
	 Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
	 AffichageDijkstra(PGraphe.all, Node_A.all(5), Node_A.all(40),Node_A);
      else
	 raise error_command ;
      end if;
   else
      raise error_command ;
   end if;  
   
exception
   when error_command =>
      Display_Help;
end;
