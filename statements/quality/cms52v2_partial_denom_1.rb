#Quality: CMS52v2, Portion of Denominator 1 - Occurrence A and B of HIV Visit
#
# This illustrates how to handle QDM's "specific occurrence" feature.
# In this case, the "specific occurrence" is used to enforce a 90-day gap and so it is possible to just compare the set of occurrences against itself and find any pair that is more than 90 days apart.
[
  {
    define: [
      'HIV Visit',
      {
        intersect: [
          {
            visit_occurrence: {
              cpt: %w(99201 99202 99203 99204 99205 99212 99213 99214 99215 99241 99242 99243 99244 99245 99381 99382 99383 99384 99385 99386 99387 99391 99392 99393 99394 99395 99396 99397)
            },
          },
          {
            visit_occurrence: {
              union: [
                { icd10: %w(B20 Z21) },
                { icd9: %w(V08) }
              ]
            }
          }
        ]
      }
    ]
  },
  {
    after: {
      left: { recall: 'HIV Visit' },
      right: {
        time_window: [
          { recall: 'HIV Visit' },
          { start: '0', end: '90d' }
        ]
      },
    }
  }
]
