# Aula zenekérő rendszer

Egy iskolai aulába tervezett zenekérő rendszer: bárki bármilyen eszközről (telefon, tablet, számítógép) kérhet zenét, amit egy Raspberry Pi automatikusan lejátszik YouTube-ról az aulában. A rendszerhez egy csengő is tartozik.

> Technikumi csapatprojekt.

## Hogyan működik?

1. A felhasználó regisztrál a weboldalon.
2. Az admin elfogadja a regisztrációt, ezután a felhasználó be tud jelentkezni.
3. A felhasználó bármilyen eszközről beküldi a kért zenét.
4. A kérés bekerül az adatbázisba.
5. A Raspberry Pi az adatbázisból kiolvassa a sorban álló zenéket, és sorban lejátssza őket YouTube-ról.
6. A hang az aulában szól.

## Szerepkörök

**Felhasználó**
- Regisztráció (admin jóváhagyása után használható)
- Bejelentkezés
- Zenekérés beküldése

**Admin**
- A regisztrációk elfogadása
- Az összes zenekérés listázása: ki mit kért és mikor
- A rendszer felügyelete

## Funkciók

- Zenekérés bármilyen eszközről, böngészőből
- Regisztráció és bejelentkezés, admin által jóváhagyott felhasználókkal
- Admin és felhasználói profil, külön jogosultságokkal
- A kérések tárolása adatbázisban, az admin látja, ki mit és mikor kért
- Automatikus lejátszás YouTube-ról Raspberry Pi segítségével
- Csengő program (C#), amit bárki letölthet és használhat
- Részletes dokumentáció a beállításhoz

## Használt technológiák

| Terület | Technológia |
|---|---|
| Csengő vezérlése (csengetés) | C# |
| Weboldal (backend) | PHP |
| Weboldal (frontend) | HTML, CSS, JavaScript |
| Adatbázis | SQL adatbázis |
| Hardver | Raspberry Pi |

## Telepítés és beállítás

A Raspberry Pi beállítása és a rendszer üzembe helyezése lépésről lépésre a dokumentációban található. Minden szükséges információ ott van.

📄 **Dokumentáció:** a [`dokumentacio`](dokumentumok/) mappában található, két részre bontva:

- **Felhasználói dokumentáció:** regisztráció, bejelentkezés és zenekérés
- **Admin dokumentáció:** regisztrációk elfogadása, kérések listázása, a rendszer beállítása

Röviden:

1. Az adatbázis létrehozása
2. A webes felület telepítése a szerverre
3. A Raspberry Pi beállítása és a lejátszó program elindítása
4. A csengő bekötése és beállítása

## Csengő letöltése

A csengő program elkészült, és bárki szabadon letöltheti. A letöltés a repository klónozásával történik:

```bash
git clone https://github.com/100TMrMaTe/projekt.git
```

A klónozás után a csengő telepítője a `csharp/csengoletoltes` mappában található `.iso` fájl.

## Állapot

- ✅ Zenekérés és lejátszás működik
- ✅ Dokumentáció elkészült
- ✅ A csengő elkészült, letölthető

## Csapat

A projektet csapatban készítettük.

- [@100TMrMaTe](https://github.com/100TMrMaTe) – BackEnd, Database
- [@Matyi01](https://github.com/profil2) – FrontEnd
- [@PeterJankovics](https://github.com/profil3) – FrontEnd

## Licenc

Iskolai projekt. A felhasználásról a csapat tagjainál lehet érdeklődni.
