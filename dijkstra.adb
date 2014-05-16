with Ada.Containers.Doubly_Linked_Lists;
with Ada.Text_IO; use Ada.Text_Io;
package body Dijkstra is
   
   package Natural_List is new Ada.Containers.Doubly_Linked_Lists(Natural);
   use Natural_List;
   
   -- ==========================================================================
   -- DEBUG : Affichage d'une liste d'Id de noeuds (Naturels)
   -- ==========================================================================
   procedure Print_List(Input_List : Natural_List.List) is
      Curseur : Natural_List.Cursor;
      Compte : Positive := 1;
      procedure Print_Element(Curseur : Natural_List.Cursor) is
      begin
	 Put_Line("Element n�" & Integer'Image(Compte) & " : " & Integer'Image(Element(Curseur)));
	 Compte := Compte + 1;
      end;
   begin
      Input_List.Iterate(Print_Element'Access);
   end;
   -- ==========================================================================
   
   -- ==========================================================================
   -- Ins�re un �l�ment dans une file de priorit� d�j� tri�e, v�rifie si l'�l�ment n'existe pas d�j� et change sa priorit� si c'est le cas
   -- ==========================================================================
   procedure Insert_In_Sorted_List(Input_List :in out Natural_List.List; Distances : T_Cost_Array ; Element_Id : Natural) is
      Current_Element_Is_Bigger_Or_End : Boolean := False;
      Current_Element : Natural_List.Cursor;
   begin
      
      --v�rification si l'�l�ment existe d�j� ou non
      Current_Element := Natural_List.Find(Input_List, Element_Id, Current_Element);
      
      if Current_Element /= No_Element then -- si l'�l�ment est trouv�, on fait ca salement : on supprime puis on r�ins�re.
         Natural_List.Delete(Input_List, Current_Element);
      end if;
      
      Current_Element := Natural_List.First(Input_List);
      if Input_List /= Empty_List then
	 
	 -- On trouve l'�l�ment qui a une distance tout juste plus grande que l'�l�ment � ins�rer
	 while(Current_Element_Is_Bigger_Or_End) loop 
	    Natural_List.Next(Current_Element);
	    
	    -- On test si c'est la fin, si c'est pas la fin, on v�rifie si l'�lement courant est inf�rieur ou non
	    if Current_Element = Natural_List.No_Element then
	       Current_Element_Is_Bigger_Or_End := False;
	    else
	       Current_Element_Is_Bigger_Or_End := (Distances(Natural_List.Element(Current_Element)) < Distances(Element_Id));
	    end if;
	    
	 end loop;
	 	 
	 if Current_Element = Natural_List.No_Element then
	    Natural_List.Append(Input_List, Element_Id);
	 else
	    Natural_List.Insert(Input_List, Current_Element, Element_Id);   
	 end if;
	 
      else -- Si la liste est vide, on rajoute juste au d�but
	 
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
   -- ==========================================================================

   -- ==========================================================================
   -- Calcul le plus cours chemin d'un noeud source vers tout les autres noeuds du graphe
   -- ==========================================================================
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
         Buffer_Node_ID := Natural_List.First_Element(Node_Queue); -- r�cup�ration de U
	 Natural_List.Delete_First(Node_Queue);
	 
	 Connected_Node_List := Natural_List.Empty_List; -- Liste des noeuds connect�s � U vid�e avant
	 Find_Connected_Nodes(Input_Graph, Buffer_Node_ID, Connected_Node_List); --r�cup�ration des node V connect�es � U
	 Cursor_Connected_List := Natural_List.First(Connected_Node_List); -- on place le curseur sur la t�te

         While (Cursor_Connected_List /= Natural_List.No_Element) loop

            -- Test du co�t de la distance
            If Distances(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost < Distances(Natural_List.Element(Cursor_Connected_List)) then
               
	       Distances(Natural_List.Element(Cursor_Connected_List)) := Distances(Buffer_Node_ID) + Input_Graph(Buffer_Node_ID, Natural_List.Element(Cursor_Connected_List)).Cost;
	       
	       Insert_In_Sorted_List(Node_Queue, Distances, Natural_List.Element(Cursor_Connected_List));
               
	       Previous_Nodes(Natural_List.Element(Cursor_Connected_List)) := Buffer_Node_ID; -- sauvegarde la node pr�c�dente
	       
            end if;
            Natural_List.Next(Cursor_Connected_List); --on fait avancer le curseur

         end loop;


      end loop;

   end Dijkstra;
   -- ==========================================================================
   
   -- ==========================================================================
   -- Affiche le chemin le plus court entre 2 noeuds, en utilisant l'algorithme de dijkstra
   -- ==========================================================================
   procedure AffichageDijkstra (Input_Graph : Graphe; Source : Node; Destination : Node; Input_Node_Array : P_Node_Array) is
      Node_Number : Natural := Input_Graph'Length(1);
      Distances : T_Cost_Array(1..Node_Number) := (others => Float'Last); --on met toutes les distances � l'infini
      Previous_Nodes : Node_Id_Array(1..Node_Number) := (others => 0);
   begin

      Dijkstra(Input_Graph, Source.Id, Previous_Nodes, Distances);

      --affichage du chemin
      Display_Path(Previous_Nodes, Distances, Source, Destination, Input_Node_Array, Input_Graph);
   End;
   -- ==========================================================================
end;
