# Intersect: Intersecting two different types of streams
# Streams of different types do not interact with each other in an intersect node.
# Yields two sets of results: a set of all MI Conditions and a set of all Male patients.
# This is essentially the same behavior as Union in this case.
{
  intersect: [
    { icd9: '412' },
    { gender: 'Male' }
  ]
}

