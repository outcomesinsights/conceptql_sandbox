# Numeric Values: Counting duplicate rows
# Count looks for results that are identical across all columns and then de-dupes the result set and replaces the value_as_numeric value with the number of idential rows found
{
  equal: {
    left: {
      count: {
        union: [
          { icd9: '412' },
          { icd9: '412' },
        ]
      }
    },
    right: {
      numeric: 2
    }
  }
}

