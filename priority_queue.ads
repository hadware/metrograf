
package Priority_Queue is

   -- Type de base
   type Queue is private

   --Initialisation de la file, en utilisant le nombre de noeud présent dans le grave (on a un injection des noeuds du graphe vers la file)
   function Init_Queue(Node_Number : Positive) return Queue;

   --Insertion d'un élément, son poids (ici la distance)
   procedure Insert_Element(Input_Queue : in out Queue; Element_Id : Natural ; Element_Priority : Float);

   --Récupération de l'élément le plus prioritaire : retourne l'Id du Noeud concerné
   function Get_Hight_Priority_Element(Input_Queue : in Queue) return Natural;

   --Supprime l'élément concerné par ID
   procedure Delete_Element(Input_Queue : in out Queue; Element_Id : Natural);

   --Affiche une liste de priorité
   procedure Print_Priority_List(Input_Queue : Queue);

private

   type Element is record
      Element_Id : Natural;
      Element_Priority : Float;
   end record;

   type Values is (Natural array<>) of Element;

   type Queue is record
      P_Values : access Values;
      Tail_Index : Positive; --indice de la première case vide
   end record;

   procedure Swap_Elements(Input_Queue : in out Queue; First_Element_Index : Positive; Second_Element_Index : Positive);

end package;
