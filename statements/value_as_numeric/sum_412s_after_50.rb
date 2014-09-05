# Numeric Values: Summing by person/type combination
# Sum groups all results by person and type then within the group returns
# - value_as_numeric as the sum of that column
# - start_date as the earliest start_date in the group
# - end_date as the most recent end_date in the group
# - criterion_id as 0 since the result no longer referes to any specific row in the table
{
  equal: {
    left: {
      sum: {
        count: {
          after: {
            left: { icd9: '412' },
            right: {
              time_window: [
                { gender: 'Male' },
                {
                  start: '50y',
                  end: '50y'
                }
              ]
            }
          }
        }
      }
    },
    right: {
      numeric: 2
    }
  }
}
