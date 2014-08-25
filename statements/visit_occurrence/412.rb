# Casting: All Visits Where a Patient Had an MI
# Finds all condition_occurrences of Old MI, then finds the visit_occurrences that those condition_occurrences refer to through the condition_occurrence.visit_occurrence_id
{
  visit_occurrence: {
    icd9: '412'
  }
}
