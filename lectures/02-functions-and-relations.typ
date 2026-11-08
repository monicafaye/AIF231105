#import "/templates/course-note.typ": *

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 2,
  title: "Functions and Relations",
  subtitle: "Binary Relations, Matrix Representations, Equivalence Relations, Functions, Bijections, and Composition",
)

= Binary Relations

In discrete mathematics and computer science, relationships between elements of sets—such as keys mapped to database records, vertices connected by edges in a network, or tasks constrained by scheduling dependencies—are formalized through the concept of a _relation_. While a Cartesian product $A times B$ pairs every element of $A$ with every element of $B$, a relation selects the specific subset of ordered pairs that satisfy a meaningful condition.

#definition("Binary Relation")[
  Let $A$ and $B$ be sets. A *binary relation* $R$ from set $A$ to set $B$ is a subset of the Cartesian product $A times B$:
  $ R subset.eq A times B $
  - If an ordered pair $(a, b)$ belongs to $R$, we write $(a, b) in R$ or use the infix notation $a R b$ (read as "$a$ is related to $b$ by $R$").
  - If $(a, b)$ does not belong to $R$, we write $(a, b) in.not R$ or $a cancel(R) b$.
  - Set $A$ is called the *domain* of $R$, and set $B$ is called the *codomain* of $R$.
]

#intuition(title: "Why Relations Are Defined as Subsets of Cartesian Products")[
  Defining a relation $R$ simply as a set of ordered pairs $R subset.eq A times B$ separates _which_ pairs are related from _how_ the rule is phrased (such as "is a divisor of" or "is enrolled in"). Because $A times B$ has $|A| dot |B|$ possible ordered pairs, there are $2^(|A| dot |B|)$ distinct binary relations from a finite set $A$ to a finite set $B$. In relational databases (SQL), a two-column table over domains $A$ and $B$ is a finite binary relation $R subset.eq A times B$.
]

#example(title: "Divisibility Relation Between Two Sets")[
  Let $P = {2, 3, 4}$ and $Q = {2, 4, 8, 9, 15}$. Suppose we define a binary relation $R$ from $P$ to $Q$ by the rule:
  $ (p, q) in R quad "if and only if" quad p "divides" q quad ("written" p divides q) $

  *Step-by-step evaluation across $P times Q$:*
  - For $p = 2$: $2$ divides $2, 4, 8$ in $Q$, yielding pairs $(2, 2), (2, 4), (2, 8)$.
  - For $p = 3$: $3$ divides $9, 15$ in $Q$, yielding pairs $(3, 9), (3, 15)$.
  - For $p = 4$: $4$ divides $4, 8$ in $Q$, yielding pairs $(4, 4), (4, 8)$.

  Collecting all valid ordered pairs gives:
  $ R = {(2, 2), (2, 4), (4, 4), (2, 8), (4, 8), (3, 9), (3, 15)} $

  We can visualize this bipartite mapping between $P$ and $Q$ structurally:
  #align(center)[
    #block(
      width: 82%,
      fill: palette.example-bg,
      stroke: 0.7pt + palette.rule,
      radius: 4pt,
      inset: 10pt,
      [
        #grid(
          columns: (1fr, 2fr),
          gutter: 12pt,
          align: (left + horizon, left + horizon),
          [
            *Domain $P = {2, 3, 4}$*\
            - $p = 2$ (even divisor)\
            - $p = 3$ (odd prime divisor)\
            - $p = 4$ (multiple of $4$)
          ],
          [
            *Outgoing Relation Arrows to Codomain $Q = {2, 4, 8, 9, 15}$*\
            $2 arrow.r {2, 4, 8}$\
            $3 arrow.r {9, 15}$\
            $4 arrow.r {4, 8}$
          ]
        )
      ]
    )
  ]
]

== Relations on a Single Set

In many applications—such as ordering numbers, comparing strings, or modeling transitions between states of a finite automaton—the domain and codomain are the same set.

#definition("Relation on a Set")[
  A *relation on a set $A$* is a binary relation from $A$ to $A$, that is, a subset of $A times A$:
  $ R subset.eq A times A $
]

#example(title: "Prime Factor Relation on a Set")[
  Let $A = {2, 3, 4, 8, 9}$, and let $R$ be the relation on $A$ defined by:
  $ (x, y) in R quad "if and only if" quad x "is a prime factor of" y $

  *Analysis:* For $(x, y)$ to belong to $R$, $x$ itself must be a prime number and must divide $y$. Among the elements of $A = {2, 3, 4, 8, 9}$, only $2$ and $3$ are prime ($4 = 2^2$, $8 = 2^3$, and $9 = 3^2$ are composite):
  - For $x = 2$: $2$ is a prime factor of $2$, $4$, and $8$.
  - For $x = 3$: $3$ is a prime factor of $3$ and $9$.
  - For $x in {4, 8, 9}$: None of these are prime, so they contribute no pairs as first coordinates.

  Therefore:
  $ R = {(2, 2), (2, 4), (2, 8), (3, 3), (3, 9)} $
]

= Representation and Inverse of Relations

== Zero-One Matrix Representation

When sets $A$ and $B$ are finite, a binary relation $R subset.eq A times B$ can be represented compactly in memory as a *zero-one matrix* (boolean adjacency matrix).

#concept(title: "Matrix Representation of a Binary Relation")[
  Suppose $R$ is a relation from $A = {a_1, a_2, dots, a_m}$ to $B = {b_1, b_2, dots, b_n}$, where the elements of each set are listed in a fixed order. The relation $R$ is represented by the $m times n$ matrix $M_R = [m_(i j)]$, where:
  $ M_R = mat(
    m_(1 1), m_(1 2), dots.h, m_(1 n);
    m_(2 1), m_(2 2), dots.h, m_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    m_(m 1), m_(m 2), dots.h, m_(m n)
  ) quad "with" quad m_(i j) = cases(
    1 quad &"if" (a_i, b_j) in R,
    0 quad &"if" (a_i, b_j) in.not R
  ) $
  Each row $i$ corresponds to element $a_i in A$, and each column $j$ corresponds to element $b_j in B$.
]

#example(title: "Matrix of the Divisibility Relation")[
  Returning to $P = {2, 3, 4}$ and $Q = {2, 4, 8, 9, 15}$ with $(p, q) in R <==> p divides q$, we index the elements in increasing order:
  $ p_1 = 2, quad p_2 = 3, quad p_3 = 4 $
  $ q_1 = 2, quad q_2 = 4, quad q_3 = 8, quad q_4 = 9, quad q_5 = 15 $
  The relation can be written in indexed form as:
  $ R &= {(2, 2), (2, 4), (4, 4), (2, 8), (4, 8), (3, 9), (3, 15)} \
      &= {(p_1, q_1), (p_1, q_2), (p_3, q_2), (p_1, q_3), (p_3, q_3), (p_2, q_4), (p_2, q_5)} $
  Setting entry $(i, j)$ to $1$ whenever $(p_i, q_j) in R$ and $0$ otherwise yields the $3 times 5$ zero-one matrix:
  $ M = mat(
    1, 1, 1, 0, 0;
    0, 0, 0, 1, 1;
    0, 1, 1, 0, 0
  ) $
]

#example(title: "Constructing a Relation Matrix")[
  *Problem:* Given $A = {1, 2, 3}$ and $B = {a, b, c}$, with the relation:
  $ R = {(1, a), (1, b), (2, b), (3, a), (3, b), (3, c)} $
  Represent this relation in matrix form.

  *Solution:*
  Order the domain elements as $a_1 = 1, a_2 = 2, a_3 = 3$ (rows $1, 2, 3$) and the codomain elements as $b_1 = a, b_2 = b, b_3 = c$ (columns $1, 2, 3$):
  - *Row 1 ($1$):* $(1, a) in R$, $(1, b) in R$, $(1, c) in.not R ==> [1, 1, 0]$.
  - *Row 2 ($2$):* $(2, a) in.not R$, $(2, b) in R$, $(2, c) in.not R ==> [0, 1, 0]$.
  - *Row 3 ($3$):* $(3, a) in R$, $(3, b) in R$, $(3, c) in R ==> [1, 1, 1]$.

  Combining the three rows gives the $3 times 3$ matrix representation:
  $ M_R = mat(
    1, 1, 0;
    0, 1, 0;
    1, 1, 1
  ) $
]

== Inverse Relations

Reversing the direction of every ordered pair in a relation $R$ from $A$ to $B$ produces a relation from $B$ to $A$.

#definition("Inverse Relation")[
  Let $R$ be a binary relation from set $A$ to set $B$. The *inverse relation* of $R$, denoted by $R^(-1)$, is the relation from $B$ to $A$ defined by reversing the order of every pair in $R$:
  $ R^(-1) = {(b, a) mid(|) (a, b) in R} $
  In matrix representation, the matrix of $R^(-1)$ is the *transpose* of the matrix of $R$:
  $ M_(R^(-1)) = (M_R)^T $
]

#example(title: "Inverse of the Divisibility Relation")[
  Let $P = {2, 3, 4}$ and $Q = {2, 4, 8, 9, 15}$, where $(p, q) in R$ if $p$ divides $q$:
  $ R = {(2, 2), (2, 4), (4, 4), (2, 8), (4, 8), (3, 9), (3, 15)} $
  The inverse relation $R^(-1) subset.eq Q times P$ is characterized verbally by:
  $ (q, p) in R^(-1) quad "if and only if" quad q "is a multiple of" p $
  Reversing each ordered pair in $R$ yields:
  $ R^(-1) = {(2, 2), (4, 2), (4, 4), (8, 2), (8, 4), (9, 3), (15, 3)} $
  Its matrix representation is the $5 times 3$ transpose $M^T$:
  $ M_(R^(-1)) = M^T = mat(
    1, 0, 0;
    1, 0, 1;
    1, 0, 1;
    0, 1, 0;
    0, 1, 0
  ) $
]

= Properties of Relations on a Set

When a relation $R$ is defined on a single set $A$ ($R subset.eq A times A$), we classify its behavior using four fundamental properties: _reflexivity_, _symmetry_, _antisymmetry_, and _transitivity_.

== Reflexivity

#definition("Reflexive Relation")[
  A relation $R$ on a set $A$ is called *reflexive* if every element of $A$ is related to itself:
  $ forall a in A, quad (a, a) in R $
  *Matrix signature:* Every entry on the main diagonal of $M_R$ is $1$ (i.e., $m_(i i) = 1$ for all $1 <= i <= |A|$).
]

#example(title: "Testing Reflexivity on a Finite Set")[
  Let $A = {1, 2, 3}$ and consider the relation:
  $ R = {(1, 1), (1, 3), (2, 2), (2, 1), (2, 3), (3, 3)} $
  Because $A$ contains the elements $1, 2, 3$ and $R$ contains all three self-loops $(1, 1) in R$, $(2, 2) in R$, and $(3, 3) in R$, the relation $R$ is *reflexive*.
]

#example(title: "Testing Whether y = x² Is Reflexive on Positive Integers")[
  *Problem:* A relation $R$ is defined on the set of positive integers $bb(Z)^+$ by:
  $ R : y = x^2, quad x, y in bb(Z)^+ $
  Is this relation reflexive?

  *Solution:*
  *No, $R$ is not reflexive.*
  By definition, for $R$ to be reflexive on $bb(Z)^+$, the pair $(x, x)$ must belong to $R$ for _every_ positive integer $x in bb(Z)^+$. That requires $x = x^2$ for all $x in bb(Z)^+$.
  - For $x = 1$: $1 = 1^2 = 1$, so $(1, 1) in R$.
  - For $x = 2$: $2^2 = 4 != 2$, so $(2, 2) in.not R$ (instead $(2, 4) in R$).

  Since the universal requirement $forall x in bb(Z)^+, (x, x) in R$ fails for $x = 2$, $R$ is _not reflexive_.
]

== Symmetry and Antisymmetry

#definition("Symmetric Relation")[
  A relation $R$ on a set $A$ is called *symmetric* if whenever $a$ is related to $b$, $b$ is also related to $a$:
  $ forall a, b in A, quad (a, b) in R ==> (b, a) in R $
  *Matrix signature:* $M_R$ is a symmetric matrix ($M_R = (M_R)^T$, meaning $m_(i j) = m_(j i)$ for all $i, j$).
]

#example(title: "Symmetric Relation")[
  Let $A = {1, 2, 3, 4}$ and let $R$ be defined as:
  $ R = {(1, 1), (1, 2), (2, 1), (2, 3), (3, 2), (4, 4)} $
  Every off-diagonal pair has its reverse present in $R$: $(1, 2)$ is paired with $(2, 1)$, and $(2, 3)$ is paired with $(3, 2)$. Therefore, $R$ is *symmetric*. Note that $R$ is _not_ reflexive because $(2, 2) in.not R$ and $(3, 3) in.not R$.
]

#definition("Antisymmetric Relation")[
  A relation $R$ on a set $A$ is called *antisymmetric* if two distinct elements are never mutually related—that is, if both $(a, b) in R$ and $(b, a) in R$ hold, then $a$ and $b$ must be the same element:
  $ forall a, b in A, quad ((a, b) in R and (b, a) in R) ==> a = b $
  Equivalently, by contraposition: for all $a != b$, if $(a, b) in R$, then $(b, a) in.not R$.
  *Matrix signature:* For all $i != j$, at most one of $m_(i j)$ and $m_(j i)$ can be $1$ (i.e., $m_(i j) dot m_(j i) = 0$ for $i != j$). Diagonal entries $m_(i i)$ may be $0$ or $1$ freely.
]

#example(title: "Antisymmetric Relation")[
  Let $A = {1, 2, 3}$ and let $R = {(1, 1), (2, 2), (1, 2)}$.
  - For the self-loops $(1, 1)$ and $(2, 2)$, $a = b$ holds automatically.
  - For the distinct pair $(1, 2) in R$, the reverse pair $(2, 1)$ is _not_ in $R$.
  Hence there is no pair of distinct elements $a != b$ with both $(a, b) in R$ and $(b, a) in R$, which means $R$ is *antisymmetric*.
]

#pitfall(title: "Symmetric and Antisymmetric Are Not Opposites")[
  It is easy to assume that "not symmetric" means "antisymmetric," or that a relation cannot be both. In fact:
  1. *A relation can be both symmetric and antisymmetric:* Any diagonal relation (such as the equality relation $R = {(1, 1), (2, 2), (3, 3)}$ or the empty relation $R = emptyset$) is both symmetric and antisymmetric.
  2. *A relation can be neither symmetric nor antisymmetric:* For example, $R = {(1, 2), (2, 1), (2, 3)}$ is not symmetric (missing $(3, 2)$) and not antisymmetric (contains both $(1, 2)$ and $(2, 1)$).
]

== Transitivity

#definition("Transitive Relation")[
  A relation $R$ on a set $A$ is called *transitive* if whenever $a$ is related to $b$ and $b$ is related to $c$, then $a$ is also directly related to $c$:
  $ forall a, b, c in A, quad ((a, b) in R and (b, c) in R) ==> (a, c) in R $
]

#example(title: "Verifying Transitivity via Two-Step Chains")[
  Let $A = {1, 2, 3, 4}$ and define $R = {(1, 2), (1, 3), (2, 3), (3, 4), (1, 4), (2, 4)}$.
  To verify that $R$ is transitive, we inspect every composable pair $(a, b) in R$ and $(b, c) in R$ and confirm that $(a, c)$ belongs to $R$:

  #table(
    columns: (1fr, 1fr, 1fr, 1.5fr),
    align: (center, center, center, left),
    [First Pair $(a, b)$], [Second Pair $(b, c)$], [Required $(a, c)$], [Status in $R$],
    [$(1, 2)$], [$(2, 3)$], [$(1, 3)$], [Present in $R$ ($checkmark$)],
    [$(1, 2)$], [$(2, 4)$], [$(1, 4)$], [Present in $R$ ($checkmark$)],
    [$(1, 3)$], [$(3, 4)$], [$(1, 4)$], [Present in $R$ ($checkmark$)],
    [$(2, 3)$], [$(3, 4)$], [$(2, 4)$], [Present in $R$ ($checkmark$)],
  )
  Because every two-step path $a arrow.r b arrow.r c$ has its direct edge $a arrow.r c$ in $R$ (in fact, $R$ is the strict ordering $<$ on ${1, 2, 3, 4}$), $R$ is *transitive*.
]

#example(title: "Analyzing the Relation x + y = 5 on {1, 2, 3, 4}")[
  *Problem:* Let $A = {1, 2, 3, 4}$ and let relation $R$ on $A$ be defined by:
  $ R : x + y = 5 quad "for" x, y in A $
  Determine all properties of relation $R$.

  *Solution:*
  First, list all ordered pairs $(x, y) in A times A$ satisfying $x + y = 5$:
  $ R = {(1, 4), (2, 3), (3, 2), (4, 1)} $
  Now test each of the four properties:
  1. _Reflexive?_ *No.* For $x = 1$, $1 + 1 = 2 != 5$, so $(1, 1) in.not R$ (no $(a, a)$ is in $R$ because $2a = 5$ has no integer solution).
  2. _Symmetric?_ *Yes.* Addition is commutative ($x + y = 5 ==> y + x = 5$). Explicitly, $(1, 4), (4, 1) in R$ and $(2, 3), (3, 2) in R$.
  3. _Antisymmetric?_ *No.* Both $(1, 4) in R$ and $(4, 1) in R$ hold with $1 != 4$.
  4. _Transitive?_ *No.* We have $(1, 4) in R$ and $(4, 1) in R$, which by transitivity would require $(1, 1) in R$, but $(1, 1) in.not R$.

  *Conclusion:* The relation $R$ is *symmetric only* (it is neither reflexive, nor antisymmetric, nor transitive).
]

== Equivalence Relations

#definition("Equivalence Relation")[
  A relation $R$ on a set $A$ is called an *equivalence relation* if it simultaneously satisfies three properties:
  1. *Reflexive*: $(a, a) in R$ for all $a in A$.
  2. *Symmetric*: $(a, b) in R ==> (b, a) in R$ for all $a, b in A$.
  3. *Transitive*: $(a, b) in R and (b, c) in R ==> (a, c) in R$ for all $a, b, c in A$.
]

#intuition(title: "Equivalence Relations Partition a Set into Disjoint Classes")[
  An equivalence relation generalizes "equality" by grouping elements that share a chosen attribute (such as congruence modulo $n$, having the same string length, or residing in the same connected component of an undirected graph). Every equivalence relation $R$ on $A$ partitions $A$ into mutually disjoint subsets called _equivalence classes_ $[a]_R = {x in A mid(|) (a, x) in R}$. Within each class, every element is related to every other element.
]

#example(title: "Equivalence Relation on A = {1, 2, 3, 4}")[
  Let $A = {1, 2, 3, 4}$ and consider the relation:
  $ R = {(1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3), (4, 4)} $
  Let us check why $R$ is an equivalence relation:
  - *Reflexive:* $(1, 1), (2, 2), (3, 3), (4, 4) in R$.
  - *Symmetric:* Every pair among ${1, 2, 3}$ has its reverse in $R$, and $(4, 4)$ is its own reverse.
  - *Transitive:* Notice that $R = ({1, 2, 3} times {1, 2, 3}) union {(4, 4)}$. Any composable pairs $(a, b)$ and $(b, c)$ either both lie inside ${1, 2, 3} times {1, 2, 3}$ (which contains all $9$ pairs on ${1, 2, 3}$, so $(a, c) in R$ automatically) or both equal $(4, 4)$.

  Thus $R$ is an *equivalence relation* that partitions $A$ into two equivalence classes: $[1] = [2] = [3] = {1, 2, 3}$ and $[4] = {4}$.
]

#matrix-2x2(
  title: "Summary of the Four Core Relation Properties on a Set A",
  tl-title: "Reflexive",
  tl-body: [
    *Condition:* $forall a in A, (a, a) in R$.\
    *Graph:* Every vertex has a self-loop.\
    *Matrix:* All diagonal entries $m_(i i) = 1$.
  ],
  tr-title: "Symmetric",
  tr-body: [
    *Condition:* $(a, b) in R ==> (b, a) in R$.\
    *Graph:* Every directed edge between distinct vertices is bidirectional.\
    *Matrix:* $M_R = (M_R)^T$.
  ],
  bl-title: "Antisymmetric",
  bl-body: [
    *Condition:* $(a, b) in R and (b, a) in R ==> a = b$.\
    *Graph:* No two _distinct_ vertices have two-way arrows between them.\
    *Matrix:* If $i != j$, then $m_(i j) = 0$ or $m_(j i) = 0$.
  ],
  br-title: "Transitive",
  br-body: [
    *Condition:* $(a, b) in R and (b, c) in R ==> (a, c) in R$.\
    *Graph:* Every 2-step path $a arrow.r b arrow.r c$ has a direct shortcut edge $a arrow.r c$.\
    *Combine:* Reflexive + Symmetric + Transitive = *Equivalence Relation*.
  ],
)

= Functions: Fundamentals and Specifications

A _function_ is a binary relation in which every input from the domain is assigned to a single, unambiguous output in the codomain.

#definition("Function / Mapping / Transformation")[
  Let $A$ and $B$ be non-empty sets. A binary relation $f$ from $A$ to $B$ is a *function* (also called a *mapping* or *transformation*) if every element in $A$ is associated with *exactly one* element in $B$. We write:
  $ f : A arrow.r B $
  which reads "$f$ maps $A$ to $B$." Formally, $f subset.eq A times B$ is a function if and only if:
  1. *Totality (Every input is mapped):* $forall a in A, exists b in B$ such that $(a, b) in f$.
  2. *Uniqueness (At most one output per input):* $forall a in A, forall b_1, b_2 in B$, if $(a, b_1) in f$ and $(a, b_2) in f$, then $b_1 = b_2$.
]

#concept(title: "Domain, Codomain, Image, Pre-image, and Range")[
  When $f : A arrow.r B$ and $(a, b) in f$, we write $f(a) = b$:
  - *Domain:* The set $A$ of all valid inputs.
  - *Codomain:* The target set $B$ of potential outputs.
  - *Image:* If $f(a) = b$, then $b$ is the _image_ of $a$ under $f$.
  - *Pre-image:* If $f(a) = b$, then $a$ is a _pre-image_ of $b$ under $f$.
  - *Range:* The set of all actual images attained by $f$, denoted $f(A)$ or $"Range"(f)$:
    $ "Range"(f) = f(A) = {f(a) mid(|) a in A} = {b in B mid(|) exists a in A, f(a) = b} subset.eq B $
    The range of $f$ is always a subset (possibly a _proper subset_) of the codomain $B$.
]

== Specifying a Function

A function can be specified explicitly in two main ways:
1. *Set of Ordered Pairs:*
   For finite sets $A = {1, 2, 3}$ and $B = {u, v, w}$, we can list the pairs directly:
   $ f = {(1, u), (2, v), (3, w)} <==> f(1) = u, quad f(2) = v, quad f(3) = w $
2. *Assignment Formula:*
   We can provide an algebraic rule or expression for computing $f(x)$ from $x$, such as:
   $ f(x) = x^2, quad "or equivalently in set-builder form:" quad f = {(x, x^2) mid(|) x in bb(R)} $

#example(title: "Determining Whether a Relation Is a Function")[
  *Problem:* Given $A = {1, 2, 3}$, $B = {u, v, w}$, and $f = {(1, u), (2, u), (2, v), (3, w)}$. Is $f$ a function?

  *Solution:*
  *No, $f$ is not a function.*
  Let us check each element of the domain $A = {1, 2, 3}$:
  - Element $1 in A$ is mapped only to $u$.
  - Element $2 in A$ appears in _two distinct ordered pairs_: $(2, u) in f$ and $(2, v) in f$, where $u != v$.
  - Element $3 in A$ is mapped only to $w$.

  Because the input $2 in A$ is associated with two different outputs in $B$ ($u$ and $v$), $f$ violates the uniqueness condition. Note that having $(1, u)$ and $(2, u)$ share the output $u$ is completely fine for a function, but mapping a single input $2$ to two outputs $u$ and $v$ is not allowed.
]

= Classification of Functions: Injection, Surjection, Bijection

Functions $f : A arrow.r B$ are classified by whether distinct inputs stay distinct in the output and whether the range covers the entire codomain $B$.

== Injection (One-to-One Functions)

#definition("Injection / One-to-One Function")[
  A function $f : A arrow.r B$ is called *one-to-one* or *injective* (an *injection*) if distinct elements of $A$ always map to distinct elements of $B$:
  $ forall a, b in A, quad a != b ==> f(a) != f(b) $
  By contraposition, this is equivalent to:
  $ forall a, b in A, quad f(a) = f(b) ==> a = b $
  In an arrow diagram, every element of $B$ receives _at most one_ incoming arrow from $A$. For finite sets, an injection $f : A arrow.r B$ can exist only if $|A| <= |B|$.
]

#example(title: "Testing Injectivity of f(x) = x²")[
  *Problem:*
  1. Is the function $f : bb(Z) arrow.r bb(Z)$ defined by $f(x) = x^2$ injective?
  2. What if we define $f = {(x, x^2) mid(|) x >= 0}$ (restricting the domain to non-negative integers)?

  *Solution:*
  1. _For $f : bb(Z) arrow.r bb(Z)$ with $f(x) = x^2$:_ *Not injective.*
     Take $a = 1 in bb(Z)$ and $b = -1 in bb(Z)$. Then $a != b$, yet:
     $ f(1) = 1^2 = 1 quad "and" quad f(-1) = (-1)^2 = 1 ==> f(1) = f(-1) $
     Because two distinct integers share the same image, $f$ is not one-to-one on $bb(Z)$.
  2. _When restricted to $x >= 0$ (i.e., $f : bb(N)_0 arrow.r bb(Z)$ where $f = {(x, x^2) mid(|) x >= 0}$):_ *Yes, $f$ is injective.*
     Suppose $a, b >= 0$ and $f(a) = f(b)$. Then:
     $ a^2 = b^2 ==> a^2 - b^2 = 0 ==> (a - b)(a + b) = 0 $
     Since $a >= 0$ and $b >= 0$, $a + b = 0$ can only happen when $a = b = 0$; in all other cases $a + b > 0$, forcing $a - b = 0$, so $a = b$. Restricting the domain removes the negative duplicates and makes $f$ one-to-one.
]

== Surjection (Onto Functions)

#definition("Surjection / Onto Function")[
  A function $f : A arrow.r B$ is called *onto* or *surjective* (a *surjection*) if every element of the codomain $B$ is the image of _at least one_ element of the domain $A$:
  $ forall b in B, quad exists a in A quad "such that" quad f(a) = b $
  Equivalently, the range of $f$ equals the entire codomain: $"Range"(f) = f(A) = B$.
  In an arrow diagram, every element of $B$ receives _one or more_ incoming arrows from $A$. For finite sets, a surjection $f : A arrow.r B$ can exist only if $|A| >= |B|$.
]

#example(title: "Testing Surjectivity of f(x) = x⁴ + 3")[
  *Problem:* Is the function $f : bb(Z) arrow.r bb(Z)$ defined by $f(x) = x^4 + 3$ onto?

  *Solution:*
  *No, $f$ is not onto.*
  For $f : bb(Z) arrow.r bb(Z)$ to be onto, for every integer $y in bb(Z)$ there would need to exist an integer $x in bb(Z)$ such that $x^4 + 3 = y$, or $x^4 = y - 3$.
  - _Lower bound on the range:_ Since $x^4 >= 0$ for all $x in bb(Z)$, we have $f(x) = x^4 + 3 >= 3$ for all $x in bb(Z)$. Thus, no integer $y < 3$ (for example, $y = 0$, which would require $x^4 = -3$) is in the range of $f$.
  - _Gaps above 3:_ Even for $y >= 3$, take $y = 5 in bb(Z)$. Then $x^4 + 3 = 5 ==> x^4 = 2$, which has no integer solution $x in bb(Z)$.

  Because $"Range"(f) = {3, 4, 19, 84, dots} subset.neq bb(Z)$, $f$ is not onto.
]

== Bijection and Inverse Functions

#definition("Bijection / One-to-One Correspondence")[
  A function $f : A arrow.r B$ is a *bijection* (or *one-to-one correspondence*) if it is simultaneously:
  1. *Injective (one-to-one)*: $f(a) = f(b) ==> a = b$, and
  2. *Surjective (onto)*: $forall b in B, exists a in A$ with $f(a) = b$.
  Every element in $B$ is the image of a _unique_ element in $A$. For finite sets, a bijection between $A$ and $B$ exists if and only if $|A| = |B|$.
]

#definition("Inverse Function")[
  Let $f : A arrow.r B$ be a *bijection*. The *inverse function* of $f$, denoted by $f^(-1) : B arrow.r A$, is the function that assigns to each element $b in B$ the unique element $a in A$ such that $f(a) = b$:
  $ f^(-1)(b) = a <==> f(a) = b $
  A function $f : A arrow.r B$ is _invertible_ (has an inverse function $f^(-1) : B arrow.r A$) if and only if $f$ is a bijection.
]

#pitfall(title: "Inverse Relation R⁻¹ vs. Inverse Function f⁻¹")[
  Any binary relation $R subset.eq A times B$ always has an _inverse relation_ $R^(-1) subset.eq B times A$. However, if $f : A arrow.r B$ is a function, its inverse relation $f^(-1) = {(b, a) mid(|) (a, b) in f}$ is a valid _function_ from $B$ to $A$ *if and only if $f$ is a bijection*:
  - If $f$ is _not injective_, then some $b in B$ has two pre-images $a_1 != a_2$, so $f^(-1)(b)$ would have two outputs (violating uniqueness).
  - If $f$ is _not surjective_, then some $b in B$ has _no_ pre-image in $A$, so $f^(-1)(b)$ would be undefined on $b$ (violating totality).
]

#example(title: "Computing Inverse Functions")[
  1. *Finite Set of Ordered Pairs:*
     Let $A = {1, 2, 3}$, $B = {u, v, w}$, and $f = {(1, u), (2, v), (3, w)}$. Since $f$ is both one-to-one and onto, its inverse function is obtained by swapping each pair:
     $ f^(-1) = {(u, 1), (v, 2), (w, 3)} $
  2. *Algebraic Formula:*
     Let $f : bb(R) arrow.r bb(R)$ be defined by $f(x) = x + 1$. Since $f$ is a bijection, we find $f^(-1)$ by solving $y = f(x)$ for $x$:
     $ y = x + 1 ==> x = y - 1 ==> f^(-1)(y) = y - 1 quad ("or" f^(-1)(x) = x - 1) $
]

= Function Composition

When the codomain of one function matches (or is contained within) the domain of a second function, we can chain the two mappings together into a pipeline.

#definition("Composition of Functions")[
  Let $g : A arrow.r B$ be a function from set $A$ to set $B$, and let $f : B arrow.r C$ be a function from set $B$ to set $C$. The *composition* of $f$ and $g$, denoted by $f compose g$, is the function from $A$ to $C$ defined by:
  $ (f compose g)(a) = f(g(a)) quad "for all" a in A $
]

#flow-chain(
  caption: "Function Composition Pipeline: g is applied first (A → B), followed by f (B → C)",
  ("Input a ∈ A", "Domain of g"),
  ("Apply g", "Intermediate g(a) ∈ B"),
  ("Apply f", "Output (f ∘ g)(a) = f(g(a)) ∈ C"),
)

#example(title: "Composing Two and Three Functions")[
  *Problem:* Given $f(x) = x + 1$ and $g(x) = x^2$ on $bb(R)$:
  1. Compute $(f compose g)(x)$ and compare it with $(g compose f)(x)$.
  2. Given $h(x) = x + 1$, determine the triple composition $(f compose g compose h)(x)$.

  *Solution:*
  1. *Two-function compositions:*
     Applying $g$ first and then $f$:
     $ (f compose g)(x) = f(g(x)) = f(x^2) = x^2 + 1 $
     By contrast, applying $f$ first and then $g$:
     $ (g compose f)(x) = g(f(x)) = g(x + 1) = (x + 1)^2 = x^2 + 2x + 1 $
     Notice that $(f compose g)(x) != (g compose f)(x)$—function composition is *not commutative* in general.

  2. *Triple composition $(f compose g compose h)(x)$ with $h(x) = x + 1$:*
     Function composition is _associative_, and we evaluate from right to left (innermost function first):
     $ (f compose g compose h)(x) &= f(g(h(x))) \
       &= f(g(x + 1)) & quad &("since" h(x) = x + 1) \
       &= f((x + 1)^2) & quad &("since" g(u) = u^2) \
       &= (x + 1)^2 + 1 & quad &("since" f(v) = v + 1) \
       &= x^2 + 2x + 2 $
]

= Worked Practice Problems

Below are complete step-by-step solutions to practice problems on injectivity, surjectivity, and bijections.

#example(title: "Injectivity and Surjectivity on ℤ → ℤ")[
  *Problem:*
  - *Part 1:* Determine whether each of these functions from $bb(Z)$ to $bb(Z)$ is one-to-one (injective):
    *(a)* $f(n) = n - 1$ #h(2em) *(b)* $f(n) = n^2 + 1$ #h(2em) *(c)* $f(n) = n^3$ #h(2em) *(d)* $f(n) = ceil(n / 2)$
  - *Part 2:* Which of the functions above are onto (surjective)?

  *Solutions:*
  - *(a) $f(n) = n - 1$:*
    - _One-to-one?_ *Yes.* Suppose $f(a) = f(b)$ for $a, b in bb(Z)$. Then $a - 1 = b - 1 ==> a = b$.
    - _Onto?_ *Yes.* Let $y in bb(Z)$ be any target integer. Choose $n = y + 1 in bb(Z)$. Then $f(y + 1) = (y + 1) - 1 = y$. Since $f$ is both one-to-one and onto, $f(n) = n - 1$ is a _bijection_ on $bb(Z)$.

  - *(b) $f(n) = n^2 + 1$:*
    - _One-to-one?_ *No.* Counterexample: $f(1) = 1^2 + 1 = 2$ and $f(-1) = (-1)^2 + 1 = 2$, so $f(1) = f(-1)$ with $1 != -1$.
    - _Onto?_ *No.* Since $n^2 >= 0$ for all $n in bb(Z)$, $f(n) = n^2 + 1 >= 1$. Thus no integer $y <= 0$ (e.g., $y = 0$) is in the range of $f$ (nor is $y = 3$, since $n^2 = 2$ has no integer solution).

  - *(c) $f(n) = n^3$:*
    - _One-to-one?_ *Yes.* The cube function is strictly increasing on $bb(R)$ (and hence on $bb(Z)$): if $a^3 = b^3$, taking real cube roots yields $a = b$.
    - _Onto?_ *No.* Only perfect cubes belong to the range. For example, $y = 2 in bb(Z)$ has no integer pre-image because $n^3 = 2$ has no solution in $bb(Z)$ ($1^3 = 1 < 2 < 8 = 2^3$).

  - *(d) $f(n) = ceil(n / 2)$:*
    - _One-to-one?_ *No.* Every consecutive pair of odd and even integers maps to the same ceiling value: for example, $f(1) = ceil(1/2) = 1$ and $f(2) = ceil(2/2) = 1$, yet $1 != 2$.
    - _Onto?_ *Yes.* Given any target integer $y in bb(Z)$, choose the even integer $n = 2y in bb(Z)$ (or $n = 2y - 1$). Then $f(2y) = ceil((2y)/2) = ceil(y) = y$.

  #table(
    columns: (1fr, 1.5fr, 1.5fr, 1.5fr),
    align: (left, center, center, center),
    [Function $f : bb(Z) arrow.r bb(Z)$], [One-to-One], [Onto], [Bijection?],
    [*(a)* $f(n) = n - 1$], [Yes ($checkmark$)], [Yes ($checkmark$)], [Yes],
    [*(b)* $f(n) = n^2 + 1$], [No ($times.o$, $f(1)=f(-1)$)], [No ($times.o$, $f(n) >= 1$)], [No],
    [*(c)* $f(n) = n^3$], [Yes ($checkmark$)], [No ($times.o$, $2 in.not "Range"$)], [No],
    [*(d)* $f(n) = ceil(n / 2)$], [No ($times.o$, $f(1)=f(2)$)], [Yes ($checkmark$, $f(2y)=y$)], [No],
  )
]

#example(title: "Surjectivity of Two-Variable Integer Functions f : ℤ × ℤ → ℤ (Set I)")[
  *Problem:* Determine whether $f : bb(Z) times bb(Z) arrow.r bb(Z)$ is onto if:
  *(a)* $f(m, n) = 2m - n$ #h(1.5em) *(b)* $f(m, n) = m^2 - n^2$ #h(1.5em) *(c)* $f(m, n) = m + n + 1$ #h(1.5em) *(d)* $f(m, n) = |m| - |n|$ #h(1.5em) *(e)* $f(m, n) = m^2 - 4$

  *Solutions:*
  To show $f : bb(Z) times bb(Z) arrow.r bb(Z)$ is _onto_, we check whether every integer $k in bb(Z)$ can be written as $f(m, n) = k$ for some $(m, n) in bb(Z) times bb(Z)$.

  - *(a) $f(m, n) = 2m - n$:* *Onto.*
    For any $k in bb(Z)$, set $m = 0$ and $n = -k$ (both in $bb(Z)$). Then $f(0, -k) = 2(0) - (-k) = k$.

  - *(b) $f(m, n) = m^2 - n^2$:* *Not onto.*
    Factoring gives $m^2 - n^2 = (m - n)(m + n)$. Notice that $(m - n)$ and $(m + n)$ always have the _same parity_ (their difference is $2n$, which is even).
    - If both factors are even, their product is a multiple of $4$.
    - If both factors are odd, their product is odd.
    Therefore, $m^2 - n^2$ can never equal an integer congruent to $2$ modulo $4$. Specifically, $k = 2 in bb(Z)$ has no integer solution because the only factorizations of $2$ are $1 times 2$ and $(-1) times (-2)$, where the factors have opposite parity. Thus $2 in.not "Range"(f)$.

  - *(c) $f(m, n) = m + n + 1$:* *Onto.*
    For any $k in bb(Z)$, choose $m = k - 1 in bb(Z)$ and $n = 0 in bb(Z)$. Then $f(k - 1, 0) = (k - 1) + 0 + 1 = k$.

  - *(d) $f(m, n) = |m| - |n|$:* *Onto.*
    Let $k in bb(Z)$ be any integer:
    - If $k >= 0$, choose $(m, n) = (k, 0)$, giving $f(k, 0) = |k| - |0| = k$.
    - If $k < 0$, choose $(m, n) = (0, k)$, giving $f(0, k) = |0| - |k| = -(-k) = k$.
    Every integer $k in bb(Z)$ is achieved.

  - *(e) $f(m, n) = m^2 - 4$:* *Not onto.*
    Since $m^2 >= 0$ for all $m in bb(Z)$, $f(m, n) = m^2 - 4 >= -4$. No integer $k < -4$ (such as $k = -5$) is in the range (nor is $k = -2$, since $m^2 = 2$ has no integer solution).
]

#example(title: "Surjectivity of Two-Variable Integer Functions f : ℤ × ℤ → ℤ (Set II)")[
  *Problem:* Determine whether the function $f : bb(Z) times bb(Z) arrow.r bb(Z)$ is onto if:
  *(a)* $f(m, n) = m + n$ #h(1.5em) *(b)* $f(m, n) = m^2 + n^2$ #h(1.5em) *(c)* $f(m, n) = m$ #h(1.5em) *(d)* $f(m, n) = |n|$ #h(1.5em) *(e)* $f(m, n) = m - n$

  *Solutions:*
  - *(a) $f(m, n) = m + n$:* *Onto.* For any $k in bb(Z)$, choose $(m, n) = (k, 0) in bb(Z) times bb(Z)$; then $f(k, 0) = k + 0 = k$.
  - *(b) $f(m, n) = m^2 + n^2$:* *Not onto.* Since $m^2 + n^2 >= 0$, negative integers (e.g., $k = -1$) are never attained, and positive integers like $k = 3$ cannot be written as a sum of two integer squares.
  - *(c) $f(m, n) = m$:* *Onto.* This is the projection onto the first coordinate. For any $k in bb(Z)$, $f(k, 0) = k$.
  - *(d) $f(m, n) = |n|$:* *Not onto.* Since $|n| >= 0$ for all $n in bb(Z)$, no negative integer (such as $k = -1$) is in the range of $f$.
  - *(e) $f(m, n) = m - n$:* *Onto.* For any $k in bb(Z)$, choose $(m, n) = (k, 0) in bb(Z) times bb(Z)$; then $f(k, 0) = k - 0 = k$.
]

#example(title: "Testing Bijections from ℝ to ℝ")[
  *Problem:* Determine whether each of these functions is a bijection from $bb(R)$ to $bb(R)$:
  - *Set 1:*
    *(a)* $f(x) = -3x + 4$ #h(1.5em) *(b)* $f(x) = -3x^2 + 7$ #h(1.5em) *(c)* $f(x) = (x + 1)/(x + 2)$ #h(1.5em) *(d)* $f(x) = x^5 + 1$
  - *Set 2:*
    *(a)* $f(x) = 2x + 1$ #h(1.5em) *(b)* $f(x) = x^2 + 1$ #h(1.5em) *(c)* $f(x) = x^3$ #h(1.5em) *(d)* $f(x) = (x^2 + 1)/(x^2 + 2)$

  *Solutions for Set 1:*
  - *1(a) $f(x) = -3x + 4$:* *Bijection.*
    - _One-to-one:_ $-3a + 4 = -3b + 4 ==> -3a = -3b ==> a = b$.
    - _Onto:_ For any $y in bb(R)$, solving $y = -3x + 4$ gives $x = (4 - y)/3 in bb(R)$, so $f((4 - y)/3) = y$.
  - *1(b) $f(x) = -3x^2 + 7$:* *Not a bijection* (neither one-to-one nor onto).
    - _Not one-to-one:_ $f(1) = 4 = f(-1)$ with $1 != -1$.
    - _Not onto:_ Since $x^2 >= 0$, $f(x) <= 7$, so $y = 8 in bb(R)$ has no real pre-image.
  - *1(c) $f(x) = (x + 1)/(x + 2)$:* *Not a bijection from $bb(R)$ to $bb(R)$.*
    - _Not defined on all of $bb(R)$:_ At $x = -2$, the denominator is $0$, so $f(-2)$ is undefined.
    - _Not onto $bb(R)$:_ Rewriting $f(x) = ((x + 2) - 1)/(x + 2) = 1 - 1/(x + 2)$ shows that $f(x) != 1$ for all $x in bb(R) without {-2}$, so $y = 1$ has no pre-image. (Note: $f$ is a bijection from $bb(R) without {-2}$ to $bb(R) without {1}$.)
  - *1(d) $f(x) = x^5 + 1$:* *Bijection.*
    - _One-to-one:_ $a^5 + 1 = b^5 + 1 ==> a^5 = b^5 ==> a = b$ (since odd powers are strictly increasing on $bb(R)$).
    - _Onto:_ For any $y in bb(R)$, every real number has a unique real fifth root $x = root(5, y - 1) in bb(R)$, satisfying $f(root(5, y - 1)) = (y - 1) + 1 = y$.

  *Solutions for Set 2:*
  - *2(a) $f(x) = 2x + 1$:* *Bijection.*
    - _One-to-one:_ $2a + 1 = 2b + 1 ==> a = b$.
    - _Onto:_ For any $y in bb(R)$, $x = (y - 1)/2 in bb(R)$ satisfies $f((y - 1)/2) = y$ (with inverse $f^(-1)(y) = (y - 1)/2$).
  - *2(b) $f(x) = x^2 + 1$:* *Not a bijection* (neither one-to-one nor onto).
    - _Not one-to-one:_ $f(1) = 2 = f(-1)$.
    - _Not onto:_ $f(x) = x^2 + 1 >= 1$, so $y = 0 in bb(R)$ has no real pre-image.
  - *2(c) $f(x) = x^3$:* *Bijection.*
    - _One-to-one:_ $a^3 = b^3 ==> a = b$ in $bb(R)$.
    - _Onto:_ For any $y in bb(R)$, $x = root(3, y) in bb(R)$ satisfies $f(root(3, y)) = (root(3, y))^3 = y$. (Unlike on $bb(Z)$, $f(x) = x^3$ _is_ onto on $bb(R)$.)
  - *2(d) $f(x) = (x^2 + 1)/(x^2 + 2)$:* *Not a bijection* (neither one-to-one nor onto).
    - _Not one-to-one:_ $f(1) = 2/3 = f(-1)$ since $(-x)^2 = x^2$.
    - _Not onto:_ Writing $f(x) = 1 - 1/(x^2 + 2)$ and using $x^2 >= 0 ==> x^2 + 2 >= 2 ==> 0 < 1/(x^2 + 2) <= 1/2$, we see that $"Range"(f) = [1/2, 1) subset.neq bb(R)$.
]
