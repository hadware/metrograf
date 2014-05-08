with Package_Graphe;
use Package_Graphe;

package BellmanFord is
   
   -- Calcul les chemins les plus du noeud vers tous les autres
   procedure BellmanFord (G: Graphe; Source : Node);
   
   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageBellmanFord (G: Graphe; Source : Node; Destination : Node);
   
end;
