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
with Ada.Text_Io,Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;
with Ada.IO_Exceptions;
use Ada.IO_Exceptions;


procedure Main is
   PGraphe : P_Graphe;
   Node_A : P_Node_Array;
   vertex_A : P_Vertex_Array; 
   Way_List : L_Node.List;
   error_command : Exception;
   Source_Id,Destination_Id : Integer := 0; 
   
   -- Affichage de l'erreur
   procedure Display_Help is
   begin
      Put_Line("****** Erreur dans la ligne de commande ******");
      Put_Line("Arguments : ");
      Put_Line("            - Nom du fichier en .graph");
      Put_Line("            - b ou d pour utiliser Bellman ou Dijkstra");
      Put_Line("**********************************************");
   end;
   
   -- Vérifie si les valeurs des noeuds sont corrects
   procedure Check_Id(Max_Id : Integer; Id : in out Integer; Check_Bool : in out boolean ) is
   begin
      if Id < 0 or Id > Max_Id then
	 Check_Bool := False;
	 Put_Line("valeur du noeud incorrect");
      else
	 Check_Bool := True;
      end if;
   end Check_Id;
   
   -- Permet de réccuperer les valeurs des noeuds de départ et d'arrivée
   procedure Get_Id (Max_Id : Integer; Source_Id : in out Integer; Destination_Id : in out Integer) is
      Check_Bool : Boolean := false;
   begin
      
      Put_Line("Id maximum = " & Integer'Image(Max_Id));
      while Check_Bool = False loop
	 Put("Entrez le numero de la source : ");Get(Source_Id);Skip_Line;
	 Check_Id(Max_Id, Source_Id, Check_Bool);
      
      end loop;
      Check_Bool :=  False;
      while Check_Bool = False loop
	 Put("Entrez Le Numéro de l'arrivee : ");Get(Destination_Id);Skip_Line;
	 Check_Id(Max_Id, Destination_Id, Check_Bool);
      end loop;
   end Get_Id;
     
   
begin
   
   if Argument_Count = 2 then
      if Argument(2) = "b" then 
	 Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
	 Get_Id(Node_A'Last, Source_Id, Destination_Id);
	 AffichageBellmanFord(PGraphe.all, Node_A.all(Source_Id), Node_A.all(Destination_Id),Node_A);
      elsif Argument(2) = "d" then
	 Load_Graph_From_File(Argument(1), PGraphe, Node_A, Vertex_A);
	 Get_Id(Node_A'Last, Source_Id, Destination_Id);
	 AffichageDijkstra(PGraphe.all, Node_A.all(Source_Id), Node_A.all(Destination_Id),Node_A);
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
