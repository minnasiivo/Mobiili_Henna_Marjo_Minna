# Sääsovellus

Tämä on sääsovellus, joka hakee säätietoja halutun maan tai kaupungin mukaan. Sovellus käyttää säätietojen hakuun OpenWeatherMap API:n rajapintaa. Sovellus tuo haetun maan mukaan maakoodin. Tallennettaessa sovellus tallentaa lämpötilan ja kuvauksen säästä. Sään kuvausta havainnollistetaan iconilla. Hakutuloksen voi tallentaa päiväkirjaan sääkortiksi etusivun sydän iconista, johon on lisätty animaatio. Sääkorttiin pystyy lisätä kuvia. Tietojen tallennukseen on käytetty Firebasea.

Sovelluksessa käytetään puhelimen ominaisuuksista sijaintia (GPS) ja kameraa.

Sovellukseen lisätty mm. seuraavat paketit (haettu komennolla Flutter pub deps):
anim_search_bar 2.0.3
*	sovelluksen hakupalkki
camera 0.10.3+2
*	sovelluksen kamera
firebase_auth 4.4.0
*	tallennukseen
flutter 0.0.0
*	sovelluksen toimimiseen

Lähteenä käytetty repositorio: https://github.com/SamiaAshraff/WeatherCast
 

# Sovelluksen näkymät


Etusivu
*	kuvaus säästä ja lämpötila
*	hakutoiminto
*	haetun paikan lisääminen suosikkeihin


![Alt text](pictures/aloitus.jpeg "Aloitus")

Kirjautuminen
*	sovellukseen rekisteröityminen ja kirjautuminen

![Alt text](pictures/kirjaus.jpeg "Kirjaus")

Kamera
*	kuvan ottaminen
*	tallentaminen tietokantaan


![Alt text](pictures/kuva.jpeg "Kuva")

Päiväkirja
*	tallennettujen tietojen poistaminen
*	kamera ja kuvan ottaminen
*	haettujen säätietojen tallennus

![Alt text](pictures/pk.jpeg "Pk")


