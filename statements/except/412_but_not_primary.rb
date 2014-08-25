# Except: All Conditions that are Old MI except when reported in Inpatient Header
{
  except: {
    left: { icd9: '412' },
    right: { condition_type: :inpatient_header }
  }
}

