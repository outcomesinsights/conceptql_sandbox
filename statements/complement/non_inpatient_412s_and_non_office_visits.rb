# Complement: Non-Office Visit Procedures and all Conditions that aren't Old MI reported in Inpatient Header
# This demonstrates how complement operates on each stream type separately.
{
  complement: {
    union: [
      { icd9: '412' },
      { condition_type: :inpatient_header },
      { cpt: '99214' }
    ]
  }
}

