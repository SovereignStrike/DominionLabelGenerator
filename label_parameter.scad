include <params.scad>
use <fonts/osifont.ttf>

//Expansion = "Seaside"; // [Adventures, Alchemy, Allies, Base_Game, Cornucopia, Dark_Ages, Empires, Guilds, Hinterlands, Intrigue, Menagerie, Nocturne, Plunder, Promo, Prosperity, Renaissance, Seaside]


//Card_Name = "1234567890123456";

//Cost = 2; // [14]
//Cost_Icon = "Coin"; // [Coin, Debt]
//Hide_Cost = false;

//Hide_Second_Cost = true;
//Second_Cost = 0; // [14]
//Second_Cost_Icon = "Coin"; // [Coin, Debt]

// Kinda adaptative font size for wordy card names
Card_Name_Length = len(Card_Name);
echo(Card_Name_Length);

//Card_Name_FontSize = (Card_Name_Length <= 16) ? 4.5 : 4;
Card_Name_FontSize = FontSize(Card_Name_Length);
echo("Fontsize");
echo(Card_Name_FontSize);
Extrusion_Height = 0.4;


module base(){
 //Load STL

STL =  (Tray_Height == 5)   ? "stl/label_5.stl" :
       (Tray_Height == 8)   ? "stl/label_8.stl" :
       (Tray_Height == 10)  ? "stl/label_10.stl" :      
       (Tray_Height == 12)  ? "stl/label_12.stl" :      
       (Tray_Height == 16)  ? "stl/label_16.stl" :      
       (Tray_Height == 22)  ? "stl/label_22.stl":
       "stl/label.stl";
 
 
 translate([0,0,-3]) color("white") import(STL);   
}

module rest()
{
  //Load Icon
translate([0.5,0.5,0])
color("red")
linear_extrude(Extrusion_Height) {
        scale(1)
        color([1,0,0])
         import(str("icons/",str(Expansion,".svg")));
};

//Load Cost Icon
if (Hide_Cost){} 
else {
    translate([56,-0.5,0])
    color([0,1,0])
    linear_extrude(Extrusion_Height) {
            scale(1.2)
            color([1,0,0])
            import(str("icons/",str(Cost_Icon,".svg")));
    };
}


//Cost Text
if (Hide_Cost){} 
else {
    translate(Cost > 9 ? [58.5,2.2] : [59.4,1.9])
    color([0,1,0])
    linear_extrude(Extrusion_Height)
    text(str(Cost),size = Cost > 9 ? 4.5 : 5,font = "osifont");
}


//Load Second Cost Icon
if (Hide_Second_Cost){} 
else {
    translate([47,-0.5,0])
    color([0,1,0])
    linear_extrude(Extrusion_Height) {
            scale(1.2)
            color([1,0,0])
            import(str("icons/",str(Second_Cost_Icon,".svg")));
    };
}


//Cost Second Text
if (Hide_Second_Cost){} 
else {
    translate(Second_Cost > 9 ? [49.5,2.2] : [50.4,1.9])
    color([0,1,0])
    linear_extrude(Extrusion_Height)
    text(str(Second_Cost),size = Second_Cost > 9 ? 4.5 : 5,font = "osifont");
}


//Card Name
union(){
translate([9.5,TextVerticalAjustment(Card_Name_Length)])
color([0,1,0])
linear_extrude(Extrusion_Height)
text(Card_Name,size = Card_Name_FontSize,font = "osifont"); 
}
 
}
// Fonftsize fonction
function FontSize(chars) = -0.175*chars + 7.2;
//text adjustment
function TextVerticalAjustment(chars) = 0.075*chars + 1.1;

base();
rest();
