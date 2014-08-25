# Variables: Simple example of using variables
# Defines a set of variables and assembles them into a statement
# In this case, we store all conditions representing Old MI in "Old MI"
# then store all procedures representing office visits as "Office Visits"
# and lastly find all "Old MIs" that occur after "Office Visits"

old_mi = {
  define: [
    'Old MI',
    { icd9: %w(412) }
  ]
}

office_visits = {
  define: [
    'Office Visits',
    { cpt: %w(99211 99212 99213 99214 99215) }
  ]
}

[
  old_mi,
  office_visits,
  {
    after: {
      left: { recall: 'Old MI' },
      right: { recall: 'Office Visits' }
    }
  }
]
