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

  #text(size: 18pt, [Fizyka 2 - laboratorium 7])

  #text(size: 21pt, [*Busola stycznych*])
  #v(2em)
    Ćwiczenie nr 41

    12 listopada 2024
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
      align(horizon)[Busola stycznych],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(41, [Busola stycznych], "12.11.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie

== Cel ćwiczenia
Zapoznanie się z budową i działaniem przyrządu nazwanego busolą stycznych. Wyznaczenie składowej poziomej ziemskiego pola magnetycznego.

== Wstęp teoretyczny
Prąd płynący przez przewodnik wytwarza wokół niego pole magnetyczne. Wektor indukcji tego pola w dowolnym punkcie można traktować jako superpozycję przyczynków $d arrow(B)$, które pochodzą od poszczególnych elementów $d arrow(l)$ długości przewodnika.

Wartość oraz kierunek $d arrow(B)$ określa wzór Biota-Savarta:

$ d arrow(B) = (mu_0 I d arrow(l) crossmark arrow(r)) / (4 pi abs(arrow(r)) ^ 3) $

gdzie $mu_0 = 4 pi dot 10^(-7) upright("Vs"/"Am")$ to stała magnetyczna, $I$ to natężenie prądu, a $arrow(r)$ jest wektorem łączącym element $d arrow(l)$ i punkt, w którym obliczamy pole.

#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    Kierunek wektora $d arrow(B)$ jest prostopadły do płaszczyzny wektorów $d arrow(l)$ oraz $arrow(r)$ (zgodnie z własnościami iloczynu wektorowego).
  ],
  align(right + top)[
    #figure(
      caption: [Ilustracja prawa Biota–Savarta @opis1],
      image("ilustrprbiota.png", width: 70%),
    )
  ]
)

#v(1em)

Stosując prawo Biota-Savarta do obliczenia pola magnetycznego w środku przewodnika kołowego o promieniu R, można otrzymać wzór na wartość indukcji pola magnetycznego dla środka cewki kołowej, lub bardzo krótkiej zwojnicy złożonej z $N$ zwojów:

$ B = mu_0 (N I)/(2R) $

#pagebreak()

Wykorzystując znajomość pola w środku cewki kołowej, można zbudować przyrząd służący do pomiaru poziomej składowej pola magnetycznego Ziemi - busolę stycznych. Busola wykorzystuje oddziaływanie pola magnetycznego, które jest generowane przez cewkę z prądem, na igłę magnetyczną. Uzwojenie cewki, zazwyczaj wykonane z miedzi, jest nawinięte na cienką obręcz z materiału nieferromagnetycznego, takiego jak mosiądz czy aluminium. Igła magnetyczna znajduje się w środku tej obręczy i jest zamocowana w sposób umożliwiający jej swobodny obrót w płaszczyźnie poziomej. Wokół igły znajduje się skala kątowa, na której można odczytać jej wychylenie. Oddziaływanie pola magnetycznego z momentem magnetycznym igły powoduje, że ustawia się ona równolegle do poziomej składowej pola wypadkowego. Gdy w cewce nie płynie prąd, igła magnetyczna ustawia się równolegle do poziomej składowej ziemskiego pola magnetycznego $B_0$. Busolę można ustawić tak, aby kierunek $B_0$ znajdował się w płaszczyźnie zwojów.

Gdy przez cewkę płynie prąd, generowane jest pole magnetyczne $B$, którego kierunek jest prostopadły do płaszczyzny zwojów. W wyniku tego igła magnetyczna ustawia się zgodnie z kierunkiem wypadkowego pola magnetycznego.

Wektory pola wypadkowego $arrow(B)_w$, pola ziemskiego $arrow(B)_0$ oraz pola cewki $arrow(B)$ tworzą trójkąt prostokątny. Na podstawie tego można zauważyć, że:

$ B / B_0 = tan(alpha) $
$ B_0 = B/tan(alpha) = mu_0 (N I)/ (2R tan(alpha)) $

Poprzez pomiar kąta wychylenia igły oraz natężenia prądu można wyznaczyć składową poziomą indukcji ziemskiego pola magnetycznego.

#align(center + top)[
  #figure(
    image("schembus.png", height: 35%),
    caption: [ Schemat busoli stycznych. Oznaczenia wektorów: $arrow(B)_0$ - pole Ziemi,\ $arrow(B)$ - pole wytwarzane przez cewkę i $arrow(B)_w$ - pole wypadkowe @opis1.]
  )
]

#pagebreak()

= Układ pomiarowy

#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Busola stycznych* (składająca się ze zwojnicy z igłą magnetyczną w jej centrum oraz skali stopniowej do odmierzania kąta odchylenia)
    + *Zasilacz napięcia stałego*
    + *Amperomierz analogowy* (klasa 0.5)
    + *Przełącznik kierunku prądu*

  ],
  align(right + horizon)[
    #figure(
      image("uzwojenia.png", width: 80%),
      caption: [Schemat uzwojeń busoli @instr1]
    )<1>
  ]
)

#align(center)[
  #figure(
    image("ukladelektr.png", width: 80%),
    caption: [Układ elektryczny busoli stycznych @instr1]
  )
]
#v(1em)
Cewka busoli stycznych posiada wyprowadzenia, na których oznaczenia 4, 16 i 40 wskazują liczbę zwojów między danym zaciskiem a zaciskiem 0. Poprzez odpowiednie połączenie przewodów możliwe jest jednak uzyskanie innych liczby zwojów, takich jak 12, 16, 24, 36 i 40 (#ref(<1>)).

= Przebieg ćwiczenia
#v(1em)
Przed rozpoczęciem pomiarów zapoznano się z budową busoli oraz elementami układu elektrycznego. Ustawiono płaszczyznę zwojów równolegle do płaszczyzny południka magnetycznego Ziemi (zgodnie z kierunkiem wskazania igły magnetycznej). W tej samej płaszczyźnie ustawiono główną oś kątomierza. Dla zadanej liczby zwojów dobrano natężenie prądu tak, aby kąt wychylenia igły busoli, po jej ustabilizowaniu, zawierał się w przedziale od około $25 degree$ do około $65 degree$. Zmierzono i zanotowano wartość kąta wychylenia w lewo. Następnie zmieniono zwrot prądu w obwodzie i zmierzono kąt wychylenia w przeciwnym kierunku. Całą procedurę pomiarową powtórzono dla różnych wartości natężenia prądu oraz różnej liczby zwojów. Wyniki pomiarów zapisano w tabeli.

#pagebreak()

= Analiza danych pomiarowych
#v(1em)

Odczytano następujące dane:

klasa amperomierza $= 0.5$

Większość pomiarów została wykonana na ustawionym zakresie $750 " "upright(m A)$.

Średnica cewki $d = 260 " " upright(m m)$\
$u_B (d) = 3 " "upright(m m) $

#v(1em)

#align(center + top)[
  #show table.cell.where(x: 6, y: 22): set text(rgb(255, 0, 0))
  #set text(size: 11pt)
  #figure(
    table(
      rows: 25,
      align: center + horizon,
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      [*Lp.*], [*Liczba zwojów* $bold(N)$], [*Prąd* $bold(I " " upright([m A]))$], [*Kąt\ wychylenia w lewo* $bold(alpha " " upright([degree]))$], [*Kąt\ wychylenia w prawo* $bold(alpha " " upright([degree]))$], [*Średni kąt\ wychylenia * $bold(overline(alpha) " " upright([degree]))$], [$bold(B_0\ " " upright([mu T]))$], [$bold((B_i - B_0)^2\ " " upright([(mu T)^2]))$],
      ..csv("wyniki.csv").flatten()
    ),
    caption: [Wyniki pomiarów, gdzie $B_0 = mu_0 (N I)/ (2R tan(alpha))$.\ $B_0_22$ (oznaczone na czerwono) wyraźnie różni się od pozostałych wyników i zostało pominięte w dalszych obliczeniach]
  )
]

#pagebreak()

Jako wartość składowej poziomej indukcji ziemskiego pola magnetycznego przyjęto średnią arytmetyczną z wielkości $B_i$:

$ B_0 = overline(B) = 19.8371 " " upright(mu T) $

#v(1em)
Następnie wyznaczono niepewność pomiarową.

$ u_A (B_0) = sqrt((sum(B_i - B_0)^2)/(N dot (N - 1))) $

$ u_A (B_0) = 0.2077 " " upright(mu T) approx 0.21 " " upright(mu T) $

$ (u_A (B_0)) / B_0 dot 100% = (0.21 " " upright(mu T)) / (19.8371 " " upright(mu T)) dot 100% approx 1.06 % $

#v(1em)

Pomiar wykonywany był dla różnej wartości natężenia prądu. Dla uproszczenia przyjmijmy jeden wybrany zakres i wartość prądu równą połowie zakresu.
#v(1em)

$ u_B (I) = Delta I = ("zakres" dot "klasa") / 100 = (750 " "upright(m A) dot 0.5) / 100 = 3.75 " "upright(m A) approx 3.8 " "upright(m A) $

$ (u_B (I)) / I dot 100% = (3.8 " "upright(m A)) / (375 " "upright(m A) ) dot 100% approx 1.01 % $

#v(1em)
Następnym błędem systematycznym jest błąd pomiaru promienia. Ponieważ udostępniono nam jedynie błąd pomiaru średnicy, wykorzystamy go zamiennie. Wzór, na którym opieramy odpowiedź, zawiera promień w postaci $2 R$, co odpowiada średnicy, dlatego takie podejście jest uzasadnione.
#v(1em)

$ u_B (d) = 3 " "upright(m m) $
$ (u_B (d))/d dot 100% = (3 " "upright(m m)) / (260 " " upright(m m)) dot 100% approx 1.15% $

#v(1em)

$ (u_C (B_0)) /B_0 dot 100% = sqrt([(u_A (B_0)) / B_0 dot 100%] ^ 2 + [(u_B (I)) / I dot 100%]^2 + [(u_B (d))/d dot 100%]^2) $

$ (u_C (B_0)) /B_0 dot 100% = sqrt([1.06 %] ^ 2 + [1.01 %]^2 + [1.15%]^2) approx 1.86 % $

#v(1em)
$ u_C (B_0) = B_0 dot (u_C (B_0)) /B_0 = 19.8371 " " upright(mu T) dot (1.86%)/(100%) = 0.369 " " upright(mu T) approx 0.37 " " upright(mu T) $

#pagebreak()

Przyjmując za $k = 2$, można obliczyć niepewność rozszerzoną.

$ U(B_0) = k dot u_C (B_0) $
$ U(B_0) = 2 dot 0.37 " " upright(mu T) = 0.74 " " upright(mu T) $

#v(1em)
Wynik zaokrąglony do niepewności:

$ B_0 approx 19.84 " " upright(mu T) $

$ bold(B_0 = (19.84 plus.minus 0.74)" " upright(mu T)) $

#v(1em)
Wartość tabelaryczna dla Krakowa wynosi około $21 " " upright(mu T)$.

$ abs(B_0 - B_0_"tab") = abs(19.84 " " upright(mu T) - 21 " " upright(mu T)) = 1.16 " " upright(mu T) > U(B_0) $

Otrzymana wartość poziomej składowej ziemskiego pola magnetycznego nie jest zgodna z wartością tablicową w granicach niepewności.

#v(1em)
= Wnioski
#v(1em)
W trakcie ćwiczenia otrzymano wartość poziomej składowej pola magnetycznego\ $B_0 = (19.84 plus.minus 0.74)" " upright(mu T)$. Nie jest ona zgodna z wartością tabelaryczną dla Krakowa w granicach niepewności. Na dokładność pomiaru wpływ mogły mieć różne czynniki, takie jak jakość źródła prądu, konstrukcja busoli czy błąd ludzki obecny na różnych etapach pomiaru, od regulacji natężenia prądu na zasilaczu za pomocą pokrętła, po odczyt kąta na busoli. Istotnym czynnikiem mógł być również efekt paralaksy, który występuje podczas odczytu kąta, gdy patrzy się na skalę pod nieodpowiednim kątem, co prowadzi do błędnych wyników. Dodatkowo, otoczenie stanowiska pomiarowego mogło mieć właściwości magnetyczne, które mogło wpłynąć na ustawienie igły magnetycznej.

#align(bottom)[
#bibliography("bib.yml")
]