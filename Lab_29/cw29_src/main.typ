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

  #text(size: 18pt, [Fizyka 2 - laboratorium 3])

  #text(size: 21pt, [*Fale podłużne w ciałach stałych*])
  #v(2em)
    Ćwiczenie nr 29

    15 października 2024
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
      align(horizon)[Fale podłużne w ciałach stałych],
      line(length: 200%, stroke: 0.3pt)
    )
  ],
)

#v(1em)
#header_table(29, [Fale podłużne w ciałach stałych], "15.10.2024", none, none, none)

#set heading(numbering: "1.")
#v(1em)

= Wprowadzenie

== Cel ćwiczenia
Wyznaczenie modułu Younga dla różnych materiałów na podstawie pomiaru prędkości
rozchodzenia się fali dźwiękowej w pręcie.

== Wstęp teoretyczny
Fala podłużna w pręcie jest zjawiskiem, które zachodzi, gdy część pręta zostaje chwilowo wytrącona ze stanu równowagi. To zaburzenie wywołuje serię drgań, które dzięki elastycznym właściwościom materiału, mogą być propagowane wzdłuż całej długości pręta. Proces ten umożliwia rozprzestrzenianie się fali w całym ośrodku. Prędkość, z jaką fala przemieszcza się w pręcie, jest determinowana przez dwa kluczowe czynniki charakteryzujące materiał: jego bezwładność oraz sprężystość. Te właściwości fizyczne ośrodka, w którym fala się rozprzestrzenia, mają bezpośredni wpływ na szybkość jej propagacji. Rozważając m.in. mały wycinek jednorodnego pręta oraz biorąc pod uwagę prawo Hooke'a:
$ sigma = epsilon E $
gdzie:\

$sigma$ - naprężenie\ $epsilon$ - odkształcenie względne\ $E$ - moduł Younga,\

otrzymujemy związek pomiędzy modułem Younga a prędkością rozchodzenia się fali:

$ v = sqrt(E/rho) $

gdzie $rho$ to gęstość materiału, z którego wykonany jest pręt.

Z czego wynika, że moduł Younga jest równy:
$ E = rho v^2 $

W pręcie powstaje fala stojąca poprzez interferencję fal padającej i odbitej. Odległość między węzłami fali stojącej wyraża się wzorem:
$ l = 1/2 lambda => lambda = 2l $

Znając długość fali $lambda$ oraz jej częstotliwość $f$ można obliczyć prędkość fali:
$ v = 2l f $

Podstawiając powyższe równanie do poprzedniego wzoru na moduł Younga, otrzymujemy ostateczny wzór:
$ E = 4 rho l^2 f^2 $

Fala dźwiękowa w pręcie może zostać przybliżona jako złożenie drgań harmonicznych sinusoidalnych. Aplikacja szybkiej transformaty Fouriera umożliwia analizę pakietu sinusoid, pozwalając określić odpowiadające im wartości częstotliwości. Częstotliwość podstawowa, odpowiadająca najniższemu tonowi, jest bazą szeregu częstotliwości harmonicznych. Częstotliwości harmoniczne stanowią całkowite wielokrotności częstotliwości podstawowej, co wyraża się zależnością:
$ f_k = f_0 dot k $
gdzie $k = 2, 3, ...$

#v(1em)
= Układ pomiarowy
#v(1em)

#grid(
  columns: (1fr, 1fr),
  align(horizon + left)[
    + *Komputer stacjonarny*
      - System Windows 10
      - Mikrofon
      - Oprogramowanie Zelscope
    + *Zestaw czterech prętów*
      - Aluminiowy
      - Miedziany
      - Stalowy
      - Mosiężny
    + *Przyrządy pomiarowe*
      - Suwmiarka (dokładność: 0.05 mm)
      - Miarka w rolce (dokładność: 1 mm)
      - Waga elektroniczna (dokładność: 1 g)
    + *Akcesoria*
      - Młotek (do wzbudzania fal podłużnych)
  ],
  align(right + top)[
    #figure(
      image("csm_029_o1_651305ac8a.png", width: 90%),
      caption: [Ogólny widok układu pomiarowego z komputerem i oprogramowaniem Zelscope @strona.]
    )
  ]
)


= Przebieg ćwiczenia
#v(1em)
Ćwiczenie rozpoczęto od dokonania pomiarów długości, średnicy przekroju oraz masy próbek. Następnie zmierzono długości prętów. Włączono komputer i skonfigurowano oprogramowanie Zelscope. Pręty kolejno poddawano uderzeniom młotkiem, w celu wytworzenia fali podłużnej, oraz rejestrowano częstotliwości kolejnych harmonicznych dla każdego materiału (dokładność odczytu częstotliwości wynosiła 20 Hz). Wyniki zapisano w tabeli.

#pagebreak()

= Analiza danych pomiarowych

== Wyniki pomiarów dla próbek
#v(1em)
#figure(
  caption: [Wyniki pomiarów masy $m$, długości $h$ i średnicy $d$ próbek prętów, a także
długości prętów $l$, z wyznaczoną objętością $V = pi (d/2)^2 h$ i gęstością $rho = m/V$, wraz z niepewnościami.],
  align(center + top)[
    #table(
      columns: (5em, 7em, auto, auto, auto, auto, auto, auto, auto, auto),
      inset: 4pt,
      align: center + horizon,
      table.cell(colspan: 2)[], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Próbka 1*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Próbka 2*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Próbka 3*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Próbka 4*]]],
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Materiał*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Aluminium*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Mosiądz*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Miedź*]]], 
      table.cell(colspan: 2)[#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Stal*]]],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(m "[g]")$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_B (m) "[g]")$ ]]], [69], [1], [114], [1], [120], [1], [107], [1],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(h "[cm]")$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_B (h) "[cm]")$ ]]], [12], [0.1], [12], [0.1], [12], [0.1], [12], [0.1],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(d "[cm]")$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_B (d) "[cm]")$ ]]], [1.63], [0.005], [1.2], [0.005], [1.2], [0.005], [1.2], [0.005],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(l "[cm]")$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_B (l) "[cm]")$ ]]], [196.7], [0.1], [198.8], [0.1], [197.8], [0.1], [196.8], [0.1],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(V ["cm"^3])$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_C (V) ["cm"^3])$ ]]], [25.0407], [0.26], [13.5717], [0.16], [13.5717], [0.16], [13.5717], [0.16],
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(ρ ["g"/"cm"^3])$ ]]], [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_C (ρ) ["g"/"cm"^3])$]]], [2.7555], [0.050], [8.3998], [0.13], [8.8419], [0.13], [7.8841], [0.12],
    )
  ]
)

#v(1em)
Do obliczenia niepewności złożonych skorzystano z prawa przenoszenia niepewności:
$ V = pi (d/2)^2 h = 1/4 pi d^2 h $
$ u_c (V) = sqrt(((partial V)/(partial d) dot u_B (d))^2 + ((partial V)/(partial h) dot u_B (h)) ^2) = sqrt((1/2 pi d h dot u_B (d))^2 + (1/4 pi d^2 dot u_B (h))^2) $

#v(2em)
$ rho = m/V $

$ u_C (rho) = sqrt(((partial rho)/(partial m) dot u_B (m))^2 + ((partial rho)/(partial V) dot u_C (V)) ^2) = sqrt((1/V dot u_B (m))^2 + ((-m)/V^2 dot u_C (V))^2) $

#pagebreak()

Odpowiednio zaokrąglone wyznaczone wartości:

#align(center + top)[
  #set text(size: 11pt)
  #grid(
    align: center + horizon,
    inset: 15pt,
    columns: (auto, auto, auto, auto),
    [$ V_"Al" approx 25.04 " ""cm"^3 $
  $ u_C (V_"Al") = 0.26 " ""cm"^3 $ ],
  grid.vline(stroke: 0.3pt),
    [$ V_"CuZn" approx 13.57 " ""cm"^3 $
  $ u_C (V_"CuZn") = 0.16 " ""cm"^3 $],
  grid.vline(stroke: 0.3pt),
    [$ V_"Cu" approx 13.57 " ""cm"^3 $
  $ u_C (V_"Cu") = 0.16 " ""cm"^3 $],
  grid.vline(stroke: 0.3pt),
    [$ V_"FeC" approx 13.57 " ""cm"^3 $
  $ u_C (V_"FeC") = 0.16 " ""cm"^3 $],
  )
]

#align(center + top)[
  #set text(size: 11pt)
  #grid(
    align: center + horizon,
    inset: 15pt,
    columns: (auto, auto, auto, auto),
    [$ rho_"Al" approx 2.756 " ""g"/"cm"^3 $
  $ u_C (rho_"Al") = 0.050 " ""g"/"cm"^3 $ ],
  grid.vline(stroke: 0.3pt),
    [$ rho_"CuZn" approx 8.40 " ""g"/"cm"^3 $
  $ u_C (rho_"CuZn") = 0.13 " ""g"/"cm"^3 $],
  grid.vline(stroke: 0.3pt),
    [$ rho_"Cu" approx 8.84 " ""g"/"cm"^3 $
  $ u_C (rho_"Cu") = 0.13 " ""g"/"cm"^3 $],
  grid.vline(stroke: 0.3pt),
    [$ rho_"FeC" approx 7.88 " ""g"/"cm"^3 $
  $ u_C (rho_"FeC") = 0.12 " ""g"/"cm"^3 $],
  )
]

== Wyniki pomiarów dla poszczególnych prętów


#figure(
  caption: [Częstotliwości składowych harmonicznych $k$ zarejestrowane dla poszczególnych
prętów oraz wyliczone długości fali $lambda_k = (2l)/k$ (gdzie $l$ jest długością pręta), prędkość fali dźwiękowej $v_k = lambda_k f_k$ oraz niepewności złożone $u_c (lambda_k)$ i $u_c (v_k)$.], 
  align(center + top)[
    #table(
      columns: (7em, auto, auto, auto, 6em, auto, 6em),
      inset: 4pt,
      align: center + horizon,
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[*Materiał*]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[*k*]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(f_k "[Hz]")$ ]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(lambda_k "[m]")$]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_c (lambda_k) "[m]")$ ]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(v_k ["m"/"s"])$]]], 
      [#rect(width: 100%, height: 30pt)[#align(center + horizon)[$bold(u_c (v_k) ["m"/"s"])$]]],
      table.cell(rowspan: 6)[*Aluminium*], [1], [1264.71], [3.9340], [0.0020], [4975.3691], [79],
      [2], [2647.06], [1.9670], [0.0010], [5206.7670], [40],
      [3], [3911.76], [1.3113], [0.00067], [5129.6213], [27],
      [4], [5264.71], [0.9835], [0.00050], [5177.8423], [20],
      [5], [6558.82], [0.7868], [0.00040], [5160.4796], [16],
      [6], [7911.76], [0.6557], [0.00034], [5187.4773], [14],
      table.cell(rowspan: 6)[*Mosiądz*], [1], [882.35], [3.9760], [0.0020], [3508.2236], [80],
      [2], [1764.71], [1.9880], [0.0010], [3508.2435], [40],
      [3], [2670.59], [1.3253], [0.00067], [3539.4219], [27],
      [4], [3588.24], [0.9940], [0.00050], [3566.7106], [20],
      [5], [4494.12], [0.7952], [0.00040], [3573.7242], [16],
      [6], [5376.47], [0.6627], [0.00034], [3562.8075], [14],
      table.cell(rowspan: 6)[*Miedź*], [1], [964.71], [3.9560], [0.0020], [3816.3928], [80],
      [2], [1917.65], [1.9780], [0.0010], [3793.1117], [40],
      [3], [2882.35], [1.3187], [0.00067], [3800.8589], [27],
      [4], [3858.82], [0.9890], [0.00050], [3816.3730], [20],
      [5], [4811.76], [0.7912], [0.00040], [3807.0645], [16],
      [6], [5776.47], [0.6593], [0.00034], [3808.6192], [14],
      table.cell(rowspan: 6)[*Stal*], [1], [1258.82], [3.9360], [0.0020], [4954.7155], [79],
      [2], [2494.12], [1.9680], [0.0010], [4908.4282], [40],
      [3], [3764.71], [1.3120], [0.00067], [4939.2995], [27],
      [4], [5035.29], [0.9840], [0.00050], [4954.7254], [20],
      [5], [6305.88], [0.7872], [0.00040], [4963.9887], [16],
      [6], [7529.41], [0.6560], [0.00034], [4939.2930], [14],
    )
  ]
)
#pagebreak()

Przyjęto niepewność typu B dla odczytu częstotliwości:
$ u_B (f) = 20 "Hz" $

Niepewności w tabeli wyznaczono wg poniższych wzorów:

$ lambda_k  =(2l)/k $

$ u_C (lambda_k)  = sqrt(((partial lambda_k)/(partial l) dot u_B (l))^2) = abs(2/k dot u_B (l)) = 2/k dot u_B (l) $

#v(2em)

$ v_k  = lambda_k f_k $

$ u_C (v_k) = sqrt(((partial v_k)/(partial lambda_k) dot u_C (lambda_k))^2 + ((partial v_k)/(partial f_k) dot u_B (f))^2) = sqrt((f_k dot u_C (lambda_k))^2 + (lambda_k dot u_B (f))^2) $

#v(1em)
== Obliczenie średniej prędkości dźwięku w danym materiale wraz z niepewnością
#v(1em)

Na podstawie danych z powyższej tabeli, można wyznaczyć średnią prędkość dźwięku dla każdego z metali:
$ v_"śr" = 1/N sum_(k = 1)^N v_k = 1/6 sum_(k = 1)^6 v_k $

Oraz niepewność:
$ u(v_"śr") = sqrt(sum_(k = 1)^n (u(v_k)/n)^2) = sqrt(sum_(k = 1)^6 (u(v_k)/6)^2) = 1/36 sqrt(sum_(k = 1)^6 (u(v_k))^2) $

#v(1em)
=== Aluminium
#v(1em)

$ u(v_"śr"_"Al") = 16.13 " ""m"/"s" approx 17 " ""m"/"s" $

$ v_"śr"_"Al" = 5139.5928 " ""m"/"s" approx 5140 " ""m"/"s" $

#v(1em)
=== Mosiądz
#v(1em)

$ u(v_"śr"_"CuZn") = 16.22 " ""m"/"s" approx 17 " ""m"/"s" $

$ v_"śr"_"CuZn" = 3543.1885 " ""m"/"s" approx 3543 " ""m"/"s" $

#v(1em)
=== Miedź
#v(1em)

$ u(v_"śr"_"Cu") = 16.11 " ""m"/"s" approx 17 " ""m"/"s" $

$ v_"śr"_"Cu" = 3807,07 " ""m"/"s" approx 3807 " ""m"/"s" $

#v(1em)
=== Stal
#v(1em)

$ u(v_"śr"_"FeC") = 16.14 " ""m"/"s" approx 17 " ""m"/"s" $

$ v_"śr"_"FeC" = 4943,4084 " ""m"/"s" approx 4943 " ""m"/"s" $

#v(1em)

== Obliczenie modułu Younga dla poszczególnych materiałów
#v(1em)

Podczas obliczeń zostanie wykorzystany poniższy wzór:
$ E = rho v_"śr"^2 $

Z prawa przenoszenia niepewności:
$ u_C (E) = sqrt(((partial E)/(partial rho) dot u_C (rho))^2 + ((partial E)/(partial v_"śr") dot u(v_"śr"))^2) = sqrt((v_"śr"^2 dot u_C (rho))^2 + (2rho v_"śr" dot u(v_"śr"))^2) $
#v(1em)
Dla niepewności rozszerzonych przyjęto k = 2.

#v(1em)
=== Aluminium
#v(1em)

$ E_"Al" = 2.756 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot (5140 " ""m"/"s")^2 =  7.281 dot 10^10 " ""kg"/("m" dot "s"^2) = 72.81 " GPa" $
#v(1em)
$ u_C (E_"Al") = sqrt(((5140 " ""m"/"s")^2 dot 0.050 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3))^2 + (2 dot 2.756 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot 5140 " ""m"/"s" dot 17 " ""m"/"s")^2) =\ =sqrt(1.745 dot 10^18 "kg"^2/("m"^2 dot "s"^4) + 2.3198 dot 10^17 "kg"^2/("m"^2 dot "s"^4)) = 1.41 dot 10^9 "Pa" $
#v(1em)
$ u_C (E_"Al") approx 1.5 " GPa" $

$ U(E_"Al") = k dot u_C (E_"Al") = 3.0 " GPa" $

Odpowiednio zaokrąglamy wartość:

$ E_"Al" approx 72.8 " GPa" $

$ bold(E_"Al" = (72.8 plus.minus 3.0) " GPa") $

#v(1em)
=== Mosiądz
#v(1em)

$ E_"CuZn" = 8.40 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot (3543 " ""m"/"s")^2 =  1.0544 dot 10^11 " ""kg"/("m" dot "s"^2) = 105.44 " GPa" $
#v(1em)
$ u_C (E_"CuZn") = sqrt(((3543 " ""m"/"s")^2 dot 0.13 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3))^2 + (2 dot 8.40 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot 3543 " ""m"/"s" dot 17 " ""m"/"s")^2) =\ =sqrt(2.663 dot 10^18 "kg"^2/("m"^2 dot "s"^4) + 1.024 dot 10^18 "kg"^2/("m"^2 dot "s"^4)) = 1.92 dot 10^9 "Pa" $
#v(1em)
$ u_C (E_"CuZn") approx 2.0 " GPa" $

$ U(E_"CuZn") = k dot u_C (E_"CuZn") = 4.0 " GPa" $

Odpowiednio zaokrąglamy wartość:

$ E_"CuZn" approx 105.4 " GPa" $

$ bold(E_"CuZn" = (105.4 plus.minus 4.0) " GPa") $

#v(1em)
=== Miedź
#v(1em)

$ E_"Cu" = 8.84 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot (3807 " ""m"/"s")^2 =  1.2812 dot 10^11 " ""kg"/("m" dot "s"^2) = 128.12 " GPa" $
#v(1em)
$ u_C (E_"Cu") = sqrt(((3807 " ""m"/"s")^2 dot 0.13 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3))^2 + (2 dot 8.84 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot 3807 " ""m"/"s" dot 17 " ""m"/"s")^2) =\ =sqrt(3.55 dot 10^18 "kg"^2/("m"^2 dot "s"^4) + 1.309 dot 10^18 "kg"^2/("m"^2 dot "s"^4)) = 2.204 dot 10^9 "Pa" $
#v(1em)
$ u_C (E_"Cu") approx 2.3 " GPa" $

$ U(E_"Cu") = k dot u_C (E_"Cu") = 4.6 " GPa" $

Odpowiednio zaokrąglamy wartość:

$ E_"Cu" approx 128.1 " GPa" $

$ bold(E_"Cu" = (128.1 plus.minus 4.6) " GPa") $

#v(1em)
=== Stal
#v(1em)

$ E_"FeC" = 7.88 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot (4943 " ""m"/"s")^2 =  1.9253 dot 10^11 " ""kg"/("m" dot "s"^2) = 192.534 " GPa" $
#v(1em)
$ u_C (E_"FeC") = sqrt(((4943 " ""m"/"s")^2 dot 0.12 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3))^2 + (2 dot 7.88 " " ("kg" dot 10^(-3))/(("m" dot 10^(-2))^3) dot 4943 " ""m"/"s" dot 17 " ""m"/"s")^2) =\ =sqrt(8.597 dot 10^18 "kg"^2/("m"^2 dot "s"^4) + 1.754 dot 10^18 "kg"^2/("m"^2 dot "s"^4)) = 3.217 dot 10^9 "Pa" $
#v(1em)
$ u_C (E_"FeC") approx 3.3 " GPa" $

$ U(E_"FeC") = k dot u_C (E_"FeC") = 6.6 " GPa" $

Odpowiednio zaokrąglamy wartość:

$ E_"FeC" approx 192.5 " GPa" $

$ bold(E_"FeC" = (192.5 plus.minus 6.6) " GPa") $

#v(1em)

= Porównanie wyznaczonych wartości modułu Younga z wartościami tabelarycznymi
#v(1em)


#figure(
  caption: [Porównanie wyznaczonych wartości modułu Younga z wartościami tabelarycznymi @wiki @opis1.],
  align(center + top)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 6pt,
      align: center + horizon,
      [*Materiał*],[*$bold(E)$ wyznaczone [GPa]*],[*$bold(E_0)$ tablicowe [GPa]*],[$bold(abs(E - E_0))$ *[GPa]*],
      [*Aluminium*],[72.8],[70],[2.8 < $U(E_"Al")$],
      [*Mosiądz*],[105.4],[103-124],[0],
      [*Miedź*],[128.1],[110-135],[0],
      [*Stal*],[192.5],[190–210],[0],
    )
  ]
)

= Wnioski
#v(1em)

W trakcie ćwiczenia otrzymano wartości modułu Younga, dla poszczególnych metali, które wynoszą:

$ bold(E_"Al" = (72.8 plus.minus 3.0) " GPa") $
$ bold(E_"CuZn" = (105.4 plus.minus 4.0) " GPa") $
$ bold(E_"Cu" = (128.1 plus.minus 4.6) " GPa") $
$ bold(E_"FeC" = (192.5 plus.minus 6.6) " GPa") $

#pagebreak()

Otrzymane wyniki są zgodne z wartościami tabelarycznymi w granicach niepewności.

Niepewności dla niektórych materiałów są większe od pozostałych, na co wpływ mogły mieć:
- Interferencja z innych równolegle prowadzonych eksperymentów, w szczególności urządzeń generujących fale,
- Hałas akustyczny pochodzący z rozmów innych uczestników laboratorium.


#align(bottom)[
#bibliography("bib.yml")
]