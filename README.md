# Sääsovellus eli SÄÄPPI

Tämän sovelluksen ovat tehneet Mobiilisovelluskehitys -kurssilla Marjo Jäkärä, Henna Pusa ja Minna Siivo

Tämä on sääsovellus, joka hakee säätietoja halutun kaupungin mukaan. Sovellus käyttää säätietojen hakuun OpenWeatherMap API:n rajapintaa. 
Kaupunki haetaan ensisijaisesti puhelimen GPS tiedon perusteella. Eri kaupunkien säätietoja voi etsiä myös hakupalkin avulla.
Sovellus tuo haetun maan mukana maakoodin.  Sään kuvausta havainnollistetaan ikonilla.
Kaupungin säätilan  voi tallentaa päiväkirjaan sääkortiksi etusivun sydän-ikonista, johon on lisätty animaatio. 
Sääkorttiin tallentuu päivämäärä, lämpötila ja säätilan kuvaus. Sääkorttiin käyttäjä voi lisätä säätilasta ottamansa kuvan puhelimen kameraa käyttäen. Tietojen tallennukseen on käytetty Firebasea.

Sovelluksessa käytetään puhelimen ominaisuuksista sijaintia (GPS) ja kameraa.

Sovellukseen lisätty mm. seuraavat paketit (haettu komennolla Flutter pub deps):

anim_search_bar 2.0.3
*	sovelluksen hakupalkki

camera 0.10.3+2
*	sovelluksen kamera

firebase_auth 4.4.0
*	käyttäjän tunnistaminen

flutterfire_ui 0.4.3+20
* kirjautumisen käyttöliittymä

firebase_database_web 0.2.2
* säätietojen tallennus 

firebase_storage 11.1.0
* sääkuvien tallennus

geolocator 9.0.2
* puhelimen paikannus

flutter 0.0.0
*	sovelluksen toimimiseen

Lähteenä käytetty repositorio: https://github.com/SamiaAshraff/WeatherCast
tästä otettu sovelluksen päänäkymä ja perusrakenne säätietojen hakuun rajapinnasta.
Sekä päänykymää, että API-kutsua on muokattu vastaamaan meidän sovelluksen suunnitelmaa.
 

# Sovelluksen näkymät


Etusivu
*	kuvaus säästä ja lämpötila
*	hakutoiminto
*	haetun paikan lisääminen suosikkeihin
* animoitu iconi
* kirjautuneen käyttäjän tiedot


![Alt text](pictures/aloitus.jpeg "Aloitus")

Kirjautuminen
*	sovellukseen rekisteröityminen ja kirjautuminen

![Alt text](pictures/kirjaus.jpeg "Kirjaus")

Kamera ja kuvan esikatselu
*	kuvan ottaminen
*	tallentaminen firebaseen


![Alt text](pictures/kuva.jpeg "Kuva")

Päiväkirja
*	tallennettujen tietojen poistaminen
*	kamera ja kuvan ottaminen
*	haettujen säätietojen tallennus

![Alt text](pictures/pk.jpeg "Pk")


