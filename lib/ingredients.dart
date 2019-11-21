

enum Ingredients {
  // 1 - 12 (without 10) Zusatzstoffe
  color, // 1 Farbstoff
  preservative, // 2 Konservierungsstoff
  antioxidant, // 3 Antioxidationsmittel
  flavour_enhancer, // 4 Geschmacksverstärker
  sulphite, // 5 geschwefelt
  blackened, // 6 geschwärzt
  waxed, // 7 gewachst
  phosphate, // 8 Phosphat
  sweetener, // 9 Süßungsmittel
  sugar_and_sweetener, // 11 mit einer Zuckerart u. Süßungsmittel
  nitrite_salt, // 12 Nitratsalz

  // 20-33,89 including appendices A-Q Allergene
  wheat, // 20A Weizen
  rye, // 20B Roggen
  barley, // 20C Gerste
  oats, // 20D Hafer
  spelt, // 20E Dinkel
  kamut, // 20F Kamut
  crustaceans, // 21 Krebstiere und Krebstiererzeugnisse
  eggs, // 22 Eier und Eiererzeugnisse
  fish, // 23 Fisch und Fischerzeugnisse
  peanuts, // 24 Erdnüsse und Erdnusserzeugnisse
  soya, // 25 Soja und Sojaerzeugnisse
  milk, // 26 Milch und Milcherzeugnisse
  almonds, // 27J Mandeln
  hazelnuts, // 27K Haselnüsse
  walnuts, // 27L Walnüsse
  cashew_nuts, // 27M Cashewnüsse
  pecans_nuts, // 27N Pecannüsse
  brazil_nuts, // 27O Paranüsse
  pistachios, // 27P Pistazien
  macadamia_nuts, // 27Q Macadamianüsse
  celery, // 28 Sellerie und Sellerieerzeugnisse
  mustard, // 29 Senf und Senferzeugnisse
  sesame_seeds, // 30 Sesamsamen und Sesamsamenerzeugnisse
  sulphur_dioxid, // 31 Schwefeldioxid und Sulfite > 10 mg/kg
  lupins, // 32 Lupine und Lupinenerzeugnisse
  molluscs, // 33 Weichtiere und Weichtiererzeugnisse
  meaty, // 89 fleischhaltig

  // a-z Kennzeichnung
  alcohol, // a mit Alkohol
  sustainable_fishery, // f nachhaltige Fischerei
  poultry_meat, // g Geflügelfleisch
  species_appropriate_husbandry, // j artgerechte Haltung
  garlic, // k mit Knoblauch
  naturally_fresh, // n natürlich frisch
  fat_glaze_containing_cocoa, // p kakaohaltige Fettglasur
  beef, // r Rindfleisch
  pork, // s Schweinefleisch
  without_meat, // v ohne Fleisch
  vegan, // x vegan
  shaped_meat, // z aus Formfleisch zusammengefügt
}

class Ingredient {

  static Ingredients ingredientsFromIdentifier(value) {
    switch (value) {
    // Zusatzstoffe
      case '1':
        return Ingredients.color;
      case '2':
        return Ingredients.preservative;
      case '3':
        return Ingredients.antioxidant;
      case '4':
        return Ingredients.flavour_enhancer;
      case '5':
        return Ingredients.sulphite;
      case '6':
        return Ingredients.blackened;
      case '7':
        return Ingredients.waxed;
      case '8':
        return Ingredients.phosphate;
      case '9':
        return Ingredients.sweetener;
      case '11':
        return Ingredients.sugar_and_sweetener;
      case '12':
        return Ingredients.nitrite_salt;
    // Allergene
      case '20A':
        return Ingredients.wheat;
      case '20B':
        return Ingredients.rye;
      case '20C':
        return Ingredients.barley;
      case '20D':
        return Ingredients.oats;
      case '20E':
        return Ingredients.spelt;
      case '20F':
        return Ingredients.kamut;
      case '21':
        return Ingredients.crustaceans;
      case '22':
        return Ingredients.eggs;
      case '23':
        return Ingredients.fish;
      case '24':
        return Ingredients.peanuts;
      case '25':
        return Ingredients.soya;
      case '26':
        return Ingredients.milk;
      case '27J':
        return Ingredients.almonds;
      case '27K':
        return Ingredients.hazelnuts;
      case '27L':
        return Ingredients.walnuts;
      case '27M':
        return Ingredients.cashew_nuts;
      case '27N':
        return Ingredients.pecans_nuts;
      case '27O':
        return Ingredients.pistachios;
      case '27P':
        return Ingredients.brazil_nuts;
      case '27Q':
        return Ingredients.macadamia_nuts;
      case '28':
        return Ingredients.celery;
      case '29':
        return Ingredients.mustard;
      case '30':
        return Ingredients.sesame_seeds;
      case '31':
        return Ingredients.sulphur_dioxid;
      case '32':
        return Ingredients.lupins;
      case '33':
        return Ingredients.molluscs;
      case '89':
        return Ingredients.meaty;
    // Kennzeichnung
      case 'a':
        return Ingredients.alcohol;
      case 'f':
        return Ingredients.sustainable_fishery;
      case 'g':
        return Ingredients.poultry_meat;
      case 'j':
        return Ingredients.species_appropriate_husbandry;
      case 'k':
        return Ingredients.garlic;
      case 'n':
        return Ingredients.naturally_fresh;
      case 'p':
        return Ingredients.fat_glaze_containing_cocoa;
      case 'r':
        return Ingredients.beef;
      case 's':
        return Ingredients.pork;
      case 'v':
        return Ingredients.without_meat;
      case 'x':
        return Ingredients.vegan;
      case 'z':
        return Ingredients.shaped_meat;
      default:
        print("> $value < is not mapped.");
        return null;
    }
  }

  static String ingredientsToString(value) {
    switch (value) {
    // Zusatzstoffe
      case Ingredients.color:
        return "Farbstoff";
      case Ingredients.preservative:
        return "Konservierungsstoffe";
      case Ingredients.antioxidant:
        return "Antioxidationsmittel";
      case Ingredients.flavour_enhancer:
        return "Geschmacksverstärker";
      case Ingredients.sulphite:
        return "Geschwefelt";
      case Ingredients.blackened:
        return "Geschwärzt";
      case Ingredients.waxed:
        return "Gewachst";
      case Ingredients.phosphate:
        return "Phosphat";
      case Ingredients.sweetener:
        return "Süßungsmittel";
      case Ingredients.sugar_and_sweetener:
        return "Zucker und Süßungsmittel";
      case Ingredients.nitrite_salt:
        return "Nitritsalz";
    // Allergene
      case Ingredients.wheat:
        return "Weizen";
      case Ingredients.rye:
        return "Roggen";
      case Ingredients.barley:
        return "Gerste";
      case Ingredients.oats:
        return "Hafer";
      case Ingredients.spelt:
        return "Dinkel";
      case Ingredients.kamut:
        return "Kamut";
      case Ingredients.crustaceans:
        return "Krebstiere";
      case Ingredients.eggs:
        return "Eier";
      case Ingredients.fish:
        return "Fisch";
      case Ingredients.peanuts:
        return "Erdnüsse";
      case Ingredients.soya:
        return "Soja";
      case Ingredients.milk:
        return "Milch";
      case Ingredients.almonds:
        return "Mandeln";
      case Ingredients.hazelnuts:
        return "Haselnüsse";
      case Ingredients.walnuts:
        return "Walnüsse";
      case Ingredients.cashew_nuts:
        return "Cashewnüsse";
      case Ingredients.pecans_nuts:
        return "Pecannüsse";
      case Ingredients.brazil_nuts:
        return "Paranüsse";
      case Ingredients.pistachios:
        return "Pistazien";
      case Ingredients.macadamia_nuts:
        return "Macadamianüsse";
      case Ingredients.celery:
        return "Sellerie";
      case Ingredients.mustard:
        return "Senf";
      case Ingredients.sesame_seeds:
        return "Sesamsamen";
      case Ingredients.sulphur_dioxid:
        return "Schwefeldioxid";
      case Ingredients.lupins:
        return "Lupine";
      case Ingredients.molluscs:
        return "Weichtiere";
      case Ingredients.meaty:
        return "Fleischhaltig";
    // Kennzeichnung
      case Ingredients.alcohol:
        return "Alkohol";
      case Ingredients.sustainable_fishery:
        return "Nachhaltige Fischerei";
      case Ingredients.poultry_meat:
        return "Geflügelfleisch";
      case Ingredients.species_appropriate_husbandry:
        return "Artgerechte Haltung";
      case Ingredients.garlic:
        return "Knoblauch";
      case Ingredients.naturally_fresh:
        return "Natürlich Frisch";
      case Ingredients.fat_glaze_containing_cocoa:
        return "Kakaohaltige Fettglasur";
      case Ingredients.beef:
        return "Rindfleisch";
      case Ingredients.pork:
        return "Schweinefleisch";
      case Ingredients.without_meat:
        return "Ohne Fleisch";
      case Ingredients.vegan:
        return "Vegan";
      case Ingredients.shaped_meat:
        return "Formfleisch";
      default:
        print("> $value < is not mapped.");
        return null;
    }
  }

  static String ingredientsToShortString(value) {
    switch (value) {
    // Zusatzstoffe
      case Ingredients.color:
        return "(1)";
      case Ingredients.preservative:
        return "(2)";
      case Ingredients.antioxidant:
        return "(3)";
      case Ingredients.flavour_enhancer:
        return "(4)";
      case Ingredients.sulphite:
        return "(5)";
      case Ingredients.blackened:
        return "(6)";
      case Ingredients.waxed:
        return "(7)";
      case Ingredients.phosphate:
        return "(8)";
      case Ingredients.sweetener:
        return "(9)";
      case Ingredients.sugar_and_sweetener:
        return "(11)";
      case Ingredients.nitrite_salt:
        return "(12)";
    // Allergene
      case Ingredients.wheat:
        return "(20A)";
      case Ingredients.rye:
        return "(20B)";
      case Ingredients.barley:
        return "(20C)";
      case Ingredients.oats:
        return "(20D)";
      case Ingredients.spelt:
        return "(20E)";
      case Ingredients.kamut:
        return "(20F)";
      case Ingredients.crustaceans:
        return "(21)";
      case Ingredients.eggs:
        return "(22)";
      case Ingredients.fish:
        return "(23)";
      case Ingredients.peanuts:
        return "(24)";
      case Ingredients.soya:
        return "(25)";
      case Ingredients.milk:
        return "(26)";
      case Ingredients.almonds:
        return "(27J)";
      case Ingredients.hazelnuts:
        return "(27K)";
      case Ingredients.walnuts:
        return "(27L)";
      case Ingredients.cashew_nuts:
        return "(27M)";
      case Ingredients.pecans_nuts:
        return "(27N)";
      case Ingredients.brazil_nuts:
        return "(27O)";
      case Ingredients.pistachios:
        return "(27P)";
      case Ingredients.macadamia_nuts:
        return "(27Q)";
      case Ingredients.celery:
        return "(28)";
      case Ingredients.mustard:
        return "(29)";
      case Ingredients.sesame_seeds:
        return "(30)";
      case Ingredients.sulphur_dioxid:
        return "(31)";
      case Ingredients.lupins:
        return "(32)";
      case Ingredients.molluscs:
        return "(33)";
      case Ingredients.meaty:
        return "(89)";
    // Kennzeichnung
      case Ingredients.alcohol:
        return "(a)";
      case Ingredients.sustainable_fishery:
        return "(f)";
      case Ingredients.poultry_meat:
        return "(g)";
      case Ingredients.species_appropriate_husbandry:
        return "(j)";
      case Ingredients.garlic:
        return "(k)";
      case Ingredients.naturally_fresh:
        return "(n)";
      case Ingredients.fat_glaze_containing_cocoa:
        return "(p)";
      case Ingredients.beef:
        return "(r)";
      case Ingredients.pork:
        return "(s)";
      case Ingredients.without_meat:
        return "(v)";
      case Ingredients.vegan:
        return "(x)";
      case Ingredients.shaped_meat:
        return "(z)";
      default:
        print("> $value < is not mapped.");
        return null;
    }
  }

}