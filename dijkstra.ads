with Package_Graphe;
use Package_Graphe;
package Dijkstra is

   -- Calcul le plus cours chemin d'un noeud source vers tout les autres noeuds du graphe
   function Dijkstra (Input_Graph: Graphe; Source_Id : Integer) return Distance_Array;

   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (G: Graphe; Source : Node; Destination : Node);

end;
