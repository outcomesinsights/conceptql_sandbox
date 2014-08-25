# Person Filter: All MI Conditions for people who are Male OR had an office visit at some point in the data
# The right-hand set of a person filter is turned into the set of unique person_ids.
# The left-hand set only passes through results belonging to people who appear in the right-hand set.
{
  person_filter: {
    left: { icd9: '412' },
    right: {
      union: [
        { cpt: '99214' },
        { gender: 'Male' }
      ]
    }
  }
}

