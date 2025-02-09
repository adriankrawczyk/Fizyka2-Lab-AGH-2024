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

  #text(size: 18pt, [Fizyka 2 - laboratorium 5])

  #text(size: 21pt, [*Moduł Younga*])
  #v(2em)
    Ćwiczenie nr 11

    29 października 2024
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
      align(horizon)[Moduł Younga],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(11, [Moduł Younga], "29.10.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie
#v(1em)

== Cel ćwiczenia

Wyznaczenie modułu Younga metodą statyczną za pomocą pomiaru wydłużenia drutu\ z badanego metalu obciążonego stałą siłą.

#v(1em)
== Wstęp teoretyczny
Rzeczywiste ciała zmieniają swój kształt pod wpływem przyłożonych sił, więc pojęcie bryły sztywnej jest tylko użytecznym przybliżeniem. Odkształcenie nazywamy sprężystym, gdy ciało wraca do pierwotnego kształtu po usunięciu działającej siły. Prawo Hooke'a stanowi, że że odkształcenie sprężyste ciała jest proporcjonalne do przyłożonej siły. Dotyczy ono dowolnego kształtu ciała i konfiguracji przyłożonych sił. Dla najprostszego przypadku rozciągania jednorodnego pręta może ono być wyrażone wzorem:

$ Delta l = (F l)/(E S) $
gdzie $Delta l$ to przyrost długości pręta, $l$ to jego długość, $F$ to siła przyłożona do pola przekroju pręta, $E$ to moduł Younga, a $S$ to pole przekroju poprzecznego pręta.

Prawo Hooke'a dla rozciągania lub ściskania może być także zapisane za pomocą wzoru:
$ sigma = E epsilon $
gdzie:
- $sigma$ - naprężenie normalne ($sigma = F / S$),
- $epsilon$ - odkształcenie względne ($epsilon = (Delta l )/ l$).
Wzór w tej postaci charakteryzuje stan naprężeń i odkształceń w rozciąganej próbce w sposób niezależny od jej kształtu.
#pagebreak()

#v(1em)
#align(center + top)[
  #figure(
    image("wykresopis.png", width: 40%),
    caption: [Charakterystyka rozciągania typowa dla większości metali.\ Wstawka pokazuje wygląd próbki
wykorzystywanej w profesjonalnej aparaturze do badania pełnej zależności $sigma (epsilon)$ @opis1.]
  )
]
#v(2em)
Na rysunku przedstawiono typową dla metali zależność naprężenie-odkształcenie. Charakterystyczne punkty na krzywej to: granica proporcjonalności (A), oznaczająca koniec odcinka liniowego, granica sprężystości (B), po przekroczeniu której pojawiają się odkształcenia nieodwracalne, punkt maksymalnego naprężenia (C) oraz punkt zerwania materiału (D). 

Materiały kruche charakteryzuje prostszy przebieg rozciągania - podlegają prawu Hooke'a aż do momentu pęknięcia, które następuje przy określonym naprężeniu.

Wyznaczenie modułu Younga metodą statyczną polega na bezpośrednim pomiarze wielkości wchodzących do wzoru $Delta l = (F l)/(E S)$.  W ćwiczeniu, siła $F$ rozciągająca drut jest siłą ciężkości odważników o masie $m$. Wobec tego $F = m g$, gdzie g to wartość przyspieszenia ziemskiego. Zgodnie z prawem Hooke'a $Delta l (F)$ powinna być prostą: $Delta l = a F + b$.\

Poprzez przyrównanie tej zależności z $Delta l = (F l)/(E S)$ otrzymujemy:
$ a = l/(E S) => E = l/(a S) $
#v(1em)
Ponadto uwzględniając, że pole przekroju $S = (pi d^2)/4$ (gdzie $d$ to średnica przekroju drutu), to wzór na moduł Younga przyjmuje postać:
$ E = (4l)/(pi d^2 a) $

Niepewność złożoną $u_C (E)$ obliczyć można przy pomocy prawa propagacji niepewności względnej na podstawie niepewności $l$, $d$ oraz $a$:

$ (u_C (E)) / E = sqrt((u(l) / l)^2 + (-2 dot u(d) / d)^2 + (-u(a) / a)^2) $

#pagebreak()

= Układ pomiarowy

#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Druty wykonane ze stali i mosiądzu*
    + *Przyrząd do pomiaru wydłużenia drutu pod wpływem stałej siły, zaopatrzony w czujnik mikrometryczny*\ (dokładność 0.01 mm)
    + *Zestaw odważników*
    + *Śruba mikrometryczna*\ (dokładność 0.01 mm)
    + *Przymiar milimetrowy przymocowany do prawego ramienia statywu*\ (działka elementarna 1 mm)
  ],
  align(right + top)[
    #figure(
      image("ukladpom.png", width: 50%),
      caption: [Urządzenie do pomiaru modułu Younga metodą statyczną @instrukcja]
    )
  ]
)

= Przebieg ćwiczenia
#v(1em)
Pomiary rozpoczęto od wyznaczenia długości drutów (stalowego i mosiężnego) przy użyciu przymiaru milimetrowego. Po zamocowaniu drutu w statywie przy pomocy nakrętek i wstępnym obciążeniu szalki dwoma odważnikami kilogramowymi, dokonano pomiaru średnicy drutu śrubą mikrometryczną w trzech miejscach. Po zdjęciu odważników i wyregulowaniu mocowania, wyzerowano czujnik mikrometryczny. Następnie przeprowadzono serię pomiarów wydłużenia drutu, stopniowo zwiększając, a później zmniejszając obciążenie szalki odważnikami, notując każdorazowo sumaryczną masę i odpowiadające jej wydłużenie. Procedurę powtórzono dla obu badanych drutów.

= Analiza danych pomiarowych
#v(1em)
Do pomiaru długości obu drutów skorzystano z przymiaru milimetrowego przymocowanego do statywu. Ze względu na to, przyjęto niepewność pomiarową typu B:
$ u_B (l) = 3 "mm" $

Niepewność pomiaru średnicy drutu jest równa działce elementarnej śruby mikrometrycznej:
$ u_B (d) = 0.01 "mm" $

== Dla drutu stalowego

#v(1em)
Długość drutu $l = 107 "cm"$

#align(center)[
#table(
  align: center,
  columns: (7em, 7em, 7em),
  table.cell(colspan: 3)[Pomiary średnicy drutu stalowego $d$ [mm]],
  [0.80],[0.81],[0.86]
)]

#pagebreak()

$ d_"śr"_"FeC" = (0.80 "mm" + 0.81 "mm" + 0.86 "mm") /3 = 0.823 "mm" approx 0.82 "mm" $

#v(2em)
#let stalwyn = csv("stal.csv")
#align(center)[
  #figure(
    table(
      align: center + horizon,
      columns: (auto, auto, auto, auto, auto),
      [*$bold(m)$ [kg]*],[*$bold(F)$ [N]*],[*Wskazanie czujnika podczas zmniejszania obciążenia [m]*],[*Wskazanie czujnika podczas zwiększania obciążenia [m]*],[$bold(Delta l)$ *[m]*],
      ..stalwyn.flatten(),
    ),
    caption: [Wyniki pomiarów wydłużenia drutu stalowego dla zwiększającej się masy odważników $m$, dla siły rozciągającej $F = m g$, gdzie $Delta l$ - wydłużenie średnie]
  )
]

#v(1em)
W powyższej tabeli $Delta l$ wyznaczono ze wzoru:
$ Delta l = ("cz" arrow.t + "cz" arrow.b ) / 4 $
Przy obliczaniu średniej dzielimy przez 4 aby uwzględnić działanie dźwigni.

#v(1em)

#align(center)[
  #figure(
    image("wykstal1.png", width: 66%),
    caption: [Wykres zależności średniego wydłużenia stalowego drutu\ od przyłożonej siły rozciągającej]
  )
]

#pagebreak()

Zaznaczony na wykresie punkt znacząco odbiega od liniowego przebiegu. Przyczyną może być obecność zagięć w drucie - początkowo przykładana siła mogła powodować prostowanie drutu zamiast jego wydłużania. Z tego względu punkt ten zostanie pominięty w dalszych obliczeniach.

#v(1em)

#align(center)[
  #figure(
    image("wykstal2.png", width: 70%),
    caption: [Wykres zależności średniego wydłużenia stalowego drutu\ od przyłożonej siły rozciągającej (z pominiętym pierwszym punktem)]
  )
]

#v(2em)

Wykorzystując funkcję _REGLINP_ programu _Microsoft Excel_ wyznaczono współczynnik nachylenia prostej oraz jego niepewność:
  $ u(a) = 0.06455 dot 10^(-5) " ""m"/"N" approx 0.065 dot 10^(-5) " ""m"/"N" $

  $ a = 1.47708 dot 10^(-5) " ""m"/"N" approx 1.477 dot 10^(-5) " ""m"/"N"  $

Wartość modułu Younga dla stali obliczyć można z zależności:
$ E = (4l)/(pi d^2 a) $
$ E_"FeC" = (4 dot 1.07 " m")/(pi dot (0.82 dot 10^(-3) " m")^2 dot 1.477 dot 10^(-5) " ""m"/"N") = 1.37178 dot 10^11 "Pa" = 137.178 "GPa" $
#v(1em)
Niepewność $E$ można wyznaczyć przy pomocy poniższego wzoru:

$ u_C (E) = E sqrt(((u_B (l)) / l)^2 + (-2 dot (u_B (d)) / d_"śr")^2 + (-u(a) / a)^2) $

#pagebreak()

$ u_C (E_"FeC") = 137.178 "GPa" dot sqrt(((3 dot 10^(-3) " m")/( 1.07 " m"))^2 + (-2 dot (0.01 " mm") / (0.82 " mm"))^2 + (-(0.065 dot 10^(-5) " ""m"/"N") / (1.477 dot 10^(-5) " ""m"/"N"))^2) $

$ u_C (E_"FeC") = 6.913 "GPa" approx 7.0 "GPa" $

#v(1em)
Niepewność rozszerzona wyrażona jest wzorem:
$ U(E_"FeC") = k dot u_C (E_"FeC")  $
gdzie przyjęto $k = 2$.

$ U(E_"FeC") = 2 dot 7.0 "GPa" = 14 "GPa" $

#v(1em)
Odpowiednio zaokrąglony do niepewności wynik:
$ E_"FeC" approx 137 "GPa" $

#v(1em)

$ bold(E_"FeC" = (137 plus.minus 14) "GPa") $

#v(1em)
== Dla drutu mosiężnego

#v(1em)
Długość drutu $l = 107.1 "cm"$

#align(center)[
#table(
  align: center,
  columns: (7em, 7em, 7em),
  table.cell(colspan: 3)[Pomiary średnicy drutu mosiężnego $d$ [mm]],
  [1.21],[1.20],[1.20]
)]


$ d_"śr"_"CuZn" = (1.21 "mm" + 1.20 "mm" + 1.20 "mm") /3 = 1.203 "mm" approx 1.20 "mm" $

#v(1em)
#let moswyn = csv("moswyn.csv")
#align(center)[
  #figure(
    table(
      align: center + horizon,
      columns: (auto, auto, auto, auto, auto),
      inset: 4.2pt,
      [*$bold(m)$ [kg]*],[*$bold(F)$ [N]*],[*Wskazanie czujnika podczas zmniejszania obciążenia [m]*],[*Wskazanie czujnika podczas zwiększania obciążenia [m]*],[$bold(Delta l)$ *[m]*],
      ..moswyn.flatten(),
    ),
    caption: [Wyniki pomiarów wydłużenia drutu mosiężnego dla zwiększającej się masy odważników $m$, dla siły rozciągającej $F = m g$, gdzie $Delta l$ - wydłużenie średnie]
  )
]

#v(1em)
W powyższej tabeli $Delta l$ wyznaczono tak samo jak w przypadku dla drutu stalowego.

#v(1em)

#align(center)[
  #figure(
    image("wykmos1.png", width: 70%),
    caption: [Wykres zależności średniego wydłużenia mosiężnego drutu\ od przyłożonej siły rozciągającej]
  )
]

#v(1em)
Zaznaczony na wykresie punkt zostanie pominięty w dalszych obliczeniach z podobnego powodu co w przypadku dla drutu stalowego.

#v(1em)

#align(center)[
  #figure(
    image("wykmos2.png", width: 70%),
    caption: [Wykres zależności średniego wydłużenia mosiężnego drutu\ od przyłożonej siły rozciągającej (z pominiętym pierwszym punktem)]
  )
]

#pagebreak()

#v(2em)

Wykorzystując funkcję _REGLINP_ programu _Microsoft Excel_ wyznaczono współczynnik nachylenia prostej oraz jego niepewność:
  $ u(a) = 0.04791 dot 10^(-5) " ""m"/"N" approx 0.048 dot 10^(-5) " ""m"/"N" $

  $ a = 1.41400 dot 10^(-5) " ""m"/"N" approx 1.414 dot 10^(-5) " ""m"/"N"  $

Wartość modułu Younga dla stali obliczyć można z zależności:
$ E = (4l)/(pi d^2 a) $
$ E_"CuZn" = (4 dot 1.071 " m")/(pi dot (1.20 dot 10^(-3) " m")^2 dot 1.414 dot 10^(-5) " ""m"/"N") = 6.6971 dot 10^10 "Pa" = 66.971 "GPa" $
#v(1em)
Niepewność $E$ można wyznaczyć przy pomocy poniższego wzoru:

$ u_C (E) = E sqrt(((u_B (l)) / l)^2 + (-2 dot (u_B (d)) / d_"śr")^2 + (-u(a) / a)^2) $

#v(1em)

$ u_C (E_"CuZn") = 66.971 "GPa" dot sqrt(((3 dot 10^(-3) " m")/( 1.071 " m"))^2 + (-2 dot (0.01 " mm") / (1.20 " mm"))^2 + (-(0.048 dot 10^(-5) " ""m"/"N") / (1.414 dot 10^(-5) " ""m"/"N"))^2) $

$ u_C (E_"CuZn") = 2.539 "GPa" approx 2.6 "GPa" $

#v(1em)
Niepewność rozszerzona wyrażona jest wzorem:
$ U(E_"CuZn") = k dot u_C (E_"CuZn")  $
gdzie przyjęto $k = 2$.

$ U(E_"CuZn") = 2 dot 2.6 "GPa" = 5.2 "GPa" $

#v(1em)
Odpowiednio zaokrąglony do niepewności wynik:
$ E_"CuZn" approx 67.0 "GPa" $

#v(1em)

$ bold(E_"CuZn" = (67.0 plus.minus 5.2) "GPa") $

#pagebreak()

= Porównanie wyznaczonych wartości modułu Younga z wartościami tabelarycznymi
#v(1em)


#figure(
  caption: [Porównanie wyznaczonych wartości modułu Younga z wartościami tabelarycznymi @opis1.],
  align(center + top)[
    #table(
      columns: (auto, auto, auto, auto, auto),
      inset: 6pt,
      align: center + horizon,
      [*Materiał*],[*$bold(E)$ wyznaczone [GPa]*],[*$bold(E_0)$ tablicowe [GPa]*],[$bold(U)$ *[GPa]*],[$bold(abs(E - E_0))$ *[GPa]*],
      [*Stal*], [137], [210 - 220], [14], [73 > $U(E_"FeC")$],
      [*Mosiądz*], [67.0], [100], [5.2], [33 > $U(E_"CuZn")$]
    )
  ]
)
= Wnioski
#v(1em)
W trakcie ćwiczenia otrzymano wartości modułu Younga, dla poszczególnych metali, które wynoszą:

$ bold(E_"FeC" = (137 plus.minus 14) "GPa") $
$ bold(E_"CuZn" = (67.0 plus.minus 5.2) "GPa") $

Otrzymane wyniki nie są zgodne z wartościami tabelarycznymi w granicach niepewności. 
Przyczyną tego zjawiska mogą być zużyte i lekko pozaginane druty użyte w doświadczeniu, które w początkowej fazie obciążenia zamiast wykazywać liniowe wydłużenie, charakterystyczne dla wyznaczania modułu Younga, najpierw się prostowały. Powoduje to, że ich rozciągnięcie jest łatwiejsze niż wynikałoby to z teoretycznych założeń. Moduł Younga dla stali jest większy niż dla mosiądzu, co oznacza, że potrzeba większej siły, aby rozciągnąć stal na tę samą odległość co mosiądz, co jest zgodne z przewidywaniami teoretycznymi.


#align(bottom)[
#bibliography("bib.yml")
]