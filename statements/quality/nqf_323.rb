# Quality: NQF 323
# This statement captures the denominator definition, along with a month-long
# period of the numerator.
#
# The measure is supposed to find ESRD patients recieving dialysis and the
# numerator includes a patient if one of the three is true:
# 1) The patient didn't have dialysis that month
# 2) The patient had dialysis and a Kt/V >= 1.2
# 3) The patient had dialysis and a Kt/V < 1.2 and had some intervention to make dialysis more optimal
[
  {
    define: [
      'Measurement Period',
      { date_range: { start: '2011-01-01', end: '2011-12-31'} }
    ]
  },
  {
    define: [
      'Period after 18th Birthday',
      {
        after: {
          left: { recall: 'Measurement Period' },
          right: {
            time_window: [
              { person: true},
              { start: '+18y', end: '+18y' }
            ]
          }
        }
      }
    ]
  },
  {
    define: [
      'ESRD',
      {
        during: {
          left: {
            icd9: '585.6'
          },
          right: { recall: 'Period after 18th Birthday'}
        }
      }
    ]
  },
  {
    define: [
      'Hemodialysis Procedure',
      {
        during: {
          left: {
            cpt: %w(90935 90937 90940 90957 90958 90959 90960 90961 90962)
          },
          right: { recall: 'Period after 18th Birthday' }
        }
      }
    ]
  },
  {
    define: [
      'Hemodialysis Encounter',
      {
        during: {
          left: {
            icd9_procedure: %w(V56.0 V56.1)
          },
          right: { recall: 'Period after 18th Birthday' }
        }
      }
    ]
  },
  {
    define: [
      'IPP Period',
      {
        person_filter: {
          left: { recall: 'Period after 18th Birthday' },
          right: {
            intersect: [
              { person: { recall: 'ESRD' } },
              {
                person: {
                  union: [
                    { recall: 'Hemodialysis Procedure' },
                    { recall: 'Hemodialysis Encounter' }
                  ]
                }
              }
            ]
          }
        }
      }
    ]
  },
  {
    define: [
      'Period A',
      {
        time_window: [
          { recall: 'IPP Period' },
          { start: '29d', end: '64d' }
        ]
      }
    ]
  },
  {
    define: [
      'No Hemo During A',
      {
        person_filter: {
          left: { recall: 'Period A' },
          right: {
            complement: {
              person: {
                during: {
                  left: { recall: 'Hemodialysis Procedure' },
                  right: { recall: 'Period A' }
                }
              }
            }
          }
        }
      }
    ]
  },
  {
    define: [
      'Kt/V in A',
      {
        last: {
          during: {
            left: {
              observation_concept_id: '251868007'
            },
            right: {
              recall: 'Period A'
            }
          }
        }
      }
    ]
  },
  {
    define: [
      'OK Kt/V in A',
      {
        greater_than_or_equal: {
          left: {
            recall: 'Kt/V in A'
          },
          right: {
            value: 1.2
          }
        }
      }
    ]
  },
  {
    define: [
      'Bad Kt/V in A',
      {
        except: {
          left: { recall: 'Kt/V in A' },
          right: { recall: 'OK Kt/V in A' }
        }
      }
    ]
  },
  {
    define: [
      'Intervened for Bad Kt/V in A',
      {
        person_filter: {
          left: { recall: 'Bad Kt/V in A' },
          right: {
            during: {
              left: {
                procedures: %w(381000124105 461000124106 371000124107 451000124109 391000124108 471000124104)
              },
              right: {
                recall: 'Period A'
              }
            }
          }
        }
      }
    ]
  },
  {
    define: [
      'Valid Patients for Period A',
      {
        union: [
          { recall: 'No Hemo During A' },
          { recall: 'OK Kt/V in A' },
          { recall: 'Intervened for Bad Kt/V in A' },
        ]
      }
    ]
  }
]
