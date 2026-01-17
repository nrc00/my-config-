#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#set page(numbering: "1")
#set heading(numbering: "1.1")
#show heading.where(level: 2): it => {
  text(weight: "extrabold", size: 10pt)[#it]
}

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
#pagebreak()
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
          plot.add(((2, 4), ), mark: "o", mark-size: .15, style: (stroke: none,fill:black))
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
//#pagebreak()
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
