#import "/templates/course-note.typ": *

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 3,
  title: "Sequences and Series",
  subtitle: "Discrete Sequences, Geometric and Arithmetic Progressions, Sigma Notation, and Closed-Form Summations",
)

= Sequences

In computer science and discrete mathematics, ordered lists of elements—such as array entries indexed in memory, step counts of iterative algorithms across input sizes, or states produced at discrete clock ticks—are modeled mathematically as _sequences_.

#definition("Sequence and Term")[
  A *sequence* is a function from a subset of the set of integers—usually either the set of positive integers ${1, 2, 3, dots}$ or the set of non-negative integers ${0, 1, 2, dots}$—to a target set $S$:
  $ a : {1, 2, 3, dots} arrow.r S quad "or" quad a : {0, 1, 2, dots} arrow.r S $
  - The image $a(n)$ of an integer $n$ is denoted by subscript notation $a_n$ and is called the *$n$-th term* of the sequence.
  - The entire sequence is denoted using braces as ${a_n}$ (or ${a_n}_(n=1)^infinity$).
]

#intuition(title: "Sequences Are Functions with an Integer Domain")[
  Why do we define a sequence as a _function_ rather than a _set_?
  1. *Order matters:* In a set, ${1, 2, 3} = {3, 1, 2}$, whereas the sequence $1, 2, 3, dots$ is distinct from $3, 1, 2, dots$ because the domain index $n$ fixes each position.
  2. *Repetition is allowed:* In a set, ${1, -1, 1, -1, dots} = {1, -1}$ has only two elements, whereas the alternating sequence $a_n = (-1)^n$ has infinitely many indexed terms $a_1, a_2, a_3, dots$ that take values in ${-1, 1}$.
]

#example(title: "The Harmonic Sequence")[
  Consider the sequence ${a_n}$ defined for $n >= 1$ by the explicit formula:
  $ a_n = 1 / n $
  Evaluating $a_n$ at $n = 1, 2, 3, 4, dots$ produces the sequence of terms $a_1, a_2, a_3, a_4, dots$, namely:
  $ 1, quad 1 / 2, quad 1 / 3, quad 1 / 4, quad dots, quad 1 / n, quad dots $
  This sequence is known in mathematics and algorithm analysis as the _harmonic sequence_.
]

#example(title: "Finding the First Five Terms of a Sequence")[
  *Problem:* Determine the first $5$ terms of the following sequences:
  1. $a_n = n + 1$
  2. $a_n = n^2$

  *Solution:*
  When the starting index is not explicitly stated, the standard convention in discrete mathematics is $n = 1, 2, 3, 4, 5$ (though $0$-based indexing $n = 0, 1, 2, 3, 4$ is also common in computer science). Both conventions are shown below:

  1. *For $a_n = n + 1$:*
     - Starting at $n = 1$:
       $ a_1 = 1 + 1 = 2, quad a_2 = 2 + 1 = 3, quad a_3 = 3 + 1 = 4, quad a_4 = 4 + 1 = 5, quad a_5 = 5 + 1 = 6 $
       First $5$ terms: *$2, 3, 4, 5, 6$*.
     - (If starting at $n = 0$: $a_0 = 1, a_1 = 2, a_2 = 3, a_3 = 4, a_4 = 5$, i.e., *$1, 2, 3, 4, 5$*.)

  2. *For $a_n = n^2$:*
     - Starting at $n = 1$:
       $ a_1 = 1^2 = 1, quad a_2 = 2^2 = 4, quad a_3 = 3^2 = 9, quad a_4 = 4^2 = 16, quad a_5 = 5^2 = 25 $
       First $5$ terms: *$1, 4, 9, 16, 25$*.
     - (If starting at $n = 0$: $a_0 = 0, a_1 = 1, a_2 = 4, a_3 = 9, a_4 = 16$, i.e., *$0, 1, 4, 9, 16$*.)
]

= Geometric and Arithmetic Progressions

Two families of sequences appear throughout computer science: _geometric progressions_ (which model multiplicative growth or decay, divide-and-conquer recursion trees, and binary representations) and _arithmetic progressions_ (which model constant additive stepping and nested loop counters).

== Geometric Progressions

#definition("Geometric Progression")[
  A *geometric progression* is a sequence of the form:
  $ a, quad a r, quad a r^2, quad a r^3, quad dots, quad a r^n, quad dots $
  where the *initial term* $a$ and the *common ratio* $r$ are real numbers ($a, r in bb(R)$).
  - For $0$-based indexing ($n = 0, 1, 2, dots$), the general term is $a_n = a r^n$.
  - For $1$-based indexing ($n = 1, 2, 3, dots$), the $n$-th term is $a_n = a r^(n - 1)$.
  - For every $n >= 1$ (with $a != 0, r != 0$), the ratio of consecutive terms is constant: $a_(n) / a_(n - 1) = r$.
]

#example(title: "Geometric Progression cₙ = 2 · 5ⁿ")[
  Consider the sequence ${c_n}$ defined for $n = 0, 1, 2, 3, dots$ by:
  $ c_n = 2 dot 5^n $
  This is a geometric progression with initial term $a = c_0 = 2$ and common ratio $r = 5$. Its terms are:
  $ c_0 = 2 dot 5^0 = 2, quad c_1 = 2 dot 5^1 = 10, quad c_2 = 2 dot 5^2 = 50, quad c_3 = 2 dot 5^3 = 250, quad dots $
  Each term is obtained by multiplying the preceding term by $r = 5$.
]

== Arithmetic Progressions

#definition("Arithmetic Progression")[
  An *arithmetic progression* is a sequence of the form:
  $ a, quad a + d, quad a + 2d, quad a + 3d, quad dots, quad a + n d, quad dots $
  where the *initial term* $a$ and the *common difference* $d$ are real numbers ($a, d in bb(R)$).
  - For $0$-based indexing ($n = 0, 1, 2, dots$), the general term is $a_n = a + n d$.
  - For $1$-based indexing ($n = 1, 2, 3, dots$), the $n$-th term is $a_n = a + (n - 1) d$.
  - For every $n >= 1$, the difference between consecutive terms is constant: $a_n - a_(n - 1) = d$.
]

#example(title: "Arithmetic Progression bₙ = 1 + 3n")[
  Consider the sequence ${b_n}$ defined for $n = 0, 1, 2, 3, dots$ by:
  $ b_n = 1 + n dot 3 $
  This is an arithmetic progression with initial term $a = b_0 = 1$ and common difference $d = 3$. Its terms are:
  $ b_0 = 1, quad b_1 = 1 + 3 = 4, quad b_2 = 1 + 6 = 7, quad b_3 = 1 + 9 = 10, quad dots $
  Each successive term increases by the constant difference $d = 3$.
]

#intuition(title: "Discrete Analogues of Linear and Exponential Functions")[
  - An *arithmetic progression* $a_n = a + n d$ is the discrete counterpart of the continuous _linear function_ $f(x) = d x + a$ (constant first difference $Delta a_n = a_(n+1) - a_n = d$, analogous to a constant derivative $f'(x) = d$).
  - A *geometric progression* $a_n = a r^n$ is the discrete counterpart of the continuous _exponential function_ $f(x) = a r^x$ (constant consecutive ratio $a_(n+1) / a_n = r$).
]

#example(title: "Classifying Geometric and Arithmetic Sequences")[
  *Problem:* Identify which of the following sequences are geometric progressions and which are arithmetic progressions:
  1. $2, 4, 8, 16, dots$
  2. $1, 4, 7, 10, dots$
  3. $1, -1, 1, -1, dots$
  4. $5, 9, 13, 17, dots$

  *Solution:*
  1. *$2, 4, 8, 16, dots$ — Geometric Progression.*
     - _Consecutive ratios:_ $4 / 2 = 2$, $8 / 4 = 2$, $16 / 8 = 2$.
     - _Parameters:_ Initial term $a = 2$, common ratio $r = 2$.
     - _Explicit formula:_ $a_n = 2 dot 2^n = 2^(n+1)$ (for $n >= 0$), or $a_n = 2^n$ (for $n >= 1$).

  2. *$1, 4, 7, 10, dots$ — Arithmetic Progression.*
     - _Consecutive differences:_ $4 - 1 = 3$, $7 - 4 = 3$, $10 - 7 = 3$.
     - _Parameters:_ Initial term $a = 1$, common difference $d = 3$.
     - _Explicit formula:_ $a_n = 1 + 3n$ (for $n >= 0$), or $a_n = 3n - 2$ (for $n >= 1$).

  3. *$1, -1, 1, -1, dots$ — Geometric Progression.*
     - _Consecutive ratios:_ $(-1) / 1 = -1$, $1 / (-1) = -1$, $(-1) / 1 = -1$. (Differences alternate between $-2$ and $+2$, so it is _not_ arithmetic.)
     - _Parameters:_ Initial term $a = 1$, common ratio $r = -1$.
     - _Explicit formula:_ $a_n = (-1)^n$ (for $n >= 0$), or $a_n = (-1)^(n-1)$ (for $n >= 1$).

  4. *$5, 9, 13, 17, dots$ — Arithmetic Progression.*
     - _Consecutive differences:_ $9 - 5 = 4$, $13 - 9 = 4$, $17 - 13 = 4$.
     - _Parameters:_ Initial term $a = 5$, common difference $d = 4$.
     - _Explicit formula:_ $a_n = 5 + 4n$ (for $n >= 0$), or $a_n = 4n + 1$ (for $n >= 1$).
]

== Reference Table of Common Sequences

Recognizing standard integer sequences by their first several terms is helpful for pattern recognition, solving recurrences, and analyzing algorithms.

#table(
  columns: (1.1fr, 2.9fr, 1.8fr),
  align: (center, left, left),
  [$n$-th Term ($n >= 1$)], [First $10$ Terms], [Sequence Name / Context],
  [$n^2$], [$1, 4, 9, 16, 25, 36, 49, 64, 81, 100, dots$], [Perfect squares (quadratic growth)],
  [$n^3$], [$1, 8, 27, 64, 125, 216, 343, 512, 729, 1000, dots$], [Perfect cubes (cubic growth)],
  [$n^4$], [$1, 16, 81, 256, 625, 1296, 2401, 4096, 6561, 10000, dots$], [Fourth powers (quartic growth)],
  [$2^n$], [$2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, dots$], [Powers of $2$ (binary subsets)],
  [$3^n$], [$3, 9, 27, 81, 243, 729, 2187, 6561, 19683, 59049, dots$], [Powers of $3$ (ternary growth)],
  [$n!$], [$1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, dots$], [Factorials (permutations of $n$ items)],
  [$f_n$], [$1, 1, 2, 3, 5, 8, 13, 21, 34, 55, (89), dots$], [Fibonacci ($f_1=1, f_2=1, f_n = f_(n-1)+f_(n-2)$)],
)

= Series and Sigma Summation Notation

Adding together consecutive terms of a sequence ${a_n}$ produces a _series_, which we express concisely using capital Greek sigma ($Sigma$) notation.

#definition("Series and Summation Notation")[
  The sum of the terms $a_m, a_(m+1), dots, a_k$ from a sequence ${a_n}$ is written in *sigma notation* as:
  $ sum_(i = m)^k a_i = a_m + a_(m + 1) + dots.h + a_(k - 1) + a_k $
  - The variable $i$ is called the *index of summation*. It is a bound (dummy) variable: replacing $i$ with $j$ or $k$ does not change the value of the sum.
  - The integer $m$ is the *lower limit*, and the integer $k$ (with $k >= m$) is the *upper limit*.
  - The total number of terms in the sum is $(k - m + 1)$.
]

#example(title: "Expanding and Evaluating Summations")[
  1. *Harmonic Sum ($sum_(j=1)^n 1/j$):*
     In expanded form:
     $ sum_(j = 1)^n 1 / j = 1 + 1 / 2 + 1 / 3 + dots.h + 1 / n $
     Evaluating for $n = 5$ using the least common denominator $"lcm"(1, 2, 3, 4, 5) = 60$:
     $ sum_(j = 1)^5 1 / j = 1 + 1 / 2 + 1 / 3 + 1 / 4 + 1 / 5 = (60 + 30 + 20 + 15 + 12) / 60 = 137 / 60 $

  2. *Sum of Squares ($sum_(i=1)^k i^2$):*
     In expanded form:
     $ sum_(i = 1)^k i^2 = 1 + 4 + 9 + dots.h + k^2 $
     Evaluating for $k = 10$:
     $ sum_(i = 1)^(10) i^2 = 1 + 4 + 9 + 16 + 25 + 36 + 49 + 64 + 81 + 100 = 385 $

  3. *Shifted Linear Sum ($sum_(i=2)^n (i + 1)$):*
     In expanded form:
     $ sum_(i = 2)^n (i + 1) = 3 + 4 + 5 + dots.h + (n + 1) $
     Evaluating for $n = 7$ (which has $7 - 2 + 1 = 6$ terms):
     $ sum_(i = 2)^7 (i + 1) = 3 + 4 + 5 + 6 + 7 + 8 = 33 $
]

= Geometric Series and Closed-Form Summation Formulae

In algorithm analysis, rather than adding terms one by one, we aim to convert a summation $sum_(k=m)^n a_k$ into an equivalent _closed-form expression_ that can be evaluated in $O(1)$ arithmetic operations.

== The Geometric Series Theorem

#concept(title: "Theorem: Sum of a Finite Geometric Series")[
  If $a$ and $r$ are real numbers and $r != 0$, then:
  $ sum_(j = 0)^n a r^j = cases(
    (a r^(n + 1) - a) / (r - 1) = (a (r^(n + 1) - 1)) / (r - 1) = (a (1 - r^(n + 1))) / (1 - r) quad &"if" r != 1,
    (n + 1) a quad &"if" r = 1
  ) $
]

#intuition(title: "Derivation of the Geometric Series Formula (Shift-and-Subtract)")[
  Why does $sum_(j=0)^n a r^j$ simplify to $(a r^(n+1) - a) / (r - 1)$?
  - *Case $r = 1$:* Each of the $n + 1$ terms equals $a dot 1^j = a$, so the sum is $(n + 1) a$.
  - *Case $r != 1$:* Let $S_n = sum_(j=0)^n a r^j = a + a r + a r^2 + dots.h + a r^n$. Multiply both sides by $r$:
    $ r S_n &= a r + a r^2 + a r^3 + dots.h + a r^n + a r^(n + 1) \
      S_n   &= a + a r + a r^2 + dots.h + a r^(n - 1) + a r^n $
    Subtracting the second equation from the first cancels all intermediate terms (_telescoping cancellation_):
    $ (r - 1) S_n = a r^(n + 1) - a ==> S_n = (a r^(n + 1) - a) / (r - 1) $
]

#example(title: "Sum of the First 10 Terms of a Geometric Series")[
  *Problem:* Given the geometric series $2 + 6 + 18 + 54 + dots$, what is the sum of the first $10$ terms of this series?

  *Solution:*
  1. Identify the parameters:
     - First term: $a = 2$.
     - Common ratio: $r = 6 / 2 = 18 / 6 = 3$.
     - Upper index limit: Because the summation formula $sum_(j=0)^n a r^j$ starts at $j = 0$, the first $10$ terms correspond to indices $j = 0, 1, 2, dots, 9$, so *$n = 9$* (yielding $n + 1 = 10$ terms).
  2. Apply the Geometric Series Theorem:
     $ sum_(j = 0)^9 2 dot 3^j = (2 dot 3^(9 + 1) - 2) / (3 - 1) = (2 dot 3^(10) - 2) / 2 = 3^(10) - 1 = 59049 - 1 = 59048 $
]

#pitfall(title: "Off-by-One Trap in Geometric Series: Counting Terms vs. Upper Limit n")[
  In the formula $sum_(j=0)^n a r^j = (a r^(n+1) - a)/(r - 1)$, the exponent in the numerator is *$n + 1$*, which equals the *total number of terms* when the sum starts at $j = 0$.
  - If a problem asks for the _first $10$ terms_ starting at $j = 0$, the upper limit is $n = 9$, and the exponent is $n + 1 = 10$.
  - If a summation instead starts at $j = 1$, such as $sum_(j=1)^n a r^j$, the first term of the sum is $a r$ (not $a$), and there are $n$ terms, so the sum is $((a r) r^n - a r)/(r - 1) = (a r^(n+1) - a r)/(r - 1)$.
]

== Table of Useful Summation Formulae

The following closed-form identities are standard tools for simplifying finite and infinite series:

#table(
  columns: (1.6fr, 1.8fr, 2.2fr),
  align: (center, center, left),
  [Summation (Sum)], [Closed Form], [Name & Applicability],
  [$display(sum_(k = 0)^n a r^k) quad (r != 0)$], [$display((a r^(n + 1) - a) / (r - 1)), quad r != 1$], [Finite Geometric Series ($n + 1$ terms)],
  [$display(sum_(k = 1)^n k)$], [$display((n (n + 1)) / 2)$], [Sum of first $n$ positive integers (Gauss's formula)],
  [$display(sum_(k = 1)^n k^2)$], [$display((n (n + 1) (2n + 1)) / 6)$], [Sum of first $n$ perfect squares],
  [$display(sum_(k = 1)^n k^3)$], [$display((n^2 (n + 1)^2) / 4) = display(((n(n+1))/2)^2)$], [Sum of first $n$ perfect cubes (Nicomachus's identity)],
  [$display(sum_(k = 0)^infinity x^k), quad |x| < 1$], [$display(1 / (1 - x))$], [Infinite Geometric Series (converges iff $|x| < 1$)],
  [$display(sum_(k = 1)^infinity k x^(k - 1)), quad |x| < 1$], [$display(1 / (1 - x)^2)$], [Differentiated Infinite Geometric Series],
)

== Index Splitting for Non-Unit Lower Limits

When a summation starts at $k = m > 1$ instead of $k = 1$, we can apply the standard closed-form formulas from the table above by subtracting the missing prefix sum $sum_(k=1)^(m-1) a_k$:
$ sum_(k = m)^n a_k = sum_(k = 1)^n a_k - sum_(k = 1)^(m - 1) a_k $

#example(title: "Evaluating Shifted Summations")[
  *Problem:* Evaluate the following two summations:
  $ (1) quad sum_(i = 2)^(10) i #h(4em) (2) quad sum_(k = 10)^(15) k^2 $

  *Solutions:*
  1. *Evaluating $sum_(i = 2)^(10) i$:*
     Using index splitting and Gauss's formula $sum_(i=1)^n i = (n(n+1))/2$:
     $ sum_(i = 2)^(10) i = sum_(i = 1)^(10) i - sum_(i = 1)^1 i = (10 dot (10 + 1)) / 2 - 1 = 55 - 1 = 54 $
     (_Verification by arithmetic series:_ There are $10 - 2 + 1 = 9$ terms with first term $2$ and last term $10$, so $S = 9 dot (2 + 10)/2 = 9 dot 6 = 54$.)

  2. *Evaluating $sum_(k = 10)^(15) k^2$:*
     Using index splitting with $m = 10$ (so $m - 1 = 9$) and the sum-of-squares formula $sum_(k=1)^n k^2 = (n(n+1)(2n+1))/6$:
     $ sum_(k = 10)^(15) k^2 &= sum_(k = 1)^(15) k^2 - sum_(k = 1)^9 k^2 \
       &= (15 dot (15 + 1) dot (2(15) + 1)) / 6 - (9 dot (9 + 1) dot (2(9) + 1)) / 6 \
       &= (15 dot 16 dot 31) / 6 - (9 dot 10 dot 19) / 6 \
       &= 1240 - 285 = 955 $
     (_Direct term-by-term verification:_ $10^2 + 11^2 + 12^2 + 13^2 + 14^2 + 15^2 = 100 + 121 + 144 + 169 + 196 + 225 = 955$.)
]

= Worked Practice Exercises

Below are worked solutions to additional practice problems on sequences, recurrences, pattern recognition, and summations.

#example(title: "Finding Sequence Terms from Explicit and Recursive Rules")[
  *Part 1:* Find the first four terms of each of the following sequences whose $n$-th term ($n = 1, 2, 3, 4$) is given by:
  - *(a) $a_n = 2^n - n$:*
    $ a_1 = 2^1 - 1 = 1, quad a_2 = 2^2 - 2 = 2, quad a_3 = 2^3 - 3 = 5, quad a_4 = 2^4 - 4 = 12 $
  - *(b) $a_n = 3$:* (Constant sequence)
    $ a_1 = 3, quad a_2 = 3, quad a_3 = 3, quad a_4 = 3 $
  - *(c) $a_n = 7 + 4^n$:*
    $ a_1 = 7 + 4 = 11, quad a_2 = 7 + 16 = 23, quad a_3 = 7 + 64 = 71, quad a_4 = 7 + 256 = 263 $
  - *(d) $a_n = 2^n + (-2)^n$:*
    $ a_1 = 2 - 2 = 0, quad a_2 = 4 + 4 = 8, quad a_3 = 8 - 8 = 0, quad a_4 = 16 + 16 = 32 $

  *Part 2:* Find the first five terms ($n = 0, 1, 2, 3, 4$ or $n = 1, dots, 5$) of sequences defined by recurrence relations:
  - *(a) $a_n = 6 a_(n-1), quad a_0 = 2$:*
    Geometric progression with $a = 2, r = 6$:
    $ a_0 = 2, quad a_1 = 12, quad a_2 = 72, quad a_3 = 432, quad a_4 = 2592 $
  - *(b) $a_n = a_(n-1)^2, quad a_1 = 2$:*
    Each term squares the previous term ($a_n = 2^(2^(n-1))$):
    $ a_1 = 2, quad a_2 = 2^2 = 4, quad a_3 = 4^2 = 16, quad a_4 = 16^2 = 256, quad a_5 = 256^2 = 65536 $
  - *(c) $a_n = a_(n-1) + 3 a_(n-2), quad a_0 = 1, a_1 = 2$:*
    $ a_0 = 1, quad a_1 = 2, quad a_2 = 2 + 3(1) = 5, quad a_3 = 5 + 3(2) = 11, quad a_4 = 11 + 3(5) = 26 $
  - *(d) $a_n = n a_(n-1) + n^2 a_(n-2), quad a_0 = 1, a_1 = 1$:*
    - $a_0 = 1, quad a_1 = 1$
    - $a_2 = 2 a_1 + 2^2 a_0 = 2(1) + 4(1) = 6$
    - $a_3 = 3 a_2 + 3^2 a_1 = 3(6) + 9(1) = 27$
    - $a_4 = 4 a_3 + 4^2 a_2 = 4(27) + 16(6) = 108 + 96 = 204$
]

#example(title: "Constructing the First 10 Terms from Verbal Rules")[
  *Problem:* List the first $10$ terms of each of these sequences:
  - *(a) Begins with $2$ and each successive term is $3$ more than the preceding term:*
    Arithmetic progression ($a = 2, d = 3$): *$2, 5, 8, 11, 14, 17, 20, 23, 26, 29$*.
  - *(b) Lists each positive integer three times, in increasing order:*
    *$1, 1, 1, 2, 2, 2, 3, 3, 3, 4$*.
  - *(c) Lists the odd positive integers in increasing order, listing each odd integer twice:*
    *$1, 1, 3, 3, 5, 5, 7, 7, 9, 9$*.
  - *(d) Whose $n$-th term is $n! - 2^n$ (for $n = 1, 2, dots, 10$):*
    - $n = 1$: $1 - 2 = -1$
    - $n = 2$: $2 - 4 = -2$
    - $n = 3$: $6 - 8 = -2$
    - $n = 4$: $24 - 16 = 8$
    - $n = 5$: $120 - 32 = 88$
    - $n = 6$: $720 - 64 = 656$
    - $n = 7$: $5040 - 128 = 4912$
    - $n = 8$: $40320 - 256 = 40064$
    - $n = 9$: $362880 - 512 = 362368$
    - $n = 10$: $3628800 - 1024 = 3627776$
  - *(e) Begins with $3$, where each succeeding term is twice the preceding term:*
    Geometric progression ($a = 3, r = 2$): *$3, 6, 12, 24, 48, 96, 192, 384, 768, 1536$*.
  - *(f) First term is $2$, second term is $4$, and each succeeding term is the sum of the two preceding terms:*
    Fibonacci-like recurrence ($a_n = a_(n-1) + a_(n-2)$): *$2, 4, 6, 10, 16, 26, 42, 68, 110, 178$*.
  - *(g) Whose $n$-th term is the number of bits in the binary expansion of positive integer $n$ ($floor(log_2 n) + 1$):*
    For $n = 1; 2, 3; 4, 5, 6, 7; 8, 9, 10$: *$1, 2, 2, 3, 3, 3, 3, 4, 4, 4$*.
  - *(h) Where the $n$-th term is the number of letters in the English word for the index $n$:*
    For _one (3), two (3), three (5), four (4), five (4), six (3), seven (5), eight (5), nine (4), ten (3)_:
    *$3, 3, 5, 4, 4, 3, 5, 5, 4, 3$*.
]

#example(title: "Finding Explicit Formulas for Sequence Patterns")[
  *Problem:* For each of these lists of integers, provide a simple formula or rule that generates the terms of an integer sequence that begins with the given list ($n = 1, 2, 3, dots$):
  - *(a) $3, 6, 11, 18, 27, 38, 51, 66, 83, 102, dots$*
    The first differences are $3, 5, 7, 9, 11, dots$ (consecutive odd numbers), or comparing directly with $n^2 = 1, 4, 9, 16, 25, dots$, each term is $2$ more than $n^2$.
    *Formula:* $a_n = n^2 + 2$ (for $n >= 1$).

  - *(b) $7, 11, 15, 19, 23, 27, 31, 35, 39, 43, dots$*
    Constant difference $d = 4$ with initial term $a_1 = 7$.
    *Formula:* $a_n = 7 + 4(n - 1) = 4n + 3$ (for $n >= 1$).

  - *(c) $1, 10, 11, 100, 101, 110, 111, 1000, 1001, 1010, 1011, dots$*
    Each term is the _binary (base-2) representation_ of the positive integer $n$ ($1_2 = 1, 2_2 = 10, 3_2 = 11, 4_2 = 100, dots$).

  - *(d) $1, 2, 2, 2, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, dots$*
    The integer $1$ appears $1$ time, $2$ appears $3$ times, $3$ appears $5$ times, $5$ appears $7$ times: the $k$-th Fibonacci number (starting from $f_2 = 1, f_3 = 2, f_4 = 3, f_5 = 5, dots$) is repeated $(2k - 1)$ times.
]

#example(title: "Evaluating Summations and Closed Forms")[
  *Part 1:* Find the value of each of these sums:
  - *(a) $sum_(k = 1)^5 (k + 1)$:*
    $ sum_(k = 1)^5 (k + 1) = 2 + 3 + 4 + 5 + 6 = 20 $
  - *(b) $sum_(j = 0)^4 (-2)^j$:*
    Geometric series with $a = 1, r = -2, n = 4$:
    $ sum_(j = 0)^4 (-2)^j = ((-2)^5 - 1) / (-2 - 1) = (-32 - 1) / (-3) = (-33) / (-3) = 11 $
  - *(c) $sum_(i = 1)^(10) 3$:*
    Sum of $10$ identical copies of $3$: $10 times 3 = 30$.
  - *(d) $sum_(j = 0)^8 (2^(j + 1) - 2^j)$:*
    This is a _telescoping sum_. Since $2^(j+1) - 2^j = 2^j$, or by telescoping cancellation $(2^1 - 2^0) + (2^2 - 2^1) + dots.h + (2^9 - 2^8)$:
    $ sum_(j = 0)^8 (2^(j + 1) - 2^j) = 2^9 - 2^0 = 512 - 1 = 511 $

  *Part 2:* Find the value of each of these sums of terms of a geometric progression:
  - *(a) $sum_(j = 0)^8 3 dot 2^j$:*
    With $a = 3, r = 2, n = 8$:
    $ sum_(j = 0)^8 3 dot 2^j = (3 dot 2^9 - 3) / (2 - 1) = 3(512 - 1) = 3 dot 511 = 1533 $
  - *(b) $sum_(j = 1)^8 2^j$:*
    Subtract the $j = 0$ term ($2^0 = 1$) from $sum_(j=0)^8 2^j = 2^9 - 1 = 511$:
    $ sum_(j = 1)^8 2^j = 511 - 1 = 510 $
  - *(c) $sum_(j = 2)^8 (-3)^j$:*
    First term at $j = 2$ is $a = (-3)^2 = 9$, common ratio $r = -3$, and there are $8 - 2 + 1 = 7$ terms:
    $ sum_(j = 2)^8 (-3)^j = (9 ((-3)^7 - 1)) / (-3 - 1) = (9 (-2187 - 1)) / (-4) = (9 (-2188)) / (-4) = 9 dot 547 = 4923 $
  - *(d) $sum_(j = 0)^8 2 dot (-3)^j$:*
    With $a = 2, r = -3, n = 8$:
    $ sum_(j = 0)^8 2 dot (-3)^j = (2 ((-3)^9 - 1)) / (-3 - 1) = (2 (-19683 - 1)) / (-4) = (-19684) / (-2) = 9842 $

  *Part 3:* Find a closed-form value for shifted power sums:
  - *(a) Evaluate $sum_(k = 50)^(100) k^2$:*
    Using index splitting ($m = 50 ==> m - 1 = 49$) and $sum_(k=1)^n k^2 = (n(n+1)(2n+1))/6$:
    $ sum_(k = 50)^(100) k^2 &= sum_(k = 1)^(100) k^2 - sum_(k = 1)^(49) k^2 \
      &= (100 dot 101 dot 201) / 6 - (49 dot 50 dot 99) / 6 \
      &= 338350 - 40425 = 297925 $
  - *(b) Evaluate $sum_(k = 99)^(200) k^3$:*
    Using index splitting ($m = 99 ==> m - 1 = 98$) and $sum_(k=1)^n k^3 = (n^2(n+1)^2)/4$:
    $ sum_(k = 99)^(200) k^3 &= sum_(k = 1)^(200) k^3 - sum_(k = 1)^(98) k^3 \
      &= ((200 dot 201) / 2)^2 - ((98 dot 99) / 2)^2 \
      &= (20100)^2 - (4851)^2 = 404010000 - 23532201 = 380477799 $
]
