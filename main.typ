#import "/templates/course-note.typ": *

#show: course-book.with(
  course-code: "AIF231105",
  course-name: "Discrete Mathematics",
  subtitle: "Sets, Relations, Functions, Sequences, Number Theory, and Induction",
)

#include "lectures/01-sets.typ"
#include "lectures/02-functions-and-relations.typ"
#include "lectures/03-sequences-and-series.typ"
#include "lectures/04-number-theory.typ"
#include "lectures/05-important-functions.typ"
#include "lectures/06-mathematical-induction.typ"
