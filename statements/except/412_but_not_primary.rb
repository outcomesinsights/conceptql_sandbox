# Except: All Conditions that are Old MI unless they inpatient headers
{
  except: {
    left: { icd9: '412' },
    right: { condition_type: :inpatient_header }
  }
}

