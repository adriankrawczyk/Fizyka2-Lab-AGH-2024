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

  #text(size: 18pt, [Fizyka 2 - laboratorium 1])

  #text(size: 23pt, [*Wyznaczanie przyspieszenia ziemskiego z wykorzystaniem wahadła matematycznego*])

    Ćwiczenie nr 0

    1 października 2024
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
      align(horizon)[Opracowanie danych pomiarowych],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(0, "Opracowanie danych pomiarowych", "01.10.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie

== Cel ćwiczenia
Zaznajomienie się z typowymi metodami opracowania danych pomiarowych przy wykorzystaniu wyników pomiarów dla wahadła prostego (matematycznego).

== Wstęp teoretyczny
Wahadło matematyczne to teoretyczny model składający się z punktowej masy zawieszonej na nieważkiej, nierozciągliwej nici. W rzeczywistości używamy małego ciężarka na cienkiej nici, co stanowi odpowiednie przybliżenie modelu teoretycznego. To podejście jest poprawne, gdy $sin theta approx theta$ (gdzie $theta$ to kąt wychylenia w radianach), co jest dobrym przybliżeniem dla kątów mniejszych niż około 5°.

Okres wahadła można wyliczyć ze wzoru:
$ T = 2pi sqrt(l/g) $

gdzie $T$ to okres wahadła, $l$ to długość nici mierzona od punktu zaczepienia do środka ciężkości ciężarka, a $g$ to przyspieszenie ziemskie.

Powyższy wzór możemy przekształcić do następujących postaci:
$ T^2 = 4pi^2l/g $

oraz:
$ g = 4pi^2l/T^2 $

#pagebreak()

#v(1em)
= Układ pomiarowy


#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Zestaw wahadła prostego* (Rysunek 1)
    + *Sekundomierz* (stoper) - z dokładnością do 0.01 s
    + *Przymiar milimetrowy* (linijka) - działka\ elementarna 1 mm
  ],
  align(right)[
    #figure(
    image("image.png", width: 40%),
    caption: [
      Zestaw wahadła prostego @electronic. 
    ],
  )
  ]
)

= Przebieg ćwiczenia

== Sposób pierwszy - wahadło o stałej długości
W ramach ćwiczenia przeprowadzono serię pomiarów okresu wahadła przy zachowaniu stałej długości nici. Wykorzystano stoper do wykonania 10 niezależnych pomiarów. W celu zminimalizowania błędów wynikających z czasu reakcji człowieka, każdy pojedynczy pomiar obejmował czas trwania 10 pełnych cykli wahadła.
Przed rozpoczęciem pomiarów czasowych, pierwszym etapem było określenie długości wahadła.

== Sposób drugi - wahadło o zmiennej długości
Tym razem dla każdej z 3 zmierzonych długości wahadła, wykonano po 3 pomiary czasu trwania 10 okresów drgań. Czwarty zestaw danych opiera się na długości nici oraz średnim czasie jednego okresu, uzyskanym z pomiarów wykonanych w pierwszym sposobie.

= Analiza danych pomiarowych

== Sposób pierwszy

=== Długość wahadła $l$ wraz z niepewnością standardową $u_B (l)$
Zmierzona długość wahadła $l = 64 "cm"$\
Najmniejsza działka przyrządu to $Delta l = 1 "mm"$\

Ze względu na problem z dokładnym ustaleniem środka ciężkości zawieszonego ciała oraz punktu zaczepienia nici, niepewność standardowa (typu B) została przyjęta na:
$ u_B (l) = 3 "mm" $
Niepewność względna pomiaru wyniosła:
$ (u_B (l)) / l dot 100% = (0.003 " m") / (0.64 " m") = 0.4688 "%" approx 0.47 "%" $

#pagebreak()

#v(1em)
=== Pomiar okresów drgań
#v(1em)
#align(center + top)[
  #table(
    columns: (3cm, 4cm, 4cm, 5cm),
    inset: 4pt,
    align: center,
    [*Nr pomiaru*], [*Czas 10 okresów*], [*Czas 1 okresu*], [*Kwadrat odchyłki od średniej*],
    [*i*], [$bold(10T_i "[s]")$], [$bold(T_i "[s]")$], [$bold((T_i - T_"śr")^2  ["s"^2])$],
    [*1*], [16.03], [1.603], [0.00006084],
    [*2*], [16.11], [1.611], [0.00024964],
    [*3*], [15.99], [1.599], [0.00000484],
    [*4*], [15.77], [1.577], [0.00033124],
    [*5*], [15.78], [1.578], [0.00029584],
    [*6*], [15.90], [1.590], [0.00002704],
    [*7*], [15.97], [1.597], [0.00000324],
    [*8*], [15.89], [1.589], [0.00003844],
    [*9*], [15.97], [1.597], [0.00000324],
    [*10*], [16.11], [1.611], [0.00024964],
  )
]
#align(center)[W wynikach pomiarów nie zaobserwowano żadnych błędów grubych.]
#v(1em)

$ N = 10 $
$ T_"śr" = 1.5952 " s" $
$ sum_(i=1)^10 (T_i - T_"śr")^2 = 0.0012736 " s"^2 $

=== Niepewność standardowa $u_A (T_"śr")$
#v(1em)
$ u_A (T_"śr") = sqrt((sum(T_i - T_"śr")^2)/(N(N - 1))) $ 
$ u_A (T_"śr") = sqrt((0.0012736 " s"^2)/(10(10 - 1))) = 0.00376 " s" approx 0.0038 " s" $
#v(1em)
Niepewność względna:
$ (u_A (T_"śr"))/T_"śr" dot 100% = (0.0038 " s") / (1.5952 " s") dot 100% approx 0.24% $

=== Obliczenie przyspieszenia ziemskiego wraz z niepewnością
#v(1em)
$ g = (4pi^2l)/T_"śr"^2 $
$ g = (4pi^2 dot 0.64 " m") / (1.5952 " s")^2 = (25.26612 " m")/ (2.5447 " s"^2) = 9.9289 " " "m"/"s"^2 $

#pagebreak()

#v(1em)
Z prawa przenoszenia niepewności o ogólnym wzorze:
$ u_C (g) = sqrt(sum ((partial g) / (partial x_k') u(x_k') ) ^2) $

$u_c$ - niepewność złożona, w tym przypadku k' = 2, co daje:

$ u_C (g) = sqrt(((partial g)/(partial l) u_B (l))^2  + ((partial g) / (partial T) u_A (T_"śr"))^2) = sqrt(((4pi^2)/(T_"śr"^2) u_B (l))^2  + ((-8pi^2l) / (T_"śr"^3) u_A (T_"śr"))^2) $

$ u_C (g) = sqrt(((4pi^2)/((1.5952 " s")^2) dot 0.003 " m")^2  + ((-8pi^2*0.64 " m") / ((1.5952 " s")^3) dot 0.0038 " s")^2) = 0.0664 " " ("m")/("s"^2) approx 0.067 " " ("m")/("s"^2) $

#v(1em)

Niepewność rozszerzona:
$ U(g) = u_C (g) dot k $
gdzie k to współczynnik rozszerzenia  (przyjmujemy k = 2)

$ U(g) = 2 dot 0.067 " " ("m")/("s"^2) = 0.134 " " ("m")/("s"^2) approx 0.14  " " ("m")/("s"^2) $

=== Przyspieszenie ziemskie otrzymane przy pomocy sposobu pierwszego

#v(1em)

Odpowiednio zaokrąglamy wynik:
$ g = 9.9289 " " "m"/"s"^2 approx 9.93 " " "m"/"s"^2 $

Porównanie wartości zmierzonej z teoretyczną:
 $ g_0 = 9.811 " " "m"/"s"^2 $
 $ |g - g_0| = abs(9.93 " " "m"/"s"^2 - 9.811  " " "m"/"s"^2) = 0.118 " " "m"/"s"^2 < U(g) $

 Otrzymany wynik jest zgodny z wartością przyspieszenia ziemskiego dla Krakowa.

 $ bold(g = (9.93 plus.minus 0.14)  " " "m"/"s"^2  ) $
 
#pagebreak()

#v(1em)
== Sposób drugi

=== Pomiar długości wahadła oraz okresów drgań
#v(1em)
#align(center + top)[
  #table(
    columns: (3cm, 3cm, 3cm, 3cm, 3cm, 3cm),
    inset: 4pt,
    align: center,
    [*Nr\ pomiaru*], [*Długość\ wahadła*], [*Czas\ 10 okresów*], [*Czas 1\ okresu*], [*Średni okres dla danego L*], [*Kwadrat okresu*],
    [*i*], [$bold(L_i ["m"])$], [$bold(10T_i ["s"])$], [$bold(T_i ["s"])$], [$bold(T_"iśr" ["s"])$], [$bold(T_i^2 ["s"^2])$ ],
    [*1*], table.cell(rowspan: 3)[0.530], 
    [14.24], [1.424], table.cell(rowspan: 3)[1.4187], table.cell(rowspan: 3)[2.0126],
    [*1*], [14.18], [1.418], 
    [*1*], [14.14], [1.414], 
    [*2*], table.cell(rowspan: 3)[0.400], 
    [12.50], [1.250], table.cell(rowspan: 3)[1.2510], table.cell(rowspan: 3)[1.5650],
    [*2*], [12.62], [1.262],  
    [*2*], [12.41], [1.241],
    [*3*], table.cell(rowspan: 3)[0.270], 
    [10.14], [1.014], table.cell(rowspan: 3)[1.0257], table.cell(rowspan: 3)[1.0520],
    [*3*], [10.25], [1.025], 
    [*3*], [10.38], [1.038],  
    [*4*], [0.640], table.cell(colspan: 2)[z poprzedniej części ćw.], [1.5952], [2.5447]
  )
]

#align(center)[W wynikach pomiarów nie zaobserwowano żadnych błędów grubych.]
#v(1em)

=== Wykres zależności okresu od długości wahadła $T(l)$
#v(1em)
#align(center)[
    #figure(
    image("wyk1.png", width: 90%),
    caption: [
      Wykres zależności okresu od długości wahadła $T(l)$ 
    ],
  )
  ]

#pagebreak()

#v(1em)

=== Zlinearyzowany wykres $T^2$ w funkcji $l$
#v(1em)

Wzór $T=2pi sqrt(l/g)$  możemy przekształcić i zapisać jako zależność liniową $T^2=(4pi^2)/g l$, gdzie typ zależności liniowej to $y = A x + B$ oraz odpowiednio $y -> T^2, x -> l, A -> (4pi^2)/g$.\
Wykorzystując dane z tabeli powyżej, na wykres naniesiono 4 punkty o współrzędnych $(L_i, T_i ^2)$.
Przy pomocy funkcji _REGLINP_ programu _Microsoft Excel_ dopasowano do nich prostą regresji $T_i ^2 = A dot l_i + B$.

#v(1em)
#align(center)[
    #figure(
    image("wyk2.png", width: 90%),
    caption: [
      Wykres dopasowanej prostej zależności $T^2(l)$ 
    ],
  )
  ]

Otrzymano wartość współczynnika $A$ oraz jej niepewność $u(A)$:
$ A = 3.96  " " "s"^2/"m", u(A) = 0.19 " " "s"^2/"m" $

=== Obliczenie przyspieszenia ziemskiego wraz z niepewnością
#v(1em)

Ze wzoru $A = (4pi^2)/g$ można wyliczyć $g = (4pi^2)/ A$:

$ g = (4pi^2)/(3.96   " " "s"^2/"m") = 9.9693  " " "m"/"s"^2  $

Niepewność obliczamy z prawa przenoszenia niepewności:
 $ u_C (g) = sqrt(((4pi^2)/(-A^2))^2(u(A))^2) = (4pi^2 u(A))/(A^2) $

 $ u_C (g) = (4pi^2 dot 0.19 " " "s"^2/"m") / (3.96  " " "s"^2/"m")^2 = 0.4783 " " "m"/"s"^2 approx 0.48 " " "m"/"s"^2 $

 #pagebreak()

 #v(1em)

 Niepewność rozszerzona:
 $ U(g) = u_C (g) dot k $

 $ U(g) = 0.48 " " "m"/"s"^2 dot 2 = 0.96 " " "m"/"s"^2 $

 === Przyspieszenie ziemskie otrzymane przy pomocy sposobu drugiego

#v(1em)

Odpowiednio zaokrąglamy wynik:
$ g = 9.9693 " " "m"/"s"^2 approx 9.97 " " "m"/"s"^2 $

Porównanie wartości zmierzonej z teoretyczną:
 $ |g - g_0| = abs(9.97 " " "m"/"s"^2 - 9.811  " " "m"/"s"^2) = 0.159 " " "m"/"s"^2 < U(g) $

 Otrzymany wynik jest zgodny z wartością przyspieszenia ziemskiego dla Krakowa.

 $ bold(g = (9.97 plus.minus 0.96)  " " "m"/"s"^2  ) $

 = Wnioski
#v(1em)
Wartości przyspieszenia grawitacyjnego $g_1 = (9.93 plus.minus 0.14)  " " "m"/"s"^2$  oraz $g_2 = (9.97 plus.minus 0.96)  " " "m"/"s"^2$ otrzymane kolejno z pierwszego i drugiego sposobu wykonania ćwiczenia są zgodne z przyspieszeniem dla Krakowa $g_0 = 9.811" " "m"/"s"^2$ w granicach niepewności. Przyjęta metoda pozwala wyznaczyć dobre przybliżenie przyspieszenia ziemskiego. Na dokładność wpływ mogły mieć:
- czas reakcji człowieka podczas obsługi stopera,
-  problem z dokładnym ustaleniem środka ciężkości zawieszonego ciała oraz punktu zaczepienia nici,
- niedoskonałe wprawianie wahadła w ruch,
- niewielka liczba pomiarów.

#align(bottom)[
#bibliography("bib.yml")
]