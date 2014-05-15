

--implémentation d'une file d'attente
package body Priority_Queue is

   function Get_Father(Index : Positive) return Positive is
   begin
      return Index / 2;
   end;

   --Renvoie l'indice du plus grand fils. S'il n'existe pas de fils, la fonction renvoie 0
   function Get_Max_Son(Input_Queue : Queue; Father_Index : Natural) return Integer is
      Left_Son_Index := Father_Index * 2;
      Right_Son_Index := Father_Index * 2 + 1;
   begin

      if Left_Son_Index >= Queue.Tail_Index then
         return 0;
      elsif Right_Son_Index >= Queue.Tail_Index then
         return Left_Son_Id;
      else
         If Input_Queue.P_Values(Left_Son_Index).Element_Priority > Input_Queue.P_Values(Right_Son_Index).Element_Priority then
            return Left_Son_Index;
         else
            return Right_Son_Index;
         end if;
      end if;

   end;


   --Initialisation de la file, en utilisant le nombre de noeud présent dans le grave (on a un injection des noeuds du graphe vers la file)
   function Init_Queue(Node_Number : Positive) return Queue is

   Output_Queue : Queue;

   begin

      Output_Queue.P_Values := new Values(1..Node_Number);
      Output_Queue.Tail_Index := 1;

      return Output_Queue;
   end;

   -- Renvoie 0 si l'élément n'est pas trouvé, sinon sa position (son index)
   function Element_Exists(Input_Queue : Queue; Element_Id : Positive) return Integer is
      Position : Integer := 0;
   begin

      For i in (1..(Input_Queue.Tail_Index - 1)) loop
         if Input_Queue.P_Values(i) := Element_Id then
            Position := i;
            -- J'aurai bien break la loop mais apparemment c'est impossible
         end if;
      end loop;

      return Position;
   end;

   --Insertion d'un élément, son poids (ici la distance)
   procedure Insert_Element(Input_Queue : in out Queue; Element_Id : Natural ; Element_Priority : Float) is

      Current_Index : Positive;
      Input_Element : Element;
      Position_If_Already_There : Integer;

   begin
      --Si La file est vide
      if Input_Queue.Tail_Index := 1 then
         nput_Element.Element_Id := Element_Id;
         Input_Element.Element_Priority := Element_Priority;
         Input_Queue.P_Values(Input_Queue.Tail_Index) := Input_Element; --rajout de l'élément à la fin de la file
         Input_Queue.Tail_Index := Input_Queue.Tail_Index + 1; --on oublie pas d'incrémenter la position de la queue

      else -- si la file comporte au moins 1 élement

         Position_If_Already_There := Element_Exists(Element_Id);
         if Position_If_Already_There = 0 then --si l'élément n'a pas été trouvé dans le tableau, insertion standard

            Input_Element.Element_Id := Element_Id;
            Input_Element.Element_Priority := Element_Priority;
            Input_Queue.P_Values(Input_Queue.Tail_Index) := Input_Element; --rajout de l'élément à la fin de la file
            Current_Index := Input_Queue.Tail_Index ; --on fait "pointer" l'index de travail sur le dernier élément
            Input_Queue.Tail_Index := Input_Queue.Tail_Index + 1; --on oublie pas d'incrémenter la position de la queue

         else

            Current_Index := Position_If_Already_There;
            Input_Queue.P_Values(Input_Queue.Tail_Index).Element_Priority := Element_Priority;

         end if;

         while (Input_Queue.P_Values(Get_Father(Current_Index)).Element_Priority > Input_Queue.P_Values(Current_Index).Element_Priority)  or ( Current_Index /= 1 ) loop

            Swap_Elements(Input_Queue, Get_Father(Current_Index)), Current_Index);
            Current_Index := Get_Father(Current_Index);

         end loop;

      end if;

   end;

   --Récupération de l'élément le plus prioritaire : retourne l'Id du Noeud concerné
   function Get_Hight_Priority_Element(Input_Queue : in Queue) return Natural is
   begin

      return Input_Queue.P_Values(1).Element_Id;

   end;

   --Supprime l'élément concerné par ID
   procedure Delete_Element(Input_Queue : in out Queue; Element_Id : Natural) is

      Position_If_Already_There : Integer;
      Current_Index : Integer;

   begin
      if Input_Queue.Tail_Index := 2 then

         Input_Queue.Tail_Index := 1

      else

         Position_If_Already_There := Element_Exists;
         Input_Queue.Tail_Index := Input_Queue.Tail_Index - 1;
         if Position_If_Already_There /= 0 then
            Swap(
            Current_Index := Position_If_Already_There;
            While Get_Max_Son(Current_Index); /= 0 loop
               Swap_Elements(Input_Queue,

            end loop;

         end if;

      end if;

   end;

   procedure Swap_Elements(Input_Queue : in out Queue; First_Element_Index : Positive; Second_Element_Index : Positive) is
      Buffer_Element : Element;
   begin
      Buffer_Element := Input_Queue.P_Values(First_Element_Index);
      Input_Queue.P_Values(First_Element_Index) := Input_Queue.P_Values(Second_Element_Index);
      Input_Queue.P_Values(Second_Element_Index) := Buffer_Element;
   end;

end package;
