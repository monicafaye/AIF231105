# AIF231105 — Discrete Mathematics

Comprehensive, textbook-style course notes for **AIF231105 — Discrete Mathematics**, written in **Typst**. Every lecture includes formal definitions, intuition callouts, native diagrams, algebraic proofs, and fully worked practice problems.

---

## Full Course Compendium

- **[Download Complete Course Book (`AIF231105-book.pdf`)](./build/AIF231105-book.pdf)** — Unified 69-page textbook compendium containing all 6 lectures with a complete Table of Contents and chapter-numbered sections (`main.typ`).

---

## Lectures & Topics Covered

| # | Lecture Title | Core Topics Covered | Standalone PDF | Typst Source |
| :-: | :--- | :--- | :---: | :---: |
| **01** | **Set Theory** | Roster & set-builder notation, standard number systems, Venn diagrams, cardinality, subsets, power sets, set operations ($\cap, \cup, -, \oplus, \times$), Principle of Inclusion–Exclusion, set algebra laws, duality, and identity proofs (membership tables & algebraic proofs) | [`01-sets.pdf`](./build/lectures/01-sets.pdf) | [`01-sets.typ`](./lectures/01-sets.typ) |
| **02** | **Functions and Relations** | Binary relations, relations on a set, $0\text{–}1$ matrix representations, inverse relations, reflexivity, symmetry, antisymmetry, transitivity, equivalence relations & classes, functions, injections, surjections, bijections, inverse functions, and composition | [`02-functions-and-relations.pdf`](./build/lectures/02-functions-and-relations.pdf) | [`02-functions-and-relations.typ`](./lectures/02-functions-and-relations.typ) |
| **03** | **Sequences and Series** | Discrete sequences, geometric & arithmetic progressions, common integer sequences (powers, factorials, Fibonacci), sigma ($\sum$) notation, finite & infinite geometric series, closed-form summation formulas, and index splitting | [`03-sequences-and-series.pdf`](./build/lectures/03-sequences-and-series.pdf) | [`03-sequences-and-series.typ`](./lectures/03-sequences-and-series.typ) |
| **04** | **Number Theory** | Integer divisibility & algebraic properties, the Division Algorithm ($a = dq + r$), modulo operator & congruence modulo $m$, modular arithmetic, prime numbers, Fundamental Theorem of Arithmetic, $\sqrt{n}$ primality testing, GCD, coprimality, and the Euclidean Algorithm | [`04-number-theory.pdf`](./build/lectures/04-number-theory.pdf) | [`04-number-theory.typ`](./lectures/04-number-theory.typ) |
| **05** | **Important Functions in Computer Science** | Ceiling ($\lceil x \rceil$) and floor ($\lfloor x \rfloor$) functions, step-function behavior & algebraic identities, recursive functions (basis & inductive steps), factorial, Chebyshev polynomials, Fibonacci numbers, and deriving recurrences from closed forms | [`05-important-functions.pdf`](./build/lectures/05-important-functions.pdf) | [`05-important-functions.typ`](./lectures/05-important-functions.typ) |
| **06** | **Mathematical Induction** | Deductive vs. inductive reasoning, Well-Ordering Principle, simple (weak) induction, summation & divisibility & power-set proofs, shifted base cases ($n \ge n_0$), inequality proofs ($2^n < n!$), strong induction, and classic inductive fallacies | [`06-mathematical-induction.pdf`](./build/lectures/06-mathematical-induction.pdf) | [`06-mathematical-induction.typ`](./lectures/06-mathematical-induction.typ) |

---

## Repository Structure

```text
AIF231105/
├── README.md                                  # Course overview and PDF index
├── .gitignore                                 # Ignores raw slide decks (slides/*)
├── main.typ                                   # Master course book entry point
├── lectures/                                  # Modular per-lecture Typst files
│   ├── 01-sets.typ
│   ├── 02-functions-and-relations.typ
│   ├── 03-sequences-and-series.typ
│   ├── 04-number-theory.typ
│   ├── 05-important-functions.typ
│   └── 06-mathematical-induction.typ
└── build/                                     # Compiled PDF outputs
    ├── AIF231105-book.pdf                     # Unified course textbook
    └── lectures/                              # Standalone lecture handouts
        ├── 01-sets.pdf
        ├── 02-functions-and-relations.pdf
        ├── 03-sequences-and-series.pdf
        ├── 04-number-theory.pdf
        ├── 05-important-functions.pdf
        └── 06-mathematical-induction.pdf
```

---

## Building from Source

This course repository is designed to be placed inside the `courses/AIF231105` directory of the parent [**`course-notes`**](https://github.com/monicafaye/course-notes) tooling workspace (which provides `/templates/course-note.typ`).

1. Clone the tooling workspace and this course repository:
   ```bash
   git clone https://github.com/monicafaye/course-notes.git
   cd course-notes
   git clone https://github.com/monicafaye/AIF231105.git courses/AIF231105
   ```
2. Compile from the `course-notes` workspace root using `typst compile --root .`:
   ```bash
   # Compile the unified course book
   typst compile --root . courses/AIF231105/main.typ courses/AIF231105/build/AIF231105-book.pdf

   # Compile an individual lecture handout
   typst compile --root . courses/AIF231105/lectures/01-sets.typ courses/AIF231105/build/lectures/01-sets.pdf
   ```
