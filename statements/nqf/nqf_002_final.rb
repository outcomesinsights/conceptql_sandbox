# Quality: NQF 002 using Variables
# There are several examples of this statement in the Sandbox.
#
# This example uses the "vsac" node, which, in the future, will pull code sets from the VSAC and create a set of results from those codes.
# This example uses variables to break up the statement into sub-concepts and reuse several sub-concepts through the statement.
# The measurement period is limited to the year 2011
measurement_period = {
  date_range: {
    start: '2011-01-01',
    end: '2011-12-31'
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

initial_population = {
  during: {
    left: {
      time_window: [
        { person: true },
        { start: '+2y', end: '+17y' }
      ]
    },
    right: { recall: 'Measurement Period'}
  }
}

ambulatory_encounters = {
  during: {
    left: {
      visit_occurrence: {
        vsac: [ '2.16.840.1.113883.3.464.0001.231', :procedure_occurrence ]
      }
    },
    right: { recall: 'Initial Population' }
  }
}

pharyngitis_medication = {
  intersect: [
    { vsac: [ '2.16.840.1.113883.3.464.0001.373', :drug_exposure ] },
    { drug_type_concept_id: %w(38000175 38000176 38000177 38000179) }
  ]
}

pharyngitis_encounters = {
  intersect: [
    { recall: 'Ambulatory Encounters' },
    {
      visit_occurrence: { vsac: [ '2.16.840.1.113883.3.464.0001.369', :condition_occurrence ] }
    }
  ]

}

pharyngitis_encounter_followed_by_pharyngitis_meds = {
  during: {
    left: { recall: 'Pharyngitis Encounters' },
    right: {
      time_window: [
        { recall: 'Pharyngitis Medication' },
        { start: '-3d', end: 'start' }
      ]
    }
  }
}

meds_before_ambulatory_encounter = {
  during: {
    left: { recall: 'Ambulatory Encounters' },
    right: {
      time_window: [
        { recall: 'Pharyngitis Medication' },
        { start: '0', end: '30d' }
      ]
    }
  }
}

[
  {
    define: [
      'Measurement Period',
      measurement_period
    ]
  },
  {
    define: [
      'Initial Population',
      initial_population_2
    ]
  },

  {
    define: [
      'Ambulatory Encounters',
      ambulatory_encounters
    ]
  },

  {
    define: [
      'Pharyngitis Medication',
      pharyngitis_medication
    ]
  },

  {
    define: [
      'Pharyngitis Encounters',
      pharyngitis_encounters
    ]
  },

  {
    define: [
      'Pharyngitis Encounter followed by Pharyngitis Meds',
      pharyngitis_encounter_followed_by_pharyngitis_meds
    ]
  },

  {
    define: [
      'Pharyngitis Meds before Ambulatory Encounter',
      meds_before_ambulatory_encounter
    ]
  },

  {
    except: {
      left: { recall: 'Pharyngitis Encounter followed by Pharyngitis Meds' },
      right: { recall: 'Pharyngitis Meds before Ambulatory Encounter' }
    }
  }
]

