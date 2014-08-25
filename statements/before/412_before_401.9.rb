# Before: All MIs that occurred before a person's __last__ case of hypertension (401.9)
# To be clear, we compare a person's set of 412 diagnoses against a person's
# set of 401.9 diagnoses.  That means each result in the 412 set is compared
# against each row of the 401.9 set.
#
# In reality, the date of the most recent 401.9 is the date that matters.
# Imagine events 1-1-2-1-2-1.  Technically, three 1's come before the last 2.
{
  before: {
    left: { icd9: '412' },
    right: { icd9: '401.9' }
  }
}

