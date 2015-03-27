# NCT01874691: Inclusion/Exclusion criteria for prospective study in China regarding AMI
[
{
  define: [
    'Percutaneous Coronary Intervention',
    {
      visit_occurrence: {
        cpt: %w( 92920 92921 92924 92925 92928 92929 92933 92934 92937 92938 92941 92943 92944)
      }
    }
  ]
},
{
  define: [
    'Coronary Artery Bypass Grafting',
    { visit_occurrence: { cpt: '33510' } }
  ]
},
{
  define: [
    'Acute Ischemic Symptoms',
    { icd9: %w(410.0 410.00 410.01 410.02 410.1 410.10 410.11 410.12 410.2 410.20 410.21 410.22 410.3 410.30 410.31 410.32 410.4 410.40 410.41 410.42 410.5 410.50 410.51 410.52 410.6 410.60 410.61 410.62 410.7 410.70 410.71 410.72 410.8 410.80 410.81 410.82 410.9 410.90 410.91 410.92 411.0 411.1 411.8 411.81 411.89) }
  ]
},
{
  define: [
    'AMI of ST-elevation or non ST-elevation',
    { icd9: %w(410.0 410.00 410.01 410.02 410.1 410.10 410.11 410.12 410.2 410.20 410.21 410.22 410.3 410.30 410.31 410.32 410.4 410.40 410.41 410.42 410.5 410.50 410.51 410.52 410.6 410.60 410.61 410.62 410.7 410.70 410.71 410.72 410.8 410.80 410.81 410.82)}
  ]
},
{
  define: [
    'Inclusion Symptoms during Same Visit',
    {

      intersect: [
        {
          visit_occurrence: {
            recall: 'Acute Ischemic Symptoms',

          }
        },
        {
          visit_occurrence: {
            recall: 'AMI of ST-elevation or non ST-elevation',
          }
        }
      ]
    }
  ]
},
{
  define: [
    'Exclusion Criteria',
    {
      union: [
        { recall: 'Percutaneous Coronary Intervention' },
        { recall: 'Coronary Artery Bypass Grafting' }
      ]
    }
  ]
},
{
  define: [
    'Inclusion Criteria',
    {
      during: {
        left: {
          time_window: [
            { place_of_service_code: 21 },
            { start: '0', end: 'START' }
          ]
        },
        right: {
          time_window: [
            { recall: 'Inclusion Symptoms during Same Visit'},
            { start: '0', end: '7d' }
          ]
        }
      }
    }
  ]
},
{
  except: {
    left: { recall: 'Inclusion Criteria' },
    right: { recall: 'Exclusion Criteria' }
  }
}
]
