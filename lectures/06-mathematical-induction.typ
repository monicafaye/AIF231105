#import "/templates/course-note.typ": *

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 6,
  title: "Mathematical Induction",
  subtitle: "Well-Ordering, Weak & Strong Induction, Summation Identities, Divisibility, and Combinatorial Proofs",
)

= The Concept of Mathematical Induction

In discrete mathematics and computer science, we often want to prove statements that claim something is true for every integer starting from some baseline—most commonly for all positive integers $ZZ^+ = {1, 2, 3, dots}$ or all non-negative integers $NN = {0, 1, 2, dots}$. Testing individual values like $n = 1, 2, 3, dots$ can help us spot patterns, but it can never prove a universal statement $forall n >= n_0, P(n)$, because no finite number of test cases can cover an infinite domain.

*Mathematical induction* is a proof technique designed specifically for propositions that depend on integers. Instead of checking infinitely many cases one by one, mathematical induction shows that truth carries forward automatically from one integer to the next, starting from an initial base case.

#definition("Mathematical Induction")[
  *Mathematical induction* is a formal method of proof used to establish that a proposition (predicate) $P(n)$ holds for all integers $n$ greater than or equal to a fixed starting integer $n_0$ (typically $n_0 = 1$ or $n_0 = 0$).

  Two classic examples of integer-indexed propositions that can be proved by induction are:
  1. *Divisibility Proposition*: For all integers $n >= 1$, the expression $n^3 + 2n$ is a multiple of $3$, written $3 | (n^3 + 2n)$.
  2. *Combinatorial / Set Cardinality Proposition*: The number of subsets formed from a finite set containing $n$ elements is $2^n$; that is, if $|S| = n$, then $|cal(P)(S)| = 2^n$.
]

== Deductive vs. Inductive Reasoning in Mathematics

Despite the shared name, *mathematical induction* is fundamentally different from the *inductive reasoning* used in the empirical sciences:
- In empirical science, _inductive reasoning_ generalizes a likely hypothesis from finite observations, which could later be overturned by a new counterexample.
- In mathematics, _mathematical induction_ is a *deductive proof technique* whose conclusion holds with complete certainty. Once the base case and the step-by-step transition are established, there is no possibility of a counterexample at any finite integer $n$.

#intuition(title: "Climbing an Infinite Ladder")[
  A helpful way to picture mathematical induction is the classic metaphor of *climbing an infinite ladder* whose rungs are numbered $1, 2, 3, dots, k, k+1, dots$ stretching upward without end. How can we be sure a climber can reach *every* rung on the ladder?

  We only need to verify two things:
  1. *First Rung Reachability (Base Step)*: We can reach rung $1$ ($P(1)$ is true).
  2. *Rung-to-Rung Transition (Inductive Step)*: Whenever we can reach rung $k$, we can also reach the next rung $k + 1$ ($forall k >= 1, P(k) ==> P(k+1)$).

  Once both rules hold, a chain reaction guarantees that every positive integer rung is reachable:
  - Since we can reach rung $1$ ($P(1)$), and reaching rung $1$ lets us reach rung $2$ ($P(1) ==> P(2)$), we can reach rung $2$ ($P(2)$).
  - Since we can reach rung $2$ ($P(2)$), and reaching rung $2$ lets us reach rung $3$ ($P(2) ==> P(3)$), we can reach rung $3$ ($P(3)$).
  - Repeating this transition $n - 1$ times guarantees that we reach any rung $n in ZZ^+$ in a finite number of steps.
]

#flow-chain(
  caption: "Domino / Infinite Ladder Chain Reaction: How truth propagates from P(1) to any integer n via Modus Ponens.",
  ("Base Case", [$P(1)$ is True]),
  ("Step 1 → 2", [$P(1) arrow.r P(2)$ \ gives $P(2)$]),
  ("Step 2 → 3", [$P(2) arrow.r P(3)$ \ gives $P(3)$]),
  ("Step k → k+1", [$P(k) arrow.r P(k+1)$ \ gives $P(k+1)$]),
  ("Universal Truth", [$forall n in ZZ^+, P(n)$]),
)

== Theoretical Foundation: The Well-Ordering Principle

Why does mathematical induction work as a valid rule of inference? Its soundness comes from a foundational property of the integers called the *Well-Ordering Principle*.

#concept(title: "Equivalence to the Well-Ordering Principle")[
  The *Well-Ordering Principle* states that every non-empty subset of non-negative integers (or positive integers) has a *least element*.

  We can see why mathematical induction follows from the Well-Ordering Principle by arguing by contradiction:
  1. Suppose that $P(1)$ is true and $forall k >= 1, (P(k) ==> P(k+1))$ is true, yet $P(n)$ fails for at least one positive integer.
  2. Let $S = {n in ZZ^+ | P(n) "is false"}$ be the set of all counterexamples. By our assumption, $S != emptyset$.
  3. By the Well-Ordering Principle, $S$ must have a smallest element $m in S$.
  4. Since $P(1)$ is true, $1 in.not S$, which means $m > 1$. Thus, $m - 1$ is a positive integer strictly smaller than $m$.
  5. Because $m$ is the *smallest* element in $S$, $m - 1$ cannot be in $S$, meaning $P(m - 1)$ must be *true*.
  6. Applying the inductive implication $P(k) ==> P(k+1)$ at $k = m - 1$ forces $P(m)$ to be *true*, which contradicts $m in S$. Therefore, $S$ must be empty, and $P(n)$ holds for all $n in ZZ^+$.
]

= Principle of Simple Mathematical Induction

The standard form of mathematical induction is often called *simple induction* (or *weak induction*).

#definition("Principle of Simple Induction")[
  Let $P(n)$ be a proposition about positive integers $n in ZZ^+$. To prove that $P(n)$ is true for all positive integers $n >= 1$, we complete three steps:
  1. *Basis Step*: Show that $P(1)$ is true.
  2. *Inductive Hypothesis*: Assume that $P(n)$ is true for an arbitrary positive integer $n >= 1$. _(Some authors write $P(k)$ for the hypothesis and $P(k+1)$ for the next step to distinguish the specific integer $k$ from the general variable $n$; both conventions mean the exact same thing.)_
  3. *Inductive Step*: Using the assumption that $P(n)$ holds, show that $P(n + 1)$ must also be true.

  Expressed in predicate logic, the principle of simple induction states:
  $ (P(1) and forall n in ZZ^+ (P(n) ==> P(n + 1))) ==> forall n in ZZ^+ P(n) $
]

#algo-box(
  title: "Blueprint for a Proof by Simple Induction",
  input: [A universal claim $forall n >= n_0, P(n)$ over integers $n$],
  output: [A complete proof of $forall n >= n_0, P(n)$],
  complexity: "3 Logical Steps",
)[
  1. *Define the Proposition $P(n)$*: State clearly what $P(n)$ claims for an integer $n$, along with its starting integer $n >= n_0$.
  2. *Verify the Base Case $P(n_0)$*:
     - Plug $n = n_0$ into the Left-Hand Side (LHS) and Right-Hand Side (RHS) separately (or check the property directly).
     - Confirm that $"LHS" = "RHS"$ (or that the condition holds), establishing $P(n_0)$.
  3. *State the Inductive Hypothesis (IH)*:
     - Write: _"Assume that $P(n)$ holds for some arbitrary integer $n >= n_0$."_
     - Write out the explicit equation or statement assumed for $n$.
  4. *Carry Out the Inductive Step ($P(n) ==> P(n+1)$)*:
     - State the target: _"We want to show that $P(n+1)$ holds, namely [write target formula for $n+1$]."_
     - Start with one side of $P(n+1)$ (usually the LHS), group the part that matches $P(n)$, *substitute the Inductive Hypothesis*, and simplify algebraically until you reach the RHS of $P(n+1)$.
  5. *Conclude*:
     - State that by mathematical induction, $P(n)$ holds for all integers $n >= n_0$.
]

#pitfall(title: "Why Assuming P(n) Is Not Circular Reasoning")[
  At first glance, Step 2 ("Assume $P(n)$ is true") can feel like circular reasoning, since $P(n)$ is the very statement we want to prove!
  - *Why it is valid*: In the inductive step, we are *not* assuming that $P(n)$ is already true for every integer. Instead, we are proving the *conditional statement* $P(n) ==> P(n + 1)$ for a fixed, arbitrary integer $n$.
  - To prove any conditional statement $A ==> B$ directly, we assume $A$ ($P(n)$) and deduce $B$ ($P(n + 1)$). Combined with the base case $P(1)$, this implication powers the chain of steps without any circularity.
]

= Fundamental Worked Examples

Let us work through several core proofs—covering arithmetic sums, odd-integer sums, divisibility, and power-set size—while highlighting algebraic habits that keep inductive proofs clean.

== Sum of the First $n$ Positive Integers

#example(title: "Gauss's Arithmetic Sum Formula")[
  *Proposition*: Show that for all integers $n >= 1$,
  $ 1 + 2 + 3 + dots + n = frac(n(n + 1), 2) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(i=1)^n i = 1 + 2 + 3 + dots + n = frac(n(n + 1), 2)$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$, the left-hand side is simply $1$, and the right-hand side evaluates to:
     $ frac(1(1 + 1), 2) = frac(1 dot 2, 2) = 1 $
     Since $"LHS" = 1 = "RHS"$, the base case $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for some arbitrary positive integer $n >= 1$:
     $ 1 + 2 + 3 + dots + n = frac(n(n + 1), 2) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We need to show that $P(n + 1)$ holds, namely:
     $ 1 + 2 + 3 + dots + n + (n + 1) = frac((n + 1)((n + 1) + 1), 2) = frac((n + 1)(n + 2), 2) $
     Starting from the left-hand side of $P(n + 1)$ and grouping the first $n$ terms:
     $ 1 + 2 + dots + n + (n + 1) &= underbrace((1 + 2 + dots + n), "apply IH") + (n + 1) \
     &= frac(n(n + 1), 2) + (n + 1) \
     &= frac(n(n + 1) + 2(n + 1), 2) \
     &= frac(n^2 + n + 2n + 2, 2) \
     &= frac(n^2 + 3n + 2, 2) \
     &= frac((n + 1)(n + 2), 2) \
     &= frac((n + 1)((n + 1) + 1), 2) $
     This matches the right-hand side of $P(n + 1)$. Thus, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, $1 + 2 + 3 + dots + n = frac(n(n + 1), 2)$ for all integers $n >= 1$. $square$
]

#intuition(title: "Algebraic Tip: Factor Early Instead of Expanding")[
  In the calculation above, we expanded $n(n + 1) + 2(n + 1)$ into $n^2 + 3n + 2$ and then factored it back into $(n + 1)(n + 2)$. While expanding works fine for a quadratic, doing that on degree-$3$ or degree-$4$ polynomials makes the algebra much harder than it needs to be.

  A much cleaner habit is to *factor out common terms immediately*:
  $ frac(n(n + 1) + 2(n + 1), 2) = frac((n + 1)(n + 2), 2) $
  By factoring out $(n + 1)$ right away, we reach the target expression in a single step without expanding and re-factoring.
]

== Sum of the First $n$ Positive Odd Integers

#example(title: "Sum of the First n Positive Odd Integers")[
  *Proposition*: Show that the sum of the first $n$ positive odd integers is $n^2$.

  *Proof by Mathematical Induction*:
  Notice that the $k$-th positive odd integer is $2k - 1$ (giving $1$ for $k = 1$, $3$ for $k = 2$, $5$ for $k = 3$, and $2n - 1$ for $k = n$). Let $P(n)$ be the proposition that for $n >= 1$:
  $ 1 + 3 + 5 + dots + (2n - 1) = n^2 $

  1. *Basis Step ($P(1)$)*:
     For $n = 1$, the left-hand side is $2(1) - 1 = 1$, and the right-hand side is $1^2 = 1$. Since $1 = 1$, $P(1)$ is true.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ is true for an arbitrary positive integer $n >= 1$:
     $ 1 + 3 + 5 + dots + (2n - 1) = n^2 quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ is true. The $(n + 1)$-st odd positive integer is $2(n + 1) - 1 = 2n + 1$, so the target equation for $P(n + 1)$ is:
     $ 1 + 3 + 5 + dots + (2n - 1) + (2n + 1) = (n + 1)^2 $
     Grouping the first $n$ odd integers on the left-hand side and applying the Inductive Hypothesis:
     $ 1 + 3 + 5 + dots + (2n - 1) + (2n + 1) &= underbrace((1 + 3 + 5 + dots + (2n - 1)), "apply IH") + (2n + 1) \
     &= n^2 + 2n + 1 \
     &= (n + 1)^2 $
     Thus, $P(n + 1)$ is true whenever $P(n)$ is true.

  *Conclusion*: By mathematical induction, the sum of the first $n$ positive odd integers is $n^2$ for all $n >= 1$. $square$
]

== Divisibility and Set Cardinality Proofs

Mathematical induction is equally effective outside summation formulas. Let us prove the two motivating propositions introduced in Section 1.

#example(title: "Divisibility by 3: n³ + 2n is a Multiple of 3")[
  *Proposition*: For all integers $n >= 1$, $n^3 + 2n$ is a multiple of $3$.

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the statement "$3 | (n^3 + 2n)$", meaning there exists an integer $k in ZZ$ such that $n^3 + 2n = 3k$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$, we have:
     $ 1^3 + 2(1) = 1 + 2 = 3 = 3 dot 1 $
     which is a multiple of $3$. Thus, $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume $P(n)$ holds for some arbitrary integer $n >= 1$. That is, assume there exists an integer $k in ZZ$ such that:
     $ n^3 + 2n = 3k quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We must show that $(n + 1)^3 + 2(n + 1)$ is also a multiple of $3$. Expanding the expression and regrouping terms so that $(n^3 + 2n)$ appears explicitly:
     $ (n + 1)^3 + 2(n + 1) &= (n^3 + 3n^2 + 3n + 1) + (2n + 2) \
     &= underbrace((n^3 + 2n), "apply IH") + 3n^2 + 3n + 3 \
     &= 3k + 3(n^2 + n + 1) \
     &= 3(k + n^2 + n + 1) $
     Because $k$ and $n$ are integers, $m = k + n^2 + n + 1$ is also an integer, so $(n + 1)^3 + 2(n + 1) = 3m$ is a multiple of $3$. Therefore, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, $n^3 + 2n$ is a multiple of $3$ for all integers $n >= 1$. $square$
]

#example(title: "Power Set Cardinality: A Set of n Elements Has 2ⁿ Subsets")[
  *Proposition*: For every integer $n >= 0$, a finite set containing $n$ elements has exactly $2^n$ subsets.

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the statement: "Every finite set $S$ with $|S| = n$ elements has $2^n$ subsets."

  1. *Basis Step ($P(0)$)*:
     For $n = 0$, the only set with $0$ elements is the empty set $S = emptyset$. Its only subset is $emptyset$ itself, giving $1 = 2^0$ subset. (If starting at $n = 1$, a singleton set $S = {x_1}$ has two subsets, $emptyset$ and ${x_1}$, which is $2 = 2^1$.) Thus, the base case holds.

  2. *Inductive Hypothesis*:
     Assume $P(n)$ holds for some arbitrary non-negative integer $n >= 0$: any set of $n$ elements has $2^n$ subsets.

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     Let $T$ be an arbitrary set with $n + 1$ elements, say $T = {a_1, a_2, dots, a_n, a_(n+1)}$. Remove the last element to form $S = {a_1, a_2, dots, a_n} = T without {a_(n+1)}$, which has $|S| = n$ elements.
     Every subset $A subset.eq T$ belongs to one of two disjoint categories:
     - *Category 1 ($a_(n+1) in.not A$)*: $A$ is a subset of $S$ alone. By the Inductive Hypothesis applied to $S$, there are $2^n$ such subsets.
     - *Category 2 ($a_(n+1) in A$)*: $A$ is formed by taking a subset $B subset.eq S$ and including $a_(n+1)$, so $A = B union {a_(n+1)}$. Because each of the $2^n$ subsets $B subset.eq S$ produces a distinct subset $B union {a_(n+1)}$ of $T$, there are $2^n$ subsets in Category 2 as well.
     Adding the two disjoint categories together gives the total number of subsets of $T$:
     $ |"Subsets of" T| = 2^n + 2^n = 2 dot 2^n = 2^(n+1) $
     Thus, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, any set with $n$ elements has $2^n$ subsets for all $n >= 0$. $square$
]

= Worked Practice Problems

To build fluency with different series patterns—including sums of squares, factorials, geometric progressions, alternating series, and products of consecutive integers—we work through seven classic practice problems below.

== Sums of Squares, Factorials, and Geometric Series

#example(title: "Problem 1: Sum of Squares of Odd Integers")[
  *Problem Statement*: Prove that whenever $n$ is a non-negative integer ($n >= 0$),
  $ 1^2 + 3^2 + 5^2 + dots + (2n + 1)^2 = frac((n + 1)(2n + 1)(2n + 3), 3) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=0)^n (2k + 1)^2 = frac((n + 1)(2n + 1)(2n + 3), 3)$ for $n >= 0$.

  1. *Basis Step ($P(0)$)*:
     Since the statement applies to all non-negative integers ($n >= 0$), our base case is $n = 0$:
     - $"LHS" = (2(0) + 1)^2 = 1^2 = 1$.
     - $"RHS" = frac((0 + 1)(2(0) + 1)(2(0) + 3), 3) = frac(1 dot 1 dot 3, 3) = 1$.
     Since $"LHS" = "RHS" = 1$, $P(0)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary integer $n >= 0$:
     $ 1^2 + 3^2 + 5^2 + dots + (2n + 1)^2 = frac((n + 1)(2n + 1)(2n + 3), 3) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We must show that $P(n + 1)$ holds. Replacing $n$ with $n + 1$, the next term on the LHS is $(2(n + 1) + 1)^2 = (2n + 3)^2$, and the target RHS is:
     $ frac(((n + 1) + 1)(2(n + 1) + 1)(2(n + 1) + 3), 3) = frac((n + 2)(2n + 3)(2n + 5), 3) $
     Starting from the LHS of $P(n + 1)$ and applying the Inductive Hypothesis:
     $ 1^2 + 3^2 + dots + (2n + 1)^2 + (2n + 3)^2 &= frac((n + 1)(2n + 1)(2n + 3), 3) + (2n + 3)^2 \
     &= frac((n + 1)(2n + 1)(2n + 3) + 3(2n + 3)^2, 3) $
     Factoring out the common term $(2n + 3)$ in the numerator:
     $ &= frac((2n + 3) [ (n + 1)(2n + 1) + 3(2n + 3) ], 3) \
     &= frac((2n + 3) [ (2n^2 + 3n + 1) + (6n + 9) ], 3) \
     &= frac((2n + 3) (2n^2 + 9n + 10), 3) $
     Factoring the quadratic $2n^2 + 9n + 10 = (n + 2)(2n + 5)$ yields:
     $ &= frac((n + 2)(2n + 3)(2n + 5), 3) $
     which equals the target RHS of $P(n + 1)$.

  *Conclusion*: By mathematical induction, the identity holds for all non-negative integers $n >= 0$. $square$
]

#example(title: "Problem 2: Factorial Series Identity")[
  *Problem Statement*: Prove that whenever $n$ is a positive integer ($n >= 1$),
  $ 1 dot 1! + 2 dot 2! + dots + n dot n! = (n + 1)! - 1 $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=1)^n k dot k! = (n + 1)! - 1$ for $n >= 1$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$:
     - $"LHS" = 1 dot 1! = 1 dot 1 = 1$.
     - $"RHS" = (1 + 1)! - 1 = 2! - 1 = 2 - 1 = 1$.
     Since $"LHS" = "RHS" = 1$, $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary integer $n >= 1$:
     $ 1 dot 1! + 2 dot 2! + dots + n dot n! = (n + 1)! - 1 quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 1 dot 1! + 2 dot 2! + dots + n dot n! + (n + 1)(n + 1)! = (n + 2)! - 1 $
     Starting from the LHS of $P(n + 1)$ and substituting the Inductive Hypothesis:
     $ underbrace((1 dot 1! + 2 dot 2! + dots + n dot n!), "apply IH") + (n + 1)(n + 1)! &= ((n + 1)! - 1) + (n + 1)(n + 1)! \
     &= (n + 1)! dot [ 1 + (n + 1) ] - 1 \
     &= (n + 1)! dot (n + 2) - 1 \
     &= (n + 2)! - 1 $
     where the last step uses the factorial recurrence $(n + 2)! = (n + 2) dot (n + 1)!$. This matches the RHS of $P(n + 1)$.

  *Conclusion*: By mathematical induction, $sum_(k=1)^n k dot k! = (n + 1)! - 1$ for all positive integers $n >= 1$. $square$
]

#example(title: "Problem 3: Geometric Series with Ratio 5")[
  *Problem Statement*: Prove that whenever $n$ is a non-negative integer ($n >= 0$),
  $ 3 + 3 dot 5 + 3 dot 5^2 + dots + 3 dot 5^n = frac(3(5^(n+1) - 1), 4) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=0)^n 3 dot 5^k = frac(3(5^(n+1) - 1), 4)$ for $n >= 0$.

  1. *Basis Step ($P(0)$)*:
     For $n = 0$:
     - $"LHS" = 3 dot 5^0 = 3 dot 1 = 3$.
     - $"RHS" = frac(3(5^(0+1) - 1), 4) = frac(3(5 - 1), 4) = frac(3 dot 4, 4) = 3$.
     Since $"LHS" = "RHS" = 3$, $P(0)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary integer $n >= 0$:
     $ 3 + 3 dot 5 + 3 dot 5^2 + dots + 3 dot 5^n = frac(3(5^(n+1) - 1), 4) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 3 + 3 dot 5 + dots + 3 dot 5^n + 3 dot 5^(n+1) = frac(3(5^(n+2) - 1), 4) $
     Starting from the LHS of $P(n + 1)$ and applying the Inductive Hypothesis:
     $ (3 + 3 dot 5 + dots + 3 dot 5^n) + 3 dot 5^(n+1) &= frac(3(5^(n+1) - 1), 4) + 3 dot 5^(n+1) \
     &= frac(3 dot 5^(n+1) - 3 + 4 dot 3 dot 5^(n+1), 4) \
     &= frac(3 dot 5^(n+1) (1 + 4) - 3, 4) \
     &= frac(3 dot 5^(n+1) dot 5 - 3, 4) \
     &= frac(3 dot 5^(n+2) - 3, 4) \
     &= frac(3(5^(n+2) - 1), 4) $
     Thus, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, the formula holds for all non-negative integers $n >= 0$. $square$
]

#example(title: "Problem 4: Alternating Geometric Series with Ratio -7")[
  *Problem Statement*: Prove that whenever $n$ is a non-negative integer ($n >= 0$),
  $ 2 - 2 dot 7 + 2 dot 7^2 - dots + 2(-7)^n = frac(1 - (-7)^(n+1), 4) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=0)^n 2(-7)^k = frac(1 - (-7)^(n+1), 4)$ for $n >= 0$.

  1. *Basis Step ($P(0)$)*:
     For $n = 0$:
     - $"LHS" = 2(-7)^0 = 2(1) = 2$.
     - $"RHS" = frac(1 - (-7)^(0+1), 4) = frac(1 - (-7), 4) = frac(8, 4) = 2$.
     Since $"LHS" = "RHS" = 2$, $P(0)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary integer $n >= 0$:
     $ 2 - 2 dot 7 + 2 dot 7^2 - dots + 2(-7)^n = frac(1 - (-7)^(n+1), 4) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 2 - 2 dot 7 + dots + 2(-7)^n + 2(-7)^(n+1) = frac(1 - (-7)^(n+2), 4) $
     Starting from the LHS of $P(n + 1)$ and substituting the Inductive Hypothesis:
     $ (2 - 2 dot 7 + dots + 2(-7)^n) + 2(-7)^(n+1) &= frac(1 - (-7)^(n+1), 4) + 2(-7)^(n+1) \
     &= frac(1 - (-7)^(n+1) + 8(-7)^(n+1), 4) \
     &= frac(1 + 7(-7)^(n+1), 4) \
     &= frac(1 - (-7)(-7)^(n+1), 4) \
     &= frac(1 - (-7)^(n+2), 4) $
     Notice how $+ 7(-7)^(n+1)$ rewrites cleanly as $-(-7)(-7)^(n+1) = -(-7)^(n+2)$, matching the RHS of $P(n + 1)$.

  *Conclusion*: By mathematical induction, the identity holds for all non-negative integers $n >= 0$. $square$
]

== Alternating Squares and Consecutive Factor Products

#example(title: "Problem 5: Alternating Sum of Squares")[
  *Problem Statement*: Prove that whenever $n$ is a positive integer ($n >= 1$),
  $ 1^2 - 2^2 + 3^2 - dots + (-1)^(n-1) n^2 = (-1)^(n-1) frac(n(n + 1), 2) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=1)^n (-1)^(k-1) k^2 = (-1)^(n-1) frac(n(n + 1), 2)$ for $n >= 1$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$:
     - $"LHS" = (-1)^(1-1) 1^2 = (-1)^0 dot 1 = 1$.
     - $"RHS" = (-1)^(1-1) frac(1(1 + 1), 2) = 1 dot frac(2, 2) = 1$.
     Since $"LHS" = "RHS" = 1$, $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary positive integer $n >= 1$:
     $ 1^2 - 2^2 + 3^2 - dots + (-1)^(n-1) n^2 = (-1)^(n-1) frac(n(n + 1), 2) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 1^2 - 2^2 + dots + (-1)^(n-1) n^2 + (-1)^n (n + 1)^2 = (-1)^n frac((n + 1)(n + 2), 2) $
     Starting from the LHS of $P(n + 1)$ and substituting the Inductive Hypothesis:
     $ underbrace((1^2 - 2^2 + dots + (-1)^(n-1) n^2), "apply IH") + (-1)^n (n + 1)^2 &= (-1)^(n-1) frac(n(n + 1), 2) + (-1)^n (n + 1)^2 $
     Using $(-1)^(n-1) = -(-1)^n$ and factoring out $(-1)^n (n + 1)$ from both terms:
     $ &= -(-1)^n frac(n(n + 1), 2) + (-1)^n frac(2(n + 1)^2, 2) \
     &= (-1)^n frac((n + 1) [ -n + 2(n + 1) ], 2) \
     &= (-1)^n frac((n + 1)(n + 2), 2) $
     which matches the target RHS of $P(n + 1)$.

  *Conclusion*: By mathematical induction, the identity holds for all positive integers $n >= 1$. $square$
]

#example(title: "Problem 6: Sum of Consecutive Pair Products")[
  *Problem Statement*: Prove that for every positive integer $n >= 1$,
  $ 1 dot 2 + 2 dot 3 + dots + n(n + 1) = frac(n(n + 1)(n + 2), 3) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=1)^n k(k + 1) = frac(n(n + 1)(n + 2), 3)$ for $n >= 1$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$:
     - $"LHS" = 1(1 + 1) = 1 dot 2 = 2$.
     - $"RHS" = frac(1(1 + 1)(1 + 2), 3) = frac(1 dot 2 dot 3, 3) = 2$.
     Since $"LHS" = "RHS" = 2$, $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary positive integer $n >= 1$:
     $ 1 dot 2 + 2 dot 3 + dots + n(n + 1) = frac(n(n + 1)(n + 2), 3) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 1 dot 2 + 2 dot 3 + dots + n(n + 1) + (n + 1)(n + 2) = frac((n + 1)(n + 2)(n + 3), 3) $
     Starting from the LHS of $P(n + 1)$ and applying the Inductive Hypothesis:
     $ underbrace((1 dot 2 + 2 dot 3 + dots + n(n + 1)), "apply IH") + (n + 1)(n + 2) &= frac(n(n + 1)(n + 2), 3) + (n + 1)(n + 2) \
     &= frac(n(n + 1)(n + 2) + 3(n + 1)(n + 2), 3) \
     &= frac((n + 1)(n + 2)(n + 3), 3) $
     by factoring out $(n + 1)(n + 2)$. Thus, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, the identity holds for all positive integers $n >= 1$. $square$
]

#example(title: "Problem 7: Sum of Consecutive Triple Products")[
  *Problem Statement*: Prove that for every positive integer $n >= 1$,
  $ 1 dot 2 dot 3 + 2 dot 3 dot 4 + dots + n(n + 1)(n + 2) = frac(n(n + 1)(n + 2)(n + 3), 4) $

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the proposition that $sum_(k=1)^n k(k + 1)(k + 2) = frac(n(n + 1)(n + 2)(n + 3), 4)$ for $n >= 1$.

  1. *Basis Step ($P(1)$)*:
     For $n = 1$:
     - $"LHS" = 1 dot 2 dot 3 = 6$.
     - $"RHS" = frac(1(1 + 1)(1 + 2)(1 + 3), 4) = frac(1 dot 2 dot 3 dot 4, 4) = 6$.
     Since $"LHS" = "RHS" = 6$, $P(1)$ holds.

  2. *Inductive Hypothesis*:
     Assume that $P(n)$ holds for an arbitrary positive integer $n >= 1$:
     $ 1 dot 2 dot 3 + 2 dot 3 dot 4 + dots + n(n + 1)(n + 2) = frac(n(n + 1)(n + 2)(n + 3), 4) quad "(IH)" $

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $P(n + 1)$ holds:
     $ 1 dot 2 dot 3 + dots + n(n + 1)(n + 2) + (n + 1)(n + 2)(n + 3) = frac((n + 1)(n + 2)(n + 3)(n + 4), 4) $
     Starting from the LHS of $P(n + 1)$ and substituting the Inductive Hypothesis:
     $ &underbrace((1 dot 2 dot 3 + dots + n(n + 1)(n + 2)), "apply IH") + (n + 1)(n + 2)(n + 3) \
     &= frac(n(n + 1)(n + 2)(n + 3), 4) + (n + 1)(n + 2)(n + 3) \
     &= frac(n(n + 1)(n + 2)(n + 3) + 4(n + 1)(n + 2)(n + 3), 4) \
     &= frac((n + 1)(n + 2)(n + 3)(n + 4), 4) $
     by factoring out the common product $(n + 1)(n + 2)(n + 3)$. Thus, $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, the identity holds for all positive integers $n >= 1$. $square$
]

= Inequalities, Strong Induction, and Common Pitfalls

Beyond summation identities, induction is a workhorse for proving *inequalities*, analyzing *recurrence relations*, and establishing *number-theoretic properties*.

== Induction with Shifted Base Cases ($n >= n_0$) and Inequalities

Not every true integer proposition starts at $n = 1$ or $n = 0$. Some properties fail for the first few integers and only become true starting from a threshold $n_0 > 1$. When that happens:
- The *Basis Step* verifies $P(n_0)$.
- The *Inductive Step* proves $forall n >= n_0, (P(n) ==> P(n + 1))$.

#example(title: "Induction on Inequalities with Shifted Base Case: 2ⁿ < n! for n ≥ 4")[
  *Proposition*: Prove that $2^n < n!$ for every integer $n >= 4$.

  *(For $n = 1, 2, 3$, the inequality does not hold: $2^1 = 2 > 1!$, $2^2 = 4 > 2!$, and $2^3 = 8 > 3! = 6$. It first becomes true at $n_0 = 4$.)*

  *Proof by Mathematical Induction*:
  Let $P(n)$ be the inequality $2^n < n!$.

  1. *Basis Step ($P(4)$)*:
     For $n = 4$, $"LHS" = 2^4 = 16$ and $"RHS" = 4! = 24$. Since $16 < 24$, $P(4)$ is true.

  2. *Inductive Hypothesis*:
     Assume $P(n)$ holds for an arbitrary integer $n >= 4$, so $2^n < n!$.

  3. *Inductive Step ($P(n) ==> P(n + 1)$)*:
     We want to show that $2^(n+1) < (n + 1)!$. Starting from the left-hand side:
     $ 2^(n+1) &= 2 dot 2^n \
     &< 2 dot n! quad &&"by the Inductive Hypothesis" (2^n < n!) \
     &< (n + 1) dot n! quad &&"since" n >= 4 ==> 2 < n + 1 \
     &= (n + 1)! $
     Thus, $2^(n+1) < (n + 1)!$, so $P(n + 1)$ holds.

  *Conclusion*: By mathematical induction, $2^n < n!$ for all integers $n >= 4$. $square$
]

== Strong Mathematical Induction

In simple induction, proving $P(n + 1)$ relies *only* on the single immediately preceding case $P(n)$. However, in many recurrence relations (like the Fibonacci sequence $F_(n+1) = F_n + F_(n-1)$), number-theoretic factorizations, and divide-and-conquer algorithms (like Binary Search or Merge Sort where problem size drops from $n$ to $floor(n/2)$), proving $P(n + 1)$ requires knowing that the property holds for *smaller integers earlier than $n$*.

#definition("Principle of Strong Induction")[
  Let $P(n)$ be a predicate defined for integers $n >= n_0$. To prove $forall n >= n_0, P(n)$ by *strong induction*:
  1. *Basis Step*: Prove that $P(n_0)$ (and any additional initial cases $P(n_0 + 1), dots, P(n_0 + r)$ required by the recurrence) is true.
  2. *Strong Inductive Hypothesis*: Assume that $P(j)$ is true for *all* integers $j$ in the range $n_0 <= j <= n$:
     $ P(n_0) and P(n_0 + 1) and dots and P(n) $
  3. *Inductive Step*: Prove that $P(n + 1)$ is true using any combination of the assumptions $P(n_0), dots, P(n)$.
]

#block(breakable: false)[
  #table(
    columns: (1.2fr, 1.9fr, 1.9fr),
    align: (left, left, left),
    [Feature], [Simple (Weak) Induction], [Strong Induction],
    [*Base Step*], [Verify $P(n_0)$ (single starting point)], [Verify $P(n_0), dots, P(n_0 + r)$ (one or more initial cases)],
    [*Inductive Hypothesis*], [Assume $P(n)$ holds for a *single* integer $n >= n_0$], [Assume $P(j)$ holds for *all* integers $n_0 <= j <= n$],
    [*Typical Use Cases*], [Series sums ($sum a_k$), single-step recurrences ($T(n+1) = f(T(n))$), divisibility], [Prime factorization, multi-term recurrences (Fibonacci), divide-and-conquer ($T(n) = 2T(n/2) + n$)],
    [*Logical Power*], [Equivalent to Strong Induction and Well-Ordering], [Equivalent to Simple Induction and Well-Ordering],
  )
]

#example(title: "Strong Induction Classic: Existence of Prime Factorizations")[
  *Proposition*: Every integer $n >= 2$ can be written as a prime or a product of primes.

  *Proof by Strong Induction*:
  Let $P(n)$ be the statement "$n$ can be written as a product of one or more prime numbers."
  1. *Basis Step ($P(2)$)*: For $n = 2$, $2$ is itself prime, so $P(2)$ is true.
  2. *Strong Inductive Hypothesis*: Assume that for some integer $n >= 2$, $P(j)$ holds for all integers $2 <= j <= n$ (every integer from $2$ up to $n$ is prime or a product of primes).
  3. *Inductive Step*: Consider the integer $n + 1$. There are two cases:
     - *Case 1 ($n + 1$ is prime)*: Then $n + 1$ is already a prime, so $P(n + 1)$ holds.
     - *Case 2 ($n + 1$ is composite)*: By definition of a composite number, $n + 1 = a dot b$ for two integers $a, b$ satisfying $2 <= a <= n$ and $2 <= b <= n$.
       Simple induction ($P(n)$) cannot help us here because neither $a$ nor $b$ is equal to $n$. However, by our *Strong Inductive Hypothesis*, since $2 <= a, b <= n$, both $P(a)$ and $P(b)$ hold: $a$ is a product of primes and $b$ is a product of primes. Multiplying them together shows that $n + 1 = a dot b$ is also a product of primes.
  *Conclusion*: By strong induction, every integer $n >= 2$ is a prime or a product of primes. $square$
]

== Common Pitfalls & Flawed Inductive Proofs

#matrix-2x2(
  title: "Four Common Pitfalls in Mathematical Induction Proofs",
  tl-title: "1. Omitting or Mismatching the Base Case",
  tl-body: [
    The inductive step $P(n) ==> P(n+1)$ can hold even for a *false* formula! For instance, if $P(n)$ claims "$1 + 2 + dots + n = frac(n(n+1), 2) + 99$", the inductive step still works algebraically because adding $n+1$ to both sides preserves $+99$. Only the base case $P(1)$ catches the error ($1 != 100$). Also pay close attention to whether the domain starts at $n = 0$ or $n = 1$.
  ],
  tr-title: "2. The 'All Horses Are the Same Color' Fallacy",
  tr-body: [
    George Pólya's famous paradoxical proof claims that in any set of $n$ horses, all horses have the same color. The base case $n = 1$ is trivially true. In the step $n -> n+1$, removing the first horse leaves $n$ horses of the same color, and removing the last horse leaves $n$ horses of the same color; the proof assumes the two groups overlap. *Flaw*: When going from $n = 1$ to $n + 1 = 2$, the two subsets of size $1$ have *no overlap at all*, so $P(1) arrow.r.double.not P(2)$.
  ],
  bl-title: "3. Working Backwards From P(n+1) to True",
  bl-body: [
    Writing down the target equation $"LHS"_(n+1) = "RHS"_(n+1)$ and manipulating both sides until reaching $0 = 0$ is a *logical fallacy* ($Q ==> "True"$ does not prove $Q$ unless every step is reversible $<==>$). Always start on one side (such as $"LHS"_(n+1)$) and derive the other side ($"RHS"_(n+1)$) in a single chain of equalities.
  ],
  br-title: "4. Confusing the Predicate P(n) with a Number",
  br-body: [
    $P(n)$ is a *proposition* (a true/false statement), not a number! Writing "$P(n+1) = P(n) + (n+1)$" is a type error because you cannot add an integer $n+1$ to a truth value $P(n)$. Instead, write out the left-hand side of the sum and substitute the inductive hypothesis into the numerical expression.
  ],
)

#pitfall(title: "Practical Checklist for Writing Induction Proofs")[
  When writing a proof by mathematical induction, double-check these five details:
  1. *Check the Starting Integer*: Does the statement begin at $n = 1$ (positive integers) or $n = 0$ (non-negative integers), or some larger threshold $n_0$? Make sure your base case matches the stated domain.
  2. *Highlight Where the Inductive Hypothesis Is Used*: Clearly mark the step where you substitute the Inductive Hypothesis (IH), since that is the logical heart of the proof.
  3. *Find the Correct $(n+1)$-st Term*: When moving from $n$ to $n+1$ in a sum like $sum_(k=1)^n (2k - 1)$, replace $n$ with $(n + 1)$ inside parentheses to get $2(n + 1) - 1 = 2n + 1$ (do not simply add $1$ to $2n - 1$).
  4. *Factor Before Expanding*: Factor out common terms like $(n + 1)$ or $(2n + 3)$ early when combining fractions so you do not have to expand and re-factor cubic polynomials.
  5. *Write a Clear Conclusion*: Finish with a brief closing sentence stating that the proposition holds for all $n >= n_0$ by mathematical induction.
]
