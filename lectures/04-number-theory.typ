#import "/templates/course-note.typ": *

#let pmod(m) = $(mod #m)$

#show: lecture.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  number: 4,
  title: "Number Theory",
  subtitle: "Divisibility, the Division Algorithm, Modular Arithmetic, Prime Numbers, and the Euclidean Algorithm",
)

= Divisibility

Number theory is the branch of mathematics devoted to the study of the integers $ZZ = {dots, -2, -1, 0, 1, 2, dots}$ and their arithmetic properties. While historically regarded as a purely theoretical discipline, number theory forms the backbone of modern computer science—powering public-key cryptography (such as RSA and Diffie-Hellman), cryptographic hash functions, pseudorandom number generation, error-correcting codes, and hash table indexing.

The most basic relationship between two integers is whether one divides the other evenly without leaving a remainder.

#definition("Divisibility")[
  Let $a$ and $b$ be integers with $a != 0$. We say that *$a$ divides $b$* if there exists an integer $c in ZZ$ such that:
  $ b = a c $
  - When $a$ divides $b$, we call $a$ a *factor* or *divisor* of $b$, and we call $b$ a *multiple* of $a$.
  - Notation:
    - $a divides b$ denotes that $a$ divides $b$.
    - $a divides.not b$ denotes that $a$ does not divide $b$.
]

#intuition(title: "Why Divisibility Uses Multiplication Instead of Fractions")[
  Notice that the definition $b = a c$ (for some $c in ZZ$) is written entirely using integer multiplication rather than division ($b / a$). When working with integers, we want to stay inside $ZZ$ without introducing fractions or floating-point numbers. Asking whether $a divides b$ is simply asking whether the equation $a x = b$ has an integer solution $x in ZZ$.
]

#example(title: "Basic Examples of Divisibility")[
  1. *Does $5$ divide $10$?*
     Yes, $5 divides 10$ because there is an integer $c = 2 in ZZ$ such that $10 = 5 dot 2$.
  2. *Does $3$ divide $6$?*
     Yes, $3 divides 6$ because there is an integer $c = 2 in ZZ$ such that $6 = 3 dot 2$.
  3. *Does $2$ divide $9$?*
     No, $2 divides.not 9$ because no integer $c in ZZ$ satisfies $9 = 2 c$ (since $2 dot 4 = 8 < 9 < 10 = 2 dot 5$).
]

== Algebraic Properties of Divisibility

Divisibility obeys three foundational rules that let us combine, scale, and chain divisibility relationships without computing explicit quotients.

#concept(title: "Theorem: Fundamental Properties of Divisibility")[
  Let $a$, $b$, and $c$ be integers, where $a != 0$. Then:
  1. *Additive Closure*: If $a divides b$ and $a divides c$, then $a divides (b + c)$.
  2. *Scaling by Any Integer*: If $a divides b$, then $a divides b c$ for all integers $c in ZZ$.
  3. *Transitivity*: If $a divides b$ and $b divides c$ (with $b != 0$), then $a divides c$.

  *Proof:*
  - *(i)* Suppose $a divides b$ and $a divides c$. By definition, there exist integers $s, t in ZZ$ such that $b = a s$ and $c = a t$. Adding these two equations gives:
    $ b + c = a s + a t = a(s + t) $
    Since $s + t in ZZ$, it follows that $a divides (b + c)$.
  - *(ii)* Suppose $a divides b$. Then there exists $k in ZZ$ such that $b = a k$. Multiplying both sides by any integer $c in ZZ$ gives:
    $ b c = (a k) c = a (k c) $
    Since $k c in ZZ$, we conclude that $a divides b c$.
  - *(iii)* Suppose $a divides b$ and $b divides c$. Then there exist integers $s, t in ZZ$ such that $b = a s$ and $c = b t$. Substituting $b = a s$ into the second equation gives:
    $ c = (a s) t = a (s t) $
    Since $s t in ZZ$, we conclude that $a divides c$. $square$
]

Combining parts (i) and (ii) immediately gives a useful *Linear Combination Property*: if $a divides b$ and $a divides c$, then $a divides (m b + n c)$ for any integers $m, n in ZZ$.

#example(title: "Applying the Divisibility Properties")[
  - *Property (i)*: Since $2 divides 6$ and $2 divides 4$, we immediately know that $2 divides (6 + 4)$, or $2 divides 10$.
  - *Property (ii)*: Since $5 divides 15$, multiplying $15$ by $c = 4$ guarantees that $5 divides (15 dot 4)$, or $5 divides 60$.
  - *Property (iii)*: Since $7 divides 21$ and $21 divides 42$, transitivity guarantees that $7 divides 42$.
]

#example(title: "Practice Problems: Testing and Applying Divisibility")[
  *Part A — Determine whether $a divides b$ for the following pairs:*
  1. $a = 3, b = 10$:
     We check whether there is an integer $c in ZZ$ such that $10 = 3 c$. Since $3 dot 3 = 9$ and $3 dot 4 = 12$, no such integer exists ($10 / 3 = 3.33dots in.not ZZ$). Therefore, *$3 divides.not 10$*.
  2. $a = 19, b = 95$:
     We check whether $95$ is an integer multiple of $19$. Since $95 = 19 dot 5$ and $5 in ZZ$, we conclude that *$19 divides 95$*.

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Part B — Verify the following using the divisibility properties:*
  1. *If $8 divides 32$ and $8 divides 64$, does $8 divides 96$?*
     *Yes.* By Property (i) (with $a = 8$, $b = 32$, and $c = 64$), since $8 divides 32$ and $8 divides 64$, we must have $8 divides (32 + 64)$. Since $32 + 64 = 96$, it follows that *$8 divides 96$* (indeed, $96 = 8 dot 12$).
  2. *If $16 divides 80$, does $16 divides 240$?*
     *Yes.* Notice that $240 = 80 dot 3$. By Property (ii) (with $a = 16$, $b = 80$, and multiplier $c = 3 in ZZ$), since $16 divides 80$, we have $16 divides (80 dot 3)$, which means *$16 divides 240$* (indeed, $240 = 16 dot 15$).
  3. *If $8 divides 24$ and $24 divides 72$, does $8 divides 72$?*
     *Yes.* By Property (iii) (transitivity, with $a = 8$, $b = 24$, and $c = 72$), since $8 divides 24$ and $24 divides 72$, it follows directly that *$8 divides 72$* (indeed, $72 = 8 dot 9$).
]

#pitfall(title: "The Converse of Properties (i) and (ii) Does Not Hold")[
  Be careful not to reverse the implications in the divisibility theorem:
  - *Sum trap*: $a divides (b + c)$ does *not* imply that $a divides b$ and $a divides c$. For instance, $5 divides (2 + 3)$, yet $5 divides.not 2$ and $5 divides.not 3$.
  - *Product trap*: $a divides b c$ does *not* generally imply $a divides b$ or $a divides c$ when $a$ is composite. For example, $6 divides (3 dot 4)$ because $6 divides 12$, yet $6 divides.not 3$ and $6 divides.not 4$. (This implication only holds when $a$ is a prime number, a result known as Euclid's Lemma.)
]

= The Division Algorithm & Modulo Concept

When a positive integer $d > 0$ does not divide $a$ evenly, integer division yields both an integer quotient and a strictly smaller non-negative remainder.

#concept(title: "Theorem: The Division Algorithm")[
  Let $a$ be an integer and $d$ be a positive integer ($d in ZZ^+$). Then there exist *unique* integers $q$ and $r$, with $0 <= r < d$, such that:
  $ a = d q + r $
  The four parts of this equation have standard names:
  - $a$: *dividend*
  - $d$: *divisor* (strictly positive: $d > 0$)
  - $q$: *quotient*, denoted $q = a div d = floor(a / d)$
  - $r$: *remainder*, denoted $r = a mod d$, satisfying $0 <= r < d$
]

#flow-chain(
  caption: "Decomposition of an integer dividend a by positive divisor d via the Division Algorithm.",
  ("Inputs", "a in Z, d in Z+"),
  ("Integer Division", "q = floor(a / d)"),
  ("Remainder Extraction", "r = a - d * q"),
  ("Unique Form", "a = d*q + r (0 <= r < d)"),
)

#example(title: "Division Algorithm Decompositions")[
  1. $10 = 4 dot 2 + 2$: Dividing $a = 10$ by $d = 4$ gives quotient $q = 2$ and remainder $r = 2$ (with $0 <= 2 < 4$).
  2. $90 = 7 dot 12 + 6$: Dividing $a = 90$ by $d = 7$ gives quotient $q = 12$ and remainder $r = 6$ (with $0 <= 6 < 7$).
  3. $25 = 6 dot 4 + 1$: Dividing $a = 25$ by $d = 6$ gives quotient $q = 4$ and remainder $r = 1$ (with $0 <= 1 < 6$).
]

#example(title: "Practice Problems: Expressing Numbers as a = d * q + r")[
  *Problem:* Write each pair in the form $a = d dot q + r$ with $0 <= r < d$:
  1. *$a = 91, d = 36$*:
     Dividing $91$ by $36$, the largest multiple of $36$ not exceeding $91$ is $36 dot 2 = 72$. Subtracting gives $r = 91 - 72 = 19$ (and $0 <= 19 < 36$). Thus:
     $ 91 = 36 dot 2 + 19 quad (q = 2, thin r = 19) $
  2. *$a = 65, d = 12$*:
     Dividing $65$ by $12$, the largest multiple of $12$ not exceeding $65$ is $12 dot 5 = 60$. Subtracting gives $r = 65 - 60 = 5$ (and $0 <= 5 < 12$). Thus:
     $ 65 = 12 dot 5 + 5 quad (q = 5, thin r = 5) $
  3. *$a = 121, d = 10$*:
     Dividing $121$ by $10$, the largest multiple of $10$ not exceeding $121$ is $10 dot 12 = 120$. Subtracting gives $r = 121 - 120 = 1$ (and $0 <= 1 < 10$). Thus:
     $ 121 = 10 dot 12 + 1 quad (q = 12, thin r = 1) $
]

#pitfall(title: "Negative Dividends in the Division Algorithm")[
  In the Division Algorithm, the remainder $r$ must *always* be non-negative: $0 <= r < d$.
  For example, if $a = -11$ and $d = 3$, it is *incorrect* to write $-11 = 3(-3) - 2$ because $r = -2 < 0$ violates $0 <= r < d$. Instead, we round the quotient *down* to $q = floor(-11 / 3) = -4$:
  $ -11 = 3(-4) + 1 quad ==> quad q = -4, thin r = -11 mod 3 = 1 $
  Note that in C, C++, and Java, `-11 % 3` evaluates to `-2` (truncated division toward zero), whereas Python's `-11 % 3` evaluates to `1` (true mathematical modulo). In discrete mathematics, $r$ is always in the range $0 <= r < d$.
]

== The Modulo Operator and Congruence Relation

From the Division Algorithm $a = d q + r$ ($0 <= r < d$), the remainder $r$ can be written using modulo notation:
$ r = a mod d quad "or as a congruence" quad r equiv a pmod(d) $

#example(title: "Modulo Remainder Examples")[
  - $2 equiv 5 mod 3$ because $5 = 3 dot 1 + 2$, so the remainder of $5$ divided by $3$ is $r = 2$.
  - $1 equiv 10 mod 3$ because $10 = 3 dot 3 + 1$, so the remainder of $10$ divided by $3$ is $r = 1$.
  - $15 equiv 35 mod 20$ because $35 = 20 dot 1 + 15$, so the remainder of $35$ divided by $20$ is $r = 15$.
]

= Modular Arithmetic

Often in computer science and mathematics, we care only about the remainder left when an integer is divided by a fixed positive integer $m$, called the *modulus*. For example, a 12-hour or 24-hour clock wraps around modulo $12$ or $24$, and 32-bit unsigned integer registers wrap around modulo $2^(32)$.

#definition("Congruence Modulo m")[
  Let $a$ and $b$ be integers, and let $m$ be a positive integer ($m in ZZ^+$). We say that *$a$ is congruent to $b$ modulo $m$*, written:
  $ a equiv b pmod(m) $
  if and only if $m$ divides their difference, i.e., $m divides (a - b)$ (or equivalently, $a = b + k m$ for some $k in ZZ$). If $m divides.not (a - b)$, we write $a equiv.not b pmod(m)$.
]

#concept(title: "Theorem: Congruence and Equal Remainders")[
  Let $a$ and $b$ be integers, and let $m$ be a positive integer. Then:
  $ a equiv b pmod(m) quad <==> quad a mod m = b mod m $
  That is, two integers are congruent modulo $m$ if and only if they leave the *exact same remainder* when divided by $m$.
]

#example(title: "Congruence Examples")[
  - $5 equiv 15 pmod(10)$ because $5 mod 10 = 5$ and $15 mod 10 = 5$ (and $10 divides (5 - 15) = -10$).
  - $6 equiv 21 pmod(15)$ because $6 mod 15 = 6$ and $21 mod 15 = 6$ (and $15 divides (6 - 21) = -15$).
]

#intuition(title: "Operator vs. Relation: a mod m vs. a ≡ b (mod m)")[
  It helps to distinguish between the binary *operator* $a mod m$ and the equivalence *relation* $a equiv b pmod(m)$:
  - *$a mod m$ is a function* from $ZZ times ZZ^+$ to ${0, 1, dots, m - 1}$ that returns a *single remainder* in $[0, m-1]$. For example, $15 mod 10 = 5$.
  - *$a equiv b pmod(m)$ is a relation* on $ZZ$ stating that $a$ and $b$ belong to the same remainder class. Thus $5 equiv 15 equiv 25 equiv -5 pmod(10)$ are all true at the same time.
]

== Arithmetic Operations Modulo $m$

A very useful property of congruence modulo $m$ is that it is compatible with addition, subtraction, and multiplication. This allows us to reduce intermediate results modulo $m$ *before* adding or multiplying them, keeping numbers small and avoiding overflow.

#concept(title: "Theorem & Corollary: Modular Addition and Multiplication")[
  *Theorem:* Let $m$ be a positive integer. If $a equiv b pmod(m)$ and $c equiv d pmod(m)$, then:
  $ a + c equiv b + d pmod(m) quad "and" quad a c equiv b d pmod(m) $

  *Proof:* Since $a equiv b pmod(m)$ and $c equiv d pmod(m)$, there exist integers $s, t in ZZ$ such that $a = b + s m$ and $c = d + t m$. Then:
  - $a + c = (b + d) + (s + t) m ==> a + c equiv b + d pmod(m)$.
  - $a c = (b + s m)(d + t m) = b d + m(b t + s d + s t m) ==> a c equiv b d pmod(m)$. $square$

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Corollary:* Let $m$ be a positive integer and let $a$ and $b$ be integers. Then:
  $ (a + b) mod m = ((a mod m) + (b mod m)) mod m $
  $ a b mod m = ((a mod m)(b mod m)) mod m $
]

#example(title: "Applying Modular Arithmetic")[
  1. *Combining Congruences*:
     Given $2 equiv 5 pmod(3)$ and $1 equiv 4 pmod(3)$:
     - Adding both sides gives $2 + 1 equiv 5 + 4 pmod(3)$, i.e., *$3 equiv 9 pmod(3)$* (both leave remainder $0$).
     - Multiplying both sides gives $2 dot 1 equiv 5 dot 4 pmod(3)$, i.e., *$2 equiv 20 pmod(3)$* (both leave remainder $2$, since $20 = 3 dot 6 + 2$).

  2. *Modular Sum Reduction*:
     Compute $123 mod 11$ by splitting $123 = 100 + 23$:
     $ 123 mod 11 &= ((100 mod 11) + (23 mod 11)) mod 11 \
                  &= (1 + 1) mod 11 = 2 $
     (Check: $123 = 11 dot 11 + 2$.)

  3. *Modular Product Reduction*:
     Compute $450 mod 21$ by factoring $450 = 90 dot 5$:
     $ 450 mod 21 &= ((90 mod 21)(5 mod 21)) mod 21 \
                  &= (6 dot 5) mod 21 = 30 mod 21 = 9 $
     (Check: $450 = 21 dot 21 + 9$.)
]

#pitfall(title: "Modular Division Cannot Be Done Directly")[
  While addition, subtraction, and multiplication work cleanly modulo $m$, *dividing (canceling a common factor) does not generally work*:
  $ a c equiv b c pmod(m) quad arrow.r.double.not quad a equiv b pmod(m) $
  For example, $2 dot 3 equiv 4 dot 3 pmod(6)$ (since $6 equiv 12 pmod(6)$), but dividing both sides by $3$ gives $2 equiv 4 pmod(6)$, which is *false*. You can only cancel a common factor $c$ modulo $m$ when $gcd(c, m) = 1$.
]

= Prime Numbers & Primality Testing

Every integer greater than $1$ is classified as either prime or composite based on its positive divisors.

#definition("Prime and Composite Numbers")[
  - An integer $p > 1$ is called *prime* if and only if its only positive factors are $1$ and $p$ itself:
    $ p "is prime" <==> (p > 1) and forall a in ZZ^+ (a divides p ==> (a = 1 or a = p)) $
  - An integer $n > 1$ that is not prime is called *composite*. Equivalently, $n > 1$ is composite if and only if there exist integers $a, b$ such that $n = a b$ with $1 < a < n$ and $1 < b < n$.
  - *Note*: The integer $1$ is *neither prime nor composite*. The first several primes are $2, 3, 5, 7, 11, 13, 17, 19, 23, 29, dots$
]

== The Fundamental Theorem of Arithmetic

Prime numbers serve as the multiplicative building blocks for all positive integers.

#concept(title: "Theorem: The Fundamental Theorem of Arithmetic")[
  Every integer greater than $1$ can be written *uniquely* as a prime or as the product of two or more primes, where the prime factors are written in order of nondecreasing size:
  $ n = p_1^(a_1) p_2^(a_2) dots.c p_k^(a_k) quad "with" p_1 < p_2 < dots < p_k "primes and" a_i in ZZ^+ $
]

#example(title: "Prime Factorizations of Integers")[
  Find the prime factorizations of $100$, $641$, $999$, and $1024$:
  - $100 = 2 dot 2 dot 5 dot 5 = 2^2 dot 5^2$
  - $641 = 641$ (a prime number)
  - $999 = 27 dot 37 = 3 dot 3 dot 3 dot 37 = 3^3 dot 37$
  - $1024 = 2 dot 2 dot 2 dot 2 dot 2 dot 2 dot 2 dot 2 dot 2 dot 2 = 2^(10)$
]

== Primality Testing via the $sqrt(n)$ Bound

To check whether an integer $n$ (such as $641$ above) is prime, a naive approach would test all integers from $2$ up to $n - 1$. However, the following theorem cuts the work from $O(n)$ down to $O(sqrt(n))$: we only need to test *prime* divisors up to $floor(sqrt(n))$.

#concept(title: "Theorem: Prime Divisor Bound for Composite Numbers")[
  *Theorem:* If $n$ is a composite integer, then $n$ has a prime divisor less than or equal to $sqrt(n)$.

  *Proof:* Since $n$ is composite, we can write $n = a b$ where $1 < a < n$ and $1 < b < n$. Without loss of generality, assume $a <= b$. Multiplying both sides of $a <= b$ by $a$ gives:
  $ a^2 <= a b = n quad ==> quad a <= sqrt(n) $
  Since $a > 1$, by the Fundamental Theorem of Arithmetic, $a$ is either prime itself or has a prime factor $p <= a$. By transitivity of divisibility ($p divides a$ and $a divides n$), $p divides n$ and $p <= a <= sqrt(n)$. $square$

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *Contrapositive — Primality Test:* If an integer $n > 1$ has *no prime factor* less than or equal to $sqrt(n)$, then $n$ is *prime*.
]

#example(title: "Primality Testing Walkthrough")[
  1. *Testing $n = 21$*:
     We have $sqrt(21) approx 4.6$. The primes less than or equal to $4.6$ are $2$ and $3$. Checking divisibility: $2 divides.not 21$, but *$3 divides 21$* (since $21 = 3 dot 7$). Thus $n = 21$ is composite and has a prime factor $3 <= sqrt(21)$.

  2. *Testing $n = 19$*:
     We have $sqrt(19) approx 4.36$. The only primes less than or equal to $4.36$ are $2$ and $3$.
     - Does $2 divides 19$? No ($19 = 2 dot 9 + 1$).
     - Does $3 divides 19$? No ($19 = 3 dot 6 + 1$).
     Because $19$ has no prime factor $<= sqrt(19)$, *$19$ is prime*.

  3. *Testing $n = 641$*:
     Since $sqrt(641) approx 25.31$, we test all primes $p <= 25$: $p in {2, 3, 5, 7, 11, 13, 17, 19, 23}$. None of these nine primes divide $641$, confirming that *$641$ is prime*.
]

= Greatest Common Divisor & The Euclidean Algorithm

#definition("Greatest Common Divisor (GCD)")[
  Let $a$ and $b$ be integers, not both zero. The largest integer $d$ such that $d divides a$ and $d divides b$ is called the *greatest common divisor* of $a$ and $b$, denoted $gcd(a, b)$.

  - *Relatively Prime (Coprime) Integers*: Two integers $a$ and $b$ are called *relatively prime* if their greatest common divisor is $1$, i.e., $gcd(a, b) = 1$.
]

#example(title: "GCD and Relatively Prime Examples")[
  - *$gcd(6, 9) = 3$*: The positive divisors of $6$ are ${1, 2, 3, 6}$ and of $9$ are ${1, 3, 9}$. Their common divisors are ${1, 3}$, and the largest is $3$.
  - *$gcd(24, 36) = 12$*: The common positive divisors of $24$ and $36$ are ${1, 2, 3, 4, 6, 12}$, so the greatest is $12$.
  - *$5$ and $7$ are relatively prime*: $gcd(5, 7) = 1$.
  - *$12$ and $25$ are relatively prime*: Even though both $12 = 2^2 dot 3$ and $25 = 5^2$ are composite, they share no prime factors, so $gcd(12, 25) = 1$.
]

#intuition(title: "Finding GCD and LCM from Prime Factorizations")[
  When the prime factorizations of $a$ and $b$ are already known:
  $ a = p_1^(a_1) p_2^(a_2) dots.c p_n^(a_n), quad b = p_1^(b_1) p_2^(b_2) dots.c p_n^(b_n) quad (a_i, b_i >= 0) $
  we can find both the Greatest Common Divisor ($gcd$) and the Least Common Multiple ($"lcm"$) by taking the minimum and maximum exponents of each prime:
  $ gcd(a, b) = p_1^(min(a_1, b_1)) p_2^(min(a_2, b_2)) dots.c p_n^(min(a_n, b_n)), quad "lcm"(a, b) = p_1^(max(a_1, b_1)) p_2^(max(a_2, b_2)) dots.c p_n^(max(a_n, b_n)) $
  Since $min(x, y) + max(x, y) = x + y$, these satisfy the useful identity *$a b = gcd(a, b) dot "lcm"(a, b)$*.
  However, factoring large integers is computationally expensive. Instead, the *Euclidean Algorithm* computes $gcd(a, b)$ in $O(log min(a, b))$ division steps without factoring either number.
]

== The Euclidean Algorithm

The Euclidean Algorithm is based on a simple observation: if $a = b q + r$, then any common divisor of $a$ and $b$ also divides $r = a - b q$, and vice versa. Therefore:
$ gcd(a, b) = gcd(b, a mod b) $

#algo-box(
  title: "The Euclidean Algorithm",
  input: [Positive integers $a$ and $b$ with $a > b > 0$.],
  output: [The greatest common divisor $gcd(a, b)$.],
  complexity: "O(log b) division steps",
)[
  1. Write $a$ and $b$ in the Division Algorithm form:
     $ a = b dot q + r quad "where" 0 <= r < b $
  2. If $r = 0$, terminate and output $gcd = b$.
  3. Otherwise, replace $a <- b$ and $b <- r$, and repeat from Step 1 until $r$ becomes $0$.
  4. The $gcd(a, b)$ is the value of $b$ when $r = 0$ (equivalently, the *last nonzero remainder*).
]

#example(title: "Euclidean Algorithm Trace: gcd(414, 662)")[
  *Problem:* Find the greatest common divisor of $414$ and $662$ using the Euclidean algorithm.

  *Solution:* Setting $a = 662$ and $b = 414$, we repeatedly apply the Division Algorithm:
  #table(
    columns: (auto, 1fr, auto, auto, auto),
    align: (center, left, center, center, left),
    [Step], [Division Equation ($a = b dot q + r$)], [$a$], [$b$], [Remainder $r$ & Next Step],
    [1], [$662 = 414 dot 1 + 248$], [$662$], [$414$], [$r = 248 != 0 ==> (a, b) <- (414, 248)$],
    [2], [$414 = 248 dot 1 + 166$], [$414$], [$248$], [$r = 166 != 0 ==> (a, b) <- (248, 166)$],
    [3], [$248 = 166 dot 1 + 82$],  [$248$], [$166$], [$r = 82 != 0 ==> (a, b) <- (166, 82)$],
    [4], [$166 = 82 dot 2 + 2$],    [$166$], [$82$],  [$r = 2 != 0 ==> (a, b) <- (82, 2)$],
    [5], [$82 = 2 dot 41 + 0$],     [$82$],  [$2$],   [$r = 0 ==> "Stop! Output" b = 2$],
  )
  Hence, *$gcd(414, 662) = 2$*, because $2$ is the last nonzero remainder.
]

= Worked Practice Exercises

Below are complete worked solutions to the practice problems from Kenneth H. Rosen's *Discrete Mathematics and Its Applications* (Section 4.1 on Divisibility and Modular Arithmetic, and Section 4.3 on Primes and Greatest Common Divisors).

#example(title: "Divisibility and Modular Arithmetic (Section 4.1, Nos. 1, 9, 10, 11, 12, 20, 30)")[
  *1. Does $17$ divide each of these numbers?*
  - *a) $68$*: Yes, $17 divides 68$ because $68 = 17 dot 4$.
  - *b) $84$*: No, $17 divides.not 84$ because $84 = 17 dot 4 + 16$ ($r = 16 != 0$).
  - *c) $357$*: Yes, $17 divides 357$ because $357 = 17 dot 21$.
  - *d) $1001$*: No, $17 divides.not 1001$ because $1001 = 17 dot 58 + 15$ ($r = 15 != 0$).

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *9–12. Find the quotient $q$ and remainder $r$ when:*
  #table(
    columns: (auto, 1fr, 1.2fr, auto, auto),
    align: (center, left, left, center, center),
    [No.], [Problem ($a$ divided by $d$)], [Division Algorithm ($a = d q + r, thin 0 <= r < d$)], [Quotient $q$], [Remainder $r$],
    [9a], [$19$ divided by $7$], [$19 = 7 dot 2 + 5$], [$2$], [$5$],
    [9b], [$-111$ divided by $11$], [$-111 = 11 dot (-11) + 10$], [$-11$], [$10$],
    [9c], [$789$ divided by $23$], [$789 = 23 dot 34 + 7$], [$34$], [$7$],
    [9d], [$1001$ divided by $13$], [$1001 = 13 dot 77 + 0$], [$77$], [$0$],
    [9e], [$0$ divided by $19$], [$0 = 19 dot 0 + 0$], [$0$], [$0$],
    [9f], [$3$ divided by $5$], [$3 = 5 dot 0 + 3$], [$0$], [$3$],
    [9g], [$-1$ divided by $3$], [$-1 = 3 dot (-1) + 2$], [$-1$], [$2$],
    [9h], [$4$ divided by $1$], [$4 = 1 dot 4 + 0$], [$4$], [$0$],
    [10a], [$44$ divided by $8$], [$44 = 8 dot 5 + 4$], [$5$], [$4$],
    [10b], [$777$ divided by $21$], [$777 = 21 dot 37 + 0$], [$37$], [$0$],
    [10c], [$-123$ divided by $19$], [$-123 = 19 dot (-7) + 10$], [$-7$], [$10$],
    [10d], [$-1$ divided by $23$], [$-1 = 23 dot (-1) + 22$], [$-1$], [$22$],
    [10e], [$-2002$ divided by $87$], [$-2002 = 87 dot (-24) + 86$], [$-24$], [$86$],
    [10f], [$0$ divided by $17$], [$0 = 17 dot 0 + 0$], [$0$], [$0$],
    [10g], [$1,234,567$ divided by $1001$], [$1,234,567 = 1001 dot 1233 + 334$], [$1233$], [$334$],
    [10h], [$-100$ divided by $101$], [$-100 = 101 dot (-1) + 1$], [$-1$], [$1$],
  )
  - *11. Find $-101 mod 13$ and $199 mod 19$*:
    Since $-101 = 13 dot (-8) + 3$, we have $-101 mod 13 = 3$. Since $199 = 19 dot 10 + 9$, we have $199 mod 19 = 9$.
  - *12. Find $-88 mod 13$ and $288 mod 17$*:
    Since $-88 = 13 dot (-7) + 3$, we have $-88 mod 13 = 3$. Since $288 = 17 dot 16 + 16$, we have $288 mod 17 = 16$.

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *20. Determine whether each of these integers is congruent to $5$ modulo $17$:*
  - *a) $80$*: $80 - 5 = 75$, and $17 divides.not 75$ ($75 = 17 dot 4 + 7$). Thus $80 equiv.not 5 pmod(17)$ (in fact, $80 mod 17 = 12$).
  - *b) $103$*: $103 - 5 = 98$, and $17 divides.not 98$ ($98 = 17 dot 5 + 13$). Thus $103 equiv.not 5 pmod(17)$ (in fact, $103 mod 17 = 1$).
  - *c) $-29$*: $-29 - 5 = -34 = 17 dot (-2)$, so $17 divides (-29 - 5)$. Thus *$-29 equiv 5 pmod(17)$*.
  - *d) $-122$*: $-122 - 5 = -127$, and $17 divides.not -127$ ($-127 = 17(-8) + 9$). Thus $-122 equiv.not 5 pmod(17)$.

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *30. Evaluate each of these quantities using modular arithmetic properties:*
  - *a) $(-133 mod 23 + 261 mod 23) mod 23$*:
    This simplifies to $(-133 + 261) mod 23 = 128 mod 23$. Since $128 = 23 dot 5 + 13$, the result is *$13$*.
  - *b) $(457 mod 23 dot 182 mod 23) mod 23$*:
    First reduce each factor: $457 = 23 dot 19 + 20 ==> 457 mod 23 = 20 equiv -3 pmod(23)$, and $182 = 23 dot 7 + 21 ==> 182 mod 23 = 21 equiv -2 pmod(23)$.
    Multiplying gives $(20 dot 21) mod 23 = ((-3)(-2)) mod 23 = 6 mod 23 =$ *$6$*.
  - *c) $(99^2 mod 32)^3 mod 15$*:
    First compute $99 mod 32 = 3$ (since $99 = 32 dot 3 + 3$). Thus $99^2 mod 32 = 3^2 mod 32 = 9$.
    Next, evaluate $9^3 mod 15$: since $9^2 = 81 = 15 dot 5 + 6 ==> 9^2 mod 15 = 6$, we have $9^3 mod 15 = (6 dot 9) mod 15 = 54 mod 15 =$ *$9$*.
  - *d) $((34 dot 102) mod 27)^2 mod 13$*:
    Reduce modulo $27$: $34 mod 27 = 7$ and $102 = 27 dot 3 + 21 ==> 102 mod 27 = 21 equiv -6 pmod(27)$.
    Thus $(34 dot 102) mod 27 = (7 dot (-6)) mod 27 = -42 mod 27 = 12$.
    Finally, $12^2 mod 13 = (-1)^2 mod 13 =$ *$1$*.
]

#example(title: "Primes and Greatest Common Divisors (Section 4.3, Nos. 1, 14, 15, 32)")[
  *1. Determine whether each of these integers is prime:*
  - *a) $21$*: Composite, since $3 divides 21$ ($21 = 3 dot 7$).
  - *b) $29$*: We test primes $p <= sqrt(29) approx 5.38$, i.e., $p in {2, 3, 5}$. Since $2 divides.not 29$, $3 divides.not 29$, and $5 divides.not 29$, *$29$ is prime*.
  - *c) $71$*: We test primes $p <= sqrt(71) approx 8.42$, i.e., $p in {2, 3, 5, 7}$. None divide $71$, so *$71$ is prime*.
  - *d) $97$*: We test primes $p <= sqrt(97) approx 9.85$, i.e., $p in {2, 3, 5, 7}$. None divide $97$, so *$97$ is prime*.
  - *e) $111$*: Composite. The sum of its digits is $1 + 1 + 1 = 3$, so $3 divides 111$ ($111 = 3 dot 37$).
  - *f) $143$*: We test primes $p <= sqrt(143) approx 11.95$, i.e., $p in {2, 3, 5, 7, 11}$. Checking $11$: $143 = 11 dot 13$, so *$143$ is composite*.

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *14. Which positive integers less than $12$ are relatively prime to $12$?*
  Since $12 = 2^2 dot 3$, an integer $k$ satisfies $gcd(k, 12) = 1$ if and only if $2 divides.not k$ and $3 divides.not k$. Checking $k in {1, 2, dots, 11}$:
  - Multiples of $2$: $2, 4, 6, 8, 10$ (excluded)
  - Multiples of $3$: $3, 6, 9$ (excluded)
  The remaining integers relatively prime to $12$ are *$1, 5, 7, 11$*.

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *15. Determine whether the following sets of integers are pairwise relatively prime:*
  - *a) $21, 34, 55$*: Prime factorizations are $21 = 3 dot 7$, $34 = 2 dot 17$, and $55 = 5 dot 11$. Since no two numbers share a prime factor, $gcd(21, 34) = gcd(21, 55) = gcd(34, 55) = 1$. *Yes, pairwise relatively prime.*
  - *b) $14, 17, 85$*: Although $gcd(14, 17) = 1$ and $gcd(14, 85) = 1$, we have $gcd(17, 85) = 17 != 1$ (since $85 = 5 dot 17$). *No, not pairwise relatively prime.*
  - *c) $25, 41, 49, 64$*: Prime factorizations are $25 = 5^2$, $41 = 41$, $49 = 7^2$, and $64 = 2^6$. All prime bases ($5, 41, 7, 2$) are distinct. *Yes, pairwise relatively prime.*
  - *d) $17, 18, 19, 23$*: Since $17, 19, 23$ are distinct primes that do not divide $18 = 2 dot 3^2$, every pair has $gcd = 1$. *Yes, pairwise relatively prime.*

  #line(length: 100%, stroke: 0.4pt + palette.rule)

  *32. Use the Euclidean algorithm to find the greatest common divisor of each pair:*
  - *a) $gcd(1, 5)$*:
    $5 = 1 dot 5 + 0 ==> $ *$gcd(1, 5) = 1$*.
  - *b) $gcd(100, 101)$*:
    $101 = 100 dot 1 + 1$, then $100 = 1 dot 100 + 0 ==> $ *$gcd(100, 101) = 1$*.
  - *c) $gcd(123, 277)$*:
    - $277 = 123 dot 2 + 31$
    - $123 = 31 dot 3 + 30$
    - $31 = 30 dot 1 + 1$
    - $30 = 1 dot 30 + 0$
    Hence *$gcd(123, 277) = 1$*.
  - *d) $gcd(1529, 14039)$*:
    - $14039 = 1529 dot 9 + 278$
    - $1529 = 278 dot 5 + 139$
    - $278 = 139 dot 2 + 0$
    Hence *$gcd(1529, 14039) = 139$*.
  - *e) $gcd(1529, 14038)$*:
    - $14038 = 1529 dot 9 + 277$
    - $1529 = 277 dot 5 + 144$
    - $277 = 144 dot 1 + 133$
    - $144 = 133 dot 1 + 11$
    - $133 = 11 dot 12 + 1$
    - $11 = 1 dot 11 + 0$
    Hence *$gcd(1529, 14038) = 1$*.
  - *f) $gcd(11111, 111111)$*:
    - $111111 = 11111 dot 10 + 1$
    - $11111 = 1 dot 11111 + 0$
    Hence *$gcd(11111, 111111) = 1$*.
]
