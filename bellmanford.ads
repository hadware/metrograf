with Package_Graphe;
use Package_Graphe;

package BellmanFord is
   
   type T_Cost_Array is array (Integer range <>) of float;
         
   -- Calcul les chemins les plus du noeud vers tous les autres
   procedure BellmanFord ( Input_Graphe : Graphe; Source : Node; Cost_Array : out T_Cost_Array; Way_Array : out Node_Array);
   

   
   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageBellmanFord (Input_Graphe : Graphe; Source : Node; Destination : Node);
   
   
   
end;
