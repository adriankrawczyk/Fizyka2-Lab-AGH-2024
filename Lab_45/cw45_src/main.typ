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

  #text(size: 18pt, [Fizyka 2 - laboratorium 2])

  #text(size: 21pt, [*Wyznaczanie ładunku właściwego $e/m$ elektronu*])
  #v(2em)
    Ćwiczenie nr 45

    8 października 2024
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
      align(horizon)[Wyznaczanie ładunku właściwego $e/m$ elektronu],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(45, [Wyznaczanie ładunku właściwego $e/m$ elektronu], "08.10.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie

== Cel ćwiczenia
Obserwacja toru ruchu elektronu w jednorodnym polu magnetycznym, wytworzonym przez układ dwóch cewek Helmholtza. Wyznaczenie ładunku właściwego $e/m$ elektronu metodą badania ruchu wiązki elektronów w jednorodnym polu magnetycznym.

== Wstęp teoretyczny
Do wyznaczenia ładunku właściwego elektronu wykorzystamy w wysokim stopniu jednorodne pole magnetyczne. Na elektron w takim polu oddziałuje siła Lorentza wyrażona wzorem:
$ arrow(F) = e arrow(v) times arrow(B) $
gdzie $e$ to ładunek elektronu, $arrow(v)$ to prędkość ładunku,  a $arrow(B)$ to wektor indukcji pola magnetycznego.

Siła ta działa w kierunku prostopadłym zarówno do indukcji pola $arrow(B)$, jak i do prędkości $arrow(v)$ ładunku, zakrzywiając jego tor i nie wpływając na zmianę wartości jego prędkości. Jeżeli pole magnetyczne jest dostatecznie silne, to elektron zacznie poruszać się po okręgu. W takim przypadku siła Lorentza równa jest sile dośrodkowej, z czego możemy wyznaczyć $e/m$:
$ e v B = (m v^2) / r $
$ e/m = v/(B r) $
gdzie $m$ to masa elektronu, a $r$ to promień zataczanego okręgu.

Ładunek jest rozpędzany w polu elektrycznym na drodze o różnicy potencjałów $U$, więc zależność jego prędkości $v$ można wyznaczyć z zasady zachowania energii:
$ (m v ^2)/2 = e U <=> v = sqrt((2e U)/m) $
Po podstawieniu do poprzedniego wzoru otrzymujemy:
$ e/m = (2U)/(B^2 r^2) $

#pagebreak()
#v(1em)

Przy założeniu, że przez obie cewki układu Helmholtza płynie taki sam prąd, indukcję pola magnetycznego $B$ w środku takiego układu można obliczyć ze wzoru:
$ B = 0.715 mu_0 (n I)/R $

Po podstawieniu wyrażenia oraz przyjęciu za przenikalność magnetyczną powietrza\ $mu_0 = 1.256 dot 10^(-6) " " "Tm"/"A"$ ostatecznie otrzymujemy:

$ e/m = 2.480 dot 10^12 (U R^2)/(n^2 I^2 r^2) $

Do wyznaczenia ładunku właściwego elektronu potrzebne są: liczba zwojów wraz z ich promieniem, napięcie przyspieszające, natężenie prądu płynącego w cewkach oraz promień zataczanego przez elektron okręgu.

= Układ pomiarowy
#v(1em)
#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Układ dwóch cewek Helmholtza*\ (Rysunek 1)
    + *Lampa katodowa ze skalą o kształcie poziomej drabinki*
    + *Zasilacz cewek*
    + *Zasilacz lampy katodowej*
    + *Multimetry*
    + *Miernik*
  ],
  align(right)[
    #figure(
    image("cewki.png", width: 50%),
    caption: [
      Układ dwóch cewek Helmholtza @cwiczenia. 
    ],
  )
  ]
)

#v(2em)
#figure(
    image("uklpom.png", width: 90%),
    caption: [
      Ogólny widok układu pomiarowego @electronic. 
    ],
  )

#pagebreak()

#figure(
    image("schem1.png", width: 70%),
    caption: [
      Schemat obwodu zasilania cewek Helmholtza @cwiczenia. 
    ],
  )

#figure(
    image("schem2.png", width: 70%),
    caption: [
      Schemat obwodu zasilania lampy katodowej @cwiczenia. 
    ],
  )

= Przebieg ćwiczenia
#v(1em)
Po sprawdzeniu układu i podłączeniu go do zasilania, rozpoczęto właściwą część ćwiczenia. Najpierw uruchomiono obwód żarzenia, a po upływie minuty załączono napięcie siatkowe o wartości 30 V oraz napięcie anodowe, które początkowo ustawiono na 175 V. Prawidłowość napięć zweryfikowano na podłączonych miernikach. Układ stabilizował się przez około 3 minuty, po czym zaobserwowano wyraźny ślad wiązki elektronów emitowanej przez działo elektronowe lampy katodowej. Następnie uruchomiono zasilacz cewek Helmholtza i obserwując tor wiązki elektronowej, zwiększano natężenie prądu w cewkach, dążąc do uzyskania toru o kształcie okręgu. W kolejnym etapie przeprowadzono serię pomiarów dla różnych wartości napięcia anodowego: 150 V, 175 V, 190 V, 200 V i 210 V. Dla każdego z tych napięć regulowano natężenie prądu płynącego przez cewki, odczytując jego wartość w momencie, gdy wiązka trafiała w kolejne szczeble drabinki umieszczonej wewnątrz lampy. Drabinka ta służyła jako punkt odniesienia, umożliwiając określenie promienia toru wiązki elektronów dla wartości 2, 3, 4 oraz 5 cm.

= Analiza danych pomiarowych

== Wyniki pomiarów
#v(1em)

Odczytano promień $R$ cewek układu Helmholtza oraz liczbę zwojów $n$:
$ R = 0.2 " m" $
$ n = 154 $

#pagebreak()
#v(1em)
#figure(
  caption: [Wyniki pomiarów natężenia prądu $I$ płynącego w cewkach dla różnych promieni
zataczanych przez wiązkę okręgów i dla różnych wartości napięcia anodowego.
],
  align(center + top)[
    #table(
      columns: (auto, auto, auto, auto, 15em),
      inset: 4pt,
      align: center + horizon,
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(U "[V]")$]]],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(r "[m]")$]]],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(I "[A]")$]]],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(e/m ["C"/"kg"])$]]],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(((e/m)_i - (e/m)_"śr")^2 ["C"^2/"kg"^2])$]]],
      table.cell(rowspan: 4)[*150*], [0.02], [3.28], [$1.4580 dot 10^(11)$],[$2.3584 dot 10^(20)$],
      [0.03], [2.04], [$1.6752 dot 10^(11)$], [$4.0463 dot 10^(19)$],
      [0.04], [1.49], [$1.7663 dot 10^(11)$], [$2.3951 dot 10^(20)$],
      [0.05], [1.19], [$1.7723 dot 10^(11)$], [$2.5825 dot 10^(20)$],
      table.cell(rowspan: 4)[*175*], [0.02], [3.53], [$1.4686 dot 10^(11)$], [$2.0442 dot 10^(20)$],
       [0.03], [2.27], [$1.5784 dot 10^(11)$], [$1.1002 dot 10^(19)$],
       [0.04], [1.65], [$1.6804 dot 10^(11)$], [$4.7433 dot 10^(19)$],
     [0.05], [1.32], [$1.6804 dot 10^(11)$], [$4.7433 dot 10^(19)$],
      table.cell(rowspan: 4)[*190*], [0.02], [3.65], [$1.4913 dot 10^(11)$], [$1.4451 dot 10^(20)$],
     [0.03], [2.34], [$1.6127 dot 10^(11)$], [$1.2697 dot 10^(16)$],
       [0.04], [1.72], [$1.6790 dot 10^(11)$], [$4.5464 dot 10^(19)$],
      [0.05], [1.36], [$1.7187 dot 10^(11)$], [$1.1484 dot 10^(20)$],
     table.cell(rowspan: 4)[*200*], [0.02], [3.80], [$1.4483 dot 10^(11)$], [$2.6638 dot 10^(20)$],
       [0.03], [2.46], [$1.5360 dot 10^(11)$], [$5.7111 dot 10^(19)$],
     [0.04], [1.79], [$1.6318 dot 10^(11)$], [$4.1083 dot 10^(18)$],
       [0.05], [1.42], [$1.6595 dot 10^(11)$], [$2.3007 dot 10^(19)$],
      table.cell(rowspan: 4)[*210*], [0.02], [3.87], [$1.4662 dot 10^(11)$], [$2.1115 dot 10^(20)$],
      [0.03], [2.49], [$1.5742 dot 10^(11)$], [$1.3988 dot 10^(19)$],
     [0.04], [1.83], [$1.6393 dot 10^(11)$], [$7.7147 dot 10^(18)$],
     [0.05], [1.44], [$1.6944 dot 10^(11)$], [$6.8683 dot 10^(19)$],
    )
  ]
)
#v(1em)
#align(center)[W wynikach pomiarów nie zaobserwowano żadnych błędów grubych.]
#v(1em)

$ (e/m)_"śr" = 1.6116 dot 10^11 " ""C"/"kg" $

#v(1em)
== Niepewność standardowa $u_A (e/m)$
#v(1em)

$ sum_(i=1)^20 ((e/m)_i - (e/m)_"śr")^2 = 2.0413 dot 10^21 " ""C"^2/"kg"^2 $

$ u_A (e/m) = sqrt((sum((e/m)_i - (e/m)_"śr")^2)/(N(N - 1))) $ 
$ u_A (e/m) = sqrt((2.0413 dot 10^21 ["C"^2/"kg"^2])/(20(20 - 1))) = 2.3177 dot 10^9 " ""C"/"kg" approx 2.4 dot 10^9 " ""C"/"kg" $

#pagebreak()

== Niepewność rozszerzona
#v(1em)

$ U(e/m) = u_A (e/m) dot k $
gdzie k to współczynnik rozszerzenia  (przyjmujemy k = 2):

$ U(e/m) = 2.4 dot 10^9 " ""C"/"kg" dot 2 = 4.8 dot 10^9 " ""C"/"kg" $

== Otrzymany ładunek właściwy elektronu
#v(1em)
Odpowiednio zaokrąglamy wynik (uwzględniając różnicę w rzędach wielkości) :
$ (e/m)_"śr" = 1.6116 dot 10^11 " ""C"/"kg" approx 1.612 dot 10^11 " ""C"/"kg" $

Porównanie wartości zmierzonej z teoretyczną:
$ (e/m)_0 = 1.759 dot 10^11 " ""C"/"kg" $

 $ abs(e/m - (e/m)_0) = abs(1.612 dot 10^11 " ""C"/"kg" - 1.759 dot 10^11 " ""C"/"kg") = 1.47 dot 10^10 " ""C"/"kg" > U(e/m) $

#v(1em)
Otrzymany wynik nie jest zgodny z tablicową wartością ładunku właściwego elektronu.

$ bold(e/m = (1.612 dot 10^11 plus.minus 4.8 dot 10^9) " ""C"/"kg") $
 
= Wnioski
#v(1em)

Wartość ładunku właściwego $e/m = (1.612 dot 10^11 plus.minus 4.8 dot 10^9) " ""C"/"kg"$ nie jest zgodna z wartością teoretyczną $(e/m)_0 = 1.759 dot 10^11 " ""C"/"kg"$ w granicach niepewności. Na tę rozbieżność wpływ mogły mieć: niedoskonałość wykorzystanych przyrządów, zjawisko paralaksy związane z patrzeniem pod kątem na wskazania miernika analogowego, możliwość że kształt toru ruchu wiązki elektronów nie był doskonale kolisty. Ponadto warto zwrócić uwagę, że dla każdego z napięć anodowych, wartości ładunku właściwego dla $r = 2 " cm"$ są wyraźnie zaniżone w stosunku do pozostałych pomiarów. Może to sugerować, że promień przyjęty dla pierwszego szczebla drabinki nie jest dostatecznie dokładnie określony.

#align(bottom)[
#bibliography("bib.yml")
]