# Intersect: Four streams become two streams
# Intersect will take sets of like-types and collapse them into a single set
# Yields two sets:
# - Conditions where Old MI was reported in Inpatient Header
# - All White, Male patients
{
  intersect: [
    { icd9: '412' },
    { condition_type: :inpatient_header },
    { gender: 'Male' },
    { race: 'White' }
  ]
}

