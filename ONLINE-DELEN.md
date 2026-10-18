# Online delen met de DM

De tracker kan online worden gedeeld via Supabase. Beide spelers kunnen dezelfde HP, woede, gebeurtenissen en geschiedenis bekijken en aanpassen. Wijzigingen worden automatisch opgeslagen en ongeveer elke 3 seconden bij de ander opgehaald.

## Eenmalige inrichting

1. Maak een project aan op Supabase.
2. Open **SQL Editor** in het Supabase-dashboard en voer de volledige inhoud van `supabase-setup.sql` uit.
3. Open de API-instellingen van het project en kopieer de **Project URL** en de **Publishable key** (of legacy `anon` key).
4. Vul die URL en key in bij **Online delen** in de tracker en kies **Config opslaan**.

Gebruik nooit de `service_role`-key of een `sb_secret_`-key in de tracker. De database is zo ingesteld dat directe tabeltoegang uitgeschakeld is; de pagina gebruikt alleen de beperkte RPC-functies uit het SQL-script.

## Tracker delen

1. Kies **Nieuwe deelcode**. De huidige lokale tracker wordt dan naar Supabase gekopieerd.
2. Kopieer de deelcode en stuur die privé naar je DM.
3. De DM vult dezelfde Project URL en Publishable key in, plakt de deelcode en kiest **Verbinden**.

De deelcode is een toegangssleutel: iedereen die hem heeft kan de tracker bekijken en aanpassen. Deel hem dus alleen met je DM. Met **Deelcode intrekken** wordt de online tracker verwijderd en werkt de oude code niet meer. De lokale kopie op elk apparaat blijft bestaan.
