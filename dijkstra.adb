with Ada.Containers.Doubly_Linked_Lists;


package body Dijkstra is

   package Natural_List is new Ada.Containers.Doubly_Linked_Lists(Natural);


   function Find_Closest_Element_In_Queue( Input_List : Natural_List.List; Distances : Distance_Array) return Natural is

      ---package Float_List is new Ada.Containers.Doubly_Linked_Lists(Float);

      Position : Natural_List.Cursor ;
      Closest_Element_Id : Natural := Natural_List.First_Element(Input_List);

      procedure Find_Closest_Element(Position : in Natural_List.Cursor) is
      begin

         -- Si la distance de l'élément courant est inférieure à plus petite distances des éléments déjà parcouru, alors on change, sinon rien
         if Distances(Natural_List.Element(Position)) < Distances(Closest_Element_Id) then
            Closest_Element_Id := Distances(Natural_List.Element(Position));
         end if;

      end;

   begin

      Natural_List.Iterate(Input_List, Find_Closest_Element'Access);
      return Closest_Element_Id;
   end;

   procedure Insert_In_Sorted_List(Input_List :in out Natural_List.List; Distances : Distance_Array ; Element_Id : Natural) is

      Cursor : Natural_List.Cursor;
   begin

      --vérification si l'élément existe déjà ou non
         Cursor := Natural_List.Find(Input_List, Element_Id, Cursor);
      if Cursor /= Natural_List.No_Element then -- si l'élément est trouvé, on fait ca salement : on supprime puis on réinsère.
         Natural_List.Delete(Input_List, Cursor);
      end if;

      Cursor := Natural_List.First(Input_List);
      While(Natural_List.Element(Cursor) < Distances(Element_Id)) loop -- On trouve l'élément qui a une distance tout juste plus grande que l'élément à insérer
            Natural_List.Next(Cursor);
      end loop;
      Natural_List.Insert(Input_List, Cursor, Element_Id);

   end;

   procedure Find_Connected_Nodes(Input_Graphe : Graphe; Source_Node_Id : Natural; Connected_Node_List : in out Natural_List.List) is

   begin

      for I in Graphe'Range(1) loop

         If Graphe(Source_Node_Id, I) /= Null then
            Natural_List.Append(Connected_Node_List, I);
         end if;

      end loop;

   end;


   -- Calcul le plus cours chemin d'un noeud source vers tout les autres noeuds du graphe
   function Dijkstra (Input_Graph: Graphe; Source_Id : Integer) return Distance_Array is
      Node_Number : Natural := Input_Graph'Length(1);
      Node_Queue : Natural_List.List;
      Cursor : Natural_List.Cursor;
      Distances : Distance_Array(Input_Graph'Range(1)) := (others => Float'Last); --on met toutes les distances à l'infini

      Connected_Node_List : Natural_List.List;
      Cursor_Connected_List : Natural_List.Cursor;

      Buffer_Node_ID : Natural := 0;
   begin

      -- Initiatilisation de l'algo
      Distance(Source_Id) := 0.0 ;
      Natural_List.Append(Node_Queue, Source_Id);

      --
      while (Not(Natural_List.Is_Empty(Node_Queue))) loop
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- récupération de U
         Natural_List.Delete_First(Node_Queue);

         Natural_List.Empty_List(Connected_Node_List); -- Liste des noeuds connectés à U vidée avant
         Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --récupération des node V connectées à U
         Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on lace le curseur sur la tête


         While (Cursor_Connected_List /= No_Element) loop

            -- Test du coût de la distance
            If Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distance(Natural_List.Element(Cursor_Connected_List)) then
               Distance(Natural_List.Element(Cursor_Connected_List)) := Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
               Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;


   end Dijkstra;

   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (G: Graphe; Source : Node; Destination : Node) is
      Node_Number : Natural := Input_Graph'Length(1);
      Node_Queue : Natural_List.List;
      Cursor : Natural_List.Cursor;
      Distances : Distance_Array(Input_Graph'Range(1)) := (others => Float'Last); --on met toutes les distances à l'infini

      Connected_Node_List : Natural_List.List;
      Cursor_Connected_List : Natural_List.Cursor;

      Previous_Nodes : array (1..Node_Number) of Natural := (others => 0);

      Buffer_Node_ID : Natural := 0;
   begin

      -- Initiatilisation de l'algo
      Distance(Source_Id) := 0.0 ;
      Natural_List.Append(Node_Queue, Source_Id);

      --
      while (Not(Natural_List.Is_Empty(Node_Queue))) loop
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- récupération de U
         Natural_List.Delete_First(Node_Queue);

         Natural_List.Empty_List(Connected_Node_List); -- Liste des noeuds connectés à U vidée avant
         Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --récupération des node V connectées à U
         Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on lace le curseur sur la tête


         While (Cursor_Connected_List /= No_Element) loop

            -- Test du coût de la distance
            If Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distance(Natural_List.Element(Cursor_Connected_List)) then
               Distance(Natural_List.Element(Cursor_Connected_List)) := Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
               Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
               Previous_Nodes(Natural_List.Element(Cursor_Connected_List)) := Buffer_Node_ID;
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;


end;
