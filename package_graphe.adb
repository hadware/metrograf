
package body Package_Graphe is
   
    -- ==========================================================================
   -- Cherche le chemin entre la source et la destination
   -- ==========================================================================
   procedure Search_Way (Source_Id : Natural; Destination_Id : Natural; Previous_Node_List :  Node_Id_Array; Way : out L_Node.List) is 
      Index : Natural := Destination_Id;
   begin
      
      while Index /= Source_Id loop
	 if Index /= 0  then 
	    Index := Previous_Node_List(Index);
	 else 
	    exit;
	 end if;
	 L_Node.Prepend(Way,Index);
	 Put_Line("dest : " & Integer'Image(Destination_id));
      end loop;
   end Search_Way;
   -- ==========================================================================
   
   
   -- ==========================================================================
   -- Retrouve le chemin le plus court à partir de Previous_Node_List et Cost_Array
   -- Affiche les correspondances du chemin le plus court
   -- ==========================================================================
   procedure Display_Path (Previous_Node_List : Node_Id_Array; Cost_Array : T_Cost_Array; Source : Node; Destination : Node; Node_A : P_Node_Array; Input_Graphe : Graphe) is
      Current_Line : Unbounded_String;
      Station_Nb: integer := 0;
      Way : L_Node.List;
           
      -- ==========================================================================
      -- AFFICHE  le chemin
      -- ==========================================================================
      procedure Print_Way (Position : in L_Node.Cursor) is
	 Current_Node : Node := Node_A(L_Node.Element(Position));
	 Previous_Node : Node;
      begin
	 -- Test si le Previous_Node existe
	 if L_Node.Has_Element(L_Node.Previous(Position)) then
	    Previous_Node := Node_A(L_Node.Element(L_Node.Previous(Position)));
	 elsif L_Node.Has_Element(L_Node.Next(Position)) then
	    -- Initialise la ligne si c'est le 1er element
	    Current_Line := Input_Graphe(Current_Node.Id,Node_A(L_Node.Element(L_Node.Next(Position))).id).Line;
	 end if;
	 
	 -- Affiche une correspondance
	 if Previous_Node.Station_Name = Current_Node.Station_Name  then
	    Put_Line(Integer'Image(Station_Nb-1) & " station(s)");
	    Put("changement a ");
	    Put(To_String(Previous_Node.Station_Name) &" (" & Integer'Image(Previous_Node.Id) & ") ligne " & To_String(Current_Line));
	    
	    --test l'existance de l'élement suivant et enregistre la ligne courante
	    if L_Node.Has_Element(L_Node.Next(Position)) then
	       Current_Line := Input_Graphe(Current_Node.Id,Node_A(L_Node.Element(L_Node.Next(Position))).id).Line;
	    end if;
	    
	    Put_Line(" --> " & " (" & Integer'Image(Current_Node.Id) & ") ligne " & To_String(Current_Line));
	    Station_Nb := 1;
	 end if;
	 Station_Nb := Station_Nb + 1;
	 
      end;
      -- ==========================================================================
      
   begin
      -- Renvoie dans Way les Id dans l'ordre du chemin le plus court
      Search_Way (Source.Id, Destination.Id, Previous_Node_List, Way);
      if Cost_Array(Destination.Id) /= Float'Last then
	 Put_Line("=============== Résultat ==============="); 
	 Put("Chemin le plus court entre ");
	 Put(To_String(Source.Station_Name) & " (" & Integer'Image(Source.Id) & ") et ");
	 Put_line(To_String(Destination.Station_Name) & " (" & Integer'Image(Destination.Id) & ") : ");
	 Put_Line("Depart : " & To_String(Source.Station_Name) & " (" & Integer'Image(Source.Id) & ")");
	 
	 
	 -- Affichage des correspondances
	 Way.Iterate(Print_Way'Access);
	 Put_Line(Integer'Image(Station_Nb) & " station(s)");   
      
	 Put_Line("Arrivée : " & To_String(Destination.Station_Name) & " (" & Integer'Image(Destination.Id) & ")" );
	 Put_Line("cout du chemin : " & Float'Image(Cost_Array(Destination.id)));
	 Put_Line("=======================================");
      else
	 Put_Line("=======================================");
	 Put_Line ("Aucun chemin trouvé");
	 Put_Line("=======================================");
      end if;
   end;
   -- ==========================================================================
   
   -- ==========================================================================
   -- Procédure pour libérer la mémoire
   -- ==========================================================================
   procedure Free_Memory(PGraphe : out P_Graphe; PNode_Array : out  P_Node_Array; PVertex_Array : out P_Vertex_Array) is
   begin
      Free_Node_Array(PNode_Array);
      Free_Vertex_Array(PVertex_Array);      
      if PGraphe /= null then
	 for I in PGraphe'Range loop
	    for K in PGraphe'Range loop
	       Free_P_Vertex(PGraphe(I,K));
	    end loop;
	 end loop;
	 Free_Graphe(PGraphe);
      end if;
   end;
   
end Package_Graphe;
