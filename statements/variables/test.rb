# Defines a set of variables and assembles them into a statement

some_meds = {
  define: [
    'some meds',
    { rxnorm: %w(128123812 123182381 1283281) }
  ]
}

office_visits = {
  define: [
    'office visits',
    { cpt: %w(99211 99212 99213 99214 99215) }
  ]
}

[
  some_meds,
  office_visits,
  {
    after: {
      left: { from: 'some meds' },
      right: { from: 'office visits' }
    }
  }
]
