#import "/templates/course-note.typ": *

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 5,
  title: "Important Functions in Computer Science",
  subtitle: "Ceiling and Floor Functions, Step Graphs, Recursive Functions, and Sequence Recurrences",
)

= Ceiling and Floor Functions

In computer science, we frequently bridge the gap between continuous real-valued quantities ($x in RR$) and discrete integer resources ($n in ZZ$). For example, storing a file of $x$ bytes into disk blocks of $4096$ bytes requires an integer number of blocks, and splitting an array of $n$ elements in binary search requires an integer midpoint index. Two foundational rounding functions handle this conversion: the *ceiling function* and the *floor function*.

#definition("Ceiling Function")[
  The *ceiling function* assigns to the real number $x in RR$ the *smallest integer that is greater than or equal to $x$*.
  - *Notation*:
    $ f(x) = ceil(x) $
  - *Characterization*: For any $x in RR$ and $n in ZZ$,
    $ ceil(x) = n quad <==> quad n - 1 < x <= n $
]

#definition("Floor Function")[
  The *floor function* assigns to the real number $x in RR$ the *largest integer that is less than or equal to $x$*. (The floor function is also known as the *greatest integer function*.)
  - *Notation*:
    $ f(x) = floor(x) $
  - *Characterization*: For any $x in RR$ and $n in ZZ$,
    $ floor(x) = n quad <==> quad n <= x < n + 1 $
]

#example(title: "Ceiling and Floor Function Evaluations")[
  - *Ceiling Function Examples*:
    - $ceil(6.76) = 7$ because $7$ is the smallest integer $>= 6.76$ ($6 < 6.76 <= 7$).
    - $ceil(5.1) = 6$ because $6$ is the smallest integer $>= 5.1$ ($5 < 5.1 <= 6$).
  - *Floor Function Examples*:
    - $floor(6.76) = 6$ because $6$ is the largest integer $<= 6.76$ ($6 <= 6.76 < 7$).
    - $floor(5.1) = 5$ because $5$ is the largest integer $<= 5.1$ ($5 <= 5.1 < 6$).
]

== Step-Function Graphs and Algebraic Properties

Both $y = floor(x)$ and $y = ceil(x)$ are *piecewise-constant step functions* mapping $RR$ to $ZZ$. On each unit interval between consecutive integers $n$ and $n + 1$:
- The *floor function* $y = floor(x)$ stays constant at height $n$ on the *left-closed, right-open* interval $[n, n + 1)$, jumping up by $1$ at the right endpoint $x = n + 1$.
- The *ceiling function* $y = ceil(x)$ stays constant at height $n + 1$ on the *left-open, right-closed* interval $(n, n + 1]$, jumping up by $1$ immediately to the right of $x = n$.

#matrix-2x2(
  title: "Comparison: Floor Function vs. Ceiling Function",
  tl-title: "Floor Function: y = floor(x)",
  tl-body: [
    - *Direction*: Rounds *down* toward $-infinity$ on the number line.
    - *Constant Steps*: $floor(x) = n$ for $x in [n, n + 1)$ (closed point on the left at $(n, n)$, open point on the right at $(n+1, n)$).
    - *Bounds*: $x - 1 < floor(x) <= x$.
  ],
  tr-title: "Ceiling Function: y = ceil(x)",
  tr-body: [
    - *Direction*: Rounds *up* toward $+infinity$ on the number line.
    - *Constant Steps*: $ceil(x) = n$ for $x in (n - 1, n]$ (open point on the left at $(n-1, n)$, closed point on the right at $(n, n)$).
    - *Bounds*: $x <= ceil(x) < x + 1$.
  ],
  bl-title: "Behavior at Exact Integers (x in Z)",
  bl-body: [
    If and only if $x in ZZ$, both functions equal $x$:
    $ floor(x) = ceil(x) = x quad <==> quad x in ZZ $
    When $x in.not ZZ$, we always have $ceil(x) - floor(x) = 1$.
  ],
  br-title: "Useful Algebraic Identities (for x in R, k in Z)",
  br-body: [
    - *Integer Shift*: $floor(x + k) = floor(x) + k$ and $ceil(x + k) = ceil(x) + k$.
    - *Negation Duality*:
      $ floor(-x) = -ceil(x) quad "and" quad ceil(-x) = -floor(x) $
  ],
)

#table(
  columns: (1.2fr, 1fr, 1fr, 1.8fr),
  align: (center, center, center, left),
  [Interval of $x$], [Floor $floor(x)$], [Ceiling $ceil(x)$], [Step-Graph Endpoint Behavior],
  [$-3 <= x < -2$], [$-3$], [$-3$ (at $x=-3$) or $-2$], [Floor closed at $(-3,-3)$, open at $(-2,-3)$],
  [$-2 <= x < -1$], [$-2$], [$-2$ (at $x=-2$) or $-1$], [Floor closed at $(-2,-2)$, open at $(-1,-2)$],
  [$-1 <= x < 0$],  [$-1$], [$-1$ (at $x=-1$) or $0$],  [Floor closed at $(-1,-1)$, open at $(0,-1)$],
  [$0 <= x < 1$],   [$0$],  [$0$ (at $x=0$) or $1$],    [Floor closed at $(0,0)$, open at $(1,0)$],
  [$1 <= x < 2$],   [$1$],  [$1$ (at $x=1$) or $2$],    [Floor closed at $(1,1)$, open at $(2,1)$],
  [$2 <= x < 3$],   [$2$],  [$2$ (at $x=2$) or $3$],    [Floor closed at $(2,2)$, open at $(3,2)$],
)

#pitfall(title: "Negative Numbers in Floor and Ceiling Functions")[
  A common mistake is confusing `floor(x)` with simply dropping the fractional part (truncation toward zero).
  - For *positive* numbers, $floor(2.99) = 2$ does match dropping $.99$.
  - For *negative* numbers, $floor(-0.1) = -1$ (not $0$) because $-1 <= -0.1 < 0$, and $-1$ lies to the *left* of $-0.1$ on the number line. Conversely, $ceil(-0.1) = 0$ (not $-1$) because $0$ lies to the *right* of $-0.1$.
  When in doubt, picture the number line: *floor moves left*, *ceiling moves right*.
]

#example(title: "Practice Problems: Evaluating Floor and Ceiling Expressions")[
  *Set 1 — Find these values:*
  - *a) $floor(1.1)$*: Since $1 <= 1.1 < 2$, we have *$floor(1.1) = 1$*.
  - *b) $ceil(1.1)$*: Since $1 < 1.1 <= 2$, we have *$ceil(1.1) = 2$*.
  - *c) $floor(-0.1)$*: Since $-1 <= -0.1 < 0$, rounding down (left) gives *$floor(-0.1) = -1$*.
  - *d) $ceil(-0.1)$*: Since $-1 < -0.1 <= 0$, rounding up (right) gives *$ceil(-0.1) = 0$*.
  - *e) $ceil(2.99)$*: Since $2 < 2.99 <= 3$, we have *$ceil(2.99) = 3$*.
  - *f) $ceil(-2.99)$*: Since $-3 < -2.99 <= -2$, rounding up (right) toward zero gives *$ceil(-2.99) = -2$*.
  - *g) $floor(1/2 + ceil(1/2))$*:
    Evaluate from the inside out: first $ceil(1/2) = ceil(0.5) = 1$. Substituting into the outer floor gives:
    $ floor(1/2 + ceil(1/2)) = floor(1/2 + 1) = floor(1.5) = #strong[1] $
  - *h) $ceil(floor(1/2) + ceil(1/2) + 1/2)$*:
    First evaluate the inner terms: $floor(1/2) = 0$ and $ceil(1/2) = 1$. Substituting into the outer ceiling gives:
    $ ceil(0 + 1 + 1/2) = ceil(1.5) = #strong[2] $

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Set 2 — Find these values:*
  - *a) $ceil(3/4)$*: Since $0 < 0.75 <= 1$, we have *$ceil(3/4) = 1$*.
  - *b) $floor(7/8)$*: Since $0 <= 0.875 < 1$, we have *$floor(7/8) = 0$*.
  - *c) $ceil(-3/4)$*: Since $-1 < -0.75 <= 0$, we have *$ceil(-3/4) = 0$*.
  - *d) $floor(-7/8)$*: Since $-1 <= -0.875 < 0$, we have *$floor(-7/8) = -1$*.
  - *e) $ceil(3)$*: Since $3 in ZZ$ is already an integer, *$ceil(3) = 3$*.
  - *f) $floor(-1)$*: Since $-1 in ZZ$ is already an integer, *$floor(-1) = -1$*.
  - *g) $floor(1/2 + ceil(3/2))$*:
    First evaluate the inner ceiling: $ceil(3/2) = ceil(1.5) = 2$. Then:
    $ floor(1/2 + ceil(3/2)) = floor(0.5 + 2) = floor(2.5) = #strong[2] $
  - *h) $floor(1/2 dot floor(5/2))$*:
    First evaluate the inner floor: $floor(5/2) = floor(2.5) = 2$. Multiplying by $1/2$ inside the outer floor gives:
    $ floor(1/2 dot floor(5/2)) = floor(1/2 dot 2) = floor(1) = #strong[1] $
]

= Recursive Functions

Sometimes it is difficult or awkward to define a sequence or function directly with a closed-form formula, whereas it is natural to describe how each value builds on earlier values. This approach is called *recursion*.

#definition("Recursive Function")[
  A function $f$ (typically with domain $NN = {0, 1, 2, dots}$ or $ZZ^+ = {1, 2, 3, dots}$) is called a *recursive function* if its definition refers to itself.
  Every well-defined recursive function consists of two essential parts:
  1. *Basis Step*:
     Specifies the initial value(s) of the function directly, *without* referring to the function itself (for example, $f(0)$ or $f(1)$).
  2. *Recursive (or Inductive) Step*:
     Defines the value of the function at the current input $n$ in terms of its own values at smaller inputs (such as $f(n - 1), f(n - 2), dots$).
]

#intuition(title: "Visualizing Recursion: Self-Similarity and Call Stack Unwinding")[
  Recursion is like a picture-within-a-picture (the *Droste effect*), where a scene contains a smaller copy of the exact same scene, which in turn contains an even smaller copy.
  In programming and mathematics, however, an endless chain of self-references without a stopping condition causes infinite recursion (a stack overflow). The *Basis Step* acts as the innermost frame that holds a concrete value instead of another recursive call, allowing the evaluation to stop and unwind back to the original call.
]

#flow-chain(
  caption: "Evaluating f(3) for a recursive function with a base case at f(0).",
  ("Call f(3)", "Needs 3 * f(2)"),
  ("Call f(2)", "Needs 2 * f(1)"),
  ("Call f(1)", "Needs 1 * f(0)"),
  ("Basis f(0) = 1", "Base case reached"),
  ("Unwind Stack", "f(1)=1 -> f(2)=2 -> f(3)=6"),
)

== Classic Recursive Functions

=== The Factorial Function

Let $f(n) = n!$ denote the factorial function on $n in NN$. Because $n! = n dot (n - 1) dot (n - 2) dots.c 2 dot 1 = n dot (n - 1)!$ for $n >= 1$, we can write $f(n)$ recursively as:
$ f(n) = cases(
  1 & ", for " n = 0 quad & "(Basis)",
  n dot f(n - 1) & ", for " n > 0 quad & "(Recurrence)"
) $

#example(title: "Step-by-Step Evaluation of the Factorial Function")[
  Starting from the basis at $n = 0$ and stepping forward for $n = 0, 1, 2, 3, dots$:
  - $n = 0 ==>$ $f(0) = 1 = 0!$ (by the basis step)
  - $n = 1 ==>$ $f(1) = 1 dot f(0) = 1 dot 1 = 1 = 1!$
  - $n = 2 ==>$ $f(2) = 2 dot f(1) = 2 dot 1 = 2 = 2!$
  - $n = 3 ==>$ $f(3) = 3 dot f(2) = 3 dot 2 dot 1 = 6 = 3!$
  - $n = 4 ==>$ $f(4) = 4 dot f(3) = 4 dot 6 = 24 = 4!$, and so on.
]

=== Chebyshev Polynomials

A recursive definition can depend on *two* (or more) previous terms. When a recurrence depends on both $n - 1$ and $n - 2$ (a second-order recurrence), we must provide *two basis cases* ($n = 0$ and $n = 1$) so that the recurrence has enough starting information at $n = 2$.

The *Chebyshev polynomials of the first kind*, denoted $T(n, x)$ (used widely in numerical analysis and approximation theory because they satisfy $T(n, cos theta) = cos(n theta)$), are defined recursively by:
$ T(n, x) = cases(
  1 & ", " n = 0,
  x & ", " n = 1,
  2 x T(n - 1, x) - T(n - 2, x) & ", " n > 1
) $

#example(title: "Evaluating Chebyshev Polynomials")[
  This function has two basis cases: $n = 0$ and $n = 1$. Computing the first few polynomials:
  - $n = 0 ==>$ $T(0, x) = 1$
  - $n = 1 ==>$ $T(1, x) = x$
  - $n = 2 ==>$ Substituting $n = 2$ into the recurrence:
    $ T(2, x) &= 2 x T(1, x) - T(0, x) \
              &= 2 x (x) - 1 \
              &= 2 x^2 - 1 $
  - $n = 3 ==>$ Substituting $n = 3$ into the recurrence:
    $ T(3, x) = 2 x T(2, x) - T(1, x) = 2 x (2 x^2 - 1) - x = 4 x^3 - 3 x $
]

=== The Fibonacci Sequence

The *Fibonacci function* is another classic second-order recurrence relation with two basis values ($n = 0$ and $n = 1$):
$ f(n) = cases(
  0 & ", " n = 0,
  1 & ", " n = 1,
  f(n - 1) + f(n - 2) & ", " n > 1
) $

#example(title: "Evaluating Fibonacci Numbers for n = 0, 1, 2, 3, 4, 5")[
  *Problem:* Find the values of the Fibonacci function $f(n)$ for $n = 0, 1, 2, 3, 4, 5$.

  *Solution:* Starting from the basis values $f(0) = 0$ and $f(1) = 1$, each subsequent term is the sum of the two preceding terms:
  - *$n = 0$*: $f(0) = #strong[0]$ *(Basis 1)*
  - *$n = 1$*: $f(1) = #strong[1]$ *(Basis 2)*
  - *$n = 2$*: $f(2) = f(1) + f(0) = 1 + 0 = #strong[1]$
  - *$n = 3$*: $f(3) = f(2) + f(1) = 1 + 1 = #strong[2]$
  - *$n = 4$*: $f(4) = f(3) + f(2) = 2 + 1 = #strong[3]$
  - *$n = 5$*: $f(5) = f(4) + f(3) = 3 + 2 = #strong[5]$
]

= Expressing Closed-Form Functions Recursively

To convert an explicit formula $f(n)$ or sequence $a_n$ into a recursive definition, we follow two steps:
1. *Formulate the Recurrence*: Express the current term $f(n)$ (or $a_n$) using the previous term $f(n - 1)$ (or $a_(n - 1)$), either by expanding and grouping repeated operations or by algebraic substitution.
2. *Specify the Basis*: Evaluate the formula at the starting index of the domain (typically $n = 0$ or $n = 1$).

== Recursive Definition of Powers $f(n) = a^n$

Suppose we want to express $f(n) = a^n$ (for $a != 0$ and $n in NN$) recursively:
1. *Express $f(n)$ in terms of $f(n - 1)$*:
   $ f(n) = a^n = underbrace(a dot a dot a dots.c a, n "factors") = a dot underbrace((a dot a dots.c a), n - 1 "factors") = a dot a^(n - 1) = a dot f(n - 1) $
2. *Determine the basis*:
   At $n = 0$, we have $f(0) = a^0 = 1$.
3. *Complete Recursive Definition*:
   $ f(n) = cases(
     1 & ", " n = 0,
     a dot f(n - 1) & ", " n > 0
   ) $

== Recursive Definition of $a_n = 6 n$ via Two Methods

Suppose we want to express the linear sequence $a_n = 6 n$, for $n = 1, 2, 3, dots$, recursively. We can derive the recurrence in two ways.

#example(title: "Deriving the Recurrence for a_n = 6n")[
  *Method 1 — Expansion and Grouping:*
  - *Recurrence*: Write multiplication by $n$ as repeated addition of $6$ ($n$ times), then group the last $n - 1$ terms together:
    $ a_n &= 6 n = underbrace(6 + 6 + dots + 6, n "times") \
          &= 6 + underbrace((6 + dots + 6), n - 1 "times") \
          &= 6 + 6(n - 1) \
          &= 6 + a_(n - 1) $
  - *Basis*: Because $n$ starts at $n = 1$, the basis is:
    $ a_1 = 6(1) = 6 $

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Method 2 — Algebraic Substitution from the Closed Form:*
  - Write down the closed-form formula at index $n$ and at index $n - 1$:
    $ a_n = 6 n quad "and" quad a_(n - 1) = 6(n - 1) = 6 n - 6 $
  - Substitute $a_(n - 1) = 6 n - 6$ into the expression for $a_n$:
    $ a_n = 6 n = (6 n - 6) + 6 = a_(n - 1) + 6 $
  - *Complete Recursive Definition*:
    $ a_n = cases(
      6 & ", " n = 1,
      6 + a_(n - 1) & ", " n > 1
    ) $
]

#intuition(title: "Using Finite Differences to Formulate Any Recurrence")[
  Method 2 generalizes to *any* sequence $a_n$:
  - *Additive (Difference) Form*: Compute the difference between consecutive terms, $Delta a_n = a_n - a_(n - 1)$. Once simplified, rewrite it as:
    $ a_n = a_(n - 1) + (a_n - a_(n - 1)) $
    For example, if $a_n = n^2$, then $a_n - a_(n - 1) = n^2 - (n - 1)^2 = 2 n - 1$, which immediately gives $a_n = a_(n - 1) + 2 n - 1$.
  - *Multiplicative (Ratio) Form*: For geometric sequences where $a_n / a_(n - 1) = r$, rewrite as $a_n = r dot a_(n - 1)$.
]

= Worked Practice Exercises

Below are complete, step-by-step solutions to the practice problems on evaluating and formulating recursive functions.

== First-Order Recurrence Evaluations

#example(title: "Evaluating First-Order Recurrences (Set 1)")[
  *Problem:* Find $f(1), f(2), f(3),$ and $f(4)$ if $f(n)$ is defined recursively by *$f(0) = 1$* and for $n = 0, 1, 2, dots$:

  - *a) $f(n + 1) = f(n) + 2$* *(Arithmetic progression with common difference $+2$)*:
    - $f(1) = f(0) + 2 = 1 + 2 = #strong[3]$
    - $f(2) = f(1) + 2 = 3 + 2 = #strong[5]$
    - $f(3) = f(2) + 2 = 5 + 2 = #strong[7]$
    - $f(4) = f(3) + 2 = 7 + 2 = #strong[9]$

  - *b) $f(n + 1) = 3 f(n)$* *(Geometric progression with common ratio $3$)*:
    - $f(1) = 3 f(0) = 3(1) = #strong[3]$
    - $f(2) = 3 f(1) = 3(3) = #strong[9]$
    - $f(3) = 3 f(2) = 3(9) = #strong[27]$
    - $f(4) = 3 f(3) = 3(27) = #strong[81]$

  - *c) $f(n + 1) = 2^(f(n))$* *(Iterated exponentiation)*:
    - $f(1) = 2^(f(0)) = 2^1 = #strong[2]$
    - $f(2) = 2^(f(1)) = 2^2 = #strong[4]$
    - $f(3) = 2^(f(2)) = 2^4 = #strong[16]$
    - $f(4) = 2^(f(3)) = 2^(16) = #strong[65,536]$

  - *d) $f(n + 1) = f(n)^2 + f(n) + 1$* *(Quadratic recurrence)*:
    - $f(1) = f(0)^2 + f(0) + 1 = 1^2 + 1 + 1 = #strong[3]$
    - $f(2) = f(1)^2 + f(1) + 1 = 3^2 + 3 + 1 = 9 + 3 + 1 = #strong[13]$
    - $f(3) = f(2)^2 + f(2) + 1 = 13^2 + 13 + 1 = 169 + 13 + 1 = #strong[183]$
    - $f(4) = f(3)^2 + f(3) + 1 = 183^2 + 183 + 1 = 33,489 + 183 + 1 = #strong[33,673]$
]

#example(title: "Evaluating First-Order Recurrences (Set 2)")[
  *Problem:* Find $f(1), f(2), f(3), f(4),$ and $f(5)$ if $f(n)$ is defined recursively by *$f(0) = 3$* and for $n = 0, 1, 2, dots$:

  - *a) $f(n + 1) = -2 f(n)$*:
    - $f(1) = -2 f(0) = -2(3) = #strong[-6]$
    - $f(2) = -2 f(1) = -2(-6) = #strong[12]$
    - $f(3) = -2 f(2) = -2(12) = #strong[-24]$
    - $f(4) = -2 f(3) = -2(-24) = #strong[48]$
    - $f(5) = -2 f(4) = -2(48) = #strong[-96]$

  - *b) $f(n + 1) = 3 f(n) + 7$*:
    - $f(1) = 3(3) + 7 = 9 + 7 = #strong[16]$
    - $f(2) = 3(16) + 7 = 48 + 7 = #strong[55]$
    - $f(3) = 3(55) + 7 = 165 + 7 = #strong[172]$
    - $f(4) = 3(172) + 7 = 516 + 7 = #strong[523]$
    - $f(5) = 3(523) + 7 = 1569 + 7 = #strong[1576]$

  - *c) $f(n + 1) = f(n)^2 - 2 f(n) - 2$*:
    - $f(1) = 3^2 - 2(3) - 2 = 9 - 6 - 2 = #strong[1]$
    - $f(2) = 1^2 - 2(1) - 2 = 1 - 2 - 2 = #strong[-3]$
    - $f(3) = (-3)^2 - 2(-3) - 2 = 9 + 6 - 2 = #strong[13]$
    - $f(4) = 13^2 - 2(13) - 2 = 169 - 26 - 2 = #strong[141]$
    - $f(5) = 141^2 - 2(141) - 2 = 19,881 - 282 - 2 = #strong[19,597]$

  - *d) $f(n + 1) = 3^(f(n) / 3)$*:
    - $f(1) = 3^(f(0) / 3) = 3^(3 / 3) = 3^1 = #strong[3]$
    - $f(2) = 3^(f(1) / 3) = 3^(3 / 3) = 3^1 = #strong[3]$
    - $f(3) = 3^(f(2) / 3) = 3^(3 / 3) = #strong[3]$
    - $f(4) = 3^(f(3) / 3) = 3^(3 / 3) = #strong[3]$
    - $f(5) = 3^(f(4) / 3) = 3^(3 / 3) = #strong[3]$
    *(Notice that $f(0) = 3$ is a fixed point of the map $x |-> 3^(x / 3)$, so $f(n) = 3$ for all $n >= 0$.)*
]

== Second-Order Recurrence Evaluations

#example(title: "Evaluating Second-Order Recurrences (Set 3)")[
  *Problem:* Find $f(2), f(3), f(4),$ and $f(5)$ if $f$ is defined recursively by *$f(0) = -1, f(1) = 2$*, and for $n = 1, 2, dots$:

  - *a) $f(n + 1) = f(n) + 3 f(n - 1)$*:
    - $n = 1 ==>$ $f(2) = f(1) + 3 f(0) = 2 + 3(-1) = 2 - 3 = #strong[-1]$
    - $n = 2 ==>$ $f(3) = f(2) + 3 f(1) = -1 + 3(2) = -1 + 6 = #strong[5]$
    - $n = 3 ==>$ $f(4) = f(3) + 3 f(2) = 5 + 3(-1) = 5 - 3 = #strong[2]$
    - $n = 4 ==>$ $f(5) = f(4) + 3 f(3) = 2 + 3(5) = 2 + 15 = #strong[17]$

  - *b) $f(n + 1) = f(n)^2 f(n - 1)$*:
    - $n = 1 ==>$ $f(2) = f(1)^2 f(0) = (2)^2 (-1) = #strong[-4]$
    - $n = 2 ==>$ $f(3) = f(2)^2 f(1) = (-4)^2 (2) = 16 dot 2 = #strong[32]$
    - $n = 3 ==>$ $f(4) = f(3)^2 f(2) = (32)^2 (-4) = 1024 dot (-4) = #strong[-4096]$
    - $n = 4 ==>$ $f(5) = f(4)^2 f(3) = (-4096)^2 (32) = 16,777,216 dot 32 = #strong[536,870,912]$ (or $2^(29)$)

  - *c) $f(n + 1) = 3 f(n)^2 - 4 f(n - 1)^2$*:
    - $n = 1 ==>$ $f(2) = 3 f(1)^2 - 4 f(0)^2 = 3(2)^2 - 4(-1)^2 = 12 - 4 = #strong[8]$
    - $n = 2 ==>$ $f(3) = 3 f(2)^2 - 4 f(1)^2 = 3(8)^2 - 4(2)^2 = 192 - 16 = #strong[176]$
    - $n = 3 ==>$ $f(4) = 3 f(3)^2 - 4 f(2)^2 = 3(176)^2 - 4(8)^2 = 3(30,976) - 256 = 92,928 - 256 = #strong[92,672]$
    - $n = 4 ==>$ $f(5) = 3 f(4)^2 - 4 f(3)^2 = 3(92,672)^2 - 4(176)^2 = 25,764,298,752 - 123,904 = #strong[25,764,174,848]$

  - *d) $f(n + 1) = f(n - 1) / f(n)$*:
    - $n = 1 ==>$ $f(2) = f(0) / f(1) = (-1) / 2 = #strong[-1/2]$
    - $n = 2 ==>$ $f(3) = f(1) / f(2) = 2 / (-1/2) = #strong[-4]$
    - $n = 3 ==>$ $f(4) = f(2) / f(3) = (-1/2) / (-4) = #strong[1/8]$
    - $n = 4 ==>$ $f(5) = f(3) / f(4) = (-4) / (1/8) = #strong[-32]$
]

#example(title: "Evaluating Second-Order Recurrences (Set 4)")[
  *Problem:* Find $f(2), f(3), f(4),$ and $f(5)$ if $f$ is defined recursively by *$f(0) = f(1) = 1$* and for $n = 1, 2, dots$:

  - *a) $f(n + 1) = f(n) - f(n - 1)$*:
    - $n = 1 ==>$ $f(2) = f(1) - f(0) = 1 - 1 = #strong[0]$
    - $n = 2 ==>$ $f(3) = f(2) - f(1) = 0 - 1 = #strong[-1]$
    - $n = 3 ==>$ $f(4) = f(3) - f(2) = -1 - 0 = #strong[-1]$
    - $n = 4 ==>$ $f(5) = f(4) - f(3) = -1 - (-1) = #strong[0]$
    *(This sequence repeats with period $6$: $1, 1, 0, -1, -1, 0, 1, 1, dots$)*

  - *b) $f(n + 1) = f(n) f(n - 1)$*:
    - $n = 1 ==>$ $f(2) = f(1) f(0) = 1 dot 1 = #strong[1]$
    - $n = 2 ==>$ $f(3) = f(2) f(1) = 1 dot 1 = #strong[1]$
    - $n = 3 ==>$ $f(4) = f(3) f(2) = 1 dot 1 = #strong[1]$
    - $n = 4 ==>$ $f(5) = f(4) f(3) = 1 dot 1 = #strong[1]$

  - *c) $f(n + 1) = f(n)^2 + f(n - 1)^3$*:
    - $n = 1 ==>$ $f(2) = f(1)^2 + f(0)^3 = 1^2 + 1^3 = #strong[2]$
    - $n = 2 ==>$ $f(3) = f(2)^2 + f(1)^3 = 2^2 + 1^3 = 4 + 1 = #strong[5]$
    - $n = 3 ==>$ $f(4) = f(3)^2 + f(2)^3 = 5^2 + 2^3 = 25 + 8 = #strong[33]$
    - $n = 4 ==>$ $f(5) = f(4)^2 + f(3)^3 = 33^2 + 5^3 = 1089 + 125 = #strong[1214]$

  - *d) $f(n + 1) = f(n) / f(n - 1)$*:
    - $n = 1 ==>$ $f(2) = f(1) / f(0) = 1 / 1 = #strong[1]$
    - $n = 2 ==>$ $f(3) = f(2) / f(1) = 1 / 1 = #strong[1]$
    - $n = 3 ==>$ $f(4) = f(3) / f(2) = 1 / 1 = #strong[1]$
    - $n = 4 ==>$ $f(5) = f(4) / f(3) = 1 / 1 = #strong[1]$
]

== Formulating Recursive Sequence Definitions

#example(title: "Writing Recursive Definitions for Sequences")[
  *Set 1:* Give a recursive definition of the sequence ${a_n}, n = 1, 2, 3, dots$ if:

  - *a) $a_n = 6 n$*:
    - *Basis*: $a_1 = 6(1) = 6$.
    - *Recurrence*: Since $a_n - a_(n - 1) = 6 n - 6(n - 1) = 6$, we have $a_n = a_(n - 1) + 6$ for $n > 1$.
    $ a_n = cases(6 & ", " n = 1, a_(n - 1) + 6 & ", " n > 1) $

  - *b) $a_n = 2 n + 1$*:
    - *Basis*: $a_1 = 2(1) + 1 = 3$.
    - *Recurrence*: Since $a_n - a_(n - 1) = (2 n + 1) - (2(n - 1) + 1) = 2$, we have $a_n = a_(n - 1) + 2$ for $n > 1$.
    $ a_n = cases(3 & ", " n = 1, a_(n - 1) + 2 & ", " n > 1) $

  - *c) $a_n = 10^n$*:
    - *Basis*: $a_1 = 10^1 = 10$.
    - *Recurrence*: Since $a_n = 10 dot 10^(n - 1) = 10 a_(n - 1)$, we have $a_n = 10 a_(n - 1)$ for $n > 1$.
    $ a_n = cases(10 & ", " n = 1, 10 a_(n - 1) & ", " n > 1) $

  - *d) $a_n = 5$* *(Constant sequence)*:
    - *Basis*: $a_1 = 5$.
    - *Recurrence*: Every term equals the previous term, so $a_n = a_(n - 1)$ for $n > 1$.
    $ a_n = cases(5 & ", " n = 1, a_(n - 1) & ", " n > 1) $

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Set 2:* Give a recursive definition of the sequence ${a_n}, n = 1, 2, 3, dots$ if:

  - *a) $a_n = 4 n - 2$*:
    - *Basis*: $a_1 = 4(1) - 2 = 2$.
    - *Recurrence*: Computing the difference gives $a_n - a_(n - 1) = (4 n - 2) - (4(n - 1) - 2) = 4$. Thus $a_n = a_(n - 1) + 4$ for $n > 1$.
    $ a_n = cases(2 & ", " n = 1, a_(n - 1) + 4 & ", " n > 1) $

  - *b) $a_n = 1 + (-1)^n$*:
    Checking the first few terms: for odd $n$, $a_n = 1 - 1 = 0$; for even $n$, $a_n = 1 + 1 = 2$. Thus the sequence alternates $0, 2, 0, 2, 0, 2, dots$
    - *Method A (First-Order Complement)*: Notice that $a_n + a_(n - 1) = (1 + (-1)^n) + (1 + (-1)^(n - 1)) = 2 + 0 = 2$. Thus $a_n = 2 - a_(n - 1)$ (or $a_n = a_(n - 1) + 2(-1)^n$) with basis $a_1 = 0$:
      $ a_n = cases(0 & ", " n = 1, 2 - a_(n - 1) & ", " n > 1) $
    - *Method B (Second-Order Periodic)*: Alternatively, using two basis cases $a_1 = 0, a_2 = 2$, the recurrence is $a_n = a_(n - 2)$ for $n > 2$.

  - *c) $a_n = n(n + 1)$*:
    - *Basis*: $a_1 = 1(1 + 1) = 2$.
    - *Recurrence*: Compute the first difference $a_n - a_(n - 1)$:
      $ a_n - a_(n - 1) = n(n + 1) - (n - 1)n = n((n + 1) - (n - 1)) = 2 n $
      Therefore, $a_n = a_(n - 1) + 2 n$ for $n > 1$:
      $ a_n = cases(2 & ", " n = 1, a_(n - 1) + 2 n & ", " n > 1) $

  - *d) $a_n = n^2$*:
    - *Basis*: $a_1 = 1^2 = 1$.
    - *Recurrence*: Compute the first difference $a_n - a_(n - 1)$:
      $ a_n - a_(n - 1) = n^2 - (n - 1)^2 = n^2 - (n^2 - 2 n + 1) = 2 n - 1 $
      Therefore, $a_n = a_(n - 1) + 2 n - 1$ for $n > 1$ (showing that the $n$-th square is the sum of the first $n$ odd integers):
      $ a_n = cases(1 & ", " n = 1, a_(n - 1) + 2 n - 1 & ", " n > 1) $
]
