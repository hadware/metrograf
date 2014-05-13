-- 1 noeud -> connections sortantes

package body Package_Graphe is

   procedure Get_Output_Vertex ( Input_graphe : Graphe ; Id_Node : integer; List_Dest : out Node_List.List) is
   begin
      for I in Input_graphe'Range loop
	 if Input_graphe(Id_Node,I) /= null then
            --Node_List.Append(List_Dest, Input_graphe(Id_Node,I).Destination.id);
            Put_Line("Noeud reliés : " & Integer'Image(Input_graphe(Id_Node,I).Destination));
	 end if;
      end loop;
   end;

end Package_Graphe;
