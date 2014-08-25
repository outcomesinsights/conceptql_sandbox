# Before: All MIs that occurred before a person's __first__ case of hypertension (401.9)
# If a statement needs to enforce that a 412 come before the first occurrence
# of 401.9, you must use the "first" node.
{
  before: {
    left: { icd9: '412' },
    right: {
      first: {
        icd9: '401.9'
      }
    }
  }
}

