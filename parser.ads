-- Parseur des fichiers de graph
with Package_Graphe;
use Package_Graphe;

package parser is

   -- Récupère le tableau des noeuds à partir du fichier source
   function Parse_Nodes(Filename : in String) return Node_Array;

   --Récupère le tableau des arrêtes à partir du fichier source
   function Parse_Vertices(Filename : in String) return Vertex_Array;

   -- Construit le graphe à partir du tableau des arètes et du tableau de noeuds
   function Construct_Graph(Input_Vertex_Array: Vertex_Array; Input_Node_Array) return Graphe;

end;

