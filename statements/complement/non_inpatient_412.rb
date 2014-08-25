# Complement: All Conditions where the Condition isn't an Old MI AND in an Inpatient setting
{
  complement: {
    union: [
      { icd9: '412' },
      { condition_type: :inpatient_header }
    ]
  }
}

