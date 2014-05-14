with Package_Graphe;
use Package_Graphe;
with Ada.Containers.Doubly_Linked_Lists;

package BellmanFord is
   
   -- stock la valeur du chemin le plus court entre noeud et tous les autres
   type T_Cost_Array is array (Integer range <>) of float;
   
   --stock les id du chemin le plus court
   package L_Node is new Ada.Containers.Doubly_Linked_Lists(natural);
   
   -- Calcul les chemins les plus du noeud vers tous les autres
   procedure Bellman ( Input_Graphe : Graphe; Source : Node; Cost_Array : out T_Cost_Array; Previous_Node_List : out Node_Id_Array);
   

   
   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageBellmanFord (Input_Graphe : Graphe; Source : Node; Destination : Node; Node_A : P_Node_Array);
   
   
   
end;
