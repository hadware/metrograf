with Package_Graphe;
use Package_Graphe;
package Dijkstra is

   -- Calcul le plus cours chemin d'un noeud source vers tout les autres noeuds du graphe
   function Dijkstra (Input_Graph: Graphe; Source_Id : Integer) return T_Cost_Array;

   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (Input_Graph: Graphe; Source : Node; Destination : Node; Input_Node_Array : P_Node_Array);

end;
