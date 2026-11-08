#import "/templates/course-note.typ": *

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 1,
  title: "Set Theory",
  subtitle: "Representations, Subsets, Set Operations, Inclusion–Exclusion, and Set Algebra",
)

= Foundations of Set Theory

Set theory is the basic language of discrete mathematics and computer science. Whether we are talking about a database table, the vertices of a network graph, a formal language, or a sample space in probability, we are working with sets.

#definition("Set")[
  A *set* is an unordered collection of distinct objects, called the *elements* or *members* of the set. A set is said to *contain* its elements:
  - $a in A$ denotes that $a$ is an element of set $A$.
  - $a in.not A$ denotes that $a$ is *not* an element of set $A$.
]

By convention, uppercase letters ($A, B, C, dots$) denote sets and lowercase letters ($a, b, c, dots$) denote individual elements:
- $A = {2, 4, 6, 8}$ is a finite set of four even integers ($2 in A$, whereas $3 in.not A$).
- $B = {a, b, c, dots, x, y, z}$ denotes the lowercase letters of the English alphabet, where the ellipsis ($dots$) indicates a clear pattern.
- $bold(P)$ denotes the infinite set of all positive integers.

#intuition(title: "Why 'Unordered' and 'Distinct' Matter")[
  In programming, a mathematical set corresponds to a `Set` data structure (like `set` in Python or `std::unordered_set` in C++), rather than a `List` or `Array`:
  1. *Unordered:* Membership ($a in A$) does not depend on position; $\{2, 4, 6, 8\}$ and $\{8, 2, 6, 4\}$ are the exact same set.
  2. *No Duplicates:* Listing an element more than once does not change the set ($\{1, 2, 2, 3\} = \{1, 2, 3\}$). When multiplicity matters, we use *multisets* (bags); when order matters, we use *tuples* or *sequences*.
]

= Representations of Sets

We can describe a set in four main ways depending on whether it is finite, defined by a rule, or one of the standard number systems.

== Roster (Enumeration) Method
When a set is finite (or has an obvious pattern), we can list its members inside curly braces `{ }`:
- $A = {1, 2, 3, 4}$ — a set of four integers.
- $B = {a, b, {a, b, c}, {a, c}}$ — a set with four elements, two of which are themselves sets ($a in B$ and ${a, c} in B$, though $c in.not B$).
- $H = {"dog", "cat", "crocodile"}$ — a set of three animals.

== Standard Number Systems
Several number sets come up so often that they have dedicated boldface symbols:

#table(
  columns: (0.8fr, 1.8fr, 2.8fr),
  [Symbol], [Name], [Definition / Elements],
  [$bold(P)$], [Positive integers], [${1, 2, 3, dots}$],
  [$bold(N)$], [Natural numbers], [${1, 2, dots}$ (or ${0, 1, 2, dots}$ depending on convention)],
  [$bold(Z)$], [Integers], [${dots, -2, -1, 0, 1, 2, dots}$],
  [$bold(Q)$], [Rational numbers], [${p / q mid(|) p, q in bold(Z), q != 0}$],
  [$bold(R)$], [Real numbers], [All rational and irrational numbers on the number line],
  [$bold(C)$], [Complex numbers], [${a + b i mid(|) a, b in bold(R), i^2 = -1}$],
)

#pitfall(title: "Does N Start at 0 or 1?")[
  Different authors disagree on whether $0$ is a natural number. Here we follow the convention $bold(N) = {1, 2, 3, dots}$ (matching $bold(P)$), though many textbooks write $bold(N) = {0, 1, 2, dots}$ and $bold(Z)^+$ for ${1, 2, 3, dots}$. It is always good practice to check which convention a problem uses when $0$ is a boundary case.
]

== Set-Builder Notation
When listing every element is impractical, we describe a set by stating the condition an object $x$ must satisfy to belong to it:
$ S = {x mid(|) "condition on " x} $
The vertical bar $|$ is read as *"such that"*.

- *Example 1:* $A = {x mid(|) x in bold(P), x < 5}$ gives $A = {1, 2, 3, 4}$.
- *Example 2:* $B = {x mid(|) x / 2 in bold(P), 2 <= x <= 8}$ requires $x$ to be a positive even integer between $2$ and $8$, so $B = {2, 4, 6, 8}$.
- *Example 3:* $D = {x mid(|) x in bold(N), x < 5 or x > 10}$ gives the infinite set $D = {1, 2, 3, 4, 11, 12, 13, dots}$.

== Venn Diagrams
A *Venn diagram* represents sets visually. The *universal set* $U$—which contains all objects under consideration—is drawn as a bounding rectangle, and subsets of $U$ are drawn as circles inside it.

#venn-2(
  caption: "Venn diagram for U = {1, 2, ..., 8}, A = {1, 2, 3, 5}, and B = {2, 5, 6, 8}.",
  label-a: "A",
  label-b: "B",
  label-u: "U",
  mode: "overlap",
  items-a: "1, 3",
  items-inter: "2, 5",
  items-b: "6, 8",
  items-u: "Outside A and B: 4, 7",
)

#example(title: "Roster and Set-Builder Practice")[
  *1. List the members of each set:*
  - *(a)* ${x mid(|) x "is a real number such that" x^2 = 1}$:
    Solving $x^2 = 1$ over $bold(R)$ gives *${-1, 1}$*.
  - *(b)* ${x mid(|) x "is a positive integer less than" 12}$:
    *${1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}$*.
  - *(c)* ${x mid(|) x "is the square of an integer and" x < 100}$:
    The integers whose squares are under $100$ are $-9, dots, 9$, producing the squares *${0, 1, 4, 9, 16, 25, 36, 49, 64, 81}$*.
  - *(d)* ${x mid(|) x "is an integer such that" x^2 = 2}$:
    Since $plus.minus sqrt(2)$ are not integers, no integer satisfies this condition: *$emptyset$* (or *${}$*).

  *2. Describe each set using set-builder notation:*
  - *(a)* ${0, 3, 6, 9, 12}$:
    Multiples of $3$ from $0$ to $12$: *${3 k mid(|) k in bold(Z), 0 <= k <= 4}$*.
  - *(b)* ${-3, -2, -1, 0, 1, 2, 3}$:
    Integers with absolute value at most $3$: *${x in bold(Z) mid(|) -3 <= x <= 3}$*.
  - *(c)* ${m, n, o, p}$:
    *${x mid(|) x "is a lowercase English letter from" m "to" p "inclusive"}$*.
]

= Cardinality & Classification of Sets

== Cardinality and the Empty Set
#definition("Cardinality")[
  The *cardinality* of a finite set $A$, written $|A|$ or $n(A)$, is the number of distinct elements in $A$.
]

- For $A = {1, 2, 3, dots, 10}$, we have $|A| = 10$.
- A set with no elements has cardinality $0$ and is called the *empty set* (or *null set*), written $emptyset$ or ${}$:
  - $E = {x in bold(N) mid(|) x < 1} = emptyset$, so $|E| = 0$.
  - ${x mid(|) x < x} = emptyset$, since no number is strictly less than itself.
  - ${"humans who have walked on Mars"} = emptyset$.

#pitfall(title: "The Empty Set ∅ vs. The Singleton Set {∅}")[
  It is easy to mix up $emptyset$ and ${emptyset}$:
  - $emptyset = {}$ is an empty box with *zero* elements ($|emptyset| = 0$).
  - ${emptyset}$ is a box containing *one* element—namely, an empty box ($|{emptyset}| = 1$, since $emptyset in {emptyset}$).
]

== Subsets and Proper Subsets
#definition("Subset & Proper Subset")[
  Let $A$ and $B$ be sets:
  1. *Subset ($A subset.eq B$):* $A$ is a *subset* of $B$ if every element of $A$ is also an element of $B$:
     $ A subset.eq B <==> forall x (x in A -> x in B) $
     When $A subset.eq B$, we can also say $B$ is a *superset* of $A$ ($B supset.eq A$).
  2. *Proper Subset ($A subset B$):* $A$ is a *proper subset* of $B$ if $A subset.eq B$ and $A != B$ (meaning $B$ has at least one element not in $A$).
]

For instance, ${1, 2, 3} subset {1, 2, 3, 4, 5}$, and the standard number systems form a chain of subsets: $bold(N) subset.eq bold(Z) subset.eq bold(Q) subset.eq bold(R) subset.eq bold(C)$.

#venn-2(
  caption: "Venn diagram showing A as a subset of B (A ⊆ B) inside universe U.",
  label-a: "A",
  label-b: "B",
  label-u: "U",
  mode: "subset",
  shade-a: true,
  shade-b: true,
)

#concept(title: "Basic Subset Properties")[
  For any sets $A$, $B$, and $C$:
  1. *Reflexivity:* $A subset.eq A$ (every set is a subset of itself).
  2. *Empty Set:* $emptyset subset.eq A$ (the empty set is a subset of every set).
  3. *Transitivity:* If $A subset.eq B$ and $B subset.eq C$, then $A subset.eq C$.
]

#intuition(title: "Why Is ∅ a Subset of Every Set?")[
  Saying $emptyset subset.eq A$ means $forall x (x in emptyset -> x in A)$. Because $emptyset$ has no elements, the condition $x in emptyset$ is always false, making the implication vacuously true. Put another way: for $emptyset subset.eq A$ to fail, we would need to find an element inside $emptyset$ that is missing from $A$—which is impossible.
]

#example(title: "Finding Intermediate Proper Subsets")[
  *Problem:* Let $X = {1, 2, 5}$ and $Z = {1, 2, 5, 7, 8}$. Find all sets $Y$ such that $X subset Y$ and $Y subset Z$.

  *Solution:*
  - Because $X subset Y$ is a *proper* subset, $Y$ must contain $1, 2, 5$ plus at least one more element.
  - Because $Y subset Z$ is also a *proper* subset, every element of $Y$ must come from $Z$, and $Y$ cannot equal all of $Z$.
  - The remaining elements in $Z$ are $7$ and $8$. Including just one of them gives the two valid possibilities:
    $ Y_1 = {1, 2, 5, 7} quad "and" quad Y_2 = {1, 2, 5, 8} $
]

== Equal, Equivalent, and Disjoint Sets
#definition("Equal, Equivalent, and Disjoint Sets")[
  Let $A$ and $B$ be sets:
  1. *Equal Sets ($A = B$):* $A$ and $B$ contain the exact same elements:
     $ A = B <==> (A subset.eq B) and (B subset.eq A) $
     Set equality is reflexive ($A = A$), symmetric ($A = B ==> B = A$), and transitive ($A = B "and" B = C ==> A = C$). Order and repetition do not affect equality: ${3, 2, 2, 3} = {2, 3}$.
  2. *Equivalent Sets ($A tilde.op B$):* $A$ and $B$ have the same cardinality ($|A| = |B|$). For example, ${1, 2, 3} tilde.op {a, b, c}$ because both have $3$ elements, even though the sets are not equal.
  3. *Disjoint Sets ($A inter B = emptyset$, or `A // B`):* $A$ and $B$ share no elements in common.
]

#venn-2(
  caption: "Disjoint sets A = {horse, mouse} and B = {1, 3, 4} with no elements in common.",
  label-a: "A",
  label-b: "B",
  label-u: "U",
  mode: "disjoint",
  items-a: "horse, mouse",
  items-b: "1, 3, 4",
)

== Power Sets
#definition("Power Set")[
  The *power set* of $A$, written $P(A)$ or $2^A$, is the set of all subsets of $A$:
  $ P(A) = {S mid(|) S subset.eq A} $
  If $|A| = n$, then $|P(A)| = 2^n$ (since each of the $n$ elements can either be included or excluded when forming a subset).
]

- If $A = {1, 2}$, then $|P(A)| = 2^2 = 4$ and $P(A) = {emptyset, {1}, {2}, {1, 2}}$.
- For ${emptyset}$, we have $|{emptyset}| = 1$, so $P({emptyset}) = {emptyset, {emptyset}}$ has $2^1 = 2$ elements.
- If $A = {1, 2, 3}$, then $P(A)$ has $2^3 = 8$ subsets, which we can list by size:
  $ P(A) = {emptyset, {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}, {1, 2, 3}} $

#example(title: "Working with Subsets and Venn Diagrams")[
  *1. Determine whether the first set is a subset of the second, the second is a subset of the first, or neither:*
  - *(a)* People who speak English vs. people who speak English with an Australian accent:
    The second set is a proper subset of the first ($B subset A$).
  - *(b)* Fruits vs. citrus fruits:
    Every citrus fruit is a fruit, so the second set is a proper subset of the first ($B subset A$).
  - *(c)* Students studying discrete mathematics vs. students studying data structures:
    Neither is a subset of the other, since a student might take one course without taking the other.

  *2. Months without the letter R:*
  Inside the universal set $U$ of all $12$ months, the subset $M$ of months whose English names do not contain the letter `R` is:
  $ M = {"May", "June", "July", "August"} $
  The other $8$ months (`January` through `April`, and `September` through `December`) lie outside $M$ in $U - M$.

  *3. Visualizing subset relationships:*
  - If $A subset.eq B$ and $B subset.eq C$, we draw concentric circles $A$ inside $B$ inside $C$.
  - If $A subset B$ and $A subset C$, circle $A$ sits entirely inside the overlap region $B inter C$ of circles $B$ and $C$.
  - *Proof that $A subset.eq B$ and $B subset.eq C ==> A subset.eq C$:* Take any $x in A$. Since $A subset.eq B$, we have $x in B$. Then, since $B subset.eq C$, we have $x in C$. Thus every element of $A$ is in $C$, so $A subset.eq C$. $square$
]

= Set Operations

Given sets $A$ and $B$ inside a universal set $U$, we can build new sets using several standard operations.

== Intersection, Union, and Complement

#definition("Intersection, Union, and Complement")[
  1. *Intersection ($A inter B$):* Elements belonging to *both* $A$ and $B$:
     $ A inter B = {x mid(|) x in A and x in B} $
     For $A = {1, 5, 7, 9}$ and $B = {1, 2, 3}$, $A inter B = {1}$.
  2. *Union ($A union B$):* Elements belonging to $A$ *or* $B$ (or both):
     $ A union B = {x mid(|) x in A or x in B} $
     For $A = {1, 2}$ and $B = {2, 5, 6}$, $A union B = {1, 2, 5, 6}$.
  3. *Complement ($overline(A)$ or $A^c$):* Elements in the universe $U$ that are *not* in $A$:
     $ overline(A) = {x mid(|) x in U and x in.not A} = U - A $
     If $U = {1, 2, dots, 10}$ and $A = {1, 4, 5}$, then $overline(A) = {2, 3, 6, 7, 8, 9, 10}$.
]

#example(title: "Translating Everyday Statements into Set Notation")[
  Let $A$ be the set of red fruits, $B$ be the set of imported fruits, and $E$ be the set of fruits sold at Store X. How do we write *"the set of fruits sold at Store X that are red or imported"*?

  - Being "red or imported" means belonging to $A union B$.
  - Also being sold at Store X means belonging to $E$ as well.
  - Combining the two gives:
    $ E inter (A union B) quad ("or equivalently," (E inter A) union (E inter B)) $
]

== Set Difference and Symmetric Difference

#definition("Difference & Symmetric Difference")[
  1. *Difference ($A - B$ or $A without B$):* Elements in $A$ that are *not* in $B$:
     $ A - B = {x mid(|) x in A and x in.not B} = A inter overline(B) $
     If $A = {1, 2, dots, 10}$ and $B = {1, 2, 3, 11}$, then $A - B = {4, 5, dots, 10}$ (while $B - A = {11}$).
  2. *Symmetric Difference ($A plus.o B$):* Elements in $A$ or $B$, but *not both* (the set version of logical `XOR`):
     $ A plus.o B = (A union B) - (A inter B) = (A - B) union (B - A) $
     If $A = {1, 2, 3}$ and $B = {3, 5, 6}$, then $A plus.o B = {1, 2, 5, 6}$.
]

Symmetric difference is both *commutative* ($A plus.o B = B plus.o A$) and *associative* ($(A plus.o B) plus.o C = A plus.o (B plus.o C)$).

== Cartesian Product

#definition("Cartesian Product")[
  The *Cartesian product* of $A$ and $B$, written $A times B$, is the set of all *ordered pairs* $(a, b)$ with $a in A$ and $b in B$:
  $ A times B = {(a, b) mid(|) a in A and b in B} $
]

For example, if $A = {1, 2, 3}$ and $B = {a, b}$, then:
$ A times B = {(1, a), (1, b), (2, a), (2, b), (3, a), (3, b)} $

Key properties to keep in mind:
- *Cardinality:* For finite sets, $|A times B| = |A| dot |B|$.
- *Order matters:* $(a, b) != (b, a)$ unless $a = b$. Consequently, $A times B != B times A$ in general (unless $A = B$ or one of the sets is empty).
- *Empty set:* If $A = emptyset$ or $B = emptyset$, then $A times B = emptyset$.

#example(title: "Three-Way Cartesian Product")[
  Let $A = {1, 2}$, $B = {x, y, z}$, and $C = {3, 4}$. Then $|A times B times C| = 2 times 3 times 2 = 12$, and the ordered triples in $A times B times C$ are:
  $ A times B times C = { &(1, x, 3), (1, x, 4), (1, y, 3), (1, y, 4), (1, z, 3), (1, z, 4), \
    &(2, x, 3), (2, x, 4), (2, y, 3), (2, y, 4), (2, z, 3), (2, z, 4) } $
]

#example(title: "Set Operations Practice")[
  *1. Interpreting set expressions:* Let $A$ be students who live within one mile of school, and $B$ be students who walk to classes.
  - $A inter B$: Students who live within one mile of school *and* walk to classes.
  - $A union B$: Students who live within one mile of school *or* walk to classes.
  - $A - B$: Students who live within one mile of school but do *not* walk to classes.
  - $B - A$: Students who walk to classes but live more than one mile from school.

  *2. Writing set expressions:* Let $A$ be sophomores and $B$ be students taking discrete mathematics.
  - Sophomores taking discrete math: *$A inter B$*.
  - Sophomores not taking discrete math: *$A - B$* (or $A inter overline(B)$).
  - Students who are sophomores or taking discrete math: *$A union B$*.
  - Students who are either not sophomores or not taking discrete math: *$overline(A) union overline(B)$* (which equals $overline(A inter B)$).

  *3. Computing set operations:*
  - For $A = {1, 2, 3, 4, 5}$ and $B = {0, 3, 6}$:
    $A union B = {0, 1, 2, 3, 4, 5, 6}$, $quad A inter B = {3}$, $quad A - B = {1, 2, 4, 5}$, $quad B - A = {0, 6}$.
  - For $A = {a, b, c, d, e}$ and $B = {a, b, c, d, e, f, g, h}$ (note $A subset B$):
    $A union B = B$, $quad A inter B = A$, $quad A - B = emptyset$, $quad B - A = {f, g, h}$.
]

= The Principle of Inclusion–Exclusion

When two finite sets overlap, adding $|A| + |B|$ counts every element in $A inter B$ twice. Subtracting that overlap once gives the Principle of Inclusion–Exclusion.

#concept(title: "Principle of Inclusion–Exclusion")[
  For finite sets $A, B, C$:
  1. *Two Disjoint Sets ($A inter B = emptyset$):* $|A union B| = |A| + |B|$
  2. *Two General Sets:* $|A union B| = |A| + |B| - |A inter B|$
  3. *Three General Sets:*
     $ |A union B union C| = |A| + |B| + |C| - |A inter B| - |A inter C| - |B inter C| + |A inter B inter C| $
]

#intuition(title: "Why Do We Add Back |A ∩ B ∩ C|?")[
  Think about an element $x$ that belongs to all three sets $A$, $B$, and $C$:
  - It is counted $3$ times in $|A| + |B| + |C|$.
  - It is subtracted $3$ times in $-|A inter B| - |A inter C| - |B inter C|$, bringing its net count down to $0$.
  - Adding $+|A inter B inter C|$ adds it back once so that $x$ is counted *exactly once* in the union.
]

#example(title: "Three-Set Survey Problem")[
  *Problem:* In a survey of $60$ people ($|U| = 60$) regarding three magazines ($E$, $G$, and $F$):
  - $|E| = 25$, $|G| = 26$, and $|F| = 26$.
  - $|E inter F| = 9$, $|E inter G| = 11$, and $|G inter F| = 8$.
  - $8$ people read none of the three magazines ($|overline(E union G union F)| = 8$).
  How many people read all three magazines?

  *Solution:*
  1. Since $8$ of the $60$ people read none of the magazines, the number who read at least one is:
     $ |E union G union F| = 60 - 8 = 52 $
  2. Plugging the known counts into the 3-set Inclusion–Exclusion formula:
     $ 52 = (25 + 26 + 26) - (11 + 9 + 8) + |E inter G inter F| $
     $ 52 = 77 - 28 + |E inter G inter F| = 49 + |E inter G inter F| $
     $ |E inter G inter F| = 52 - 49 = 3 $
  So *3 people* read all three magazines.
]

= Laws of Set Algebra and Duality

Set operations follow algebraic rules that mirror propositional logic ($union$ acts like $or$, $inter$ acts like $and$, complement acts like $not$, $emptyset$ acts like $"False"$, and $U$ acts like $"True"$). Because of this symmetry, every law comes with a *dual*: swapping $union <-> inter$ and $emptyset <-> U$ turns any valid set identity into another valid identity.

#table(
  columns: (1.5fr, 1.8fr, 1.8fr),
  [Law Name], [Primary Identity], [Dual Identity],
  [1. Identity Laws], [$A union emptyset equiv A$], [$A inter U equiv A$],
  [2. Null / Domination Laws], [$A inter emptyset equiv emptyset$], [$A union U equiv U$],
  [3. Complement Laws], [$A union overline(A) equiv U$], [$A inter overline(A) equiv emptyset$],
  [4. Idempotent Laws], [$A union A equiv A$], [$A inter A equiv A$],
  [5. Involution Law], [$overline((overline(A))) equiv A$], [(Self-dual)],
  [6. Absorption Laws], [$A union (A inter B) equiv A$], [$A inter (A union B) equiv A$],
  [7. Commutative Laws], [$A union B equiv B union A$], [$A inter B equiv B inter A$],
  [8. Associative Laws], [$A union (B union C) equiv (A union B) union C$], [$A inter (B inter C) equiv (A inter B) inter C$],
  [9. Distributive Laws], [$A union (B inter C) equiv (A union B) inter (A union C)$], [$A inter (B union C) equiv (A inter B) union (A inter C)$],
  [10. De Morgan's Laws], [$overline(A inter B) equiv overline(A) union overline(B)$], [$overline(A union B) equiv overline(A) inter overline(B)$],
  [11. 0/1 Laws], [$overline(emptyset) equiv U$], [$overline(U) equiv emptyset$],
)

= Proving Set Identities

There are three common ways to check or prove that two set expressions always produce the same set.

== Venn Diagrams
To see why $A inter (B union C) equiv (A inter B) union (A inter C)$, we can draw two 3-circle Venn diagrams:
- On the left, shade $B union C$ and keep only the part inside $A$.
- On the right, shade $A inter B$ and $A inter C$ and combine them.
Both give the exact same shaded region. Venn diagrams are great for building intuition, while membership tables and algebraic proofs provide formal verification.

== Membership Tables
Just like truth tables in logic, a *membership table* checks every possible combination of whether an element $x$ is inside (`1`) or outside (`0`) each base set. Two expressions are equal if their columns match in every row:

#table(
  columns: (0.6fr, 0.6fr, 0.6fr, 1fr, 1.5fr, 1fr, 1fr, 2fr),
  align: center,
  [$A$], [$B$], [$C$], [$B union C$], [$bold(A inter (B union C))$], [$A inter B$], [$A inter C$], [$bold((A inter B) union (A inter C))$],
  [0], [0], [0], [0], [*0*], [0], [0], [*0*],
  [0], [0], [1], [1], [*0*], [0], [0], [*0*],
  [0], [1], [0], [1], [*0*], [0], [0], [*0*],
  [0], [1], [1], [1], [*0*], [0], [0], [*0*],
  [1], [0], [0], [0], [*0*], [0], [0], [*0*],
  [1], [0], [1], [1], [*1*], [0], [1], [*1*],
  [1], [1], [0], [1], [*1*], [1], [0], [*1*],
  [1], [1], [1], [1], [*1*], [1], [1], [*1*],
)

Since the two bold columns match across all 8 rows, $A inter (B union C) equiv (A inter B) union (A inter C)$.

== Algebraic Proofs
We can also rewrite one side step-by-step using the laws of set algebra (plus the difference rule $X - Y equiv X inter overline(Y)$).

For example, to prove $(A inter B) union (A inter overline(B)) equiv A$:
$ (A inter B) union (A inter overline(B)) &equiv A inter (B union overline(B)) quad &&"(Distributive Law)" \
  &equiv A inter U quad &&"(Complement Law)" \
  &equiv A quad &&"(Identity Law)" quad square $

#example(title: "Algebraic Proofs with Set Difference")[
  *1. Prove that $A inter (B - C) equiv (A inter B) - (A inter C)$:*

  Starting from the right-hand side:
  $ (A inter B) - (A inter C) &equiv (A inter B) inter overline((A inter C)) quad &&"(Definition of Difference)" \
    &equiv (A inter B) inter (overline(A) union overline(C)) quad &&"(De Morgan's Law)" \
    &equiv ((A inter B) inter overline(A)) union ((A inter B) inter overline(C)) quad &&"(Distributive Law)" \
    &equiv (B inter (A inter overline(A))) union (A inter (B inter overline(C))) quad &&"(Commutative & Associative Laws)" \
    &equiv (B inter emptyset) union (A inter (B inter overline(C))) quad &&"(Complement Law)" \
    &equiv emptyset union (A inter (B inter overline(C))) quad &&"(Domination Law)" \
    &equiv A inter (B inter overline(C)) quad &&"(Identity Law)" \
    &equiv A inter (B - C) quad &&"(Definition of Difference)" quad square $

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *2. Prove that $(A union B) - C equiv (A - C) union (B - C)$:*

  Starting from the left-hand side:
  $ (A union B) - C &equiv (A union B) inter overline(C) quad &&"(Definition of Difference)" \
    &equiv overline(C) inter (A union B) quad &&"(Commutative Law)" \
    &equiv (overline(C) inter A) union (overline(C) inter B) quad &&"(Distributive Law)" \
    &equiv (A inter overline(C)) union (B inter overline(C)) quad &&"(Commutative Law)" \
    &equiv (A - C) union (B - C) quad &&"(Definition of Difference)" quad square $
]
