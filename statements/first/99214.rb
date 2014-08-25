# First: first occurrence of an office visit per person
# For each person, select the procedure_occurrence that represents the first occurrence of an office visit
# If no such row exists for a person, retun no results for that person
{
  first: {
    cpt: '99214'
  }
}
