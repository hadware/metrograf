with Package_Graphe;
use Package_Graphe;


package BellmanFord is
   
   -- Calcul les chemins les plus du noeud vers tous les autres
   procedure Bellman ( Input_Graphe : Graphe; Source : Node; Cost_Array : out T_Cost_Array; Previous_Node_List : out Node_Id_Array);
      
   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageBellmanFord (Input_Graphe : Graphe; Source : Node; Destination : Node; Node_A : P_Node_Array);
      
end;
