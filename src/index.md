---
title: Polskie mejkerspejsy
toc: false
---

# Polskie mejkserspejsy: kondycja po pandemii COVID-19

<style>
  .card {
    font-size: 17px;
    font-family: 'Source Serif Pro', serif;
  }
</style>

```js
// Loading data using data loaders
const makerspaces = FileAttachment("data/makerspaces.csv").csv({typed: true});
const clusters = FileAttachment("data/clusters.csv").csv({typed: true});
const contentWidth = 640;
```

```js
// Creating a year input
const yearInput = Inputs.range([2010, 2022], {step: 1, value: 2022, width: 480});
const year = Generators.input(yearInput);
yearInput.querySelector("input[type=number]").remove();
```

Pierwsze warsztaty mejkerskie pojawiły się w Polsce około 2010 roku. Wtedy swoją obecność w internecie zaznaczyły **warsztaty w Trójmieście**, a w następnych miesiącach i latach powstały **Warszawski Hackerspace** oraz kolejne **hakerspejsy we Wrocławiu i Krakowie**. 

Przed wprowadzeniem obostrzeń pandemicznych w marcu 2020 roku w Polsce pozostawało aktywnych blisko 80 pracowni, w różnym stopniu związanych z ruchem mejkerskim i jego ideałami. W latach 2015–2019, przybywało nawet kilkanaście nowych pracowni rocznie, a jedynie nieliczne kończyły swoją działalność. Niestety wiele z nich zakończyło swoją działalność w czasie pandemii COVID-19.

<div style="font-size: 25px;">
Mejkerspejsy aktywne w ${year} roku
</div>
<div style="display: flex; align-items: center;">
    <div>2010</div>
    ${yearInput}
    <div style="padding-left: 0.5rem;">2022</div>
</div>

```js
import * as L from "npm:leaflet";

const container = display(document.createElement("container"));
container.style.display = "flex";

const leaflet_map = document.createElement("div");
leaflet_map.style.height = "500px";
leaflet_map.style.flex = "0 0 65%";
leaflet_map.style.margin = "0 1rem 0 0";

const workshopInfo = document.createElement("div");
workshopInfo.id = "workshopInfo";
workshopInfo.innerHTML = `<p class="muted">Wybierz pracownię, żeby wyświetlić informacje</p>`;
workshopInfo.style.flex = "0 0 35%";


container.appendChild(leaflet_map);
container.appendChild(workshopInfo);

const map = L.map(leaflet_map)
  .setView([52.11, 19.21], 6);

L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
})
  .addTo(map)

const makerspaces_filtered = makerspaces.filter(makerspace => {
    return makerspace.year_created <= year & makerspace.year_expired >= year;
});

makerspaces_filtered.forEach(makerspace => {
    let marker = L.marker([makerspace.lat, makerspace.lon])
        .bindPopup(`${makerspace.name}`)
        .openPopup()
        .addTo(map);
    
    // Attach an event listener to the marker
    marker.on('popupopen', function() {
        const wi = document.getElementById("workshopInfo")
        const wi_inner_html = `
            <h2>${makerspace.name}</h2>
            <p>${makerspace.description}</p>
            <p>Adres: ${makerspace.address}</p>
            <p>Strona internetowa: <a href="${makerspace.www1}">${makerspace.www1}</a></p>
        `;
        wi.innerHTML = wi_inner_html;
    })
});
```

<details>
  <summary>Źródło danych</summary>
    <span class="muted" style="font-size: 13px;">
        Dane podajemy, opierając się na aktywności pracowni mejkerskich na ich fanpage’ach w portalu Facebook. Nie możemy wykluczyć, że lista pracowni, którą skomponowaliśmy uwzględnia wszystkie polskie mejkerspejsy, ale zakładamy, że jest relatywnie kompletna. Początek i koniec działalności offline nie zawsze doskonale pokrywa się z początkiem i końcem aktywności online, ale jest to jedyna dostępna metoda, która pozwala nam oszacować liczbę pracowni mejkerskich w Polsce w ostatniej dekadzie i dynamikę rozwoju ruchu mejkerskiego.
    </span>
</details>

<br>

## 5 rodzajów pracowni mejkerskich

Nie ma jednej definicji pracowni mejkerskiej ani ruchu mejkerskiego. Mejkerzy, z którymi rozmawialiśmy, też często mieli problemy z określeniem jego granic oraz swojego w nim miejsca. Dlatego zdecydowaliśmy się przyjąć maksymalnie inkluzywną konceptualizację „pracowni mejkerskiej”. Do udziału w badaniu zaprosiliśmy wszystkie podmioty, które zaj- mują się szeroko rozumianą działalnością wytwórczą, majsterkowaniem lub prototypowa- niem. W przeciwieństwie do większości opracowań poświęconych ruchowi mejkerskiemu nie posługujemy się „oficjalnymi” definicjami fablabów, mejkerspejsów i hakerspejsów, które nie zawsze zdają egzamin w konfrontacji z rzeczywistością. Zamiast tego polegamy na empi- rycznej segmentacji pracowni opartej na trzech wymiarach funkcjonowania i pozyskiwania środków. Wymiar pierwszy mierzy ogólną profesjonalizację organizacyjną pracowni (na przy- kład liczbę pracowników i formę ich zatrudnienia), wymiar drugi komercyjną działalność wy- twórczą (czy pracownia uzyskuje dochody ze sprzedaży swoich wyrobów), a wymiar trzeci działalność usługową (organizowane warsztaty i szkolenia). Szczegółowy opis wszystkich trzech wymiarów zawiera ramka 2.1.

```js
html`<div style="width: ${contentWidth+30}px;">
  <div class="card" style="font-size: 16px;">
    <span style="font-weight: bold;">Ogólna profesjonalizacja organizacyjna i dostęp do środków publicznych.</span> Na ten wymiar składają się zmienne mierzące liczbę osób zatrudnionych w organizacji, charakter ich zatrudnienia, liczbę użytkowników przestrzeni oraz dostęp do rozmaitych środków publicznych – zarówno z poziomu lokalnego, krajowego, jak i europejskiego12. Ze względu na liczne braki odpowiedzi nie mogliśmy uwzględnić w segmentacji rocznego przychodu ani rozmiaru pracowni. Liczba pracowników i użytkowników pracowni oraz do- stęp do środków publicznych są ze sobą skorelowane. Instytucje o większej liczbie pracowników etatowych mogą sobie pozwolić na pisanie, składanie i rozliczanie wniosków grantowych – w przypadku organizacji bez profesjonalnego zaplecza kadrowego ich dostęp do pieniędzy publicznych jest zdecydowanie utrudniony. Na wykresie 2.1 wyniki w tym wymiarze są oznaczone na osi x.
  </div>
  <div class="card" style="font-size: 16px">
    <span style="font-weight: bold;">Komercyjna działalność wytwórcza.</span> Na ten wymiar składają się cechy pracowni, które upodabniają ją do mikroprzedsiębiorstwa społecznego. Wysokie wartości uzyskują pracownie funkcjonujące najczęściej w formie stowarzyszenia, utrzymujące się z darowizn, ale również prowadzące własną działalność gospodarczą – w tym działalność stricte wytwórczą polegającą na sprzedaży własnych wyrobów. Na wykresie wyniki w tym wymiarze są oznaczone na osi y.
  </div>
  <div class="card" style="font-size: 16px">
    <span style="font-weight: bold;">Działalność usługowa i abonament.</span> Wysokie wartości w tym wymiarze uzyskują pracownie, które utrzymują się z abonamentu, organizacji odpłatnych zajęć i kursów oraz odpłatnej działalności pożytku publicznego (na podstawie badania jakościowego przypuszczamy, że kryją się pod nią przede wszystkim usługi edukacyjno-szkoleniowe) oraz, w dalszej kolejności, darowizny od osób prywatnych. Na wykresie wartości w tym wymiarze reprezentuje rozmiar punktu.
  </div>
</div>`
```

Nie ma jednej definicji pracowni mejkerskiej ani ruchu mejkerskiego. Mejkerzy, z którymi rozmawialiśmy, też często mieli problemy z określeniem jego granic oraz swojego w nim miejsca. Dlatego zdecydowaliśmy się przyjąć maksymalnie inkluzywną konceptualizację „pracowni mejkerskiej”. Do udziału w badaniu zaprosiliśmy wszystkie podmioty, które zaj- mują się szeroko rozumianą działalnością wytwórczą, majsterkowaniem lub prototypowa- niem. W przeciwieństwie do większości opracowań poświęconych ruchowi mejkerskiemu nie posługujemy się „oficjalnymi” definicjami fablabów, mejkerspejsów i hakerspejsów, które nie zawsze zdają egzamin w konfrontacji z rzeczywistością. Zamiast tego polegamy na empi- rycznej segmentacji pracowni opartej na trzech wymiarach funkcjonowania i pozyskiwania środków.

```js
const scatterplot = Plot.plot({
    height: 500,
    grid: true,
    x: {label: "Poziom profesjonalizacji"},
    y: {label: "Model abonamentowy"},
    r: {label: "Działalność usługowa"},
    color: {legend: true},
    marks: [
        Plot.dot(clusters, 
        {
            x: x => x["coord.Dim.1"]*100, 
            y: x => x["coord.Dim.3"]*100, 
            r: x => x["coord.Dim.2"]*100,
            stroke: "white",
            strokeWidth: .5,
            fill: "klastry",
            tip: true})
    ]
})

display(html`<div class="card" style="width: ${contentWidth}px;">
  ${scatterplot}
</div>`)
```

Na podstawie wyników na powyższych wymiarach wyróżniliśmy trzy główne modele funkcjo- nowania polskich pracowni mejkerskich. Pierwszy to model, w którym struktura organiza- cyjno-finansowa pracowni przypomina typową małą lub średnią organizację społeczną, opie- rającą się na pracy niewielkiego zespołu pracowników i utrzymującą się głównie ze środków publicznych. Zasadnicza różnica między pracowniami tego typu a typowymi polskimi orga- nizacjami pozarządowymi polega na tym, że warsztaty w modelu pierwszym nie są w pełni samodzielne – przeważnie funkcjonują w jakiejś formie zależności od większego partnera in- stytucjonalnego, najczęściej instytucji akademickiej lub publicznej. Nazywamy je pracow- niami przyległymi. Drugi model skupia przede wszystkim hakerspejsy i niewielkie grupy en- tuzjastów funkcjonujące w wysoce niesformalizowany sposób. Przy ich opisie posługujemy się nazwą grupy pasjonatów. Trzeci model to otwarte warsztaty rzemieślnicze utrzymujące się przede wszystkim ze sprzedaży własnych wyrobów, świadczenia usług i organizacji warsz- tatów i zajęć.

<div class="grid grid-cols-2">
  <div class="card">
  
  **Pracownie przyległe**

  Czternaście pracowni przyległych stanowi największy i najbardziej zróżnicowany z wyróżnio- nych przez nas klastrów. Ich specyfika polega na funkcjonowaniu w ramach innej, większej, przeważnie publicznej instytucji (biblioteki, centrum kultury, miejsca aktywności lokalnej, uczelni lub agencji rozwoju regionalnego) lub w ścisłym partnerstwie z nią. Pod względem modelu działalności często przypomina małą lub średnią organizację pozarządową. Pracow- nie przyległe są nastawione przede wszystkim na działania projektowe, warsztaty oraz zajęcia z młodzieżą, które finansują z publicznych grantów. W tej grupie znajdują się zarówno męskie szopy, małe fablaby, jak i pracownie wewnątrzuczelniane.
  </div>

  <div style="display: flex; justify-content: center; align-items: center; height: 100%;">
    <p style="font-size: 30px; font-weight: bold;">3 najczęstsze <br> typy pracowni</p>
  </div>
  
  <div class="card">
  
  **Grupy pasjonatów**

   Model drugi to nieformalne zrzeszenia i stowarzyszenia pasjonatów – najczęściej w hakerspejsach i instytucjach o podobnej specyfice. Grupa stałych użytkowników tego typu pracowni średnio nie przekracza 15 osób, przeciętny roczny budżet to z kolei niespełna 40 tys. zł. Nie posiadają profesjonalnej (tzn. zatrudnionej na etat) kadry i mają relatywnie niskie przychody – głównie ze składek członkowskich. W przypadku hakerspejsów niskie przychody są często równoważone przez niskie koszty funkcjonowania, co sprawia, że ich sytuacja finan- sowa może być bardzo stabilna (jedna z pracowni, z którą rozmawialiśmy miała zapewnione środki finansowe na pół roku funkcjonowania). Finansowe trudności w tej grupie odczuwają organizacje, które usiłują połączyć model finansowania à la hakerspejs z działalnością projektową i warsztatową skierowaną do szerszego grona odbiorców.
</div>

  <div class="card">
  
  **Warsztaty rzemieślnicze**

  Trzeci model funkcjonowania to otwarty warsztat lub kooperatywa rzemieślnicza. W badaniu ilościowym wyróżniliśmy sześć tego typu pracowni, w badaniu jakościowym rozmawialiśmy z przedstawicielami jeszcze dwóch organizacji, które nie wypełniły ankiety, ale na podstawie jakościowego opisu traktujemy je jako przedstawicielki tego klastra.

  Otwarte warsztaty rzemieślnicze jako jedyne finansują swoją działalność przede wszystkim z działań komercyjnych. „Sprzedaż wyrobów własnych” jako główne źródło przychodu podają dwie z nich, a kolejne trzy wskazują „prowadzenie działalności usługowo-szkoleniowej”. Roz- maite działania edukacyjne i warsztatowe przeważnie prowadzą również te otwarte warsztaty rzemieślnicze, które głównie utrzymują się ze sprzedaży produktów. Otwarte warsztaty nie korzystają z publicznych środków. Uzasadniają to, podobnie jak grupy pasjonatów, nad- mierną biurokracją i brakiem czasu.

  </div>
  </div>
</div>

Oprócz trzech wstępnie opisanych powyżej modeli wyróżniamy trzy szczególne pracownie, które nie wpisują się w ten podział: jedną ze względu na relatywnie zdywersyfikowane źródła przychodu i duży poziom stabilizacji organizacyjnej nazywamy pracownią zrównoważoną (oznaczona kolorem zielonym na wykresie powyżej), dwie pozostałe to centra innowacji (oznaczone kolorem jasnoniebieskim) – duże organizacje nastawione na promocję innowa- cyjności i przedsiębiorczości w skali regionalnej, w których przestrzenie mejkerskie stanowią jedynie element dużo szerszego i bardzo urozmaiconego krajobrazu działań. Skrajność wszystkich trzech szczególnych przypadków widać na wykresie 2.1. Określają ją: pozycja pra- cowni na osiach x i y oraz rozmiar punktu.

<div class="grid grid-cols-2">
  <div class="card">
  
  **Centra innowacji**

  Centra innowacji to duże instytucje naukowe lub publiczne, w których mejkerspejs lub fablab jest tylko jednym z wielu komponentów składających się na całokształt ich działań. Pracownie są, jak ujął to jeden z naszych rozmówców, „dokładane jako element budowania innowacji” (IDI, centrum innowacji). Wśród swoich celów instytucje te wymieniają między innymi przyciąganie talentów z sektorów technicznych do regionu, realizację projektów naukowo-technicznych na rzecz zrównoważonego rozwoju czy wspieranie i inkubowanie start-upów. O ile w segmentacji statystycznej wyróżniliśmy jedynie dwie tego rodzaju instytucje, o tyle są one częścią szerszego trendu. Mejkerspejsy w centrach innowacji są de facto pracowniami przyległymi, ale przy większych instytucjach, z większymi budżetami, liczniejszą kadrą i uczestniczącymi w większych projektach, często finansowanych ze środków europejskich.
  
  </div>
  <div class="card">
  
  **Pracownia zrównoważona**

  Pracownia zrównoważona – „model” reprezentowany przez jedną z 39 aktywnych pracowni, które wzięły udział w badaniu – to przykład dużej instytucji mejkerskiej o stabilnej sytuacji finansowej, zdywersyfikowanych źródłach finansowania i profesjonalnej, choć wciąż nielicznej, kadrze zarządzającej. Pracownia oferuje również szeroki wachlarz zajęć i aktywności oraz posiada wiele rodzajów narzędzi. Zrównoważenie pracowni wyraża się również w tym, że stara się świadomie kształtować profil swojej społeczności użytkowników, na przykład próbuje znaleźć odpowiedni balans między liczbą użytkowników na zasadach komercyjnych a zdolnością do prowadzenia działalności statutowej. Jednocześnie jest to pracownia „oddolna”, która próbuje budować relacje z lokalną wspólnotą i mieści się w dzielnicy mieszkalnej dużego polskiego miasta.
  
  </div>
</div>

<div class="muted">
  Dane mejkerspejsów wyświetlane na interaktywnej mapie pochodzą wyłącznie z publicznie dostępnych źródeł takich jak strony internetowe lub fanpage'e.
</div>
