-- Parseur des fichiers de graph
with Package_Graphe;
use Package_Graphe;

package parser is

   procedure Load_Graph_From_File(Filename : String;
                                  Output_Graph : in out P_Graphe;
                                  Output_Node_Array : in out P_Node_Array;
                                  Output_Vertex_array : in out P_Vertex_Array);

end;

