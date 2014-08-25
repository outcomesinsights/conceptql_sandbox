# Intersect: Conditions where Old MI was reported in Inpatient Header
# This involves two Condition streams and so results are intersected
{
  intersect: [
    { icd9: '412' },
    { condition_type: :inpatient_header }
  ]
}

