# Openbare tracker op GitHub Pages

Na de Supabase-inrichting verbindt iedere bezoeker automatisch met dezelfde tracker. Jij en je DM hoeven alleen dezelfde GitHub Pages-URL te openen; er is geen deelcode of handmatige verbinding nodig. Wijzigingen worden automatisch opgeslagen en ongeveer elke 3 seconden opgehaald.

## Eenmalige inrichting

1. Open **SQL Editor** in het Supabase-dashboard en voer de volledige inhoud van `supabase-setup.sql` uit.
2. Publiceer de bijgewerkte `index.html` via GitHub Pages.

De Supabase-project-URL en publishable key zijn al in de pagina ingevuld. De instellingen en deelcodevelden zijn verborgen. Gebruik nooit een `service_role`-key of `sb_secret_`-key in de pagina.

## Toegang en privacy

Dit is bewust een openbare tracker: iedereen die de GitHub Pages-URL kent kan de HP, woede en geschiedenis zien en aanpassen. De tracker is niet beperkt tot jou en de DM. De SQL beschermt de tabel tegen directe toegang, maar de publieke pagina kan de gedeelde gegevens via de RPC-functies lezen en wijzigen.

De pagina maakt de gedeelde database-record automatisch aan bij het eerste bezoek. Bij volgende bezoeken wordt die bestaande tracker geladen en niet overschreven. Om de tracker terug te zetten, gebruik je **Alles resetten** in de pagina.
