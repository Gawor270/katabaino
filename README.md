# Katabaino

**Autor:** Bernard Gawor

---

## 1. Opis gry

**Katabaino** (gr. *καταβαίνω* – schodzić w dół, zstępować) to atmosferyczna gra eksploracyjna 2D osadzona w słowiańskim folklorze. Gracz wciela się w postać przemierzającą nocne wsie, lasy i cmentarze, napotykając po drodze istoty z mitologii słowiańskiej – rusałkę, upiora i fantomowego konia.

Koncepcja gry inspirowana jest slow-horror'owymi grami spacerującymi (*walking simulators*) pokroju *Yume Nikki* oraz słowiańską mitologią i ludowym nastrojem grozy – nie opartym na bezpośrednim zagrożeniu, lecz na poczuciu obcości i atmosferze. Pośrednią inspiracją była też literatura: ballada *Erlkönig* Goethego (obecna również w ścieżce dźwiękowej).

Charakterystyczną cechą gry jest jej narracyjne tempo i klimat – brak systemu walki, skupienie na eksploracji i interakcji z otoczeniem, a muzyka klasyczna stanowiąca kontrapunkt do ponurej scenerii.

---

## 2. Użyte narzędzia

| Element | Technologia |
|---|---|
| Silnik gry | **Godot Engine 4.6** |
| Język skryptowy | **GDScript** |
| Renderer | GL Compatibility (OpenGL) |
| Edytor sprite'ów | **Aseprite** (animacje postaci) |
| Platforma docelowa | Linux / Windows Desktop |

---

## 3. Mechaniki gry

### Świat

Gra zbudowana jest z szeregu oddzielnych, połączonych ze sobą map 2D (widok z góry, top-down):

- **Pokój startowy** – scena tutorialowa, blokuje gracza do momentu potwierdzenia klawiszem
- **Las** – główna przestrzeń eksploracyjna
- **Głęboki las** – specjalna mapa z zapętlonym przewijaniem: gracz przekraczający krawędź pojawia się po drugiej stronie (efekt nieskończonej przestrzeni)
- **Kościół** – wnętrze budynku z własną muzyką
- **Cmentarz** – strefa docelowa

Przejścia między mapami obsługiwane są przez system sygnałów (`Events.map_change_requested`) z efektem fade-in/fade-out. Każda mapa może definiować punkt spawnu gracza po załadowaniu (`Marker2D`).

### Kamera

Kamera śledzi postać gracza (`Camera2D` z wygładzaniem). W głębokim lesie przy teleportacji gracza do przeciwległej krawędzi resetowane jest wygładzanie kamery, żeby nie powstawał artefakt „skoku".

### Postać gracza

- Ruch ośmiokierunkowy (WASD / strzałki), prędkość bazowa: **45 px/s**
- Kierunek patrzenia zapamiętywany po zatrzymaniu
- System interakcji oparty na **RayCast2D** – rzut promienia w kierunku patrzenia (16 px), wywołanie metody `_on_interacted()` na trafionej kolizji
- Globalny stan gracza (`PlayerData` – Autoload): przechowuje informację o posiadaniu i użyciu roweru

### Przedmioty i ekwipunek

| Przedmiot | Efekt | Klawisz |
|---|---|---|
| **Rower** | Podnosi prędkość do 90 px/s (x2) | `X` – przełącznik |

Rower podnoszony jest z ziemi przez interakcję (`Z`). Po podniesieniu znika z mapy i nie można go podnieść ponownie (persistencja przez `PlayerData`).

### NPCe

- **Błądzący NPC** (*wandering_npc*) – prosta maszyna stanów (`IDLE / WANDER`): losowo co 1–3 sekundy zmienia kierunek ruchu lub zatrzymuje się. Prędkość: 25 px/s. Animacje czterokierunkowe zsynchronizowane z wektorem prędkości.
- **Rusałka** – interaktywny NPC; interakcja (`Z`) teleportuje gracza na cmentarz.
- **Fantomowy koń** – dekoracyjny NPC z własną sceną i animacją.

### Interfejs użytkownika

- **Menu pauzy** (`Esc`) – wznów grę / wyjdź
- **Tutorial** – nakładka blokująca ruch gracza na starcie, zamykana przez `Enter/Space`
- **Intro** – 11-sekundowa scena z przewijającym się paralaksowym lasem, przechodzi automatycznie do gry

---

## 4. Użyte assety

### Grafika

| Asset | Źródło |
|---|---|
| Sprite postaci gracza (`sadboy.ase`) | Wykonany ręcznie w Aseprite |
| Sprite rusałki (`rusalka.ase`) | Wykonany ręcznie w Aseprite |
| Sprite gargulca (`gargulec.ase`) | Wykonany ręcznie w Aseprite |
| Animacja roweru (`bike.ase`) | Wykonana ręcznie w Aseprite |
| Grafika kościoła (`church_pixel_art.png`) | Wykonana ręcznie |
| Tileset lasu (`forest_tileset.tres`, `trees.tres`) | Zaimportowany z zewnętrznych źródeł |
| Tileset wnętrz (`Tileset_Interior Wood_Gnomenlied.png`) | Zaimportowany – Gnomenlied (itch.io) |
| Obóz (`Pixel Camping Pack 32x32`) | Zaimportowany pack (itch.io) |
| Koń (`Horse/`) | Zaimportowany sprite pack |
| Woda (`Water16x16.png`) | Zaimportowany tileset |
| Słońce (`Sun_Pixel.png`) | Zaimportowany asset |

### Dźwięk i muzyka

| Asset | Źródło |
|---|---|
| `erlkonig_slow.ogg` | Klasyczna ballada Schuberta *Erlkönig* – nagranie publiczne |
| `rachmaninoff-elegie-op-3-no-1.ogg` | Rachmaninoff *Élégie op. 3 nr 1* – nagranie publiczne |
| `prelude-f-sharp-minor.ogg` | Preludium fis-moll – nagranie publiczne |
| `intro_music.mp3` | Zaimportowany track ambientowy |
| `night-ambience.mp3` | Zaimportowany ambient nocny |
| `wind.mp3` | Efekt wiatru |
| `church-bell.mp3` | Efekt dzwonu kościelnego |

---

## 5. Wykorzystanie AI

AI było wykorzystane pomocniczo w procesie developmentu:

- **Asystent kodowania (Claude)** – pomoc przy projektowaniu architektury systemu sygnałów między mapami, systemu przejść scen z punktami spawnu oraz debugowanie logiki maszyny stanów NPC
- **Grafika** – sprite'y postaci wykonane ręcznie w Aseprite; żadna grafika nie była generowana przez AI
- **Muzyka** – żadna muzyka nie była generowana przez AI; użyto nagrań klasycznych z domeny publicznej oraz gotowych efektów dźwiękowych
- **Zachowanie postaci** – wbudowana prosta maszyna stanów (`IDLE/WANDER`) zaimplementowana ręcznie w GDScript; brak uczenia maszynowego

---

## 6. Uruchomienie gry

### Ze źródeł (Godot Editor)

1. Zainstaluj **Godot Engine 4.6** (https://godotengine.org)
2. Otwórz projekt: `Project → Import` → wskaż plik `project.godot`
3. Uruchom: klawisz `F5` lub `Project → Run`

### Moduł wykonywalny

Wersja wykonywalna (Linux x86_64 / Windows) dostępna w sekcji **Releases** repozytorium lub jako załącznik do zgłoszenia projektowego.

### Sterowanie

| Klawisz | Akcja |
|---|---|
| `WASD` / strzałki | Poruszanie się |
| `Z` | Interakcja z obiektem/NPC |
| `X` | Użyj efektu (rower) |
| `Esc` | Pauza |
| `Enter` / `Spacja` | Potwierdź (tutorial) |

---

## 7. Screenshoty

*Screenshoty z rozgrywki do uzupełnienia.*

---

## 8. Bibliografia

- Godot Engine 4.x – dokumentacja oficjalna: https://docs.godotengine.org
- Goethe, J.W. – *Erlkönig* (1782) – inspiracja fabularna i muzyczna
- Tileset wnętrz: *Tileset Interior Wood* – Gnomenlied (itch.io)
- *Pixel Camping Pack 32x32* – itch.io
