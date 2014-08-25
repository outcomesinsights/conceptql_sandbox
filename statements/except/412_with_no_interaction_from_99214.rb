# Except: Despite presence of CPT codes, all Conditions that are MI
#
# Because there are no procedures in the left-hand stream, the right-hand
# stream has no results that are in common with the left-hand stream and so
# all results in the left-hand stream pass through.
{
  except: {
    left: { icd9: '412' },
    right: { cpt: '99214' }
  }
}

