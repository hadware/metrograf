with Graphe;
use Graphe;
package Dijkstra is
   
   -- Calcul les chemins les plus du noeud vers tous les autres
   procedure Dijkstra (G: Graphe; Source : Node);
   
   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (G: Graphe; Source : Node; Destination : Node);
   
end
