with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Doubly_Linked_Lists;
with GNAT.Regpat; use GNAT.Regpat;
with GNAT.String_Split;
use GNAT;

package body Parser is
   
   -- ==========================================================================
   -- Compte le nombre d'arguments dans une chaine donnée en splittant par rapport aux espaces
   -- ==========================================================================
   function Argument_Count(Input_String : String) return Natural is
      Slices : String_Split.Slice_Set;   
   begin
      String_Split.Create (S => Slices,
                           From => Input_String,
                           Separators => " ",
                           Mode       => String_Split.Multiple);
      return Natural(String_Split.Slice_Count(Slices));
   end;
   -- ==========================================================================
   
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
         --Put_Line(To_String(Buffer_String));
         Match (Compiled_Regexp, To_String(Buffer_String), Matches);
         --Put_Line("Début : " & Integer'Image(Matches(1).First) & " fin : " & Integer'Image(Matches(1).Last));
         --Put_Line(Integer'Image(Output_Node_Array(1).Station_Name);
         Output_Node_Array(i).Id := Integer'Value(Slice(Buffer_String, Matches(1).First, Matches(1).Last)) + 1;
         Output_Node_Array(i).Station_Name := To_Unbounded_String(Slice(Buffer_String, Matches(2).First, Matches(2).Last));
         Put_Line(" Nom de station : " &  To_String(Output_Node_Array(i).Station_Name) & ", noeud n° " & Integer'Image(Output_Node_Array(i).Id));

      end loop;

      return Output_Node_Array;
   end;
   -- ==========================================================================


   -- ==========================================================================
   --Récupère le tableau des arrêtes à partir du fichier source
   -- ==========================================================================
   function Parse_Vertices(Input_File : File_Type; Vertex_Number : Positive; Node_Number : Natural) return Vertex_Array is

      Buffer_String : Unbounded_String;
      Output_Vertex_Array : Vertex_Array(1..Vertex_Number);

      --pour les expressions régulières
      Regexp_Vertex_Value : String := "[ ]*([0-9]*)[ ]+([0-9]*)[ ]+([0-9]*\.?[0-9eE+-]*)[ ]+(.*)[ ]*"; -- pour matcher les lignes des vertices
      Compiled_Regexp : Pattern_Matcher := Compile(Regexp_Vertex_Value); -- Précompilée pour ne le faire qu'une seule fois
      Matches : Match_Array(0..4); -- Tableau des bornes des chaines "matchées" dans la chaine cible
      
      Regexp_Vertex_No_Line : String := "[ ]*([0-9]*)[ ]+([0-9]*)[ ]+([0-9]*\.?[0-9eE+-]*)[ ]*"; --si il n'y a que 3 arguments (pas de ligne de traim/metro)
      Compiled_No_Line_Regexp : Pattern_Matcher := Compile(Regexp_Vertex_No_Line);
      Matches_No_Line : Match_Array(0..3);
   begin

      Put_Line("Récupération des Arêtes...");

      
      for i in Output_Vertex_Array'Range loop
	 
         Buffer_String := To_Unbounded_String(Get_Line(Input_File));
         if Argument_Count(To_String(Buffer_String)) = 4 then 
	    
	    Match (Compiled_Regexp, To_String(Buffer_String), Matches);
	    Output_Vertex_Array(i).Source := Integer'Value(Slice(Buffer_String, Matches(1).First, Matches(1).Last)) + 1;
	    Output_Vertex_Array(i).Destination := Integer'Value(Slice(Buffer_String, Matches(2).First, Matches(2).Last)) + 1;
	    Output_Vertex_Array(i).Cost := Float'Value(Slice(Buffer_String, Matches(3).First, Matches(3).Last));
	    Output_Vertex_Array(i).Line := To_Unbounded_String(Slice(Buffer_String, Matches(4).First, Matches(4).Last));
	    Put_Line("Arête trouvée, de " & Integer'Image(Output_Vertex_Array(i).Source) & " à " & Integer'Image(Output_Vertex_Array(i).Destination)& ", distance " & Float'Image(Output_Vertex_Array(i).Cost)  & ", ligne " & To_String(Output_Vertex_Array(i).Line));
	    
	 else
	    
	    Match (Compiled_No_Line_Regexp, To_String(Buffer_String), Matches_No_Line);
	    Output_Vertex_Array(i).Source := Integer'Value(Slice(Buffer_String, Matches_No_Line(1).First, Matches_No_Line(1).Last)) + 1;
	    Output_Vertex_Array(i).Destination := Integer'Value(Slice(Buffer_String, Matches_No_Line(2).First, Matches_No_Line(2).Last)) + 1;
	    Output_Vertex_Array(i).Cost := Float'Value(Slice(Buffer_String, Matches_No_Line(3).First, Matches_No_Line(3).Last));
	    Put_Line("Arête trouvée, de " & Integer'Image(Output_Vertex_Array(i).Source) & " à " & Integer'Image(Output_Vertex_Array(i).Destination)& ", distance " & Float'Image(Output_Vertex_Array(i).Cost)  & ", ligne : Aucune ligne trouvée");
	 end if;
	 
      end loop;

      return Output_Vertex_Array;

   end;
   -- ==========================================================================


   -- ==========================================================================
   -- Construit le graphe à partir du tableau des arètes et du tableau de noeuds
   -- ==========================================================================
   procedure Construct_Graph(Source_File : File_Type; Input_Graphe : in out P_Graphe; Input_Node_array : P_Node_Array; Input_Vertex_Array : P_Vertex_Array) is

      Node_Number : Positive := Input_Graphe.all'Length;
      Vertex_Number : Positive := Input_Vertex_Array.all'Length;
      Buffer_Vertex_Array : Vertex_Array(1..Vertex_Number) := Input_Vertex_Array.all; --copie du tableau pointé... impossible de faire un pointeur vers une valeur du tableau pointé

   begin

      Put_Line("Construction du graphe à partir des données...");

      for i in 1..Vertex_Number loop
         Input_Graphe(Input_Vertex_Array(i).Source, Input_Vertex_Array(i).Destination) := new Vertex;
         Input_Graphe(Input_Vertex_Array(i).Source, Input_Vertex_Array(i).Destination).all := Buffer_Vertex_Array(i);
      end loop;

   end;
   -- ==========================================================================

   -- ==========================================================================
   -- Charge un graphe à partir d'un fichier
   -- ==========================================================================
   procedure Load_Graph_From_File(Filename : String; Output_Graph : in out P_Graphe; Output_Node_Array : in out P_Node_Array; Output_Vertex_array : in out P_Vertex_Array) is

      Buffer_String : Unbounded_String;
      Source_File : File_Type;

      --pour l'expression régulière qui récupère le les données de la première libre
      Regexp_Line_Count  : String := "[ ]*([0-9]*)[ ]+([0-9]*)[ ]*"; --pour matcher les données de la 1ère ligne
      Matches : Match_Array(0..2); -- Tableau des bornes des chaines "matchées" dans la chaine cible

      Node_Number : Natural;
      Vertex_Number : Natural;

   begin

      --ouverture du fichier, récupération de la 1ère ligne contenant les nombres de noeuds/arètes
      Open(File => Source_File, Mode => In_File, Name => Filename);
      Buffer_String := To_Unbounded_String(Get_Line(Source_File));

      --récupération du nombre de noeuds/arêtes à partir de la première ligne
      Match (Compile(Regexp_Line_Count), To_String(Buffer_String), Matches);
      Node_Number := Integer'Value(Slice(Buffer_String, Matches(1).First, Matches(1).Last));
      Vertex_Number := Integer'Value(Slice(Buffer_String, Matches(2).First, Matches(2).Last));
      Put_Line("Le graphe contient " & Natural'Image(Node_Number) & " noeuds et " & Natural'Image(Vertex_Number) & " arètes");

      --Instanciation des tableaux de stockage nécessaires
      Output_Graph := new Graphe(1..Node_Number, 1..Node_Number);
      Output_Node_Array := new Node_Array(1..Node_Number);
      Output_Vertex_Array := new Vertex_Array(1..Vertex_Number);

      --initialisation "propre" du graphe
      for i in 1..Node_Number loop
         for j in 1..Node_Number loop
            Output_Graph(i,j) := null;
         end loop;
      end loop;


      --Récupération à partir du fichier des valeurs des noeuds et des arètes
      Output_Node_Array.all := Parse_Nodes(Source_File, Node_Number);
      Output_Vertex_Array.all := Parse_Vertices(Source_File, Vertex_Number, Node_Number);

      --Construction du graphe à partir des donnéees récupérées
      Construct_Graph(Source_File, Output_Graph, Output_Node_Array, Output_Vertex_Array);

      --fermeture du fichier
      Close(Source_File);

   end;
   -- ==========================================================================
   
end;
