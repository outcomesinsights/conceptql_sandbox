# Complement: All Conditions that aren't Old MI reported in Inpatient Header
{
  complement: {
    union: [
      { icd9: '412' },
      { condition_type: :inpatient_header }
    ]
  }
}

