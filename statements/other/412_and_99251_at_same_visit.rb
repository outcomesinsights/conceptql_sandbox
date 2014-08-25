# Intersect: All Visits where a Patient had both an MI and a Hospital Encounter
# By casting conditions and procedures to visit_occurrences, we can find
# situations where a condition and procdure were reported within the same patient
# encounter.
{
  intersect: [
    { visit_occurrence: { icd9: '412' } },
    { visit_occurrence: { cpt: '99251' } }
  ]
}

