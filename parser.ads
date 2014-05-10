-- Parseur des fichiers de graph
with Package_Graphe;
use Package_Graphe;

package parser is

   -- R�cup�re le tableau des noeuds � partir du fichier source
   function Parse_Nodes(Filename : in String) return Node_Array;

   --R�cup�re le tableau des arr�tes � partir du fichier source
   function Parse_Vertices(Filename : in String) return Vertex_Array;

   -- Construit le graphe � partir du tableau des ar�tes et du tableau de noeuds
   function Construct_Graph(Input_Vertex_Array: Vertex_Array; Input_Node_Array) return Graphe;

end;

