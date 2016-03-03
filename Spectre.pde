int[] sHydrogene = new int[] {389,397,410,434,486,656};
int[] sSodium = new int[] {589,590};
int[] sMagnesium = new int[] {310,470,517,518};
int[] sSoleil = new int[]{393,397,410,422,434,438,466,485,490,495,498,517,526,533,537};

String nom, nom2;
int lgo, lgo2; //Affichage des longueur d'onde.

PFont font;
Bouton hydrogeneE,sodiumE,magnesiumE,soleilA;
boolean hy,sd,mg,sol;

void setup()
{ 
  hydrogeneE = new Bouton();
  sodiumE = new Bouton();
  magnesiumE = new Bouton();
  soleilA = new Bouton();
  size(800,600);
  frameRate(60);
  
  font = createFont("font.ttf",32);
  textFont(font);
}
void draw()
{
  
  background(50);
  if(hydrogeneE.afficher(10,210,150,50,"Hydrogene")){
    hy = true; 
    sd = false; 
    mg = false;
  }
  if(sodiumE.afficher(200,210,150,50,"Sodium")){
    hy = false; 
    sd = true; 
    mg = false;
  }
  if(magnesiumE.afficher(390,210,150,50,"Magnesium")) {
    hy = false; 
    sd = false; 
    mg = true;
  }
  if(soleilA.afficher(10,510,150,50,"Soleil")) sol = true;
  
  if(hy){
    spectreEmission(0,0,800,100,sHydrogene);
    nom = "Hydrogene";
  }
  if(sd){
    spectreEmission(0,0,800,100,sSodium);
    nom = "Sodium";
  }
  if(mg){
    spectreEmission(0,0,800,100,sMagnesium);
    nom = "Magnesium";
  }
  if(sol){
    spectreAbsorption(0,300,800,100,sSoleil);
    nom2 = "Soleil"; 
  }
  
  affichage(10,110,780,80,nom,lgo);
  affichage(10,410,780,80,nom2,lgo2);
  lgo = 0; // Remet a zero la couleur.
  lgo2 = 0;
}
void affichageBouton()
{
  
}
void affichage(int x, int y, int w , int h, String nom, int longeurOnde)
{
  stroke(255);
  strokeWeight(5);
  fill(0);
  rect(x,y,w,h);
  
  fill(255);
  textAlign(LEFT,TOP);
  text("Spectre : " + nom, x + 10,y + 5);
  text("Longueur d'onde : " + longeurOnde + " nm", x + 50, y + 40);
  text("Couleur : " , x + 400, y + 40);
  
  noStroke();
  fill(wav2RGB(longeurOnde));
  rect(x + 530,y + 35, 30, 30);
}
void spectreEmission(int x, int y, int w, int h, int[] longOnde)
{
   noStroke(); //Pour afficher les couleurs
   fill(0);
   rect(x,y,w,h); //fond
   for(int i = 380; i <= 780; i++)
   {
      for(int j = 0; j < longOnde.length; j++) {  //Pour chacune des longueur donde
         if(longOnde[j] == i) {
            fill(wav2RGB(i)); //Transforme la longueur d'onde en rgb.
            rect(((i-380)*w/400.) + x,y,w/400.,h); //positionne les raies avec la bonne largeur
         }
         if(mouseY <= y+h && mouseY >= y && mouseX >= x && mouseX <= x+w)
         {
           //Test de collision des raies avec la souris
           if(mouseX >= ((longOnde[j]-380)*w/400.) && mouseX < ((longOnde[j]-380)*w/400.) + w/400.)
           {
              lgo = longOnde[j]; //On stock la longeur d'onde.
           } 
         }  
      }
   }
}
void spectreAbsorption(int x, int y, int w, int h, int[] longOnde)
{
   noStroke(); //Pour afficher les couleurs
   fill(0);
   rect(x,y,w,h); //fond
   for(int i = 380; i <= 780; i++)
   {
      boolean peutDessiner = false;
      for(int j = 0; j < longOnde.length; j++) {
         if(longOnde[j] == i){
           peutDessiner = false; //On ne dessiner pas
           break; // On sort de la boucle pour ne pas tester les autres valeurs
         }
         else
            peutDessiner = true; //On peut dessiner
         //Colission souris et raies
         if(mouseY <= y+h && mouseY >= y && mouseX >= x && mouseX <= x+w)
         {
           //Test de collision des raies avec la souris
           if(mouseX >= ((longOnde[j]-380)*w/400.) && mouseX < ((longOnde[j]-380)*w/400.) + w/400.)
           {
              lgo2 = longOnde[j]; //On stock la longeur d'onde.
           } 
         }
      }
      if(peutDessiner)
      { //On dessiner les raies non-absorber
          fill(wav2RGB(i));
          rect(((i-380)*w/400.) + x,y,w/400.,h); //positionne les raies avec la bonne largeur   
      }
   }
}
color wav2RGB(int w)
{
   double r;
   double g;
   double b;
   double SSS; //intensity
   //Colour
   if(w >= 380 && w < 440)
   {
       r = -(w-440.)/(440.-350.);
       g = 0.;
       b = 1.;
   }
   else if (w >= 440 && w < 490)
   {
       r = 0.;
       g = (w-440.)/(490.-440.);
       b = 1.;
   }
   else if (w >= 490 && w < 510)
   {
       r = 0.;
       g = 1.;
       b = -(w-510.)/(510.-490.);
   }
   else if (w >= 510 && w < 580)
   {
       r = (w-510.)/(580.-510.);
       g = 1.;
       b = 0.;
   }
   else if (w >= 580 && w < 645)
   {
       r = 1.;
       g = -(w-645.)/(645.-580.);
       b = 0.;
   }
   else if (w >= 645 && w <= 780)
   {
       r = 1;
       g = 0;
       b = 0;
   }  
   else
   {
       r = 0;
       g = 0; 
       b = 0;
   }
   
   //Intensity
   if(w >= 380 && w < 420)
   {
       SSS = 0.3 + 0.7*(w-350.)/(420.-350.);
   }
   else if(w >= 420 && w <= 700)
   {
       SSS = 1;
   }
   else if(w > 700 && w <= 780)
   {
       SSS = 0.3 + 0.7*(780.-w)/(780.-700.);
   }
   else
   {
       SSS = 0;
   }
   SSS *= 255;
   
   return color((int)(SSS*r),(int)(SSS*g),(int)(SSS*b));
}
class Bouton{  
  boolean afficher(float x,float y, float longueur, float largeur, String texte){
    if(mouseX < x+longueur && mouseX > x && mouseY <  y+largeur && mouseY > y){
       fill(0);
    }
    else {
      fill(100);    
    }
    stroke(0);
    rect(x,y,longueur,largeur);
    fill(255);
    textAlign(CENTER);
    text(texte,x+(longueur/2),y+(largeur/1.6));
    textAlign(0);
    
    if(mousePressed == true){
      if(mouseX < x+longueur && mouseX > x && mouseY <  y+largeur && mouseY > y){
        return true;
      }
    }
      return false;
  }
}
