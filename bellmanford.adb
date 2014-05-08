with Package_Graphe;
use Package_Graphe;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body BellmanFord is 

procedure BellmanFord (G: Graphe; Source : Node) is
   
   --calcule le cout entre source et dstinataire
   Function Calc_Cost (G : Graphe; Source : Node; Destination : Node) return float is 
   begin
      return (G(Source.Id,Destination.Id).Cost);      
   end;
   
   Nb_summit : Integer := G'length; 
   
   type T_Cost_Array is array (1..Nb_summit) of float;
   Cost_Array : T_Cost_Array := (others => Float'Last);
   
   Cost_Temp : float := 0.0;
   U,V : Node;
      
begin
   
   --Distance (1.. n ) := ( others = > Float ’ Last );
   --Distance ( Source ) := 0;
   --pour i = 2 jusqu ’ a n faire
   --    pour chaque arc (u , v ) du graphe faire
   --       DistTemp := Distance ( u ) + Cout (u , v );
   --       si DistTemp < distance ( v ) alors
   --          Distance ( v ) := DistTemp ;
   --       fin si
   --    fin pour
   --fin pour
   
   Cost_Array(Source.Id) := 0.0;
   
   for I in 2..Nb_Summit loop -- pour tout les sommets
      for J in 1..Nb_Summit loop -- pour tous les arcs du graphe
	 for K in 1..Nb_Summit loop
	    U := G(J,K).Source.all;
	    V := G(J,K).Destination.all;
	    Cost_Temp := Cost_Array(U.Id) + G(J,K).cost;
	    if Cost_Temp < Cost_Array(V.Id) then
	       Cost_Array(V.Id) := Cost_Temp;
	    end if;
	 end loop;
      end loop;
   end loop;
   
end;

procedure AffichageBellmanFord (G : Graphe; Source : Node; Destination : Node) is
begin
   null;
end;

end;
