# Algorithm Pattern: 1 inpatient, or 2 outpatient diagnoses separated by 30 days
# This is a common pattern for claims data.  The pattern is derived from the way the Charlson Comorbidity Index is calculated.
# Some diagnoses that are reported on claims data are included to justify billing a particular test or lab.   The test is performed as a means to rule out a certain condition, so if the diagnosis appears in an outpatient setting, there is a chance it is reported for the purposes of ruling out a particular condition.
# Because of this, outpatient diganoses aren't guaranteed to represent actual conditions for a person.  So the Charlson Comorbidity Index requires that an diagnosis reported in an outpatient setting appear twice, at least 30 days apart.
# If a condition is reported in an inpatient setting, it is considered an actual condition.
#
# This example uses variables to isolate the condition of interest (Old MI) and then intersect the condition with the inpatient and outpatient settings.  Finally it compares outpatient diagnoses against each other, looking for the 30 day gap, and returns the first valid occurrence of a condition, be it inpatient or outpatient.
[
  {
    define: [
      'Heart Attack Visit',
      { visit_occurrence: { icd9: '412' } }
    ]
  },

  {
    define: [
      'Inpatient Heart Attack',
      {
        intersect: [
          { recall: 'Heart Attack Visit'},
          { place_of_service_code: 21 }
        ]
      }
    ]
  },

  {
    define: [
      'Outpatient Heart Attack',
      {
        intersect: [
          { recall: 'Heart Attack Visit'},
          {
            complement: {
              place_of_service_code: 21
            }
          }
        ]
      }
    ]
  },

  {
    define: [
      'Earlier of Two Outpatient Heart Attacks',
      {
        before: {
          left: { recall: 'Outpatient Heart Attack' },
          right: {
            time_window: [
              { recall: 'Outpatient Heart Attack' },
              { start: '-30d', end: '0' }
            ]
          }
        }
      }
    ]
  },

  {
    first: {
      union: [
        { recall: 'Inpatient Heart Attack' },
        { recall: 'Earlier of Two Outpatient Heart Attacks'}
      ]
    }
  }
]
