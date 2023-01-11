# Documentatie

## Gebruikte medium

Om dit project te maken heb ik gebruik gemaakt van Vivado 2019.2 software om de code te kunnen maken. Om de game te runnen maak ik gebruik van Basys 3 Artix-7 FPGA board. Ook werd er gebruik gemaakt van een monitor om het beeld van het spel te tonen. Om de spel te kunnen besturen wordt er een toetsenboard gebruikt. Verder wordt er uiteraard de nodige kabels gebruikt zoals micro-USB kabel om FPGA board te programmeren, VGA en power kabels voor de monitor.
Om dit documentatie te maken, maak ik gebruik van Word. Bovendien wordt dit project ook op Github gezet. Zodat andere mensen ook van dit project kunnen benutten. Hierdoor wordt het ook mogelijk om dit project verder uit te bereiden en te verbeteren. 


## Taalgebruik

De taal van de documentatie die bij dit project gebruikt wordt is vooral Nederlands, zodat het makkelijk begrijpbaar is voor de andere studenten die dit project verder willen maken. Ook was het voor mezelf makkelijker om de taal Nederlands te gebruiken. Er zijn wel aantal variabelen/signalen in de code die in het Engels zijn geschreven omdat aantal van de componenten heb ik hergebruikt uit andere projecten die op Digitap stonden.

## Reproduceerbaarheid

Zoals eerder aangehaald, staat de code op Github beschikbaar. Ook heb ik geprobeerd om zoveel mogelijk met componenten te werken. Hierdoor zit de code iets netjes eruit en is ook gestructureerd. Zo kan men het project makkelijk reproduceren en verandering aanbrengen als het nodig zou zijn.

## Commentaren in de code

Ik heb geprobeerd om commentaar bij te zetten bij belangrijke delen zodat de code overzichtelijk blijft. Ook ga ik in dit document die belangrijke delen verder uitleggen.

# Presentatie

## Doel van je project

Het doel van dit project is om de Snake game na te maken met een Basys 3 Artix-7 FPGA board. Ook wordt er gebruik gemaakt van een monitor en een keyboard om de snake te besturen. Het besturen van de slang kan zowel met de toets van keyboard gebeuren en met de knoppen van de FPGA board. Ook is er de optie om het spel te pauzeren en om te resetten.

## Traject

Ik had eerst wat meer informatie en voorbeeld code opgezocht op het internet. Als volgt heb ik dan ook een soort blok diagram gemaakt van de componenten zodat ik een beetje inzicht kon krijgen over hoe alles in elkaar zit.

![image](https://user-images.githubusercontent.com/93825775/211519511-139632a6-5b88-4609-9b05-3a527d2bbcdc.png)

## Testing

De testing heb ik grotendeels met trail en error principe gedaan. Dus door regelmatig naar de output op de monitor te controleren. De toetsenboard heb ik ook gecontroleerd door de gekozen toetsen te drukken en te zien of de slang naar de juiste richting gaat. Ook heb ik de log berichten van Vivado grondig bekeken bij een error.

## Ervaarde moeilijkheden / gevonden oplossingen

Bij het start van het project had moeilijkheden met de VGA. Ik kon niet echt iets op de display tonen. Eerst kreeg ik gewoon een zwart scherm en nieks werd getoond. Na aantal aanpassingen kreeg ik geen zwart scherm maar een error op het scherm namelijk “Video mode not supported”.
Om deze error weg te werken heeft me heel veel tijd gekost. Na het opzoeken op het internet ben ik pagina van tinyvga.com tegengekomen. Op deze pagina stonden de nodige timings die nodig zijn om de monitor te laten werken. Ik heb Samsung SyncMaster 151s (resolutie van 1024 x 768) als monitor gebruikt en hieronder vindt u de timings daarvoor.

![image](https://user-images.githubusercontent.com/93825775/211519969-d8a7e892-5a30-498e-b8d1-d14c044c3e77.png)

Hierdoor ben ik achter gekomen dat de output klok van mijn clk_wiz_0 verkeerd stond en ook de resolutie stond verkeerd. Na deze aanpassingen te doen heb ik de display te werk gekregen.

Andere grote moeilijkheid die tegenkwam was, was met de keyboard. Ik had al de nodige porten en componenten gemaakt maar was vergeten om een signaal te maken om met de buitenwereld te communiceren. Ook had ik een probleem dat de toetsenboard constant in de slaap gaat als er geen toets gedrukt. Maar deze probleem kwam enkel voor bij de toetsenboard die ik thuis had want ik had ook met de keyboard van school getest en daar had ik dit probleem niet.

De toetsenboard werk nu, maar je moet elke toets twee keer drukken om een toets te kunnen registreren. Uiteraard kwam ik nog andere kleine problemen tegen, maar die kon ik wel iets sneller wegwerken. 


## Toekomstig werk

Er is nog de mogelijkheid om dit project verder uit te bereiden. Hieronder vind u aantal zaken die uitgebreid kunnen worden:
-	Toevoegen van de moeilijkheidsgraad
-	Bijvoegen van score
-	Toevoegen van muziek


# Project

## Correcte werking

De logica van het spel werd geschreven door Donough Liu en de code was op Github beschikbaar. Ik heb zijn code gebruikt om met het project te starten. Daarna heb ik de instellingen voor de VGA aangepast voor mijn monitor. Daarnaast had ik ook de constraints file aangepast. Bovendien heb ik ook een toetsenboard toegevoegd. Ook heb ik Clocking wizard gebruikt. Verder heb ik ook geprobeerd om de FPGA met een usb te programmeren.

Het spel heeft aantal belangrijke componenten/blokken die hieronder worden beschreven:

* clk_wiz_0
Het spel gebruikt twee input klok signalen ene is 100MHz en de andere is 65MHz. Deze 65MHz klok wordt door een Clocking Wizard gegenereerd. Deze input klok is nodig voor de VGA want de monitor heeft een pixel frequentie van 65MHz nodig om te werken en voor de synchronisatie.

![image](https://user-images.githubusercontent.com/93825775/211520339-1fe44330-b054-4cca-8704-6b6222337db5.png)
![image](https://user-images.githubusercontent.com/93825775/211520374-750150cc-bab6-42d5-8617-5cabbbe2f105.png)
![image](https://user-images.githubusercontent.com/93825775/211520387-e54a8e13-93ea-444d-865d-c2a30c16cfa5.png)

* vga
Dit blok zorgt ervoor dat de timings van de vga juist en gesynchroniseerd zijn. We hebben eerste een input klok van 65MHz nodig voor de synchronisatie. Om de VGA goed te laten werken moeten we de aantal pixels van de visible area, front porch, sync pulse, back porch voor de horizontale en verticale lijnen juist instellen. Ik werk met de resolutie van 1024 x 768. 

Hieronder vindt u een diagram van de horizontale lijn:
![image](https://user-images.githubusercontent.com/93825775/211520503-2d0383f7-526b-43bd-b5f3-b7eb6f67c206.png)
![image](https://user-images.githubusercontent.com/93825775/211520575-0b3c465f-037c-4cb1-a2cc-fc8050adba99.png)

Bij horizontale lijn hebben we (1320px – 296px) 1024px van visible area. In deze tijd gaat de signaal voor de kleuren rood, groen en blauw hoog staan en wij kunnen een beeld tonen op het scherm. Wanneer we beginnen met het tellen van de pixels voor de horizontale lijn, zal de hsync zal ‘0’ blijven tot 136px. Daarna zal de hsync ‘1’ worden. Na 1344 px, zal de hsync terug ‘0’ worden en we tellen en column bij voor een nieuwe lijn.

Hieronder vindt u een diagram van de verticale lijn:
![image](https://user-images.githubusercontent.com/93825775/211520746-b76e16de-6891-445b-a0c2-ee7b044c796c.png)
![image](https://user-images.githubusercontent.com/93825775/211520797-6a9db176-7075-4895-b3d9-9cd4b6ed008c.png)

De verticale lijn werkt ook met hetzelfde principe.Vanaf de 0px tot 5px blijft de vsync op ‘0’. Vanaf de 6de px staat de vsync op ‘1’. Daarnaast hebben we ook van (803px – 35px) 768px een visible area. Wanneer alles lijnen opgeteld zijn (806px), dan gaat de vsync terug naar ‘0’ en de rij wordt opgeteld.

![image](https://user-images.githubusercontent.com/93825775/211520851-bf1bc9da-a2ae-4c36-82aa-c16d8b688996.png)
![image](https://user-images.githubusercontent.com/93825775/211520873-562a24b9-d6df-4bd4-95b8-f598ae35f1e1.png)
![image](https://user-images.githubusercontent.com/93825775/211520896-13a67d5d-bf1d-40f1-89e8-c22baeeefbd4.png)

* beeld_en_rgb
Deze component gaat de slang en de kleuren op de juiste coördinaten plaatsen. Ook zorgt deze voor een vlooiende beeld wanneer de slang in de bepaalde richting vooruit gaat. Daarnaast genereerd deze ook een random eten op het scherm voor de slang.

![image](https://user-images.githubusercontent.com/93825775/211520980-57736ab1-9c4f-4f2c-b60c-a187f0220c03.png)
![image](https://user-images.githubusercontent.com/93825775/211520996-a96e008f-1252-46ba-9d5c-55fe6f479f1e.png)
![image](https://user-images.githubusercontent.com/93825775/211521017-5d000495-84f1-4e9f-90ac-ad4c2fe04b73.png)
![image](https://user-images.githubusercontent.com/93825775/211521039-f86b9377-b0d8-4960-95f4-678c97c9f4ba.png)
![image](https://user-images.githubusercontent.com/93825775/211521077-330e48d5-84e9-485f-8af2-b73d72a69c63.png)
![image](https://user-images.githubusercontent.com/93825775/211521099-f64bd9fa-6545-47af-9dc8-e4452d56cf15.png)
![image](https://user-images.githubusercontent.com/93825775/211521115-794cc345-835a-4edc-9918-0c3dfb1e38c4.png)

* top_PS2_CR
Binnen deze component zijn er nog twee subcomponenten namelijk:
  * PS2
  De PS2 blok krijgt een input data van PS2 bus voor de toetesboard. De klok die hier gebruikt wordt is 100MHz. Deze data wordt in een internal shift register  
  opgeslagen bij de falling edge van de PS2 klok. Daarnaast wordt er ook een debounce filter toegepast. Verder wordt er een idle counter gebruikt om te bepalen wanneer 
  de transactie klaar is. Bovendien is ook een ps2_out port die verbonden is met de volgende component die de informatie bevat van de ingedrukte toets.
  ![image](https://user-images.githubusercontent.com/93825775/211521316-9c22322f-b10f-4efd-b1b6-3281f25beeaa.png)

  * PS2_CR
  Hier wordt de ps2_out signaal verder bewerkt en doorgestuurd naar de “besturing” component.
  ![image](https://user-images.githubusercontent.com/93825775/211521376-3cad2ab9-00f7-40f3-8575-2c81540f5897.png)
  ![image](https://user-images.githubusercontent.com/93825775/211521395-bac6f1c8-0709-43bc-ba41-1f6dc1f05fbd.png)

* Besturing
Deze component staat in voor de besturing van de slang. We maken hier ook een klok trager van 60Hz omdat anders het beeld te snel begint te flikkeren. De besturing gebeurt zowel met de knoppen en met de toetsenboard. Wanneer er een knop gedrukt wordt, dan gaan we zien deze verschild is van de vorige knop. Is dat het geval dan sturen we deze door naar de beeld_en_rgb component. Hetzelfde geld hier voor de toets van de toetsenboard.

![image](https://user-images.githubusercontent.com/93825775/211521652-f90ef63d-5bc1-415a-be6b-ad9f87f7b544.png)
![image](https://user-images.githubusercontent.com/93825775/211521666-c5e875b4-ff2a-4db9-a19a-4df3efed93ce.png)

Hieronder vindt u nogmaals de volledige schema:
![image](https://user-images.githubusercontent.com/93825775/211521720-ac2598ee-aba1-4564-b0a5-5f65ab76359c.png)


## Moeilijkheidsgraad

Volgens mij is dit project een uitdagende project, aangezien er verschillende zaken aanbod komen en ook moeten samen ze gesynchroniseerd zijn. Persoonlijk vind ik VHDL ook heel moeilijk taal om te begrijpen en daarmee te programmeren. Maar ik heb mijn best gedaan om dit project zoveel mogelijk af te maken omdat dit zeer leuk was.

## Testing

De testing heb ik grotendeels met trail en error principe gedaan. Dus door regelmatig naar de output op de monitor te controleren. De toetsenboard heb ik ook gecontroleerd door de gekozen toetsen te drukken en te zien of de slang naar de juiste richting gaat. Ook heb ik de log berichten van Vivado grondig bekeken bij een error.

## Modulaire opbouw

Dit project is wel een modulaire opbouw omdat ik zelf ook aantal componenten heb gebruikt die op Digitap aangeboden waren. Bijvoorbeeld de component van de VGA en die van toetsenboard kan ook nog bij andere projecten gebruikt worden. Daarnaast werd er ook een Clocking Wizard gebruikt zodat je de output meteen in IP catalog kunt wijzigen en in de code gaan zoeken. Daarnaast is het ook heel makkelijk om gewoon de hex waarde te veranderen in de besturing component als je een andere toetsen wilt gebruiken.

## VHDL

Als taal wordt er gebruik van VHDL aangezien we bij de eerste jaar ook met VHDL geprogrammeerd hadden. Daarom is het voor mij werken met VHDL makkelijker dan met Verilog. Ook heb ik geprobeerd om de VHDL code zo gestructureerd mogelijk te schrijven. Ook staat er commentaar bij de belangrijke delen van de code.

## Bronnen

VGA Signal Timing. (n.d.). http://tinyvga.com/vga-timing

Digitap learning: Op de site inloggen. (n.d.). https://learning.ap.be/login/index.php

ldm0. (2019, July 21). FPGAsnake. GitHub. https://github.com/ldm0/FPGAsnake
Pantech. (2020, May 4). VGA interface with FPGA Development Kit. Pantech Solutions. https://www.pantechsolutions.net/vga-interface-with-fpga-development-kit#:~:text=VGA%20interface%20with%20FPGA%20is,visible%20area%20of%20the%20monitor.

Instructables. (2017, October 4). PS2 Keyboard for FPGA. https://www.instructables.com/PS2-Keyboard-for-FPGA/

