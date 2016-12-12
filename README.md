# Signal




# Introduction

Dans le cadre du cours de traitement numérique de l’image, nous avons eu à
réaliser un projet “vision par ordinateur”. Ce projet avait pour but de nous faire
intégrer une image dans une vidéo avec des contraintes de placements à chaque
instant et de mouvement afin de nous faire découvrir par la pratique l’utilité et
l’utilisation du traitement de l’image. Ce rapport sera l’occasion pour nous
d’expliquer la démarche algorithmique que nous avons mis en oeuvre pour
répondre à cette problématique. Nous détaillerons également l'implémentation de
ces algorithmes, que nous avons fait grâce au logiciel et langage Matlab en suivant
les consignes du sujet.

La vidéo qui servait de base à notre expérimentation dure une dizaine de
secondes. Il y a une table et une feuille blanche possédant des picots bleus à ses
quatre coins. Une main bouge ensuite la feuille de manière aléatoire sur la table. La
feuille reste tout de même à tout moment visible dans la vidéo. Le but du projet était
donc de réussir à “modéliser” la feuille blanche à chaque instant pour y insérer une
image qui la recouvre et épouse ses contours. Un palier supplémentaire au projet
consistait à faire en sorte que la main ne soit pas recouverte par l’image ajoutée.

# I) Démarche algorithmique

## 1) Initialisation

Pour réussir à modéliser la feuille blanche en chaque instant dans la vidéo, il
faut tout d’abord réussir à identifier les limites et les coins de notre image. Pour cela
on va s’aider des points bleu présents aux quatres coins de notre feuille. L’avantage
de ces points est que leur couleur (le bleu) semble assez éloigné des autres couleurs
présentes dans l’image. On peut appliquer un modèle colorimétrique de picot sur
ces points bleus. Le modèle colorimétrique de picot nous permet, en lui fournissant
une zone d’intérêt, de retourner la moyenne et la covariance des 3 composantes
(rouge vert et bleu) de la zone d’intérêt. Ici notre zone d’intérêt est tout
naturellement un des quatres points bleus.



Image extrait de la vidéo, représentation des points bleus
Grâce à ce modèle de picot, nous pouvons connaître la population
moyenne et la covariance des pixels présents dans un des points bleus.

## 2) Traitement et incrustation

Nous pouvons ensuite calculer la distance de mahalanobis de chaque point
de notre image par rapport à notre moyenne et notre covariance pour avoir le
degré de “similitude colorimétrique” du pixel avec le point bleu.
Nous pouvons ensuite appliquer un seuil sur chaque pixel, que nous avons
établi après plusieurs itérations successives. Si le point est inférieur au seuil alors il est
assez proche de la moyenne des pixels appartenant a un point bleu pour être
considéré comme un pixel bleu au contraire s’il est supérieur au seuil, alors il ne peut
pas être considéré comme un pixel bleu car son écart avec le modèle établi plus
tôt est trop importante.

Nous avons donc créé une nouvelle matrice binaire, cette fois avec :

• 1 si le point est inférieur au seuil

• 0 sinon.

A ce stade nous avons donc notre modèle colorimétrique et nous pouvons
l’appliquer à toutes les images de notre vidéo pour récupérer les points bleus.
Cependant il se peut que les points bleus ne soient pas tout à fait “nets”(certains
pixels du points ne sont pas retenus par notre modèle et notre seuil alors qu’ils sont
visiblement bleus). Nous pouvons appliquer donc appliquer un post-traitement
(dilatation et érosion sur la matrice binaire) pour corriger le problème. Ce traitement
permet également d’enlever les pixels isolés qui sont détectés comme étant des
points bleus.

Une fois que nous avons nos 4 points, nous voulons connaître la position
moyenne de chaque point (pour l’étape suivante). Pour cela on “labellise” chaque
point. La labellisation dans une image correspond au fait de donner une valeur
unique aux groupes de points homogènes. Ici nos groupes de points homogènes
sont nos points caractérisés par des 1 entourés de 0. Chaque point aura une valeur
distincte (1 2 3 4). Une fois les points labellisés, nous pouvons appliquer une moyenne
en x et y de chaque label (nous faisons la moyenne en position des 1 puis des 2
etc...).

Lorsque la moyenne de chaque point est récupérée, il suffit de donner à
chaque coin l’image à incruster la valeur du point correspondant. et l’image est
incrustée !

Cependant, on veut que cette méthode fonctionne lorsque la feuille de
papier va bouger. Pour cela il faut ré-appliquer la distance de mahalanobis sur
chaque image, faire le post traitement, labelliser, et faire la moyenne. Sauf que
maintenant on va comparer l’ordre des points avec celui de l’image précédente,
pour que les points soient toujours dans le même ordre (typiquement l’ordre horaire).
Notre algorithme permet donc d’incruster une image sur la feuille de papier.
Pour éviter qu’elle recouvre les doigts de l'expérimentateur, on peut appliquer le
modèle de picot et la distance de mahalanobis sur la peau de celui-ci. La matrice
binaire sera le “masque” de notre image. La main ne sera donc plus recouverte par
l’image.

# II) Implémentation

## 1) Mise en situation et choix techniques

Pour implémenter cet algorithme, nous avons utilisé le logiciel et langage
Matlab, développé par la société MathWorks et commercialisé depuis 1984. Ce
langage et cet environnement de développement (littéralement “MAThrix
LABoratory”) est particulièrement efficace pour le calcul sur des matrices et de très
haut niveau d’abstraction, il est donc parfait pour notre projet qui consiste en
l’analyse d’image (des matrices en 3 dimensions donc) et son haut niveau
d’abstraction permet une plus grande facilité pour le maîtriser car plus un langage
est haut niveau, plus il se rapproche du langage parlé.
Ce langage est interprété. Cette caractéristique a été déterminante dans
notre façon de penser l’implémentation des algorithmes que nous avons mis en
place . En effet un langage interprété est analysé “à la volée” pendant l’exécution.

L’utilisation de boucles est donc plutôt déconseillé dans le soucis d’optimisation des
ressources informatiques, puisque le langage alloue les cases mémoires en direct et
chaque tour de boucle lui fait perdre de l’efficacité.




Nous avons donc décidé de limiter au maximum les boucles et cette décision
va rendre notre algorithme complètement différent que s’il avait été développé en
C, par exemple.

## 2) L’initialisation

Cette première, comme dit dans la première partie, doit permettre de mettre
en oeuvre la modèle de picot sur les points bleus, pour par la suite connaître leur
position à tout moment dans notre image. Pour ce faire il faut d’abord réussir à
ouvrir la vidéo et récupérer la première image.

Pour cela on peut s’aider de la fonction VideoReader à laquelle on donne un
fichier vidéo classique (en .avi ou .mp4 par exemple) et qui permet de la traiter
avec matlab. On peut isoler une image de cet objet, en utilisant la fonction read,
qui avec un objet vidéo et un numéro d’images (en prenant garde que le numéro
d’image ne dépasse pas le nombre d’image) retourne l’image souhaité. On a donc
notre image que l’on peut analyser.

Il faut récupérer la zone d’intérêt pour mettre en oeuvre notre modèle de
picot, nous avons fait ça “à la main” en rentrant manuellement les coordonnées du
point en haut à gauche et en bas à droite. Pour le calcul de la moyenne de notre
zone d’intérêt nous avons donc limité les boucles au maximum. La ou nous aurions
pu faire 3 boucles (une pour la coordonnée horizontale, une pour la coordonnée
verticale, pour parcourir notre matrice, et une pour les 3 couleurs RVB) nous nous
sommes limités à une boucle “obligatoire”, celle des couleurs RVB. En effet la
fonction mean, sur une matrice permet de faire la moyenne des colonnes. Donc en
faisant la moyenne des moyennes des colonnes sur chaque couleur, on obtient
notre moyenne pour chaque couleur.

Calcul de la covariance pour une matrice 2 dimenstions
Nous aurions pu parcourir toute notre matrice de la zone d’intérêt mais nous
nous sommes contentés de parcourir seulement deux fois les couleurs en utilisant la
même astuce des moyennes de moyennes pour éviter d’avoir à parcourir tous les
pixels et perdre l’intérêt apporté par Matlab.

## 2) Distance de mahalanobis et application à toutes les
images

Avec cette moyenne et cet covariance, nous “tenons” notre modèle de
picot au complet.




Avec ce modèle nous pouvons faire la distance de mahalanobis pour avoir
notre matrice binaire mettant en évidence les points bleus. Pour que cette distance
soit correcte, il faut établir un seuil, nous l’avons établi manuellement par itération
successives, en s’aidant de la fonction image qui permet d’afficher une
représentation de notre matrice.

Exemple de résultat lors de l’utilisation d’un seuil correct
Nous avons ensuite fait du post traitement sur ces mêmes points pour les
rendre plus nets (érosion et dilatation) deux fonctions nous ont aidé sur Matlab
(ImDilate et Imrode) qui avec une format et une taille (nous on disque de 5 pixels)
font respectivement une dilatation et une érosion sur notre image.

Exemple de l’érosion

Cette distance peut être applicable à toutes nos images en l’insérant dans
une boucle qui va de l’image 1 à “FrameNumber” (i.e le nombre d’images) et qui
grâce à la fonction read, toujours, permet de récupérer toutes les images de la
vidéo à traiter.




## 3) Mise en place des barycentres et ordonnancement

Une fois que la distance de mahalanobis est opérationnelle sur nos images,
on peut labelliser nos points en utilisant la fonction bwlabel qui prend en entrée une
image et qui retourne la même image labellisée. Grâce à ces labels on peut faire la
moyenne de positions de chaque points. Ici aussi on ne parcourt pas toute la
matrice mais on utilise une fonction très utile de matlab (find) qui permet de
récupérer tous les points qui sont égales à une valeur de donnée (ici on fera pour
chaque label de notre image donc de 1 à 4.
Représentation d’une image après labellisation
Une fois la moyenne de chaque point récupérée, on doit ordonner nos barycentres
dans le sens horaire pour qu’ils soient utilisables par la fonction d’insertion. On le fait
“à la main” sur la première image. Ensuite il suffit de faire correspondre le point sur
l’image i avec le même point sur l’image i+1, ce qui n’est pas difficile puisque car la
feuille bougeant lentement, le point en i+1 ne s’est pas beaucoup éloigné de sa
position en i. Le plus proche de notre point sur l’image est donc le même mais à sa
position i+1. Nous avons donc utilisé la distance euclidienne, pour “réorganiser” nos
barycentres dans le même ordre que sur l’image précédente, donc dans le sens
horaire.



## 4) Incrustation et rendu vidéo

Une fois nos barycentres ordonnés pour chaque image, il fallait incruster
l’image souhaitée, ou plutôt dans notre cas et c’est un choix personnel, la vidéo.
Pour cela nous avons eu à ouvrir notre vidéo, grâce à imread. Et à chaque image i
de notre destination nous incrustions l’image i de notre source. L'incrustation se fait
grâce à la méthode fournie motif2frame, qui grâce à une destination (l’image de
“fond”), une source (l’image à incruster), un vecteur ligne correspondant aux
position en x des 4 barycentres, dans l’ordre horaire, une vecteur ligne
correspondant aux position en y des 4 barycentres, dans l’ordre horaire également,
une échelle pour que l’image incrustée soit agrandie ou rétrécie et un masque de
pixel à ne pas modifier, retourne une image avec la source incrustée dans la
destination.

A ce stade nous avons donc l’image qui est incrustée dans notre vidéo grâce
à la fonction motif2frame. Cependant la main est masquée par l’image que nous
venons d’incruster que le montre l’image qui suit:

Incrustation de l’image sur la vidéo sans
Pour que la vidéo apparaisse “par dessus” l’image incrustée il faut affecter à
la fonction motif2frame une matrice binaire ou la main est mise en évidence en tant
que masque.


Pour récupérer ce masque, on utilise le même procédé que pour récupérer
les 4 barycentres, on applique le modèle de picot sur notre main, on applique la
distance de mahalanobis avec un seuil défini défini et on obtient notre matrice qui
représente notre main !

Incrustation de la même image avec gestion de la main
Une fois l’image incrustée, il ne reste plus qu’à créer une vidéo qui
regroupera toutes les images avec l’image incrustée. Pour cela on utilise la fonction
videoWriter à laquelle on donne un nom de fichier de sortie. Il faut ouvrir le flot
d’écriture en faisant open(myWriter) où myWriter est l’objet videoWriter. On peut
alors ajouter des images à ce fichier pour créer la vidéo en faisant:

writeVideo(myWriter,myFrame) où myWriter est l’objet videoWriter et myFrame

l’image à ajouter. À la fin de notre traitement il faut penser à bien fermer le flot
d’écriture pour clôturer le fichier.

Dans notre projet nous avons décidé de faire un effet de mise en abîme(nous
en reparlerons dans la partie résultat), nous avons donc dû faire plusieurs fois ce
traitement ou la vidéo à incruster était la sortie de la vidéo précédente.


# III) Résultats

## 1) Notre solution

Nous avons tout d’abord fait le choix d’incruster une vidéo à la place d’une
simple image. Incruster une vidéo n’est pas plus difficile que d’insérer une image et
nous avons pensé que le rendu en serait plus sympathique. Sur le choix de la vidéo
nous avons décidé de faire une mise en abîme. Pour rendre notre effet plus
surprenant, nous avons décidé que chaque image soit retourné de 90 ° par rapport
à la vidéo “au dessus”.
Une des images de notre rendu final
Cet effet a pu être réalisé grâce à la fonction motif2frame. En effet elle associe le
premier point de ses vecteurs x et y au coin haut gauche de l’image. Il suffit donc
d’organiser ses points bleus dans l’ordre horaire en commençant par le point bas
gauche et l’effet fonctionne.

Pour accentuer l’effet de mise en abîme chaque vidéo est décalée de 19
frames par rapport à son “parent”. Cela produit un décalage temporel. La vidéo du
rendu final est disponible en annexe de ce document.

## 2) Les difficultés rencontrées et points de blocage

Durant ce projet nous avons eu quelques difficultés . En effet nous avons
commencé à développer notre solution en manipulant le langage comme nous en
avions l’habitude, c’est à dire en utilisant les boucles. Mais comme cela a été
mentionné dans la partie implémentation, l’utilisation de boucles est déconseillée
dans ce langage puisqu’il perd son utilité et son efficacité. Nous avons dû reprendre
les fonctions moyenne et covariance qui avaient totalement été développées en
utilisant des boucles de parcours de la matrice image.

Cette non utisisation des boucles nous paraissait contre nature au départ,
mais la répétition de ce genre d’opérations nous a habitué à cette méthode de
programmation typique des langages interprétés.

Le très haut niveau du langage matlab a été un avantage (simplification des
instructions et du langage) mais a aussi des inconvénients. En effet certaines
instructions complètement incohérentes étaient passées sous silence par le
débogueur (utilisation d’une variable non déclarée par exemple à cause de l’oubli
ou l’ajout d’une majuscule). Les erreurs renvoyées par le débogueur n’étaient pas
toujours très claires et il était difficile de connaître la cause de son erreur par
moments.

## 3) Limites du projet et points à améliorer

Le gros point noir de notre projet est le masque permettant de mettre la main
par dessus. En effet il était très dur de trouver la bonne zone d’intérêt et le bon seuil
pour le modèle de picot et la distance de mahalanobis. Notre matrice binaire qui
en résulte est assez mauvaise, et mal gérée. Le problème est que la main à plusieurs
tons de beiges et que la luminosité lui fait légèrement changer de couleur lorsqu’elle
bouge. Notre main est donc “assez” mal détectée.

## 4) Apports personnels de ce projet

Ce projet nous a permis de bien maîtriser matlab et notamment sa partie
traitement du signal numérique. Il nous a confronté à toutes nos difficultés devant
l’utilisation du logiciel et langage Matlab. Il a été très gratifiant pour nous de voir
cette vidéo incrustée dans une autre, et tout ça grâce à nos lignes de code.

# Conclusion

Ce projet de signal nous a permis de nous familiariser avec Matlab au travers
d’un projet. Le logiciel Matlab étant répandu dans le monde professionnel, il est
essentiel d’avoir les compétences minimales sur ce logiciel. Ce projet nous a
également permis de mettre en pratique toutes les notions que nous avons pu voir
en traitement numérique. Il nous a forcé à aller au bout de nos compétences
quelques fois pour trouver la solution.
