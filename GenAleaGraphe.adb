with Ada.Integer_Text_Io,Ada.Float_Text_Io,Ada.Text_Io;
with Ada.Numerics.Discrete_Random;
use Ada.Integer_Text_Io,Ada.Float_Text_Io,Ada.Text_Io;

procedure GenAleaGraphe is
	N, M : Integer; -- Nombres de noeuds et d'arcs désirés
	M2 : Integer := 0; -- Nombre d'arcs effectif
	
	type Arc;
	type L_Arc is access Arc;
	type Arc is record
		I, J : Integer; -- Ids des noeuds source et destination d'un arc
		Cout : Float; -- Coût de l'arc
		Suiv : L_Arc; -- Arc suivant dans la liste
	end record;
	
	Arcs_Crees : L_Arc;
	
	procedure GenNbAlea(N, M : in Integer; M2 : out Integer; Les_Arcs : out L_Arc) is
		subtype Intervalle is Integer range 0..(N*(N-1)-1); -- N^2 - N arcs possibles, car on n'autorise pas les arcs pour lesquels source = destination
		package Aleatoire is new Ada.Numerics.Discrete_Random(Intervalle);
		use Aleatoire;
		Tirage : Integer;
		Generateur : Generator;
	begin
		Reset(Generateur);
		M2 := 0;
		Les_Arcs := null;
		-- On parcourt tous les arcs possibles
		for I in 0..N-1 loop
			for J in 0..N-1 loop
				if I /= J then -- On n'autorise pas les arcs pour lesquels source = destination
					Tirage := Random(Generateur);
					if Tirage < M then
						Les_Arcs := new Arc'(I,J,Float(Tirage)/Float(M),Les_Arcs);
						-- Le coût associé à l'arc est déterminé à partir du tirage aléatoire, et est ramené sur [0,1]
						M2 := M2+1;
					end if;
				end if;
			end loop;
		end loop;
	end GenNbAlea;
	
	Fichier : File_type;

begin
	Put("Entrez le nombre de noeuds du graphe : ");
	Get(N);
	Put("Entrez le nombre désiré d'arcs du graphe : ");
	Get(M);
	Put_Line("Attention, le nombre d'arcs créés sera peut-être légèrement différent de" & Integer'Image(M));
	
	GenNbAlea(N,M,M2,Arcs_Crees);
	Put_Line("Le nombre d'arcs du graphe est de" & Integer'Image(M2));
	
	-- Parcours de la liste des arcs créés et création du fichier alea.graph
	Create(Fichier,Out_File,"alea.graph");
	Put_Line(Fichier,Integer'Image(N) & ' ' & Integer'Image(M2));
	for I in 0..N-1 loop
		Put_Line(Fichier,Integer'Image(I) & " ALEA");
	end loop;
	while (Arcs_Crees /= null) loop
		Put_Line(Fichier,Integer'Image(Arcs_Crees.I) & ' ' & Integer'Image(Arcs_Crees.J) & ' ' & Float'Image(Arcs_Crees.Cout));
		Arcs_Crees := Arcs_Crees.Suiv;
	end loop;
	Close(Fichier);
	
	Put_Line("Fichier alea.graph créé, c'est terminé !");
end GenAleaGraphe;
