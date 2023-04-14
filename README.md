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


etusivu
*	sivu toimii esikatselutilana/etusivuna
*	voi lisätä haetun paikan suosikkeihin
*	kuvaus säästä ja lämpötila
*	hakutoiminto


![Alt text](pictures/aloitus.jpeg "Aloitus")

kirjautuminen
*	sovellukseen kirjautumiseen/rekisteröitymiseen

![Alt text](pictures/kirjaus.jpeg "Kirjaus")

kamera
*	ottaa kuvan
*	tallentaa tietokantaan


![Alt text](pictures/kuva.jpeg "Kuva")

päiväkirja
*	voi poistaa tallennettuja tietoja?
*	avata kameran ja ottaa kuvan
*	tallentaa haetut säätiedot
*	pystyy poistamaan tietoja

![Alt text](pictures/pk.jpeg "Pk")


