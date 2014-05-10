with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Doubly_Linked_Lists; use Ada.Containers.Doubly_Linked_Lists;
with GNAT.Regpat; use GNAT.Regpat;

package Parser is

   -- ==========================================================================
   -- Récupère le tableau des noeuds à partir du fichier source
   -- ==========================================================================
   function Parse_Nodes(Input_File : File_Type; Node_Number : Positive ) return Node_Array is

      Buffer_String : Unbounded_String;
      Output_Node_Array : Node_Array(1..Node_Number);

      --pour les expressions régulières
      Regexp_Node_Values : String := "[ ]*([0-9]*)[ ]+(.*)[ ]*"; -- pour matcher les lignes des noeuds
      Compiled_Regexp : Pattern_Matcher := Compile(Regexp_Node_Values); -- Précompilée pour ne le faire qu'une seule fois
      Matches : Match_Array(0..2); -- Tableau des bornes des chaines "matchées" dans la chaine cible
   begin

      Put_Line("Récupération des Noeuds...");

      --on positionne bien le curseur du fichier à la bonne ligne
      Set_Line(Input_File, 2);

      for i in Output_Node_Array'Range loop

         Buffer_String := To_Unbounded_String(Get_Line(Input_File));
         Match (Compiled_Regexp, To_String(Buffer_String), Matches);
         Output_Node_Array(i).Id := Integer'Value(Slice(Buffer_String, Matches(1).First, Matches(1).Last));
         Output_Node_Array(i).Station_Name := Slice(Buffer_String, Matches(2).First, Matches(2).Last);

      end loop;

      return Output_Node_Array;
   end;
   -- ==========================================================================


   -- ==========================================================================
   --Récupère le tableau des arrêtes à partir du fichier source
   -- ==========================================================================
   function Parse_Vertices(Input_File : File_Type; Vertex_Number : Positive; Node_Number : Positive) return Vertex_Array is

      Buffer_String : Unbounded_String;
      Output_Vertex_Array : Vertex_Array(1..Vertex_Number);

      --pour les expressions régulières
      Regexp_Vertex_Value : String := "[ ]*([0-9]*)[ ]+([0-9]*)[ ]+([0-9]*\.?[0-9]*)[ ]+(.*)[ ]*"; -- pour matcher les lignes des vertices
      Compiled_Regexp : Pattern_Matcher := Compile(Regexp_Vertex_Value); -- Précompilée pour ne le faire qu'une seule fois
      Matches : Match_Array(0..4); -- Tableau des bornes des chaines "matchées" dans la chaine cible

   begin

      Put_Line("Récupération des Arêtes...");

       --on positionne bien le curseur du fichier à la bonne ligne
      Set_Line(Input_File, 1 + Node_Number);

      for i in Output_Node_Array'Range loop

         Buffer_String := To_Unbounded_String(Get_Line(Input_File));
         Match (Compiled_Regexp, To_String(Buffer_String), Matches);
         Output_Vertex_Array(i).Source := Integer'Value(Slice(Buffer_String, Matches(1).First, Matches(1).Last));
         Output_Vertex_Array(i).Destination := Integer'Value(Slice(Buffer_String, Matches(2).First, Matches(2).Last));
         Output_Vertex_Array(i).Cost := Float'Value(Slice(Buffer_String, Matches(3).First, Matches(3).Last));
         Output_Vertex_Array(i).Line := Slice(Buffer_String, Matches(4).First, Matches(4).Last);

      end loop;

      return Output_Vertex_Array;

   end;
   -- ==========================================================================


   -- ==========================================================================
   -- Construit le graphe à partir du tableau des arètes et du tableau de noeuds
   -- ==========================================================================
   function Construct_Graph(Filename : String) return Graphe is

      Regexp_Line_Count  : String := "[ ]*([0-9]*)[ ]+([0-9]*)[ ]*"; --pour matcher les données au début
      Matches : Match_Array(0..2); -- Tableau des bornes des chaines "matchées" dans la chaine cible
   begin

      --ouverture du fichier, récupération de la 1ère ligne contenant les nombres de noeuds/arêtes
      Open(File => Source_File, Mode => In_File, Name => Nom_Fichier);
      Buffer_String := To_Unbounded_String(Get_Line(Source_File));



   end;
   -- ==========================================================================


end;
