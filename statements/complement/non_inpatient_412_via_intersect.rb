# Complement: Conditions that aren't Old MI reported in Inpatient Header
{
  intersect: [
    { complement: { icd9: '412' } },
    { complement: {  condition_type: :inpatient_header } }
  ]
}

