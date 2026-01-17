#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#set page(numbering: "1")
#set heading(numbering: "1.1")
#show heading.where(level: 2): it => {
  text(weight: "extrabold", size: 10pt)[#it]
}
= function and graphs
#rect(fill: teal)[
  definition
  - A #strong[function] #emph[f]  consists of a set of inputs, a set of outputs, and a rule for assigning each input to exactly one output. The of inputs is called the #strong[domain] of the #strong[function]. The set of outputs is called the #strong[range] of the #strong[function].
]

== $"for" f(x)=x^2-3x+5,"evaluate" f(1) "and" f(a+h)$
$
  f(1)=3\
  f(a+h)=a^2+2 a h +h^2 -3 a - 3 h +5 \
$
== $"find the domain and range for "f(x)=sqrt(4-2x)+5$
$
  "domain:"{x|x lt.eq 2}\
  "range:"{y|y gt.eq 5}
$
#rect(fill: teal)[
  vertical line test
  - given a function #emph[ f] , every vertical line that may be drawn intersects the graph of #emph[ f] no more than once. If any vertical intersects intersects a set of points more than once, the set of points does not represent a function.

]
== $"find the zeros of "f(x)=x^3-5x^2+6x$
$
  y=0\
  0=x^3-5x^2+6x\
  x=0,2,3
$

#cetz.canvas({
  plot.plot(
    size: (7, 7),
    axis-style: "school-book",
    //x-tick-step: 1,
    //y-tick-step: 10,
    x-grid: true,
    y-grid: true,
    x-format: v => str(int(v)),
    y-format: v => str(int(v)),
    {
      plot.add(
        domain: (-2, 5),
        x => x * x * x - 5 * x * x + 6 * x,
      )
      //plot.add(((0, 0), (2, 0), (3, 0)), mark: "o", mark-size: .15, style: (fill: black))
    },
  )
})

#rect(fill: teal)[
  Definition
  - we say that a function #emph[f] is #strong[increasing on the interval #emph[I]] if for all $x_1,x_2 in I$
  $
    f(x_1) lt.eq f(x_2) "when" x_1 lt x_2.
  $
  we say #emph[f] is strictly increasing on the interval #emph[I] if for all $x_1,x_2 in I$
  $
    f(x_1) lt f(x_2) "when" x_1 lt x_2
  $
  we say that a function #emph[f] is #strong[decreasing on the interval #emph[I]] if for all $x_1,x_2 in I$
  $
    f(x_1) gt.eq f(x_2) "if" x_1 lt x_2
  $
  we say #emph[f] is  strictly decreasing on the interval #emph[I] if for all $x_1,x_2 in I$
  $
    f(x_1) gt f(x_2) "if" x_1 lt x_2
  $
]

== for $ f(x) =x^2 +3 "and "g(x)=2x-5 ,"find " (f/g)(x) $ and its domain
$
  (f/g)(x)=(x^2+3)/(2x-5)
$
$
  "domain :"{x|x eq.not 5/2}
$
#rect(fill: teal)[definition
  - consider the funtion $f$ with domain $A$ and range $B$, and the function $g$ with domain $D$ and range $E$ . if $B$ is a subset of $D$, then the #strong[composite function] $(g compose f)$ is the function with domain $A$ such that $ (g compose f)(x)=g(f(x)). $]
== let $f(x)=2-5x. "let" g(x) =sqrt(x). "find" (f compose g)(x).$
$
  (f compose g)(x)=f(g(x))=2-5 sqrt(x)
$
== If items are on sale for 10% off their original price, and a customer has a coupon for an additional 30% , what will be the final price for an item that is originally $x$ dollars, after applying the coupon to the sale price?
$
  (g compose f)(x)=0.70(0.90 x)=0.63x
$
#rect(fill: teal, width: 100%)[
  Definition
  - If $f(x) = f(-x)$ for all $x$ in the domain of $f$, then $f$ is an #strong[even function]. An even function is symmetric about the $y$-axis.
  - If $f(-x) = -f(x)$ for all $x$ in the domain of $f$, then $f$ is an #strong[odd function]. An odd function is symmetric about the origin.
]

== determine whether $f(x) =4x^3-5x$ is even ,odd,or neither
$f(-x)=-f(x)=-[4x^3-5x]$
== for the function $f(x)=abs(x+2)-4$
$
  "domain:"{x|x in RR}
  \ "range:"{y|y gt.eq -4}
$
#cetz.canvas({
  plot.plot(
    size: (8, 8),
    axis-style: "school-book",
    x-grid: true,
    y-grid: true,
    y-min: -5,
    x-tick-step: 1,
    y-tick-step: 1,
    x-format: v => str(int(v)),
    y-format: v => str(int(v)),
    {
      plot.add(
        domain: (-8, 4),
        samples: 200,
        x => calc.abs(x + 2) - 4,
      )
    },
  )
})
- excercises
+ for the following excercise, (a) determini the domain and the range of each relation , and (b) state whether the relation is a function
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [-3], [-2], [-1], [0], [1], [2], [3],
      [y], [9], [4], [1], [0], [1], [4], [9],
    )
    $
      "domain:"{-3, -2, -1, 0, 1, 2, 3}\
      "range:"{0, 1, 4, 9}\
      "function:" "yes"
    $
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [-3], [-2], [-1], [0], [1], [2], [3],
      [y], [-2], [-8], [-1], [0], [1], [8], [-2],
    )
    $
      "domain:"{-3, -2, -1, 0, 1, 2, 3}\
      "range:"{-8, -2, -1, 0, 1, 8}\
      "function:" "yes"
    $
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [1], [2], [3], [0], [1], [2], [3],
      [y], [-3], [-2], [-1], [0], [1], [2], [3],
    )
    $
      "domain:"{0, 1, 2, 3}\
      "range:"{-3, -2, -1, 0, 1, 2, 3}\
      "function:" "no"
    $
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [1], [2], [3], [4], [5], [6], [7],
      [y], [1], [1], [1], [1], [1], [1], [1],
    )
    $
      "domain:"{1, 2, 3, 4, 5, 6, 7}\
      "range:"{1}\
      "function:" "yes"
    $
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [3], [5], [8], [10], [15], [21], [33],
      [y], [3], [2], [1], [0], [1], [2], [3],
    )
    $
      "domain:"{3, 5, 8, 10, 15, 21, 33}\
      "range:"{0, 1, 2, 3}\
      "function:" "yes"
    $
  + #table(
      columns: (1fr,) * 8,
      inset: 10pt,
      align: center + horizon,
      [x], [-7], [-2], [-2], [0], [1], [3], [6],
      [y], [11], [5], [1], [-1], [-2], [4], [11],
    )
    $
      "domain:"{-7, -2, 0, 1, 3, 6}\
      "range:"{-2, -1, 1, 4, 5, 11}\
      "function:" "no"
    $
#pagebreak()
For the following exercises, find the values for each function, if they exist, then simplify.$ a. f (0) quad b. f (1) quad c. f (3) quad d. f (−x) quad e. f (a) quad f. f (a + h) $
7. $f(x)=5x-2$
  $
      f(0) & =-2, quad f(1)=3, quad f(3)=13 \
     f(-x) & =-5x-2 \
      f(a) & =5a-2 \
    f(a+h) & =5(a+h)-2 = 5a+5h-2
  $

8. $f(x) = 4x^2-3x+1$
  $
      f(0) & = 1, quad f(1) = 2, quad f(3) = 28 \
     f(-x) & = 4(-x)^2 - 3(-x) + 1 = 4x^2 + 3x + 1 \
      f(a) & = 4a^2 - 3a + 1 \
    f(a+h) & = 4(a+h)^2 - 3(a+h) + 1 \
           & = 4(a^2 + 2a h + h^2) - 3a - 3h + 1 \
           & = 4a^2 + 8a h + 4h^2 - 3a - 3h + 1
  $

9. $f(x) = 2/x$
  $
      f(0) & = "undefined", quad f(1) = 2, quad f(3) = 2/3 \
     f(-x) & = 2/(-x) = -2/x \
      f(a) & = 2/a \
    f(a+h) & = 2/(a+h)
  $

10. $f(x) = |x-7|+8$
  $
      f(0) & = |-7|+8 = 15, quad f(1) = |-6|+8 = 14, quad f(3) = |-4|+8 = 12 \
     f(-x) & = |-x-7|+8 = |x+7|+8 \
      f(a) & = |a-7|+8 \
    f(a+h) & = |a+h-7|+8 = |a+h-7|+8
  $

11. $f(x) = sqrt(6x+5)$
  $
      f(0) & = sqrt(5), quad f(1) = sqrt(11), quad f(3) = sqrt(23) \
     f(-x) & = sqrt(-6x+5) \
      f(a) & = sqrt(6a+5) \
    f(a+h) & = sqrt(6(a+h)+5) = sqrt(6a+6h+5)
  $

12. $f(x) = (x-2)/(3x+7)$
  $
      f(0) & = -2/7, quad f(1) = -1/10, quad f(3) = 1/16 \
     f(-x) & = (-x-2)/(-3x+7) = -(x+2)/-(3x-7) = (x+2)/(3x-7) \
      f(a) & = (a-2)/(3a+7) \
    f(a+h) & = (a+h-2)/(3(a+h)+7) = (a+h-2)/(3a+3h+7)
  $

13. $f(x) = 9$
  $
      f(0) & = 9, quad f(1) = 9, quad f(3) = 9 \
     f(-x) & = 9 \
      f(a) & = 9 \
    f(a+h) & = 9
  $
For the following exercises, find the domain, range, and all zeros/intercepts, if any, of the functions.
14. $f(x) = (x-2)/(x^2-16)$
  $
    "domain:" & {x | x in RR, x eq.not 4, x eq.not -4} \
     "range:" & RR \
     "zeros:" & x = 2
  $

15. $g(x) = sqrt(8x-1)$
  $
    "domain:" & {x | x in RR, x gt.eq 1/8} \
     "range:" & {y | y in RR, y gt.eq 0} \
     "zeros:" & x = 1/8
  $

16. $h(x) = 3/(x^2+4)$
  $
    "domain:" & RR \
     "range:" & {y | y in RR, 0 lt y lt.eq 3/4} \
     "zeros:" & "none"
  $

17. $f(x) = -1 + sqrt(x+2)$
  $
    "domain:" & {x | x in RR, x gt.eq -2} \
     "range:" & {y | y in RR, y gt.eq -1} \
     "zeros:" & x = -1
  $

18. $f(x) = 1/sqrt(x-9)$
  $
    "domain:" & {x | x in RR, x gt 9} \
     "range:" & {y | y in RR, y gt 0} \
     "zeros:" & "none"
  $

19. $g(x) = 3/(x-4)$
  $
    "domain:" & {x | x in RR, x eq.not 4} \
     "range:" & {y | y in RR, y eq.not 0} \
     "zeros:" & "none"
  $

20. $f(x) = 4|x+5|$
  $
    "domain:" & RR \
     "range:" & {y | y in RR, y gt.eq 0} \
     "zeros:" & x = -5
  $

21. $g(x) = sqrt(7/(x-5))$
  $
    "domain:" & {x | x in RR, x gt 5} \
     "range:" & {y | y in RR, y gt 0} \
     "zeros:" & "none"
  $
For the following exercises, set up a table to sketch the
graph of each function using the following values:
$x = −3, −2, −1, 0, 1, 2, 3.$
22. $f(x) = x^2 + 1$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      //x-tick-step: 1,
      //y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 4), x => x * x + 1)
        plot.add(((-3, 10), (-2, 5), (-1, 2), (0, 1), (1, 2), (2, 5), (3, 10)), mark: "o", mark-size: .15, style: (
          stroke: none,
          fill: black,
        ))
      },
    )
  })

23. $f(x) = 3x - 6$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 3,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 4), x => 3 * x - 6)
        plot.add(
          ((-3, -15), (-2, -12), (-1, -9), (0, -6), (1, -3), (2, 0), (3, 3)),
          mark: "o",
          mark-size: 0.15,
          style: (stroke: none, fill: black),
        )
      },
    )
  })

24. $f(x) = 1/2x + 1$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 4), x => 0.5 * x + 1)
        plot.add(
          ((-3, -0.5), (-2, 0), (-1, 0.5), (0, 1), (1, 1.5), (2, 2), (3, 2.5)),
          mark: "o",
          mark-size: .15,
          style: (stroke: none, fill: black),
        )
      },
    )
  })

25. $f(x) = 2|x|$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 4), x => 2 * calc.abs(x))
        plot.add(((-3, 6), (-2, 4), (-1, 2), (0, 0), (1, 2), (2, 4), (3, 6)), mark: "o", mark-size: .15, style: (
          stroke: none,
          fill: black,
        ))
      },
    )
  })

26. $f(x) = -x^2$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 4), x => -x * x)
        plot.add(((-3, -9), (-2, -4), (-1, -1), (0, 0), (1, -1), (2, -4), (3, -9)), mark: "o", mark-size: .15, style: (
          stroke: none,
          fill: black,
        ))
      },
    )
  })

27. $f(x) = x^3$
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 5,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-3.5, 3.5), x => x * x * x)
        plot.add(((-3, -27), (-2, -8), (-1, -1), (0, 0), (1, 1), (2, 8), (3, 27)), mark: "o", mark-size: .15, style: (
          stroke: none,
          fill: black,
        ))
      },
    )
  })
For the following exercises, use the vertical line test to
determine whether each of the given graphs represents a
function. Assume that a graph continues at both ends if
it extends beyond the given grid. If the graph represents a
function, then determine the following for each graph:\
a. Domain and range \
b. $x$-intercept, if any (estimate where necessary)\
c. $y$-Intercept, if any (estimate where necessary)\
d. The intervals for which the function is increasing\
e. The intervals for which the function is decreasing\
f. The intervals for which the function is constant\
g. Symmetry about any axis and/or the origin\
h. Whether the function is even, odd, or neither\

28.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(range(0, 361, step: 5).map(a => (calc.cos(a * 1deg), calc.sin(a * 1deg))))
      },
    )
  })
  $
    "function:" "no"
  $

29.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-1.5, 1.5), x => 2 * calc.pow(x, 4) - 3 * calc.pow(x, 2) + 1)
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" (-infinity, infinity) \
    "range:" [-0.125, infinity) \
    "x-intercepts:" -1, -0.707, 0.707, 1 \
    "y-intercept:" 1 \
    "increasing:" (-0.866, 0) union (0.866, infinity) \
    "decreasing:" (-infinity, -0.866) union (0, 0.866) \
    "symmetry:" "y-axis" \
    "type:" "even"
  $

30.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-0.5, 3.6), x => -calc.pow((x - 2), 2) + 3)
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" (-infinity, infinity) \
    "range:" (-infinity, 3] \
    "x-intercepts:" tilde 0.3, 3.7 \
    "y-intercept:" -1 \
    "increasing:" (-infinity, 2) \
    "decreasing:" (2, infinity) \
    "symmetry:" "none" \
    "type:" "neither"
  $

31.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (0, 5), x => calc.pow(x, 1 / 3))
        plot.add(domain: (-5, 0), x => -calc.pow(-x, 1 / 3))
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" (-infinity, infinity) \
    "range:" (-infinity, infinity) \
    "x-intercepts:" 0 \
    "y-intercept:" 0 \
    "increasing:" (-infinity, infinity) \
    "decreasing:" "none" \
    "symmetry:" "origin" \
    "type:" "odd"
  $

32.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(range(-30, 31).map(y => (calc.pow(y / 10, 2), y / 10)))
      },
    )
  })
  $
    "function:" "no"
  $

33.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-5, 5), x => calc.min(2, calc.max(-2, x)))
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" (-infinity, infinity) \
    "range:" [-2, 2] \
    "x-intercepts:" 0 \
    "y-intercept:" 0 \
    "increasing:" (-2, 2) \
    "decreasing:" "none" \
    "constant:" (-infinity, -2) union (2, infinity) \
    "symmetry:" "origin" \
    "type:" "odd"
  $

34.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-5, 5), x => calc.max(0, x))
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" (-infinity, infinity) \
    "range:" [0, infinity) \
    "x-intercepts:" (-infinity, 0] \
    "y-intercept:" 0 \
    "increasing:" (0, infinity) \
    "decreasing:" "none" \
    "constant:" (-infinity, 0) \
    "symmetry:" "none" \
    "type:" "neither"
  $

35.
  #cetz.canvas({
    plot.plot(
      size: (6, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-4, 0), x => 4)
        plot.add(domain: (0, 4), x => 4 - 4 * calc.sqrt(x))
        plot.add(((-4, 4), (0, 4), (4, -4)), mark: "o", mark-size: .15, style: (stroke: none, fill: black))
      },
    )
  })
  $
    "function:" "yes" \
    "domain:" [-4, 4] \
    "range:" [-4, 4] \
    "x-intercepts:" 1 \
    "y-intercept:" 4 \
    "increasing:" "none" \
    "decreasing:" (0, 4) \
    "constant:" (-4, 0) \
    "symmetry:" "none" \
    "type:" "neither"
  $

For the following exercises, for each pair of functions, find
$"a." quad f + g quad "b." quad f - g quad "c." quad f dot g quad "d." quad f / g quad$. Determine the domain of each of these new functions.

36. $f(x) = 3x + 4, g(x) = x - 2$
  $
        a. (f+g)(x) & = 4x+2, quad "domain:" RR \
        b. (f-g)(x) & = 2x+6, quad "domain:" RR \
    c. (f dot g)(x) & = 3x^2 - 2x - 8, quad "domain:" RR \
        d. (f/g)(x) & = (3x+4)/(x-2), quad "domain:" {x | x eq.not 2}
  $

37. $f(x) = x - 8, g(x) = 5x^2$
  $
        a. (f+g)(x) & = 5x^2 + x - 8, quad "domain:" RR \
        b. (f-g)(x) & = -5x^2 + x - 8, quad "domain:" RR \
    c. (f dot g)(x) & = 5x^3 - 40x^2, quad "domain:" RR \
        d. (f/g)(x) & = (x-8)/(5x^2), quad "domain:" {x | x eq.not 0}
  $

38. $f(x) = 3x^2 + 4x + 1, g(x) = x + 1$
  $
        a. (f+g)(x) & = 3x^2 + 5x + 2, quad "domain:" RR \
        b. (f-g)(x) & = 3x^2 + 3x, quad "domain:" RR \
    c. (f dot g)(x) & = (3x^2 + 4x + 1)(x+1) = 3x^3 + 7x^2 + 5x + 1, quad "domain:" RR \
        d. (f/g)(x) & = (3x^2 + 4x + 1)/(x+1) = 3x+1, quad "domain:" {x | x eq.not -1}
  $

39. $f(x) = 9 - x^2, g(x) = x^2 - 2x - 3$
  $
        a. (f+g)(x) & = -2x+6, quad "domain:" RR \
        b. (f-g)(x) & = -2x^2 + 2x + 12, quad "domain:" RR \
    c. (f dot g)(x) & = (9 - x^2)(x^2 - 2x - 3) = -x^4 + 2x^3 + 12x^2 - 18x - 27, quad "domain:" RR \
        d. (f/g)(x) & = (9 - x^2)/(x^2 - 2x - 3) = -(x+3)/(x+1), quad "domain:" {x | x eq.not 3, -1}
  $

40. $f(x) = sqrt(x), g(x) = x - 2$
  $
        a. (f+g)(x) & = sqrt(x) + x - 2, quad "domain:" {x | x gt.eq 0} \
        b. (f-g)(x) & = sqrt(x) - x + 2, quad "domain:" {x | x gt.eq 0} \
    c. (f dot g)(x) & = sqrt(x)(x-2), quad "domain:" {x | x gt.eq 0} \
        d. (f/g)(x) & = sqrt(x)/(x-2), quad "domain:" {x | x gt.eq 0, x eq.not 2}
  $

41. $f(x) = 6 + 1/x, g(x) = 1/x$
  $
        a. (f+g)(x) & = 6 + 2/x, quad "domain:" {x | x eq.not 0} \
        b. (f-g)(x) & = 6, quad "domain:" {x | x eq.not 0} \
    c. (f dot g)(x) & = 6/x + 1/x^2, quad "domain:" {x | x eq.not 0} \
        d. (f/g)(x) & = (6 + 1/x)/(1/x) = 6x + 1, quad "domain:" {x | x eq.not 0}
  $

For the following exercises, for each pair of functions, find
$
  "a." quad (f compose g)(x) quad "and" quad "b." quad (g compose f)(x)
$
Simplify the results. Find domain of each of the results.

42. $f(x) = 3x, g(x) = x + 5$
  $
    a. (f compose g)(x) & = 3(x+5) = 3x+15, quad "domain:" RR \
    b. (g compose f)(x) & = 3x+5, quad "domain:" RR
  $

43. $f(x) = x+4, g(x) = 4x-1$
  $
    a. (f compose g)(x) & = (4x-1)+4 = 4x+3, quad "domain:" RR \
    b. (g compose f)(x) & = 4(x+4)-1 = 4x+15, quad "domain:" RR
  $

44. $f(x) = 2x+4, g(x) = x^2-2$
  $
    a. (f compose g)(x) & = 2(x^2-2)+4 = 2x^2, quad "domain:" RR \
    b. (g compose f)(x) & = (2x+4)^2-2 = 4x^2+16x+14, quad "domain:" RR
  $

45. $f(x) = x^2+7, g(x) = x^2-3$
  $
    a. (f compose g)(x) & = (x^2-3)^2+7 = x^4-6x^2+16, quad "domain:" RR \
    b. (g compose f)(x) & = (x^2+7)^2-3 = x^4+14x^2+46, quad "domain:" RR
  $

46. $f(x) = sqrt(x), g(x) = x+9$
  $
    a. (f compose g)(x) & = sqrt(x+9), quad "domain:" {x | x gt.eq -9} \
    b. (g compose f)(x) & = sqrt(x)+9, quad "domain:" {x | x gt.eq 0}
  $

47. $f(x) = 3/(2x+1), g(x) = 2/x$
  $
    a. (f compose g)(x) & = 3/(2(2/x)+1) = (3x)/(x+4), quad "domain:" {x | x eq.not 0, -4} \
    b. (g compose f)(x) & = 2/(3/(2x+1)) = (4x+2)/3, quad "domain:" {x | x eq.not -1/2}
  $

48. $f(x) = |x+1|, g(x) = x^2+x-4$
  $
    a. (f compose g)(x) & = |(x^2+x-4)+1| = |x^2+x-3|, quad "domain:" RR \
    b. (g compose f)(x) & = |x+1|^2+|x+1|-4 = x^2+2x-3+|x+1|, quad "domain:" RR
  $

49. The table below lists the NBA championship winners for the years 2001 to 2012.
  #table(
    columns: (auto, auto),
    align: center,
    [*Year*], [*Winner*],
    [2001], [LA Lakers],
    [2002], [LA Lakers],
    [2003], [San Antonio Spurs],
    [2004], [Detroit Pistons],
    [2005], [San Antonio Spurs],
    [2006], [Miami Heat],
    [2007], [San Antonio Spurs],
    [2008], [Boston Celtics],
    [2009], [LA Lakers],
    [2010], [LA Lakers],
    [2011], [Dallas Mavericks],
    [2012], [Miami Heat],
  )
  a. Consider the relation in which the domain values are the years 2001 to 2012 and the range is the corresponding winner. Is this relation a function? Explain why or why not.\
  b. Consider the relation where the domain values are the winners and the range is the corresponding years. Is this relation a function? Explain why or why not.\
  #strong[solution:] \
  a. Yes, this relation is a function because each year (domain) is associated with exactly one winning team (range).\
  b. No, this relation is not a function because several teams (like the LA Lakers) are associated with multiple years (e.g., Lakers 2001, 2002, 2009, 2010).

50. [T] The area $A$ of a square depends on the length of the side $s$.\
  a. Write a function $A(s)$ for the area of a square.\
  b. Find and interpret $A(6.5)$.\
  c. Find the exact and the two-significant-digit approximation to the length of the sides of a square with area 56 square units.\
  #strong[solution:] \
  a. $A(s) = s^2$ \
  b. $A(6.5) = (6.5)^2 = 42.25$. This means the area of a square with a side length of 6.5 units is 42.25 square units.\
  c. $s = sqrt(56) = 2sqrt(14) approx 7.5$ units (to two significant digits).

51. [T] The volume of a cube depends on the length of the sides $s$.\
  a. Write a function $V(s)$ for the volume of a cube.\
  b. Find and interpret $V(11.8)$.\
  #strong[solution:] \
  a. $V(s) = s^3$ \
  b. $V(11.8) = (11.8)^3 = 1643.032$. This means the volume of a cube with a side length of 11.8 units is 1643.032 cubic units.

52. [T] A rental car company rents cars for a flat fee of \$20 and an hourly charge of \$10.25. Therefore, the total cost $C$ to rent a car is a function of the hours $t$ the car is rented plus the flat fee.\
  a. Write the formula for the function that models this situation.\
  b. Find the total cost to rent a car for 2 days and 7 hours.\
  c. Determine how long the car was rented if the bill is \$432.73.\
  #strong[solution:] \
  a. $C(t) = 10.25t + 20$ \
  b. $t = (2 dot 24) + 7 = 55$ hours. $C(55) = 10.25(55) + 20 = 583.75$. The total cost is \$583.75.\
  c. \$432.73 = $10.25t + 20 arrow.r$ \$412.73 = $10.25t arrow.r t approx 40.27$ hours (approx. 40 hours and 16 minutes).

53. [T] A vehicle has a 20-gal tank and gets 15 mpg. The number of miles $N$ that can be driven depends on the amount of gas $x$ in the tank.\
  a. Write a formula that models this situation.\
  b. Determine the number of miles the vehicle can travel on (i) a full tank of gas and (ii) 3/4 of a tank of gas.\
  c. Determine the domain and range of the function.\
  d. Determine how many times the driver had to stop for gas if she has driven a total of 578 mi.\
  #strong[solution:] \
  a. $N(x) = 15x$ \
  b. (i) $N(20) = 300$ miles; (ii) $N(15) = 225$ miles.\
  c. "domain:" $[0, 20]$, "range:" $[0, 300]$\
  d. Since the range is 300 miles, the driver has to stop once for gas to complete a 578-mile trip.

54. [T] The volume $V$ of a sphere depends on the length of its radius as $V = (4/3) pi r^3$. Because Earth is not a perfect sphere, we can use the mean radius when measuring from the center to its surface. The mean radius is the average distance from the physical center to the surface, based on a large number of samples. Find the volume of Earth with mean radius $6.371 dot 10^6$ m.\
  #strong[solution:] \
  $V = 4/3 pi (6.371 dot 10^6)^3 approx 1.083 dot 10^21 m^3$

55. [T] A certain bacterium grows in culture in a circular region. The radius of the circle, measured in centimeters, is given by $r(t) = 6 - [5/(t^2 + 1)]$, where $t$ is time measured in hours since a circle of a 1-cm radius of the bacterium was put into the culture.\
  a. Express the area of the bacteria as a function of time.\
  b. Find the exact and approximate area of the bacterial culture in 3 hours.\
  c. Express the circumference of the bacteria as a function of time.\
  d. Find the exact and approximate circumference of the bacteria in 3 hours.\
  #strong[solution:] \
  $r(t) = 6 - 5/(t^2 + 1)$ \
  a. $A(t) = pi (6 - 5/(t^2 + 1))^2$ \
  b. $A(3) = pi (6 - 5/10)^2 = pi (5.5)^2 = 30.25 pi approx 95.03 "cm"^2$ \
  c. $C(t) = 2 pi (6 - 5/(t^2 + 1))$ \
  d. $C(3) = 2 pi (5.5) = 11 pi approx 34.56 "cm"$

56. [T] An American tourist visits Paris and must convert U.S. dollars to Euros, which can be done using the function $E(x) = 0.79x$, where $x$ is the number of U.S. dollars and $E(x)$ is the equivalent number of Euros. Since conversion rates fluctuate, when the tourist returns to the United States 2 weeks later, the conversion from Euros to U.S. dollars is $D(x) = 1.245x$, where $x$ is the number of Euros and $D(x)$ is the equivalent number of U.S. dollars.\
  a. Find the composite function that converts directly from U.S. dollars to U.S. dollars via Euros. Did this tourist lose value in the conversion process?\
  b. Use (a) to determine how many U.S. dollars the tourist would get back at the end of her trip if she converted an extra \$200 when she arrived in Paris.\
  #strong[solution:] \
  $E(x) = 0.79x, quad D(x) = 1.245x$
  a. $C(x) = D(E(x)) = 1.245(0.79x) = 0.98355x$. The tourist loses value because the recovery rate is less than 1.\
  b. $C(200) = 0.98355(200) = 196.71$. She would get back \$196.71.

57. [T] The manager at a skateboard shop pays his workers a monthly salary $S$ of \$750 plus a commission of \$8.50 for each skateboard they sell.\
  a. Write a function $y = S(x)$ that models a worker’s monthly salary based on the number of skateboards $x$ he or she sells.\
  b. Find the approximate monthly salary when a worker sells 25, 40, or 55 skateboards.\
  c. Use the INTERSECT feature on a graphing calculator to determine the number of skateboards that must be sold for a worker to earn a monthly income of \$1400. (Hint: Find the intersection of the function and the line $y = 1400$.)\
  #strong[solution:] \
  a. $S(x) = 8.5x + 750$ \
  b. $S(25) = 962.5, quad S(40) = 1090, quad S(55) = 1217.5$ \
  c. \$1400 = $8.5x + 750 arrow.r 650 = 8.5x arrow.r x approx 76.47$. Intersection point: $(76.47, 1400)$.
  #cetz.canvas({
    plot.plot(
      size: (8, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-label: move(dx: 35pt)[Skateboards $(x)$],
      y-label: [Salary (S)],
      x-tick-step: 10,
      y-tick-step: 200,
      y-min: 400,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (0, 100), x => 8.5 * x + 750)
        plot.add(((76.47, 1400),), mark: "o", style: (stroke: none, fill: red)) //use approximation here , since it is not an integer
      },
    )
  })

58. [T] Use a graphing calculator to graph the half-circle $y = sqrt(25 - (x-4)^2)$. Then, use the INTERSECT feature to find the value of both the $x$- and $y$-intercepts.\
  #strong[solution:] \
  $y = sqrt(25 - (x-4)^2)$
  $x$-intercepts: $0 = sqrt(25 - (x-4)^2) arrow.r (x-4)^2 = 25 arrow.r x = 9, -1$\
  $y$-intercept: $y = sqrt(25 - (0-4)^2) = sqrt(25-16) = sqrt(9) = 3$\
  #cetz.canvas({
    plot.plot(
      size: (8, 6),
      axis-style: "school-book",
      x-grid: true,
      y-grid: true,
      x-tick-step: 1,
      y-tick-step: 1,
      y-min: -1,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      {
        plot.add(domain: (-1, 9), x => calc.sqrt(25 - (x - 4) * (x - 4)))
        plot.add(((-1, 0), (9, 0), (0, 3)), mark: "o", style: (stroke: none, fill: blue))
      },
    )
  })
