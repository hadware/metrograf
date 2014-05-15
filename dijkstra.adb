with Ada.Containers.Doubly_Linked_Lists;


package body Dijkstra is

   package Natural_List is new Ada.Containers.Doubly_Linked_Lists(Natural);



   procedure Insert_In_Sorted_List(Input_List :in out Natural_List.List; Distances : T_Cost_Array ; Element_Id : Natural) is

      Cursor : Natural_List.Cursor;
   begin

      --v�rification si l'�l�ment existe d�j� ou non
         Cursor := Natural_List.Find(Input_List, Element_Id, Cursor);
      if Cursor /= Natural_List.No_Element then -- si l'�l�ment est trouv�, on fait ca salement : on supprime puis on r�ins�re.
         Natural_List.Delete(Input_List, Cursor);
      end if;

      Cursor := Natural_List.First(Input_List);
      While(Natural_List.Element(Cursor) < Distances(Element_Id)) loop -- On trouve l'�l�ment qui a une distance tout juste plus grande que l'�l�ment � ins�rer
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
   function Dijkstra (Input_Graph: Graphe; Source_Id : Integer) return T_Cost_Array is
      Node_Number : Natural := Input_Graph'Length(1);
      Node_Queue : Natural_List.List;
      Cursor : Natural_List.Cursor;
      Distances : T_Cost_Array(Input_Graph'Range(1)) := (others => Float'Last); --on met toutes les distances � l'infini

      Connected_Node_List : Natural_List.List;
      Cursor_Connected_List : Natural_List.Cursor;

      Buffer_Node_ID : Natural := 0;
   begin

      -- Initiatilisation de l'algo
      Distance(Source_Id) := 0.0 ;
      Natural_List.Append(Node_Queue, Source_Id);

      --
      while (Not(Natural_List.Is_Empty(Node_Queue))) loop
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- r�cup�ration de U
         Natural_List.Delete_First(Node_Queue);

         Natural_List.Empty_List(Connected_Node_List); -- Liste des noeuds connect�s � U vid�e avant
         Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --r�cup�ration des node V connect�es � U
         Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on lace le curseur sur la t�te


         While (Cursor_Connected_List /= No_Element) loop

            -- Test du co�t de la distance
            If Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distance(Natural_List.Element(Cursor_Connected_List)) then
               Distance(Natural_List.Element(Cursor_Connected_List)) := Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
               Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;


   end Dijkstra;

   -- Affiche le chemin le plus court entre 2 noeuds
   procedure AffichageDijkstra (Input_Graph : Graphe; Source : Node; Destination : Node; Input_Node_Array : P_Node_Array) is
      Node_Number : Natural := Input_Graph'Length(1);
      Node_Queue : Natural_List.List;
      Cursor : Natural_List.Cursor;
      Distances : T_Cost_Array(Input_Graph'Range(1)) := (others => Float'Last); --on met toutes les distances � l'infini

      Connected_Node_List : Natural_List.List;
      Cursor_Connected_List : Natural_List.Cursor;

      Previous_Nodes : Node_Id_Array(1..Node_Number) := (others => 0);

      Buffer_Node_ID : Natural := 0;
      Source_Id : Natural := Source.Id;

   begin

      -- Initiatilisation de l'algo
      Distance(Source_Id) := 0.0 ;
      Natural_List.Append(Node_Queue, Source_Id);

      --
      while (Not(Natural_List.Is_Empty(Node_Queue))) loop
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- r�cup�ration de U
         Natural_List.Delete_First(Node_Queue);

         Natural_List.Empty_List(Connected_Node_List); -- Liste des noeuds connect�s � U vid�e avant
         Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --r�cup�ration des node V connect�es � U
         Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on lace le curseur sur la t�te


         While (Cursor_Connected_List /= No_Element) loop

            -- Test du co�t de la distance
            If Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distance(Natural_List.Element(Cursor_Connected_List)) then
               Distance(Natural_List.Element(Cursor_Connected_List)) := Distance(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
               Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
               Previous_Nodes(Natural_List.Element(Cursor_Connected_List)) := Buffer_Node_ID; -- sauvegarde la node pr�c�dente
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;

      --affichage du chemin
      Display_Path(Previous_Nodes, Distances, Source, Destination, Input_Node_Array,
end;
