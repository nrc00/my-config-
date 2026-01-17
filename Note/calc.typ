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

#pagebreak()

= Basic Classes of Functions
#counter(heading).update((1, 8))
#rect(fill: teal)[
  Definition
  - Consider line L passing through points $(x_1, y_1)$ and $(x_2, y_2)$. Let $Delta y = y_2 − y_1$ and \ $Delta x = x_2 − x_1$ denote the
  changes in y and x, respectively. The slope of the line is \
  $m = (y_2 - y_1) / (x_2 - x_1) = (Delta y) / (Delta x)$

]

#rect(fill: teal, width: 100%)[
  Definition
  - Consider a line passing through the point $(x_1, y_1)$ with slope $m$. The equation
  $ y - y_1 = m(x - x_1) $
  is the #strong[point-slope equation] for that line.

  - Consider a line with slope $m$ and $y$-intercept $(0, b)$. The equation
  $ y = m x + b $
  is an equation for that line in #strong[slope-intercept form].

  - The #strong[standard form of a line] is given by the equation
  $ a x + b y = c, $
  where $a$ and $b$ are both not zero. This form is more general because it allows for a vertical line, $x = k$.
]



== Finding Equations of Lines
Consider the line passing through points $(-3, 2)$ and $(1, 4)$.
Find the slope of the line.
Find an equation of that line in point-slope form.
Find an equation of that line in slope-intercept form.

#strong[Solution:]
The slope $m$ is given by:
$ m = (2 - 4) / (-3 - 1) = (-2) / (-4) = 1/2 $
//(or $m = (4 - 2) / (1 - (-3)) = 2 / 4 = 1/2$)

Using the point $(1, 4)$, the point-slope form is:
$ y - 4 = 1/2 (x - 1) $

To find the slope-intercept form, solve for $y$:
$
  y - 4 = 1/2 x - 1/2 \
  y = 1/2 x + 7/2
$
Alternatively, $y = 0.5x + 3.5$.
#rect(fill: teal, width: 100%)[
  #strong[Rule: The Quadratic Formula] \
  Consider the quadratic equation
  $ a x^2 + b x + c = 0, $
  where $a != 0$. The solutions of this equation are given by the quadratic formula
  $ x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a). $
  If the discriminant $b^2 - 4 a c > 0$, this formula tells us there are two real numbers that satisfy the quadratic equation. If $b^2 - 4 a c = 0$, this formula tells us there is only one solution, and it is a real number. If $b^2 - 4 a c < 0$, no real numbers satisfy the quadratic equation.
]

== Finding Zeros and Orientation
Consider the quadratic function $f(x) = 3 x^2 - 6 x + 2$.
Find the zeros of $f$.
Does the parabola open upward or downward?

#strong[Solution:]
To find the zeros, we solve $3 x^2 - 6 x + 2 = 0$ using the quadratic formula where $a = 3, b = -6, c = 2$:
$
  x = (-(-6) plus.minus sqrt((-6)^2 - 4(3)(2))) / (2(3)) = (6 plus.minus sqrt(36 - 24)) / 6 = (6 plus.minus sqrt(12)) / 6
$
$ x = (6 plus.minus 2 sqrt(3)) / 6 = 1 plus.minus sqrt(3)/3 $
The zeros are $x = 1 - sqrt(3)/3$ and $x = 1 + sqrt(3)/3$.

Since $a = 3$, which is positive ($a > 0$), the parabola opens #strong[upward].

== Finding Domain and Range
Find the domain and range for the function $f(x) = (5x + 2)/(2x - 1)$.

#strong[Solution:]

To find the domain of $f(x) = (5x + 2)/(2x - 1)$, we identify values of $x$ where the denominator is zero:
$ 2x - 1 = 0 arrow.r 2x = 1 arrow.r x = 1/2 $
The function is defined for all real numbers except $x = 1/2$.
Domain: $\{x in RR | x eq.not 1/2\}$ or $(-infinity, 1/2) union (1/2, infinity)$.

To find the range, we set $y = f(x)$ and solve for $x$:
$
  y = (5x + 2) / (2x - 1) \
  y(2x - 1) = 5x + 2 \
  2x y - y = 5x + 2 \
  2x y - 5x = y + 2 \
  x(2y - 5) = y + 2 \
  x = (y + 2) / (2y - 5)
$
The expression for $x$ is defined as long as the denominator is not zero:
$ 2y - 5 != 0 arrow.r 2y != 5 arrow.r y != 5/2 $
The range is all real numbers except $y = 5/2$.
Range: $\{y in RR | y eq.not 5/2\}$ or $(-infinity, 5/2) union (5/2, infinity)$.

== Finding Domains
Find the domain for each of the following functions:
$ f(x) = (5 - 2x) / (x^2 + 2) quad "and" quad g(x) = sqrt(5x - 1) $

#strong[Solution:]

- #strong[For $f(x) = (5 - 2x) / (x^2 + 2)$:]
  The domain of a rational function is all real numbers except where the denominator is zero.
  Since $x^2 >= 0$ for all real $x$, the denominator $x^2 + 2$ is always at least 2 and can never be zero.
  Domain: $RR$ or $(-infinity, infinity)$.

- #strong[For $g(x) = sqrt(5x - 1)$:]
  The domain of a square root function consists of all values for which the radicand is non-negative:
  $ 5x - 1 >= 0 arrow.r 5x >= 1 arrow.r x >= 1/5 $
  Domain: $\{x in RR | x >= 1/5\}$ or $[1/5, infinity)$.

== Function Classification
Is $f(x) = x/2$ an algebraic or a transcendental function?

#strong[Solution:]

$f(x) = x/2$ is an #strong[algebraic function].

Specifically, it is a polynomial of degree 1 (a linear function). Algebraic functions are those that can be expressed as the roots of a polynomial equation with polynomial coefficients. Since all polynomials and rational functions are algebraic, and $f(x) = 1/2 x$ is a polynomial, it is algebraic.

Transcendental functions, on the other hand, are functions that "transcend" algebra, such as trigonometric ($sin x$, $cos x$), exponential ($e^x$), and logarithmic ($ln x$) functions.
#pagebreak()
== Graphing Piecewise Functions
Sketch a graph of the function:
$ f(x) = cases(2 - x &"if" x <= 2, x + 2 &"if" x > 2) $

#strong[Solution:]

The function is composed of two linear pieces:
1. For $x <= 2$, the graph is the line $y = 2 - x$. At $x = 2$, $y = 0$ (closed circle).
2. For $x > 2$, the graph is the line $y = x + 2$. At $x = 2$, $y$ approaches $4$ (open circle).

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    plot.plot(
      size: (8, 6),
      x-tick-step: 1,
      y-tick-step: 1,
      x-label: $x$,
      y-label: $y$,
      x-grid: true,
      y-grid: true,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      axis-style: "school-book",
      {
        // First piece: 2 - x for x <= 2
        plot.add(
          x => 2 - x,
          domain: (-2, 2),
          label: $2 - x$,
          style: (stroke: blue + 1.5pt),
        )
        // Second piece: x + 2 for x > 2
        plot.add(
          x => x + 2,
          domain: (2, 6),
          label: $x + 2$,
          style: (stroke: red + 1.5pt),
        )
        // Points at the boundary x = 2
        plot.add-anchor("p1", (2, 0))
        plot.add-anchor("p2", (2, 4))
      },
    )
    // Draw circles at x = 2 manually using coordinates relative to plot or within canvas
    // Note: Since cetz-plot anchors can be tricky, we simply describe the jump.
  })
]

There is a discontinuity (a jump) at $x = 2$ because $lim_(x arrow.r 2^-) f(x) = 0$ while $lim_(x arrow.r 2^+) f(x) = 4$.

== Business Applications
The cost of mailing a letter is a function of the weight of the letter. Suppose the cost of mailing a letter is 49¢ for the first ounce and 21¢ for each additional ounce. Write a piecewise-defined function describing the cost $C$ as a function of the weight $x$ for $0 < x <= 3$, where $C$ is measured in cents and $x$ is measured in ounces.

#strong[Solution:]


The piecewise function is:
$
  C(x) = cases(
    49 & "if" 0 < x <= 1,
    70 & "if" 1 < x <= 2,
    91 & "if" 2 < x <= 3
  )
$

== Transformations of Functions
If the graph of a function consists of more than one transformation of another graph, it is important to transform the graph in the correct order. Given a function $f(x)$, the graph of the related function $ y = c f(a(x + b)) + d $ can be obtained from the graph of $y = f(x)$ by performing the transformations in the following order:

1. #strong[Horizontal shift] of the graph of $y = f(x)$. If $b > 0$, shift left. If $b < 0$, shift right.
2. #strong[Horizontal scaling] of the graph of $y = f(x + b)$ by a factor of $|a|$. If $a < 0$, reflect the graph about the $y$-axis.
3. #strong[Vertical scaling] of the graph of $y = f(a(x + b))$ by a factor of $|c|$. If $c < 0$, reflect the graph about the $x$-axis.
4. #strong[Vertical shift] of the graph of $y = c f(a(x + b))$. If $d > 0$, shift up. If $d < 0$, shift down.

We can summarize the different transformations and their related effects on the graph of a function in the following table.

== Applying Transformations
#strong[Exercise 1.16:] Describe how the function $f(x) = -(x + 1)^2 - 4$ can be graphed using the graph of $y = x^2$ and a sequence of transformations.

#strong[Solution:]

Starting with the base function $y = x^2$, we apply the transformations in the following order:

1. #strong[Horizontal Shift:] Shift the graph of $y = x^2$ to the #strong[left by 1 unit] to get the graph of $y = (x + 1)^2$.
2. #strong[Reflection:] Reflect the graph of $y = (x + 1)^2$ about the #strong[x-axis] to get the graph of $y = -(x + 1)^2$.
3. #strong[Vertical Shift:] Shift the graph of $y = -(x + 1)^2$ #strong[down by 4 units] to get the final graph of $f(x) = -(x + 1)^2 - 4$.

The resulting graph is a parabola that opens downward with its vertex located at $(-1, -4)$.

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    plot.plot(
      size: (10, 8),
      x-tick-step: 2,
      y-tick-step: 2,
      x-label: $x$,
      y-label: $y$,
      x-grid: true,
      y-grid: true,
      x-format: v => str(int(v)),
      y-format: v => str(int(v)),
      legend: "inner-north-east",
      axis-style: "school-book",
      {
        plot.add(x => calc.pow(x, 2), domain: (-4, 4), label: $x^2$, style: (stroke: gray + 1pt, dash: "dashed"))
        plot.add(
          x => calc.pow(x + 1, 2),
          domain: (-5, 3),
          label: $(x+1)^2$,
          style: (stroke: blue + 1pt, dash: "dotted"),
        )
        plot.add(
          x => -calc.pow(x + 1, 2),
          domain: (-5, 3),
          label: $-(x+1)^2$,
          style: (stroke: green + 1pt, dash: "dash-dotted"),
        )
        plot.add(x => -calc.pow(x + 1, 2) - 4, domain: (-5, 3), label: $-(x+1)^2 - 4$, style: (stroke: red + 2pt))
      },
    )
  })
]

#pagebreak()
= Exercises


#strong[Exercises 59-66:] For each pair of points, a. find the slope of the line passing through the points and b. indicate whether the line is increasing, decreasing, horizontal, or vertical.

59. $(-2, 4)$ and $(1, 1)$
  - a. $m = (1 - 4) / (1 - (-2)) = -3 / 3 = -1$
  - b. #strong[Decreasing]

60. $(-1, 4)$ and $(3, -1)$
  - a. $m = (-1 - 4) / (3 - (-1)) = -5 / 4$
  - b. #strong[Decreasing]

61. $(3, 5)$ and $(-1, 2)$
  - a. $m = (2 - 5) / (-1 - 3) = -3 / -4 = 3/4$
  - b. #strong[Increasing]

62. $(6, 4)$ and $(4, -3)$
  - a. $m = (-3 - 4) / (4 - 6) = -7 / -2 = 7/2$
  - b. #strong[Increasing]

63. $(2, 3)$ and $(5, 7)$
  - a. $m = (7 - 3) / (5 - 2) = 4 / 3$
  - b. #strong[Increasing]

64. $(1, 9)$ and $(-8, 5)$
  - a. $m = (5 - 9) / (-8 - 1) = -4 / -9 = 4/9$
  - b. #strong[Increasing]

65. $(2, 4)$ and $(1, 4)$
  - a. $m = (4 - 4) / (1 - 2) = 0 / (-1) = 0$
  - b. #strong[Horizontal]

66. $(1, 4)$ and $(1, 0)$
  - a. $m = (0 - 4) / (1 - 1) = -4 / 0$ (Undefined)
  - b. #strong[Vertical]

#strong[Exercises 67-74:] Write the equation of the line satisfying the given conditions in slope-intercept form ($y = m x + b$).

67. Slope $m = -6$, passes through $(1, 3)$
  - $y - 3 = -6(x - 1) arrow.r y = -6x + 6 + 3 arrow.r$ #strong[$y = -6x + 9$]

68. Slope $m = 3$, passes through $(-3, 2)$
  - $y - 2 = 3(x + 3) arrow.r y = 3x + 9 + 2 arrow.r$ #strong[$y = 3x + 11$]

69. Slope $m = 1/3$, passes through $(0, 4)$
  - #strong[$y = 1/3 x + 4$]

70. Slope $m = 2/5$, $x$-intercept $= 8$ (Point $(8, 0)$)
  - $y - 0 = 2/5(x - 8) arrow.r$ #strong[$y = 2/5 x - 16/5$]

71. Passing through $(2, 1)$ and $(-2, -1)$
  - $m = (-1 - 1) / (-2 - 2) = -2 / -4 = 1/2$
  - $y - 1 = 1/2(x - 2) arrow.r y = 1/2 x - 1 + 1 arrow.r$ #strong[$y = 1/2 x$]

72. Passing through $(-3, 7)$ and $(1, 2)$
  - $m = (2 - 7) / (1 - (-3)) = -5 / 4$
  - $y - 2 = -5/4(x - 1) arrow.r y = -5/4 x + 5/4 + 8/4 arrow.r$ #strong[$y = -5/4 x + 13/4$]

73. $x$-intercept $= 5$ and $y$-intercept $= -3$
  - Points $(5, 0)$ and $(0, -3)$. $m = (-3 - 0) / (0 - 5) = 3/5$.
  - #strong[$y = 3/5 x - 3$]

74. $x$-intercept $= -6$ and $y$-intercept $= 9$
  - Points $(-6, 0)$ and $(0, 9)$. $m = (9 - 0) / (0 - (-6)) = 9/6 = 3/2$.
  - #strong[$y = 3/2 x + 9$]

#strong[Exercises 75-82:] For each linear equation, a. give the slope $m$ and $y$-intercept $b$.

75. $y = 2x - 3$: #strong[$m = 2, b = -3$]
76. $y = -1/7 x + 1$: #strong[$m = -1/7, b = 1$]
77. $f(x) = -6x$: #strong[$m = -6, b = 0$]
78. $f(x) = -5x + 4$: #strong[$m = -5, b = 4$]
79. $4y + 24 = 0 arrow.r y = -6$: #strong[$m = 0, b = -6$]
80. $8x - 4 = 0 arrow.r x = 1/2$: #strong[$m$ undefined, no $y$-intercept]
81. $2x + 3y = 6 arrow.r y = -2/3 x + 2$: #strong[$m = -2/3, b = 2$]
82. $6x - 5y + 15 = 0 arrow.r y = 6/5 x + 3$: #strong[$m = 6/5, b = 3$]

#strong[Exercises 83-87:] For each polynomial, a. find the degree; b. find the zeros, if any; c. find the $y$-intercept(s), if any; d. use the leading coefficient to determine the graph’s end behavior; and e. determine algebraically whether the polynomial is even, odd, or neither.

83. $f(x) = 2x^2 - 3x - 5$
  - a. Degree: #strong[2]
  - b. Zeros: $2x^2 - 3x - 5 = 0 arrow.r (2x - 5)(x + 1) = 0 arrow.r$ #strong[$x = 5/2, x = -1$]
  - c. $y$-intercept: $f(0) =$ #strong[$-5$]
  - d. End behavior: Leading coefficient $2 > 0$, degree 2 (even). #strong[As $x arrow.r plus.minus infinity, f(x) arrow.r infinity$.]
  - e. #strong[Neither] ($f(-x) = 2x^2 + 3x - 5 eq.not f(x)$ and $eq.not -f(x)$)

84. $f(x) = -3x^2 + 6x$
  - a. Degree: #strong[2]
  - b. Zeros: $-3x^2 + 6x = 0 arrow.r -3x(x - 2) = 0 arrow.r$ #strong[$x = 0, x = 2$]
  - c. $y$-intercept: $f(0) =$ #strong[$0$]
  - d. End behavior: Leading coefficient $-3 < 0$, degree 2 (even). #strong[As $x arrow.r plus.minus infinity, f(x) arrow.r -infinity$.]
  - e. #strong[Neither] ($f(-x) = -3x^2 - 6x$)

85. $f(x) = 1/2 x^2 - 1$
  - a. Degree: #strong[2]
  - b. Zeros: $1/2 x^2 - 1 = 0 arrow.r x^2 = 2 arrow.r$ #strong[$x = plus.minus sqrt(2)$]
  - c. $y$-intercept: $f(0) =$ #strong[$-1$]
  - d. End behavior: Leading coefficient $1/2 > 0$, degree 2 (even). #strong[As $x arrow.r plus.minus infinity, f(x) arrow.r infinity$.]
  - e. #strong[Even] ($f(-x) = 1/2(-x)^2 - 1 = 1/2x^2 - 1 = f(x)$)

86. $f(x) = x^3 + 3x^2 - x - 3$
  - a. Degree: #strong[3]
  - b. Zeros: $x^2(x + 3) - 1(x + 3) = (x^2 - 1)(x + 3) = 0 arrow.r$ #strong[$x = 1, -1, -3$]
  - c. $y$-intercept: $f(0) =$ #strong[$-3$]
  - d. End behavior: Leading coefficient $1 > 0$, degree 3 (odd). #strong[As $x arrow.r infinity, f(x) arrow.r infinity$] and #strong[as $x arrow.r -infinity, f(x) arrow.r -infinity$.]
  - e. #strong[Neither] ($f(-x) = -x^3 + 3x^2 + x - 3$)

87. $f(x) = 3x - x^3$
  - a. Degree: #strong[3]
  - b. Zeros: $x(3 - x^2) = 0 arrow.r$ #strong[$x = 0, x = plus.minus sqrt(3)$]
  - c. $y$-intercept: $f(0) =$ #strong[$0$]
  - d. End behavior: Leading coefficient $-1 < 0$, degree 3 (odd). #strong[As $x arrow.r infinity, f(x) arrow.r -infinity$] and #strong[as $x arrow.r -infinity, f(x) arrow.r infinity$.]
  - e. #strong[Odd] ($f(-x) = 3(-x) - (-x)^3 = -(3x - x^3) = -f(x)$)


//#pagebreak()
#strong[Exercises 88-89:] Use the graph of $f(x) = x^2$ to graph each transformed function $g$.

88. $g(x) = x^2 - 1$
  - #strong[Transformation:] Vertical shift down by 1 unit.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 2,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => calc.pow(x, 2), domain: (-3, 3), label: $x^2$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => calc.pow(x, 2) - 1, domain: (-3, 3), label: $x^2 - 1$, style: (stroke: blue + 1.5pt))
        },
      )
    })
  ]

89. $g(x) = (x + 3)^2 + 1$
  - #strong[Transformation:] Shift left by 3 units and up by 1 unit.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 2,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => calc.pow(x, 2), domain: (-6, 2), label: $x^2$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => calc.pow(x + 3, 2) + 1, domain: (-6, 2), label: $(x+3)^2 + 1$, style: (stroke: red + 1.5pt))
        },
      )
    })
  ]

#strong[Exercises 90-91:] Use the graph of $f(x) = sqrt(x)$ to graph each transformed function $g$.

90. $g(x) = sqrt(x + 2)$
  - #strong[Transformation:] Horizontal shift left by 2 units.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 1,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => calc.sqrt(x), domain: (0, 4), label: $sqrt(x)$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => calc.sqrt(x + 2), domain: (-2, 4), label: $sqrt(x+2)$, style: (stroke: green + 1.5pt))
        },
      )
    })
  ]

91. $g(x) = -sqrt(x) - 1$
  - #strong[Transformation:] Reflection about the $x$-axis and shift down by 1 unit.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 1,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => calc.sqrt(x), domain: (0, 4), label: $sqrt(x)$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => -calc.sqrt(x) - 1, domain: (0, 4), label: $-sqrt(x)-1$, style: (stroke: orange + 1.5pt))
        },
      )
    })
  ]

#strong[Exercises 92-93:] For the following exercises, use the graph of $y = f(x)$ to graph each transformed function $g$.

92. $g(x) = f(x) + 1$
  - #strong[Transformation:] Vertical shift up by 1 unit.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let f(x) = {
        if x < -3 { 0 } else if x < -1 { x + 3 } else if x < 1 { 2 } else if x < 3 { -x + 3 } else { 0 }
      }
      plot.plot(
        size: (6, 4),
        x-tick-step: 1,
        y-tick-step: 1,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(f, domain: (-5, 5), label: $f(x)$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => f(x) + 1, domain: (-5, 5), label: $f(x) + 1$, style: (stroke: blue + 1.5pt))
        },
      )
    })
  ]

93. $g(x) = f(x - 1) + 2$
  - #strong[Transformation:] Horizontal shift right by 1 unit and vertical shift up by 2 units.
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let f(x) = {
        if x < -3 { 0 } else if x < -1 { x + 3 } else if x < 1 { 2 } else if x < 3 { -x + 3 } else { 0 }
      }
      plot.plot(
        size: (6, 4),
        x-tick-step: 1,
        y-tick-step: 1,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(f, domain: (-5, 5), label: $f(x)$, style: (stroke: gray + 1pt, dash: "dashed"))
          plot.add(x => f(x - 1) + 2, domain: (-5, 5), label: $f(x-1)+2$, style: (stroke: red + 1.5pt))
        },
      )
    })
  ]

#strong[Exercises 94-97:] For each of the piecewise-defined functions, a. evaluate at the given values of the independent variable and b. sketch the graph.

94. $f(x) = cases(4x + 3 &"if" x <= 0, -x + 1 &"if" x > 0)$
  - a. $f(-3) =$ #strong[$-9$], $f(0) =$ #strong[$3$], $f(2) =$ #strong[$-1$]
  - b. Graph:
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 1,
        y-tick-step: 2,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => 4 * x + 3, domain: (-2, 0), style: (stroke: blue + 1.5pt))
          plot.add(x => -x + 1, domain: (0, 3), style: (stroke: blue + 1.5pt))
        },
      )
    })
  ]

95. $f(x) = cases(x^2 - 3 &"if" x < 0, 4x - 3 &"if" x >= 0)$
  - a. $f(-4) =$ #strong[$13$], $f(0) =$ #strong[$-3$], $f(2) =$ #strong[$5$]
  - b. Graph:
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 5,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => calc.pow(x, 2) - 3, domain: (-4, 0), style: (stroke: red + 1.5pt))
          plot.add(x => 4 * x - 3, domain: (0, 3), style: (stroke: red + 1.5pt))
        },
      )
    })
  ]

96. $h(x) = cases(x + 1 &"if" x <= 5, 4 &"if" x > 5)$
  - a. $h(0) =$ #strong[$1$], $h(pi) =$ #strong[$pi + 1 approx 4.14$], $h(5) =$ #strong[$6$]
  - b. Graph:
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 2,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => x + 1, domain: (0, 5), style: (stroke: green + 1.5pt))
          plot.add(x => 4, domain: (5, 8), style: (stroke: green + 1.5pt))
        },
      )
    })
  ]

97. $g(x) = cases(3 / (x - 2) &"if" x != 2, 4 &"if" x = 2)$
  - a. $g(0) =$ #strong[$-1.5$], $g(-4) =$ #strong[$-0.5$], $g(2) =$ #strong[$4$]
  - b. Graph:
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      plot.plot(
        size: (6, 4),
        x-tick-step: 2,
        y-tick-step: 2,
        x-grid: true,
        y-grid: true,
        x-format: v => str(int(v)),
        y-format: v => str(int(v)),
        axis-style: "school-book",
        {
          plot.add(x => 3 / (x - 2), domain: (-4, 1.8), style: (stroke: orange + 1.5pt))
          plot.add(x => 3 / (x - 2), domain: (2.2, 8), style: (stroke: orange + 1.5pt))
        },
      )
    })
  ]

#strong[Exercises 98-102:] Determine whether the statement is #emph[true] or #emph[false]. Explain why.

98. $f(x) = (4x + 1)/(7x - 2)$ is a transcendental function.
  - #strong[False.] This is a rational function, which is a type of #strong[algebraic function]. Transcendental functions include trigonometric, exponential, and logarithmic functions.

99. $g(x) = root(3, x)$ is an odd root function.
  - #strong[True.] The index of the root is 3, which is an #strong[odd number].

100. A logarithmic function is an algebraic function.
  - #strong[False.] A logarithmic function is a #strong[transcendental function].

101. A function of the form $f(x) = x^b$, where $b$ is a real valued constant, is an exponential function.
  - #strong[False.] This is a #strong[power function]. An exponential function is of the form $f(x) = b^x$, where the variable $x$ is in the exponent.

102. The domain of an even root function is all real numbers.
  - #strong[False.] The domain of an even root function consists only of values that make the radicand #strong[non-negative] (e.g., $x >= 0$ for $sqrt(x)$).

#strong[Exercises 103-112:] Solve the following word problems.

103. [T] A company purchases some computer equipment for \$20,500. At the end of a 3-year period, the value of the equipment has decreased linearly to \$12,300.
  - a. Find a function $y = V(t)$ that determines the value $V$ of the equipment at the end of $t$ years.
    - Points: $(0, 20500)$ and $(3, 12300)$.
    - $m = (12300 - 20500) / (3 - 0) = -8200 / 3$.
    - #strong[$V(t) = -8200/3 t + 20500$]
  - b. Find and interpret the meaning of the $x$- and $y$-intercepts for this situation.
    - $y$-intercept $(0, 20500)$: The #strong[initial purchase price] of the equipment.
    - $x$-intercept: $0 = -8200/3 t + 20500 arrow.r 8200/3 t = 20500 arrow.r t = 7.5$.
    - Meaning: The equipment will have #strong[depreciated to \$0 after 7.5 years].
  - c. What is the value of the equipment at the end of 5 years?
    - $V(5) = -8200/3(5) + 20500 = -41000/3 + 61500/3 = 20500/3 approx$ #strong[\$6,833.33]
  - d. When will the value of the equipment be \$3,000?
    - $3000 = -8200/3 t + 20500 arrow.r -17500 = -8200/3 t arrow.r t = 52500 / 8200 approx$ #strong[6.40 years]

104. [T] Total online shopping during the Christmas holidays has increased dramatically during the past 5 years. In 2012 ($t=0$), total online holiday sales were \$42.3 billion, whereas in 2013 they were \$48.1 billion.
  - a. Find a linear function $S$ that estimates the total online holiday sales in the year $t$.
    - $m = (48.1 - 42.3) / (1 - 0) = 5.8$.
    - #strong[$S(t) = 5.8t + 42.3$]
  - b. Interpret the slope of the graph of $S$.
    - The slope of #strong[5.8] means that online holiday sales increase by #strong[\$5.8 billion per year].
  - c. Use part a. to predict the year when online shopping during Christmas will reach \$60 billion.
    - $60 = 5.8t + 42.3 arrow.r 17.7 = 5.8t arrow.r t approx 3.05$.
    - Since $t=0$ is 2012, sales reach \$60 billion during #strong[2015].

105. [T] A family bakery makes cupcakes and sells them at local outdoor festivals. For a music festival, there is a fixed cost of \$125 to set up a cupcake stand. The owner estimates that it costs \$0.75 to make each cupcake. The owner is interested in determining the total cost $C$ as a function of number of cupcakes made.
  - a. Find a linear function that relates cost $C$ to $x$, the number of cupcakes made.
    - #strong[$C(x) = 0.75x + 125$]
  - b. Find the cost to bake 160 cupcakes.
    - $C(160) = 0.75(160) + 125 = 120 + 125 =$ #strong[\$245]
  - c. If the owner sells the cupcakes for \$1.50 apiece, how many cupcakes does she need to sell to start making profit?
    - Revenue $R(x) = 1.50x$. Break-even where $R(x) = C(x)$:
    - $1.50x = 0.75x + 125 arrow.r 0.75x = 125 arrow.r x = 125 / 0.75 approx 166.67$.
    - She needs to sell #strong[167 cupcakes] to start making a profit.

106. [T] A house purchased for \$250,000 is expected to be worth twice its purchase price in 18 years.
  - a. Find a linear function that models the price $P$ of the house versus the number of years $t$ since the original purchase.
    - Points: $(0, 250000)$ and $(18, 500000)$.
    - $m = (500000 - 250000) / 18 = 125000 / 9$.
    - #strong[$P(t) = (125000/9)t + 250000$]
  - b. Interpret the slope of the graph of $P$.
    - The slope $125000/9 approx 13888.89$ means the house value #strong[increases by \$13,888.89 per year].
  - c. Find the price of the house 15 years from when it was originally purchased.
    - $P(15) = (125000/9)(15) + 250000 = 625000/3 + 250000 approx$ #strong[\$458,333.33]
#pagebreak()
107. [T] A car was purchased for \$26,000. The value of the car depreciates by \$1,500 per year.
  - a. Find a linear function that models the value $V$ of the car after $t$ years.
    - #strong[$V(t) = -1500t + 26000$]
  - b. Find and interpret $V(4)$.
    - $V(4) = -1500(4) + 26000 = -6000 + 26000 =$ #strong[\$20,000].
    - $V(4) = -1500(4) + 26000 = -6000 + 26000 =$ #strong[\$20,000].
    - After 4 years, the car is worth \$20,000.

108. [T] A condominium in an upscale part of the city was purchased for \$432,000. In 35 years it is worth \$60,500. Find the rate of depreciation.
  - Points: $(0, 432000)$ and $(35, 60500)$.
  - $m = (60500 - 432000) / 35 = -371500 / 35 = -10614.2857$.
  - The rate of depreciation is approximately #strong[\$10,614.29 per year].

109. [T] The total cost $C$ (in thousands of dollars) to produce a certain item is modeled by the function $C(x) = 10.50x + 28,500$, where $x$ is the number of items produced. Determine the cost to produce 175 items.
  - $C(175) = 10.50(175) + 28500 = 1837.5 + 28500 = 30337.5$.
  - The cost to produce 175 items is #strong[\$30,337.50] (if $C$ is in dollars) or #strong[\$30,337,500] (if $C$ is in thousands of dollars).
  - #emph[Note: Based on standard textbook formatting, it is likely the constant is 28.5 if the unit is thousands of dollars, but we use the provided formula.]

110. [T] A professor asks her class to report the amount of time $t$ they spent writing two assignments. Most students report that it takes them about 45 minutes to type a four-page assignment and about 1.5 hours to type a nine-page assignment.
  - a. Find the linear function $y = N(t)$ that models this situation, where $N$ is the number of pages typed and $t$ is the time in minutes.
    - Points: $(45, 4)$ and $(90, 9)$.
    - $m = (9 - 4) / (90 - 45) = 5 / 45 = 1/9$.
    - $N - 4 = 1/9(t - 45) arrow.r N = 1/9 t - 5 + 4 arrow.r$ #strong[$N(t) = 1/9 t - 1$]
  - b. Use part a. to determine how many pages can be typed in 2 hours.
    - 2 hours = 120 minutes. $N(120) = 1/9(120) - 1 = 40/3 - 1 = 37/3 approx$ #strong[12.33 pages].
  - c. Use part a. to determine how long it takes to type a 20-page assignment.
    - $20 = 1/9 t - 1 arrow.r 21 = 1/9 t arrow.r t = 189$ minutes.
    - It takes #strong[189 minutes] (or 3 hours and 9 minutes).

111. [T] The output (as a percent of total capacity) of nuclear power plants in the United States can be modeled by the function $P(t) = 1.8576t + 68.052$, where $t$ is time in years and $t = 0$ corresponds to the beginning of 2000. Use the model to predict the percentage output in 2015.
  - $t = 15$ for the year 2015.
  - $P(15) = 1.8576(15) + 68.052 = 27.864 + 68.052 = 95.916$.
  - The predicted output is approximately #strong[95.92%].
#pagebreak()
112. [T] The admissions office at a public university estimates that 65% of the students offered admission to the class of 2019 will actually enroll.
  - a. Find the linear function $y = N(x)$, where $N$ is the number of students that actually enroll and $x$ is the number of all students offered admission to the class of 2019.
    - #strong[$N(x) = 0.65x$]
  - b. If the university wants the 2019 freshman class size to be 1350, determine how many students should be admitted.
    - $1350 = 0.65x arrow.r x = 1350 / 0.65 approx 2076.92$.
    - Approximately #strong[2077 students] should be admitted.
