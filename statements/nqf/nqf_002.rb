# Quality: NQF 002 as One Large Statement
# There are several examples of this statement in the Sandbox.
#
# This example uses the "vsac" node, which, in the future, will pull code sets from the VSAC and create a set of results from those codes.
# This example also forgoes using variables to break the statement up into sub-concepts, yielding a large diagram and a complex SQL query.
# Lastly, this example doesn't limit the measure period to a single year and instead defines the measure period to be any time a person was between 2 and 18 between the years 2000 through 2099.
measurement_period = {
  date_range: {
    start: '2000-01-01',
    end: '2099-12-31'
  }
}

initial_population = {
  during: {
    left: {
      time_window: [
        { person: true },
        { start: '+2y', end: '+18y-1d' }
      ]
    },
    right: measurement_period
  }
}

initial_population_2 = {
  during: {
    left: measurement_period,
    right: {
      time_window: [
        { person: true },
        { start: '+2y', end: '+18y' }
      ]
    }
  }
}

ambulatory_encounters = {
  during: {
    left: {
      visit_occurrence: {
        vsac: [ '2.16.840.1.113883.3.464.0001.231', :procedure_occurrence ]
      }
    },
    right: initial_population
  }
}

pharyngitis_medication = {
  intersect: [
    { vsac: [ '2.16.840.1.113883.3.464.0001.373', :drug_exposure ] },
    { drug_type_concept_id: %w(38000175 38000176 38000177 38000179) }
  ]
}

ambulatory_encounters_with_pharyngitis = {
  intersect: [
    ambulatory_encounters,
    {
      visit_occurrence: { vsac: [ '2.16.840.1.113883.3.464.0001.369', :condition_occurrence ] }
    }
  ]
}

ambulatory_encounter_with_meds = {
  during: {
    left: ambulatory_encounters_with_pharyngitis,
    right: {
      time_window: [
        pharyngitis_medication,
        { start: '-3d', end: 'start' }
      ]
    }
  }
}

meds_before_ambulatory_encounter = {
  during: {
    left: ambulatory_encounters,
    right: {
      time_window: [
        pharyngitis_medication,
        { start: '0', end: '30d' }
      ]
    }
  }
}

{
  except: {
    left: ambulatory_encounter_with_meds,
    right: meds_before_ambulatory_encounter
  }
}
