# Arvestustöö raport

Nimi:Sven Erik Arro
Variant: A
Kuupaev:9.OCT

Kirjelda vahemalt **6 leitud probleemi**.

# Bash skriptide analuusi raport

Projekt: `sa-test`
Kuupaev: 09.10.2026
Susteem: Linux / Debian 13

## Probleem 1
- Skript: `scripts/disk_check.sh`
- Mida skript naoliselt tegi: Naitas kettakasutuse protsenti.
- Mis oli tegelikult vale: Skript luges valet `df` veergu. Lisaks kasutati `df -p`, mis andis vea. Seetottu jai kasutuse vaartus tuhjaks.
- Kuidas vea avastasin: Kaivitasin skripti silumisreziimis ja vaatasin veateadet.
- Millise kasuga kontrollisin: `df -P /` ja `bash -x scripts/disk_check.sh`
- Parandus: Kasutasin `df -P` ja lugesin viiendat veergu, kus on kasutuse protsent.
- Kuidas kontrollisin parast parandust: Vordsin skripti tulemust `df -P /` valjundiga.
- Exit code enne / parast: Enne tuli vale hoiatus ja kood `1`. Parast: `0` kui kasutus on alla piiri, `1` kui piir on tais voi uletatud, `2` kui kontroll ebaonnestub.

## Probleem 2
- Skript: `scripts/user_check.sh`
- Mida skript naoliselt tegi: Kontrollis, kas kasutaja on olemas.
- Mis oli tegelikult vale: Skript otsis nime grupifailist, mitte kasutajakontode hulgast. Ka null leitud vastet loeti eduks.
- Kuidas vea avastasin: Proovisin olemasolevat ja olematut kasutajanime.
- Millise kasuga kontrollisin: `bash scripts/user_check.sh root` ja `bash scripts/user_check.sh kasutaja_keda_ei_ole`
- Parandus: Kasutasin kontode kontrollimiseks `getent passwd`.
- Kuidas kontrollisin parast parandust: `root` andis koodi `0`, olematu kasutaja koodi `1` ja tuhi nimi koodi `2`.
- Exit code enne / parast: Enne sai ka olematu kasutaja koodi `0`. Parast on koodid `0`, `1` ja `2` vastavalt tulemusele.

## Probleem 3
- Skript: `scripts/service_check.sh`
- Mida skript naoliselt tegi: Teatas, kas teenus tootab.
- Mis oli tegelikult vale: Algne kask kontrollis ainult teenuse faili olemasolu. See ei naita, kas teenus parasjagu tootab.
- Kuidas vea avastasin: Vordlesin skripti kasutatud kasku teenuse oleku kontrolliga.
- Millise kasuga kontrollisin: `systemctl is-active TEENUS` ja `bash -x scripts/service_check.sh ""`
- Parandus: Kasutasin `systemctl is-active --quiet`.
- Kuidas kontrollisin parast parandust: Tuhi sisend naitas kasutusjuhist ja andis koodi `2`. Teenuse tulemust tuleb vordelda `systemctl is-active` valjundiga.
- Exit code enne / parast: Parast parandust: `0` aktiivse teenuse korral, `1` mitteaktiivse korral, `2` vigase sisendi korral.

## Probleem 4
- Skript: `scripts/system_info.sh`
- Mida skript naoliselt tegi: Naitas arvuti nime ja kasutaja nime.
- Mis oli tegelikult vale: Hostinime ja kasutaja vaartused olid omavahel vahetuses.
- Kuidas vea avastasin: Vordlesin skripti valjundit Linuxi enda kaskudega.
- Millise kasuga kontrollisin: `hostname`, `id -un` ja `bash scripts/system_info.sh`
- Parandus: `hostname` naitab arvuti nime ja `id -un` kasutaja nime.
- Kuidas kontrollisin parast parandust: Vordsin molemat valja nende kaskude tulemustega.

## Probleem 5
- Skript: `scripts/system_info.sh`
- Mida skript naoliselt tegi: Naitas kerneli versiooni, tootamisaega ja malu hulka.
- Mis oli tegelikult vale: `uname -m` naitab arvuti arhitektuuri, mitte kerneli versiooni. `date` naitab kellaaega, mitte tootamisaega. `Swap` naitab saalemalu, mitte RAM-i.
- Kuidas vea avastasin: Kontrollisin, mida need Linuxi kaskud tegelikult naitavad.
- Millise kasuga kontrollisin: `uname -r`, `uname -m`, `uptime -p` ja `free -h`
- Parandus: Kasutasin kerneli jaoks `uname -r`, tootamisaaja jaoks `uptime -p` ja RAM-i jaoks `free -h` valja `Mem`.
- Kuidas kontrollisin parast parandust: Vordsin skripti valju eelmainitud kaskude tulemustega.

## Probleem 6
- Skript: `scripts/backup.sh`
- Mida skript naoliselt tegi: Loi `.tar.gz` varukoopia ja teatas, et see on valmis.
- Mis oli tegelikult vale: Algne skript salvestas faili ainult failinimede loendi. See ei olnud pariselt tihendatud varukoopia.
- Kuidas vea avastasin: Kontrollisin faili tuupi ja proovisin sisu TAR-kasuga avada.
- Millise kasuga kontrollisin: `bash -x scripts/backup.sh`, `file backups/backup_*.tar.gz` ja `tar -tzf ARHIIVI_TEE`
- Parandus: Kasutasin `tar -czf` arhiivi loomiseks ja `tar -tzf` arhiivi kontrollimiseks.
- Kuidas kontrollisin parast parandust: Skript teatas edust, arhiiv oli gzip-fail ja selle sisu sai valja lugeda. Loendis oli ka tuhikuga failinimi `important data.txt`.

## Uus funktsionaalsus
- Lisatud `scripts/verify_backup.sh`, mis kontrollib varukoopia sobivust.
- Kaivita nii: `bash scripts/verify_backup.sh backups/ARHIIVI_NIMI.tar.gz`
- Kehtiv arhiiv annab koodi `0`; vigane arhiiv annab koodi `1`.
- Menyys on uue funktsiooni jaoks valik 6.


