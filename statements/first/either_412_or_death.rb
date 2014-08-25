# First: First occurrence of either MI or Death for each patient
# This illustrates a very powerful feature of ConceptQL.
#
# The statement generates two sets of results of different types, but then
# feeds them into a node that evaluates streams on a person-by-person level.
#
# The result of this statement is a person's first occurrence of EITHER an Old Mi or Death
# So if a person had an Old MI followed by death sometime later, that person's Old MI passes through and their death result is discareded.
# If a person died never having had an Old MI, their death result passes through.
# If a person somehow died and then had an Old MI, their death result passes through.
#
# The point here is that we can use this technique to build endpoints into an algorithm.
# If we want to censor our cohort based on a set of outcomes (death, end of data, occurrence of MI),
# those outcomes can be fed into the "first" node to yield the first occurrence of any of those outcomes.
{
  first: {
    union: [
      { icd9: '412' },
      { death: true }
    ]
  }
}

