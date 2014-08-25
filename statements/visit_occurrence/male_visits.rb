# Casting: All Visits for All Males
# Finds all visit_occurrences for persons who are male.
# We find all results in the visit_occurrence table where visit_occurrence.person_id is in the set of person_ids for Males
{
  visit_occurrence: {
    gender: 'Male'
  }
}

