# Union: Two streams become one
# Two streams of the same type (condition_occurrence) will be joined into a single stream of conditions represent either Old MI (412) or Hypertension (401.9)
{
  union: [
    { icd9: '412' },
    { icd9: '401.9' }
  ]
}

