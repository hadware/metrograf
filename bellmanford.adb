with Package_Graphe;
use Package_Graphe;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body BellmanFord is 

   procedure BellmanFord (Input_Graphe: Graphe; Source : Node; Cost_Array : Out T_Cost_Array; Way_Array : out Node_Array) is
   
   --calcule le cout entre source et dstinataire
   Function Calc_Cost (Input_Graphe : Graphe; Source : Node; Destination : Node) return float is 
   begin
      return (Input_Graphe(Source.Id,Destination.Id).Cost);      
   end;
   
   Nb_summit : Integer := Input_Graphe'length; 
     
   Cost_Temp : float := 0.0;
   U,V : P_Node;
   Index : Integer := 1;
      
begin
   
   --Distance (1.. n ) := ( others = > Float ’ Last );
   --Distance ( Source ) := 0;
   --pour i = 2 jusqu ’ a n fair null;e
   --    pour chaque arc (u , v ) du graphe faire
   --       DistTemp := Distance ( u ) + Cout (u , v );
   --       si DistTemp < distance ( v ) alors
   --          Distance ( v ) := DistTemp ;
   --       fin si
   --    fin pour
   --fin pour
   
   Cost_Array := (others => Float'Last); 
   Cost_Array(Source.Id) := 0.0;
   
   for I in 2..Nb_Summit loop -- pour tout les sommets
      for J in 1..Nb_Summit loop -- pour tous les arcs du graphe
	 for K in 1..Nb_Summit loop
	    U := Input_Graphe(J,K).Source;
	    V := Input_Graphe(J,K).Destination;
	    Cost_Temp := Cost_Array(U.Id) + Input_Graphe(J,K).cost;
	    if Cost_Temp < Cost_Array(V.Id) then
	       Cost_Array(V.Id) := Cost_Temp;
	       Way_Array(Index) := V;
	       Index := Index + 1;
	    end if;
	 end loop;
      end loop;
   end loop;
end;
   
   

   procedure AffichageBellmanFord (Input_graphe : Graphe; Source : Node; Destination : Node) is
      Cost_Array : T_Cost_Array(1..Input_Graphe'length);
      Way_Array : Node_Array(1..Input_Graphe'Length) := (others => null);
      
   begin
   BellmanFord(Input_Graphe, Source, Cost_Array, Way_Array);
   
   
   
   
   
   end;

end;
