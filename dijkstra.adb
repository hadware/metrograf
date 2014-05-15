with Ada.Containers.Doubly_Linked_Lists;
with Ada.Text_IO; use Ada.Text_Io;
package body Dijkstra is
   
   package Natural_List is new Ada.Containers.Doubly_Linked_Lists(Natural);
   use Natural_List;
   
   procedure Print_List(Input_List : Natural_List.List) is
      Curseur : Natural_List.Cursor;
      Compte : Positive := 1;
      procedure Print_Element(Curseur : Natural_List.Cursor) is
      begin
	 Put_Line("Element n°" & Integer'Image(Compte) & " : " & Integer'Image(Element(Curseur)));
	 Compte := Compte + 1;
      end;
   begin
      Input_List.Iterate(Print_Element'Access);
   end;
   
   
   procedure Insert_In_Sorted_List(Input_List :in out Natural_List.List; Distances : T_Cost_Array ; Element_Id : Natural) is
      Current_Element_Is_Bigger_Or_End : Boolean := False;
      Current_Element : Natural_List.Cursor;
   begin
      Put_Line("Chibre: Insertion d'un element" & Integer'Image(Element_Id));
      Print_List(Input_List);
      --vérification si l'élément existe déjà ou non
      Current_Element := Natural_List.Find(Input_List, Element_Id, Current_Element);
      
      if Current_Element /= No_Element then -- si l'élément est trouvé, on fait ca salement : on supprime puis on réinsère.
         Natural_List.Delete(Input_List, Current_Element);
      end if;
      
      Current_Element := Natural_List.First(Input_List);
      if Input_List /= Empty_List then
	 
	 -- On trouve l'élément qui a une distance tout juste plus grande que l'élément à insérer
	 while(Current_Element_Is_Bigger_Or_End) loop 
	    Natural_List.Next(Current_Element);
	    
	    -- On test si c'est la fin, si c'est pas la fin, on vérifie si l'élement courant est inférieur ou non
	    if Current_Element = Natural_List.No_Element then
	       Current_Element_Is_Bigger_Or_End := False;
	    else
	       Current_Element_Is_Bigger_Or_End := (Distances(Natural_List.Element(Current_Element)) < Distances(Element_Id));
	    end if;
	    
	 end loop;
	 Put_Line("penis");
	 
	 if Current_Element = Natural_List.No_Element then
	    Natural_List.Append(Input_List, Element_Id);
	 else
	    Natural_List.Insert(Input_List, Current_Element, Element_Id);   
	 end if;
	 
      else -- Si la liste est vide, on rajoute juste au début
	 
	 Natural_List.Append(Input_List, Element_Id);
	 
      end if;
   end;

   procedure Find_Connected_Nodes(Input_Graphe : Graphe; Source_Node_Id : Natural; Connected_Node_List : in out Natural_List.List) is

   begin

      for I in Input_Graphe'Range loop

         If Input_Graphe(Source_Node_Id, I) /= Null then
            Natural_List.Append(Connected_Node_List, I);
	    
         end if;

      end loop;

   end;


   -- Calcul le plus cours chemin d'un noeud source vers tout les autres noeuds du graphe
   procedure Dijkstra (Input_Graph: Graphe; Source_Id : Integer; Previous_Nodes : in out Node_Id_Array; Distances : in out T_Cost_Array) is
      Node_Number : Natural := Input_Graph'Length(1);
      Node_Queue : Natural_List.List;
      Current_Element : Natural_List.Cursor;

      

      Connected_Node_List : Natural_List.List;
      Cursor_Connected_List : Natural_List.Cursor;

      Buffer_Node_ID : Natural := 0;
   begin

      -- Initiatilisation de l'algo
      Distances(Source_Id) := 0.0 ;
      Natural_List.Append(Node_Queue, Source_Id);
      
      --
      while (Not(Natural_List.Is_Empty(Node_Queue))) loop
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- récupération de U
	 Put_Line("Buffer Node : " & Integer'Image(Buffer_Node_ID));
	 Put_Line("Etat de la file avant supression du Buffer Node : ");
	 Print_List(Node_Queue);
         Natural_List.Delete_First(Node_Queue);

         Connected_Node_List := Natural_List.Empty_List; -- Liste des noeuds connectés à U vidée avant
	 
         Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --récupération des node V connectées à U
         Put_Line("Nooeuds connected trouved :");
	 Print_List(Connected_Node_List);
	 Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on place le curseur sur la tête


         While (Cursor_Connected_List /= Natural_List.No_Element) loop

            -- Test du coût de la distance
            If Distances(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distances(Natural_List.Element(Cursor_Connected_List)) then
               
	       Distances(Natural_List.Element(Cursor_Connected_List)) := Distances(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
	       Put_Line("Ajout du noeud connecte a la liste : " & Integer'Image(Natural_List.Element(Cursor_Connected_List)));
	       Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
               
	       Previous_Nodes(Natural_List.Element(Cursor_Connected_List)) := Buffer_Node_ID; -- sauvegarde la node précédente
	       
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;

   end Dijkstra;

   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (Input_Graph : Graphe; Source : Node; Destination : Node; Input_Node_Array : P_Node_Array) is
      Node_Number : Natural := Input_Graph'Length(1);
      Distances : T_Cost_Array(1..Node_Number) := (others => Float'Last); --on met toutes les distances à l'infini
      Previous_Nodes : Node_Id_Array(1..Node_Number) := (others => 0);
   begin

      Dijkstra(Input_Graph, Source.Id, Previous_Nodes, Distances);

      --affichage du chemin
      Display_Path(Previous_Nodes, Distances, Source, Destination, Input_Node_Array, Input_Graph);
   End;
end;
