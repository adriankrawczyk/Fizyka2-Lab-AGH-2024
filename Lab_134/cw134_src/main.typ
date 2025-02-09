// begin of def table
// ============== UZUPEŁNIĆ ============== 
#let group = "3"
#let team = "3"
#let person1 = "Aleksander Jóźwik"
#let person2 = "Adrian Krawczyk"
// =======================================

#let today = datetime.today().display("[day].[month].[year]")

#let table_content = (header, answer) => {
  header
  v(-1em)
  set text(size: 14pt)
  align(center)[#answer]
}

/*
ARGUMENTY:
1. ex_nr - numer ćwiczenia
2. desc - temat ćwiczenia
3. exp_date - data wykonania
4. return_date - pierwsza data oddania; może być none, wtedy bierze dzień w którym wyeksportowano ten pdf
5. rejection_date - data zwrotu do poprawy, none jeśli nie dotyczy
6. last_return_date - druga data oddania, jeśli ona i powyższy argument jest none to pokazuje dany dzień jak w 4
*/
#let header_table = (ex_nr, desc, exp_date, return_date, rejection_date, last_return_date) => {
  set text(font: "New Computer Modern", size: 9pt)
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: auto,
    table_content[Wydział][WI],
    table.cell(colspan: 2)[
      Imię i nazwisko
      #set text(size: 10pt)
      1. #person1
      2. #person2
    ],
    table_content[Rok][II],
    table_content[Grupa][#group],
    table_content[Zespół][#team],
    align(center, text(weight: "bold", [
      PRACOWNIA\ FIZYCZNA WFiIS AGH
    ])),
    table.cell(colspan: 4)[
      #table_content[Temat:][#desc]
    ],
    table_content[Nr ćwiczenia][#ex_nr],
    table_content[Data wykonania][#exp_date],
    table_content[Data oddania][#if return_date != none {return_date} else {today}],
    table_content[Zwrot do popr.][#rejection_date],
    table_content[Data oddania][
      #if last_return_date == none and rejection_date != none {today} else {last_return_date}],
    [Data zaliczenia],
    [Ocena \ \ \ ]
  )
}

// end of def table

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 2cm),
)
#set text(lang: "pl", font: "New Computer Modern", size: 12pt)

#counter(page).update(0)

#align(center)[
  #image("csm_agh_znak_nazwa_asym_2w_pl_d1b882bad0 (1).png", width: 130%)

  #text(size: 18pt, [Fizyka 2 - laboratorium 6])

  #text(size: 21pt, [* Ogniwo słoneczne*])
  #v(2em)
    Ćwiczenie nr 134

    5 listopada 2024
  #v(2em)
  Aleksander Jóźwik
  
  Adrian Krawczyk
]

#pagebreak()

#set page(numbering: "1")

#set par(justify: true)
#set page(
  header: [
    #set text(10pt)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [#image("header.png")],
      align(horizon)[Ogniwo słoneczne],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(134, [Ogniwo słoneczne], "05.11.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie
#v(1em)

== Cel ćwiczenia
Zapoznanie się z różnymi rodzajami półprzewodnikowych ogniw słonecznych. Wyznaczenie charakterystyki prądowo-napięciowej i sprawności przetwarzania energii świetlnej na elektryczną. 

== Wstęp teoretyczny
Słońce to podstawowe źródło energii dla naszej planety. Promieniowanie słoneczne może być zamieniane np. na ciepło poprzez urządzenie zwane kolektorem słonecznym. Inny sposób przemiany tej energii oferuje ogniwo słoneczne, zwane także fotoogniwem. Jest urządzenie służące do bezpośredniej konwersji energii światła słonecznego na energię elektryczną. Proces ten zachodzi w półprzewodnikowym złączu p-n, które charakteryzuje się dużą powierzchnią. Złącze p-n jest kontaktem dwóch warstw półprzewodnika, jednej o przewodnictwie elektronowym (n), drugiej dziurowym (p). Po obu stronach styku metalu powstaje warstwa zubożona o niskiej koncentracji swobodnych elektronów i dziur, co prowadzi do wytworzenia silnego pola elektrycznego.\ To właśnie w niej zachodzi proces zmiany światła na prąd elektryczny. Pod wpływem padającego promieniowania foton światła o energii $h nu$ wzbudza elektron z pasma walencyjnego do pasma przewodnictwa, tworząc w ten sposób parę elektron-dziura, która jest podstawą przepływu prądu.

Krzem jest głównym materiałem używanym do produkcji ogniw słonecznych. Wykorzystywane są jego trzy odmiany - od najdroższego monokrystalicznego, przez polikrystaliczny, do najtańszego amorficznego. Niezależnie od rodzaju, każde ogniwo wymaga specjalnej konstrukcji bardzo blisko powierzchni, ponieważ światło wnika w krzem tylko na głębokość około 0.01 mm.\ Na wierzchu znajduje się przezroczysta warstwa przewodząca (może to być np. cienka warstwa złota lub tlenków przewodzących), a z niej prąd zbierany jest przez metalowe paski.

Charakterystyka prądowo-napięciowa fotoogniwa w ciemności przypomina charakterystykę diody półprzewodnikowej (suma skierowanych przeciwnie prądów dyfuzji i prądu dryfu). Generacja par elektron-dziura przez fotony powiększa jednak prąd dryfu diody o wartość proporcjonalną do natężenia światła $Phi$. W efekcie charakterystyka fotoogniwa wynosi:

$ I = I_s [exp((e U) / (m k T)) - 1] - "const" dot Phi $

i jest ona efektem przesunięcia w dół charakterystyki ogniwa nieoświetlonego o składnik\ $-"const" dot Phi$.

#pagebreak()

#v(1em)

W powyższym wzorze:
- $I$ - natężenie prądu złącza,
- $U$ - napięcie polaryzacji zewnętrznej,
- $I_S$ - teoretyczny prąd nasycenia złącza,
- $m$ - współczynnik idealności złącza p-n,
- $k$ - stała Boltzmanna,
- $T$ - temperatura bezwzględna w kelwinach,
- $e$ - ładunek elementarny elektronu.

#align(center)[
  #figure(
    caption: [Charakterystyki prądowo-napięciowe złącza p-n, ciemnego ($Phi = 0$)
i oświetlonego światłem (z zaznaczonym prostokątem mocy maksymalnej) @opis1],
    image("wykr.png", width: 50%)
    )
]

#v(1em)

Współczesne ogniwa krzemowe mogą osiągać maksymalną sprawność rzędu 25%, jednak w praktyce ich sprawność jest zwykle niższa.

W celu oceny sprawności ogniwa, natężenie światła można zmierzyć za pomocą luksomierza.

Sprawność energetyczna ogniwa jest definiowana jako stosunek mocy maksymalnej generowanej przez ogniwo do mocy padającego promieniowania, określonej wzorem:

$ eta = P_"max"/(Phi n S) $

gdzie $P_"max"$ to moc maksymalna generowana przez ogniwo,
$Phi$ to natężenie światła, $n$ to liczba sekcji, a $S$ to powierzchnia pojedynczej sekcji ogniwa.
 
#pagebreak()


= Układ pomiarowy

#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Fotoogniwa krzemowe: monokrystaliczne, polikrystaliczne, amorficzne*
    + *Żarówka jarzeniowa o charakterystyce widmowej zbliżonej do światła dziennego.*
    + *Woltomierz cyfrowy*
    + *Multimetr*
    + *Opornik o regulowanym oporze od 0 do 100 $ohm$*
    + *Luksomierz*

  ],
  align(right + top)[
    #figure(
      image("rys1.png", width: 50%),
      caption: [Oświetlenie fotoogniwa\ lampą jarzeniową @opis1]
    )
    #figure(
      image("rys2.jpg", width: 50%),
      caption: [Układ elektryczny do badania\ charakterystyki prądowo-napięciowej @opis1]
    )
  ]
)

= Przebieg ćwiczenia
#v(1em)
Na początku podłączono do ogniwa polikrystalicznego woltomierz oraz amperomierz, aby sprawdzić poprawność funkcjonowania układu pomiarowego. Włączono źródło światła i nakierowano na fotoogniwo. Następnie przeprowadzono testy w celu określenia zakresu napięcia przy minimalnym i maksymalnym oporze, co pozwoliło ustalić, jak często należy zapisywać wyniki w trakcie dalszych pomiarów. W kolejnych etapach wykonano kilkanaście pomiarów napięcia oraz natężenia prądu przy stopniowo zwiększanym oporze, równocześnie obliczając moc dla każdego punktu pomiarowego. W momencie, gdy moc osiągała wartość maksymalną, zagęszczono liczbę pomiarów, aby uzyskać dokładniejsze dane w tym zakresie. Całą procedurę przeprowadzono także dla dwóch pozostałych fotoogniw. Na koniec zmierzono natężenie światła emitowanego przez lampę.

= Analiza danych pomiarowych
#v(1em)
Zmierzone przy pomocy luksomierza natężenie światła wynosi:
$ Phi = 130.6 " " upright(W/m^2) $

#pagebreak()

== Ogniwo polikrystaliczne
#v(1em)

Odczytana specyfikacja ogniwa polikrystalicznego:

Liczba sekcji $n = 8$

Powierzchnia 1 sekcji $S = 7.8 " "upright(c m^2)$

Powierzchnia całkowita $n S = 62.4 " " upright(c m ^2)$

#v(1em)

#align(center)[
  #show table.cell.where(x: 3, y: 14): set text(rgb(255, 0, 0))
  #figure(
    table(
      align: center + horizon,
      columns: (auto, auto, auto, auto, auto, auto),
      [*Nr\ pomiaru*], [*U [V]*], [*I [mA]*], [$bold(P = U I)$ *[mW]*], [$bold(U/n)$ *[V]*], [$bold(j = I/S " " upright([(m A)/(c m ^2)]))$],
      ..csv("polikryst.csv").flatten()
    ),
    caption: [Wyniki pomiarów i obliczeń dla ogniwa polikrystalicznego wraz z zaznaczoną na czerwono mocą maksymalną $P_"max"$]
  )
]

$ P_"max" = 13.487 " "upright(m W) $

#v(1em)
Poniższe wykresy znormalizowanej charakterystyki $I/S = f(U/n)$ wykonano przy pomocy bibliotek _matplotlib_ oraz _numpy_ języka _Python 3.12.6_. Współczynniki krzywej trendu\ $I(U) = a dot exp(b U) + c$ zostały dopasowane numerycznie przy pomocy modułu _curve_fit_ z biblioteki _scipy_. Zostały one zapisane pod wykresami. Znak gęstości prądu przyjęto zgodnie z charakterystyką prądowo-napięciową złącza p-n podaną we wstępie teoretycznym.

#pagebreak()

#v(1em)

#align(center)[
  #figure(
    image("polikrystaliczne.png", width: 90%),
    caption: [Wykres znormalizowanej charakterystyki: $I/S = f(U/n)$ dla ogniwa polikrystalicznego]
  )
]
#v(1em)
Otrzymane współczynniki to:
$ cases(a = 1.10739638 dot 10^(-2), b = 12.1669898, c = -1.08628514) $

#v(1em)
Sprawność ogniwa można wyznaczyć korzystając ze wzoru:
$ eta = P_"max"/(Phi n S) $

$ eta_"og.polikrystalicznego" = (13.487 dot 10^(-3) " "upright(W))/(130.6 " " upright(W/m^2) dot 8 dot 7.8 dot 10^(-4) " "upright(m^2) ) = 0.0165 $

$ bold(eta_"og.polikrystalicznego" approx 1.65 %) $


#v(2em)
== Ogniwo monokrystaliczne
#v(1em)

Odczytana specyfikacja ogniwa monokrystalicznego:

Liczba sekcji $n = 1$

Powierzchnia $S = 63 " "upright(c m^2)$

#pagebreak()


#align(center)[
  #show table.cell.where(x: 3, y: 11): set text(rgb(255, 0, 0))
  #figure(
    table(
      align: center + horizon,
      columns: (auto, auto, auto, auto, auto, auto),
      [*Nr\ pomiaru*], [*U [V]*], [*I [mA]*], [$bold(P = U I)$ *[mW]*], [$bold(U/n)$ *[V]*], [$bold(j = I/S " " upright([(m A)/(c m ^2)]))$],
      ..csv("monokryst.csv").flatten()
    ),
    caption: [Wyniki pomiarów i obliczeń dla ogniwa monokrystalicznego wraz z zaznaczoną na czerwono mocą maksymalną $P_"max"$]
  )
]

$ P_"max" = 32.109 " "upright(m W) $


#align(center)[
  #figure(
    image("monokrystaliczne.png", width: 81%),
    caption: [Wykres znormalizowanej charakterystyki: $I/S = f(U/n)$ dla ogniwa monokrystalicznego]
  )
]

#pagebreak()

Otrzymane współczynniki to:
$ cases(a = 1.53840048 dot 10^(-3), b = 15.5796286, c = -1.80879472) $

#v(1em)

$ eta_"og.monokrystalicznego" = (32.109 dot 10^(-3) " "upright(W))/(130.6 " " upright(W/m^2) dot 1 dot 63 dot 10^(-4) " "upright(m^2) ) = 0.039 $

$ bold(eta_"og.monokrystalicznego" approx 3.9 %) $


== Ogniwo amorficzne

Odczytana specyfikacja ogniwa amorficznego:

Liczba sekcji $n = 14$

Powierzchnia 1 sekcji $S = 5.5 " "upright(c m^2)$

Powierzchnia całkowita $n S = 77 " " upright(c m ^2)$

// #v(1em)

#align(center)[
  #show table.cell.where(x: 3, y: 18): set text(rgb(255, 0, 0))
  #figure(
    table(
      align: center + horizon,
      inset:(
        y: 4pt,
      ),
      columns: (auto, auto, auto, auto, auto, auto),
      [*Nr\ pomiaru*], [*U [V]*], [*I [mA]*], [$bold(P = U I)$ *[mW]*], [$bold(U/n)$ *[V]*], [$bold(j = I/S " " upright([(m A)/(c m ^2)]))$],
      ..csv("amorf.csv").flatten()
    ),
    caption: [Wyniki pomiarów i obliczeń dla ogniwa amorficznego wraz z zaznaczoną na czerwono mocą maksymalną $P_"max"$]
  )
]

#pagebreak()

#v(1em)
$ P_"max" = 8.713 " "upright(m W) $

#v(1em)
#align(center)[
  #figure(
    image("amorficzne.png", width: 90%),
    caption: [Wykres znormalizowanej charakterystyki: $I/S = f(U/n)$ dla ogniwa amorficznego]
  )
]
#v(1em)
Otrzymane współczynniki to:
$ cases(a = 5.46337445 dot 10^(-5), b = 12.8175339, c = -2.58502015 dot 10^(-1)) $

#v(2em)

$ eta_"og.amorficznego" = (8.713 dot 10^(-3) " "upright(W))/(130.6 " " upright(W/m^2) dot 14 dot 5.5 dot 10^(-4) " "upright(m^2) ) = 8.66 dot 10^(-3) $

#v(1em)
$ bold(eta_"og.amorficznego" approx 0.87 %) $

#pagebreak()

== Wspólny wykres znormalizowanych charakterystyk: $I/S = f(U/n)$ dla 3 fotoogniw
#align(center)[
  #figure(
    image("wspolny.png", width: 90%),
    caption: [Wspólny wykres znormalizowanych charakterystyk: $I/S = f(U/n)$ dla 3 fotoogniw]
  )
]


= Wnioski
#v(1em)

Na podstawie wspólnego wykresu znormalizowanych charakterystyk oraz danych w tabelach można zauważyć, że największą wartość gęstości prądu zwarcia $j = 1.789 " "upright((m A)/(c m ^2))$ posiada ogniwo monokrystaliczne, podczas gdy ogniwo amorficzne charakteryzuje największe napięcie przypadające na jedną sekcję $U/n = 0.63 " "upright(V)$. W trakcie ćwiczenia wyznaczono następujące sprawności ogniw fotowoltaicznych:
$ eta_"og.amorficznego" approx 0.87 % " "|" " eta_"og.polikrystalicznego" approx 1.65 % " "|" " eta_"og.monokrystalicznego" approx 3.9 % $
Wartości te potwierdzają, że największą sprawnością cechują się najdroższe ogniwa z krzemu monokrystalicznego, a najniższą najtańsze ogniwa amorficzne. Otrzymane sprawności są znacząco niższe od maksymalnej teoretycznej potencjalnej sprawności wynoszącej 25%. Ponieważ nie znamy rzeczywistej wartości sprawności ogniw, możemy jedynie przypuszczać, że zmierzona wartość może znacznie od niej odbiegać. Wynika to prawdopodobnie z budowy, jakości, stanu (liczne zarysowania) badanych ogniw oraz niedokładności pomiaru natężenia światła luksomierzem. Urządzenie to było bardzo czułe, a nawet niewielkie zmiany jego położenia powodowały różnice w zmierzonym natężeniu światła. Pomiary były prowadzone przez pewien czas bez przerwy, co mogło wpływać na wzrost temperatury opornika i obniżenie jego oporu, co z kolei ograniczało zakres wartości $R$, dla których wykonano pomiary.


#align(bottom)[
#bibliography("bib.yml")
]