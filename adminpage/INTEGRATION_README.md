# Integrált Admin Panel - Használati Útmutató

## 📦 Fájlok

```
adminpage_integrated.html    - HTML fájl (használd ezt az eredeti adminpage.html helyett)
adminpage_integrated.js      - Integrált JavaScript
adminpage_improved.css       - Modernizált CSS (ugyanaz mint korábban)
index.js                     - Eredeti backend logika (NE módosítsd!)
```

## 🔄 Mi változott?

### ✅ Megtartva az Eredeti Funkcionalitásból:

1. **Backend Kapcsolat** - Minden API hívás ugyanúgy működik:
   - `init()` → `adminpageLog()`
   - `approveUser(id)`
   - `denyUser(id)`
   - `deleteUser(id)`
   - `makeAdmin(id)`

2. **Adatstruktúra** - A backend által küldött JSON ugyanaz marad

3. **HTML Generálás** - A függvények ugyanúgy működnek:
   - `waitingApproval(id, email, user_class)`
   - `usersAdmin(id, email, user_class)`
   - `usersNotAdmin(id, email, user_class)`
   - `songlog(id, email, user_class, date, title)`

### ✨ Új Funkciók:

1. **Modern UI** - Glassmorphism design az improved CSS-ből
2. **Animációk** - Smooth átmenetek törléskor/jóváhagyáskor
3. **Toast Értesítések** - Vizuális visszajelzés minden művelethez
4. **Keresés** - Minden listában szűrés
5. **Statisztikák** - Automatikus számláló kártyák
6. **Téma Váltás** - Dark/Light mode
7. **Loading Állapotok** - Spinner gombokban művelet közben

## 🚀 Használat

### 1. Fájlok Cseréje

**Régi struktúra:**
```
adminpage.html
adminpage.css
index.js
```

**Új struktúra:**
```
adminpage_integrated.html  (használd ezt az adminpage.html helyett)
adminpage_improved.css     (használd ezt az adminpage.css helyett)
adminpage_integrated.js    (új fájl)
index.js                   (NE változtasd meg!)
```

### 2. HTML Integráció

Az új HTML automatikusan betölti mindkét JS fájlt:

```html
<script src="../index.js"></script>
<script src="adminpage_integrated.js"></script>
```

### 3. Működés

A `adminpage_integrated.js`:
- Felülírja a HTML generáló függvényeket modern designnal
- Hozzáad animációkat és toast értesítéseket
- Megtartja az eredeti backend hívásokat
- Frissíti a statisztikákat automatikusan

## 🎯 Funkciók Részletesen

### Kérelmek Jóváhagyása

**Eredeti működés:**
```javascript
approveUser(id) → Backend hívás → init() → Lista frissül
```

**Új működés:**
```javascript
approveUserWithAnimation(id, button) → 
    - Gomb letiltása + loading spinner
    - approveUser(id) → Backend hívás
    - Toast értesítés
    - Fade-out animáció
    - Elem törlése
    - Statisztikák frissítése
    - init() → Lista frissül (a backend-ből)
```

### Felhasználók Törlése

**Eredeti működés:**
```javascript
deleteUser(id) → Backend hívás → init() → Lista frissül
```

**Új működés:**
```javascript
deleteUserWithAnimation(id, button) →
    - Confirm dialógus
    - Gomb letiltása + loading spinner
    - deleteUser(id) → Backend hívás
    - Toast értesítés
    - Scale-down animáció
    - Elem törlése
    - Statisztikák frissítése
    - init() → Lista frissül
```

### Admin Jog Váltás

```javascript
makeAdminWithAnimation(id, button) →
    - Gomb letiltása
    - makeAdmin(id) → Backend hívás
    - Toast értesítés (admin hozzáadva/eltávolítva)
    - init() → Teljes lista frissül
```

## 🎨 Design Elemek

### HTML Generálás

A függvények mostmár modern HTML-t generálnak:

**Kérelem elem:**
```html
<li class="list-group-item glass-item">
    <i class="bi bi-person-circle"></i> Email
    <div class="info-badge">Osztály: 13</div>
    <button class="btn btn-success action-btn">
        <i class="bi bi-check-lg"></i> Elfogad
    </button>
</li>
```

**Felhasználó elem (Admin):**
```html
<li class="list-group-item glass-item">
    <i class="bi bi-person-fill"></i> Email
    <span class="admin-badge">Admin</span>
    <div class="info-badge">Osztály: 13</div>
    <button>Admin eltávolítás</button>
</li>
```

**Napló elem:**
```html
<li class="list-group-item glass-item">
    <i class="bi bi-music-note-beamed"></i>
    <div class="song-title">BSW - Hello</div>
    <i class="bi bi-person-circle"></i> Email
    <div class="info-badge">Osztály: 13</div>
    <div class="info-badge">2024-06-01 12:30</div>
</li>
```

## ⚙️ Beállítások

### Auto-Refresh Engedélyezése

Az `adminpage_integrated.js` végén:

```javascript
// Uncomment to enable auto-refresh every 5 seconds
setInterval(init, 5000);
```

### Háttérkép Váltás

```javascript
// Uncomment to enable background change every 30 seconds
setInterval(bgChange, 30000);
```

### Téma Mentés

A téma automatikusan mentődik localStorage-ba:
```javascript
localStorage.setItem('theme', 'dark'); // vagy 'light'
```

## 🔧 Testreszabás

### Animációk Gyorsítása/Lassítása

Az `adminpage_integrated.js`-ben:

```javascript
// Jelenlegi: 300ms
setTimeout(() => {
    listItem.remove();
    updateStats();
}, 300); // <- Változtasd ezt az értéket
```

### Toast Időzítés

A Bootstrap Toast alapértelmezetten 5 másodpercig látható. Módosításhoz:

```javascript
const toast = new bootstrap.Toast(toastEl, {
    delay: 3000 // 3 másodperc
});
```

### Keresés Módosítása

A keresés case-insensitive és bárhol keres a szövegben:

```javascript
function filterList(listId, searchTerm) {
    searchTerm = searchTerm.toLowerCase();
    // ... keresési logika
}
```

## 🐛 Hibaelhárítás

### A statisztikák nem frissülnek

Ellenőrizd, hogy az `updateStats()` hívódik-e az `adminpageLog()` után:

```javascript
// adminpage_integrated.js végén
setTimeout(updateStats, 100);
```

### Az animációk nem működnek

Ellenőrizd a CSS betöltését:

```html
<link rel="stylesheet" href="adminpage_improved.css">
```

### A backend hívások nem működnek

Az eredeti `index.js` logikát NEM szabad módosítani. Csak az új fájlokat add hozzá:

```html
<script src="../index.js"></script>        <!-- EREDETI -->
<script src="adminpage_integrated.js"></script>  <!-- ÚJ -->
```

## 📊 Kompatibilitás

### Backend Válasz Formátum

A backend-nek ugyanazt a JSON formátumot kell visszaadnia:

```json
{
    "status": "success_adminpage",
    "waitinglist": [
        {"id": 1, "email": "user@example.com", "user_class": "13"}
    ],
    "approvedusers": [
        {"id": 2, "email": "admin@example.com", "user_class": "12", "isadmin": 1}
    ],
    "log": [
        {"id": 3, "email": "user@example.com", "user_class": "13", 
         "date": "2024-06-01 12:30", "title": "Song Title"}
    ]
}
```

### API Endpoint

```
GET  ../index.php?muvelet=adminpage
POST ../index.php (muvelet: approve_user, deny_user, delete_user, useradmin)
```

## 💡 Tippek

1. **Első betöltés**: Az oldal loading spinner-t mutat amíg az adatok töltődnek
2. **Keresés**: Írj be min. 1 karaktert a kereséshez
3. **Törlés**: Mindig megerősítő dialógus jelenik meg
4. **Téma**: A választott téma megmarad újratöltés után
5. **Statisztikák**: Automatikusan frissülnek minden adatbetöltéskor

## 🔮 Továbbfejlesztési Lehetőségek

- [ ] Bulk műveletek (több elem kiválasztása)
- [ ] Export funkció (CSV)
- [ ] Szűrők (dátum, osztály szerint)
- [ ] Rendezés (ABC, dátum)
- [ ] Pagination nagy listák esetén
- [ ] Drag & drop a listákban
- [ ] Real-time frissítés (WebSocket)

---

**Fontos**: Az eredeti `index.js` fájlt NE módosítsd! Az összes új funkció az `adminpage_integrated.js`-ben van.

**Verzió**: 2.0  
**Dátum**: 2026-02-02  
**Kompatibilitás**: Teljes backward compatibility az eredeti rendszerrel
