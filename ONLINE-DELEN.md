# Online delen met de DM

De tracker kan via Supabase online worden gedeeld. Beide spelers kunnen dezelfde HP, woede, gebeurtenissen en geschiedenis aanpassen. Wijzigingen worden automatisch opgeslagen en ongeveer elke 3 seconden bij de ander opgehaald.

## Eenmalige inrichting

1. Maak een project aan op Supabase.
2. Open **SQL Editor** in het Supabase-dashboard en voer de volledige inhoud van `supabase-setup.sql` uit.
3. De project-URL en publishable key voor deze tracker zijn al ingevuld. Je hoeft alleen **Config opslaan** te kiezen als je ze handmatig hebt aangepast.

Gebruik nooit de `service_role`-key of een `sb_secret_`-key in de tracker. De database is zo ingesteld dat directe tabeltoegang uitgeschakeld is; de pagina gebruikt alleen de RPC-functies uit het SQL-script.

Gebruik je ooit een ander Supabase-project, kopieer dan de **Project URL** en **Publishable key** (of legacy `anon` key) uit de API-instellingen en vul die in de tracker in.

## Tracker delen

De pagina moet eerst via een publieke HTTPS-URL bereikbaar zijn. Een link naar een lokaal bestand of `localhost` werkt alleen op jouw eigen apparaat.

1. Kies **Nieuwe deelcode**. De huidige lokale tracker wordt naar Supabase gekopieerd.
2. Open de gepubliceerde trackerpagina, kies **Kopieer uitnodigingslink** en stuur die link privé naar je DM.
3. De DM hoeft alleen de link te openen; de pagina verbindt automatisch en haalt de code daarna uit de adresbalk.

De link bevat de publishable key en een willekeurige deelcode in het URL-fragment. Het fragment wordt niet naar de webserver meegestuurd, maar iedereen met de link kan de tracker bekijken en aanpassen. Deel hem dus alleen met je DM. Met **Deelcode intrekken** wordt de online tracker verwijderd en werkt de oude link niet meer. De lokale kopie op elk apparaat blijft bestaan.
