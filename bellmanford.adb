with Package_Graphe;
use Package_Graphe;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;
with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Integer_Text_Io;
use Ada.Integer_Text_Io;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;


package body BellmanFord is 
 
   -- ==========================================================================
   -- Procédure pour libérer la mémoire
   -- ==========================================================================
   procedure Free_Memory(PGraphe : out P_Graphe; PNode_Array : out  P_Node_Array; PVertex_Array : out P_Vertex_Array) is
   begin
      Free_Node_Array(PNode_Array);
      Free_Vertex_Array(PVertex_Array);      
      if PGraphe /= null then
	 for I in PGraphe'Range loop
	    for K in PGraphe'Range loop
	       Free_P_Vertex(PGraphe(I,K));
	    end loop;
	 end loop;
	 Free_Graphe(PGraphe);
      end if;
   end;
   -- ==========================================================================
   -- Calcule tous les chemins minimum en partant de la source
   -- Rempli un tableau contenant le noeud précédant chaque noeud par le chemin calculé
   -- ==========================================================================
   procedure Bellman (Input_Graphe: Graphe; Source : Node;  Cost_Array : out T_Cost_Array; Previous_Node_List : out Node_Id_Array) is
      
      -- ==========================================================================
      -- Calcule le cout entre la source et le détinataire
      -- ==========================================================================
      Function Calc_Cost (Input_Graphe : Graphe; Id_Source : natural ; Id_Destination : natural) return float is 
      begin
	 return (Input_Graphe(Id_Source,Id_Destination).Cost);      
      end;
      -- ==========================================================================
   
      Nb_summit : Integer := Input_Graphe'length; 
      Cost_Temp : float := 0.0;
      Id_Node_U, Id_Node_V : Natural;
      
   begin
   
      Put_Line("recherche des chemins les plus courts ...");
      Cost_Array := (others => Float'Last); 
      Cost_Array(Source.Id) := 0.0;
   
      for I in 2..Nb_Summit loop -- pour tout les sommets
	 for J in 1..Nb_Summit loop -- pour tous les arcs du graphe
	    for K in 1..Nb_Summit loop
	       -- si l'arc existe :
	       if Input_Graphe(J,K) /= null then 
		  Id_Node_U := Input_Graphe(J,K).Source;
		  Id_Node_V := Input_Graphe(J,K).Destination;
		  Cost_Temp := Cost_Array(Id_Node_U) + Input_Graphe(J,K).cost;
		  if Cost_Temp < Cost_Array(Id_Node_V) then
		     Cost_Array(Id_Node_V) := Cost_Temp;
		     -- enregistrement l'antécédant de V
		     Previous_Node_List(K) := Id_Node_U;
		  end if;
	       end if;
	    end loop;
	 end loop;
      end loop;
   end Bellman;
   -- ==========================================================================
   
   
   -- ==========================================================================
   -- Cherche le chemin entre la source et la destination
   -- ==========================================================================
   procedure Search_Way (Source_Id : Natural; Destination_Id : Natural; Previous_Node_List :  Node_Id_Array; Way : out L_Node.List) is 
      Index : Natural := Destination_Id;
   begin
      while Index /= Source_Id loop
	 Index := Previous_Node_List(Index);
	 L_Node.Prepend(Way,index);
      end loop;
   end Search_Way;
   -- ==========================================================================
   
   
   -- ==========================================================================
   -- Affiche le chemin le plus court par l'algo de Bellman-Ford
   -- ==========================================================================
   procedure AffichageBellmanFord (Input_graphe : in out  Graphe; Source : Node; Destination : Node; Node_A : in out  P_Node_Array) is
      Cost_Array : T_Cost_Array(1..Input_Graphe'length);
      Previous_Node_List : Node_Id_Array(1..Input_Graphe'length);
      Way : L_Node.List;
      Current_Line : Unbounded_String;
      Station_Nb: integer := 0;
      Position : L_Node.Cursor;
      
      -- ==========================================================================
      -- Affiche le chemin
      -- ==========================================================================
      procedure Print_Way (Position : in L_Node.Cursor) is
	 Current_Node : Node := Node_A(L_Node.Element(Position));
	 Previous_Node : Node;
      begin
	 
	 -- Test si le Previous_Node existe
	 if L_Node.Has_Element(L_Node.Previous(Position)) then
	    Previous_Node := Node_A(L_Node.Element(L_Node.Previous(Position)));
	 elsif L_Node.Has_Element(L_Node.Next(Position)) then
	    -- Initialise la ligne si c'est le 1er element
	    Current_Line := Input_Graphe(Current_Node.Id,Node_A(L_Node.Element(L_Node.Next(Position))).id).Line;
	 end if;
	 
	 
	 -- Affiche une correspondance
	 if Previous_Node.Station_Name = Current_Node.Station_Name  then
	    Put_Line(Integer'Image(Station_Nb-1) & " station(s)");
	    Put("changement a ");
	    Put(To_String(Previous_Node.Station_Name) &" (" & Integer'Image(Previous_Node.Id) & ") ligne " & To_String(Current_Line));
	    
	    --test l'existance de l'élement suivant et enregistre la ligne courante
	    if L_Node.Has_Element(L_Node.Next(Position)) then
	       Current_Line := Input_Graphe(Current_Node.Id,Node_A(L_Node.Element(L_Node.Next(Position))).id).Line;
	    end if;
	    
	    Put_Line(" --> " & " (" & Integer'Image(Current_Node.Id) & ") ligne " & To_String(Current_Line));
	    Station_Nb := 0;
	 end if;
	 Station_Nb := Station_Nb + 1;
	 
      end;
      -- ==========================================================================
      
   begin
      
      Bellman(Input_Graphe, Source, Cost_Array, Previous_Node_List);
      Search_Way (Source.Id, Destination.Id, Previous_Node_List, Way);
      
      Put_Line("=============== Résultat ==============="); 
      Put("Chemin le plus court entre ");
      Put(To_String(Source.Station_Name) & " (" & Integer'Image(Source.Id) & ") et ");
      Put_line(To_String(Destination.Station_Name) & " (" & Integer'Image(Destination.Id) & ") : ");
      Put_Line("Depart : " & To_String(Source.Station_Name) & " (" & Integer'Image(Source.Id) & ")");
      
      -- Affichage des correspondances
      Way.Iterate(Print_Way'Access);
      Put_Line(Integer'Image(Station_Nb) & " station(s)");   
      
      Put_Line("Arrivée : " & To_String(Destination.Station_Name) & " (" & Integer'Image(Destination.Id) & ")" );
      Put_Line("cout du chemin : " & Float'Image(Cost_Array(Destination.id)));
      Put_Line("=======================================");
      
     
   end AffichageBellmanFord;
   -- ==========================================================================
  
   
end;

