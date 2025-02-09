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

  #text(size: 18pt, [Fizyka 2 - laboratorium 4])

  #text(size: 21pt, [*Modelowanie pola elektrycznego*])
  #v(2em)
    Ćwiczenie nr 31

    22 października 2024
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
      align(horizon)[Modelowanie pola elektrycznego],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(31, [Modelowanie pola elektrycznego], "22.10.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie

== Cel ćwiczenia

Poznanie podstawowych wielkości opisujących pole elektrostatyczne. Wyznaczenie powierzchni ekwipotencjalnych i wektorów natężenia pola elektrycznego na płaszczyźnie dla różnych konfiguracji elektrod.

== Wstęp teoretyczny

Pole elektrostatyczne powstaje w wyniku obecności nieruchomych ładunków elektrycznych w przestrzeni. Określenie jego rozkładu wymaga wyznaczenia dwóch funkcji dla każdego punktu przestrzennego - wektorowej funkcji natężenia $E(x, y, z)$ oraz skalarnej funkcji potencjału\ $V(x, y, z)$.

Pole elektryczne wewnątrz kondensatora można wyznaczyć w sposób analityczny.

=== Kondensator płaski
Wewnątrz kondensatora płaskiego pole elektryczne jest jednorodne, a jego wartość wyraża się wzorem:

$ E = U/d $

gdzie $E$ - wartość natężenia pola, $U$ - napięcie między okładkami, a $d$ to odległość między okładkami.

Wartość potencjału $V(x)$ zmienia się liniowo w przestrzeni - od zera przy elektrodzie z uziemieniem, aż do wielkości $U$, która jest równa napięciu źródła zasilania.

$ V(x) = U/d x $

gdzie $x$ to odległość od okładki o potencjale 0V.

=== Kondensator cylindryczny

Zakładając, że potencjał elektrody zewnętrznej jest równy zeru, to wartość potencjału w punkcie odległym o $r$ od osi kondensatora określa wzór:
$ V(r) = U/ln(r_z/r_w) ln(r/r_z) $

gdzie $r_z$ to promień zewnętrzny kondensatora cylindrycznego, a $r_w$ to promień wewnętrzny.

Obliczając analitycznie pochodną z powyższego wzoru można otrzymać wzór na natężenie pola:

$ E(r) = - U/(r ln(r_z/r_w)) $

Jak można zauważyć powyżej, rozkłady pola elektrycznego $E(r)$ oraz potencjału $V(r)$ nie zależą od długości kondensatora $l$, więc mogą być zbadane na płaskim modelu.

#v(1em)
Pole elektryczne można wyznaczyć także w sposób doświadczalny.

Pomiar pola elektrycznego jest trudny z powodu zakłóceń wprowadzanych przez sondę pomiarową. W praktyce stosuje się więc modelowanie analogowe, zastępując pole elektrostatyczne innym polem o tych samych funkcjach opisowych, ale łatwiejszym do zmierzenia. Dobrym przykładem jest pole elektryczne stacjonarnego przepływu prądu w obszarze o stałej oporności właściwej, które może służyć jako model pola elektrostatycznego w przestrzeni bez ładunków.

Przybliżoną wartość natężenia $E$ uzyskać można obliczając numerycznie gradient potencjału:

$ E_x = -(partial V) / (partial x) approx (V(x + h, y) - V(x, y)) / h $

$ E_y = -(partial V) / (partial y) approx (V(x, y + k) - V(x, y)) / k $

gdzie $h$ i $k$ są krokami siatki, przyjmujemy $h = k$.

= Układ pomiarowy

#v(1em)
  + *Płyty modelowe kondensatorów: cylindrycznego i płaskiego*
  + *Zasilacz*
  + *Woltomierz o dokładności 0.01 V*  
  + *Sonda*
  + *Linijka o działce elementarnej 1 mm*

#v(1em)
#grid(
  columns: (1fr, 1fr),
  align(left + top)[
    #figure(
    image("plaskischem.png"),
    caption: [
      Obwód elektryczny do badania pola w kondensatorze płaskim @opis1
    ],
  )],
  align(right + top)[
    #figure(
    image("cylindrschem.png"),
    caption: [
      Schemat połączeń układu pomiarowego do modelowania pola elektrycznego w kondensatorze cylindrycznym @instrukcja
    ],
  )
  ]
)


= Przebieg ćwiczenia
#v(1em)

Doświadczenie rozpoczęto od podłączenia elementów zgodnie ze schematami dla dwóch typów kondensatorów: płaskiego oraz cylindrycznego. Następnie zmierzono wymiary geometryczne kondensatora cylindrycznego, takie jak jego promień wewnętrzny i zewnętrzny, oraz odstęp między okładkami w kondensatorze płaskim. Kolejnym etapem było określenie odległości wyznaczonych punktów pomiarowych od okładek obu kondensatorów, co umożliwiło odczyt napięcia w tych punktach za pomocą sondy. Na końcu dokonano dodatkowych pomiarów napięcia w miejscach znajdujących się poza obszarem kondensatora płaskiego. Wszystkie uzyskane dane zostały zapisane w tabelach pomiarowych.

= Analiza danych pomiarowych

== Kondensator płaski
#v(1em)
#align(center)[
  #figure(
  image("konplaski2.png"),
  caption: [Wyniki pomiarów wartości potencjału $V$ [V] oraz odległości $d$ [cm] punktów siatki w przestrzeni dla kondensatora płaskiego]
)
]

Napięcie zasilania $U$ ustawiono na $10$ V oraz zmierzono odległość między okładkami kondensatora:
$D = 11.9 "cm"$

=== Wyniki pomiarów dla wnętrza kondensatora

#let plaski1 = csv("1.csv")

#figure(
  align(center + top)[
    #table(
    align: center + horizon,
    rows: (1.7em, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, ),
    columns: (auto, auto, auto, auto, auto, auto, auto),
    inset: 4pt,
    [*L.p.*], [$bold(x " " "[m]")$], [$bold(V_a "" "[V]")$], [$bold(V_b "[V]")$], [$bold(V_c "[V]")$], [$bold(V_"dośw" "[V]")$], [$bold(V_"teor" "[V]")$],
    ..plaski1.flatten()
  )
],
caption: [Wyniki pomiarów i obliczeń potencjału dla płaskiego układu elektrod]
)
#pagebreak()

#v(1em)
W powyższej tabeli $x$ to odległość od okładki o potencjale 0 V,\ 
$V_"dośw"$ to średnia wartość potencjału dla danego położenia $x$ wyznaczona ze wzoru:
$ V_"dośw" = (V_a + V_b + V_c)/3 $

a $V_"teor"$ wyznaczono według zależności:
$ V(x) = U/d x $

#v(1em)
Następnie obliczono wartości doświadczalne natężenia pola jako:
$ E_"dośw" = (V_(n + 1) - V_n) / (x_(n + 1) - x_n) $

Każdą z wartości przypisano do punktu leżącego w połowie odległości między $x_(n+1)$ oraz $x_n$:

$ x^* = (x_(n+1) + x_n)/2 $

#v(1em)
$ E_"teor" = U/d $

#v(1em)

#let plaski2 = csv("2.csv")

#figure(
  align(center + top)[
    #table(
    align: center + horizon,
    rows: (2em, auto, auto, auto),
    columns: (auto, auto, auto, auto),
    inset: 5pt,
    [*L.p.*], [$bold(x " ""[m]")$], [$bold(E_"dośw" " "["V"/"m"])$], [$bold(E_"teor" " "["V"/"m"])$],
    ..plaski2.flatten()
  )
],
caption: [Wyniki pomiarów i obliczeń wartości natężenia pola dla płaskiego układu elektrod]
)
#pagebreak()

#align(center + top)[
  #figure(
    image("wykres1.png"),
    caption: [Zależność potencjału $V_"dośw"$ oraz $V_ "teor"$ od odległości $x$ dla kondensatora płaskiego]
  )
]

#align(center + horizon)[
  #figure(
    image("wykres2.png", width: 78%),
    caption: [Zależność natężenia pola elektrycznego $E_"dośw"$ oraz $E_"teor"$ od odległości $x$ dla kondensatora płaskiego]
  )
]
#pagebreak()

=== Wyniki pomiarów na zewnątrz kondensatora
#v(1em)

#align(center + top)[
  #figure(
    image("wybranepunkty.png", width: 90%),
    caption: [Wartości potencjału $V$ w wybranych punktach na zewnątrz kondensatora płaskiego, wraz z ustalonymi współrzędnymi $(x, y)$]
  )
]
#v(1em)

Za pomocą wzorów $E_x approx (V(x + h, y) - V(x, y)) / h$ oraz $E_y approx (V(x, y + k) - V(x, y)) / k$ wyznaczono wektory $arrow(E)$ dla punktów na zewnątrz kondensatora ($h = k approx 1 "cm"$):

#let plaski3 = csv("3.csv")

#figure(
  align(center + top)[
    #table(
    align: center + horizon,
    rows: (2em, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
    columns: (auto, auto, auto, auto,auto,auto),
    inset: 4pt,
    [*L.p.*], [$bold(x " ""[m]")$], [$bold(y " ""[m]")$], [$bold(E_"x" " "["V"/"m"])$], [$bold(E_"y" " "["V"/"m"])$], [$bold(abs(arrow(E)) " "["V"/"m"])$],
    ..plaski3.flatten()
  )
],
caption: [Wyniki wyznaczenia wektora $arrow(E)$ w wybranych punktach dla płaskiego układu elektrod]
);

=== Wizualizacje dla kondensatora płaskiego

#align(center + top)[
  #figure(
    image("plaskiv2.png", width: 85%),
    caption: [Wizualizacja przedstawiająca wektory natężenia pola $arrow(E)$ w przestrzeni dla kondensatora płaskiego. Rysunek został wygenerowany przy pomocy skryptu w języku _Python_ @skrypt.]
  )
]

#align(center + top)[
  #figure(
    image("plaski_ekwipotencjalnyv2.png", width: 90%),
    caption: [
      Linie ekwipotencjalne dla kondensatora płaskiego o rozdzielczości $Delta V = 0.5 upright(V)$, wygenerowane przy pomocy algorytmu interpolacji z biblioteki _numpy_ oraz _matplotlib_.
    ]
  )
]

#v(1em)

== Kondensator cylindryczny

=== Wyniki pomiarów


#let plaski4 = csv("4.csv")

#figure(
  align(center + top)[
    #table(
    align: center + horizon,
    columns: (auto, auto, auto, auto,auto,auto,auto),
    inset: 5pt,
    [*L.p.*], [$bold(x " "["m"])$], [$bold(V_"a" " ""[V]")$], [$bold(V_"b" " ""[V]")$], [$bold(V_"c" " ""[V]")$], [$bold(V_"dośw" " ""[V]")$],
    [$bold(V_"teor" " ""[V]")$],
    ..plaski4.flatten()
  )
],
caption: [Wyniki pomiarów i obliczeń dla cylindrycznego układu elektrod]
)
#pagebreak()

Zmierzono napięcie zasilania $U = 10$ V, $r_"wewn" = 2$ cm oraz $r_"zewn" = 9.5$ cm.

W powyższej tabeli $x$ to odległość od okładki o potencjale 10 V,\ 

$V_"teor"$ wyznaczono według zależności:
$ V_"teor" (r) = U/ln(r_z/r_w) ln(r/r_z) $

gdzie $r$ to odległość od osi kondensatora.

$ E_"teor" (r) = - U/(r ln(r_z/r_w)) $

#show table.cell.where(x: 2, y: 3): set text(rgb(255, 0, 0))
#figure(
align(center + top)[
  #table(
  columns: (auto, auto, auto, auto),
  rows: (1.5em, auto, auto, auto, auto, auto, auto, auto, auto, auto, ),
  inset: 3pt,
  align: center,
  [$bold("L.p.")$], [$bold(x "" "[m]")$], [$bold(E_"dośw" "" ["V"/"m"])$], [$bold(E_"teor" "" ["V"/"m"])$],
  [1], [0.030], [213.89], [213.93],
  [2], [0.036], [173.33], [178.27],
  [3], [0.043], [83.75], [149.25],
  [4], [0.051], [91.90], [127.09],
  [5], [0.058], [81.67], [110.65],
  [6], [0.066], [76.19], [97.98],
  [7], [0.073], [67.14], [88.52],
  [8], [0.080], [69.05], [80.73],
  [9], [0.086], [72.22], [74.63]
  )
  ],
  caption: [Wyniki pomiarów i obliczeń wartości natężenia pola dla cylindrycznego układu elektrod]
)

Wartość natężenia pola oznaczona na czerwono najprawdopodobniej jest błędna, jednakże nie udało się zidentyfikować oczywistego błędu grubego, który znacząco odbiegałby od trendu obserwowanego w pozostałych pomiarach.

#align(center + top)[
  #figure(
    image("wykrescyl1.png", width: 67%),
    caption: [Zależność potencjału $V_"dośw"$ oraz $V_ "teor"$ od odległości $x$ dla kondensatora\ cylindrycznego]
  )
]
#pagebreak()

#align(center + top)[
  #figure(
    image("wykrescyl2.png", width: 70%),
    caption: [Zależność natężenia pola elektrycznego $E_"dośw"$ oraz $E_"teor"$ od odległości $x$ dla kondensatora cylindrycznego]
  )
]

=== Wizualizacja dla kondensatora cylindrycznego

#align(center + top)[
  #figure(
    image("cylindryczny.png", width: 70%),
    caption: [Linie ekwipotencjalne dla kondensatora cylindrycznego wygenerowane przy pomocy skryptu w języku _Python_ @skrypt.]
  )
]
#pagebreak()


= Wnioski
#v(1em)

Doświadczenie wykazało, że uzyskane wartości natężenia pola elektrycznego odbiegały od teoretycznych, co można przypisać złemu stanowi technicznemu płyty modelowej. Zużyty i zdeformowany papier przewodzący prąd elektryczny, posiadający liczne wgniecenia i odkształcenia, uniemożliwił uzyskanie dokładnych odczytów wartości potencjału, co prowadziło do problemów z ustaleniem się stałej wartości dla punktów pomiarowych.

Wyniki eksperymentalne przy krańcowych wartościach 
𝑥
x wykazały najmniejsze odchylenia od wartości teoretycznych, co sugeruje, że w tych obszarach papier przewodzący był najmniej uszkodzony. Aby uzyskać dokładniejsze wyniki, konieczne byłoby przeprowadzenie pomiarów na sprawnej płycie modelowej z nieuszkodzonym papierem przewodzącym.

W przypadku dokładniejszych pomiarów, doświadczenie prawdopodobnie potwierdziłoby, że wewnątrz kondensatora płaskiego natężenie pola elektrycznego ma stałą wartość, podczas gdy potencjał maleje liniowo. Natomiast w kondensatorze cylindrycznym, że potencjał zmienia się nieliniowo, co ilustrują zagęszczające się linie ekwipotencjalne w pobliżu środka kondensatora.

Dodatkowo, w pobliżu końców kondensatora płaskiego pole elektryczne przestaje być jednorodne, co udało się zmierzyć oraz zwizualizować, ukazując zmiany wartości oraz kierunków wektorów natężenia pola.


#align(bottom)[
#bibliography("bib.yml")
]