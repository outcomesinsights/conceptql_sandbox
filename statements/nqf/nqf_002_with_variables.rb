# NQF 002 using Variables
measurement_period = {
  date_range: {
    start: '2000-01-01',
    end: '2099-12-31'
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
    right: { from: 'measurement period'}
  }
}

ambulatory_encounters = {
  during: {
    left: {
      visit_occurrence: {
        vsac: [ '2.16.840.1.113883.3.464.0001.231', :procedure_occurrence ]
      }
    },
    right: { from: 'initial population' }
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
    { from: 'ambulatory encounters' },
    {
      visit_occurrence: { vsac: [ '2.16.840.1.113883.3.464.0001.369', :condition_occurrence ] }
    }
  ]

}

pharyngitis_encounter_followed_by_pharyngitis_meds = {
  during: {
    left: { from: 'pharyngitis encounters' },
    right: {
      time_window: [
        { from: 'pharyngitis medication' },
        { start: '-3d', end: 'start' }
      ]
    }
  }
}

meds_before_ambulatory_encounter = {
  during: {
    left: { from: 'ambulatory encounters' },
    right: {
      time_window: [
        { from: 'pharyngitis medication' },
        { start: '0', end: '30d' }
      ]
    }
  }
}

[
  {
    define: [
      'measurement period',
      measurement_period
    ]
  },
  {
    define: [
      'initial population',
      initial_population
    ]
  },

  {
    define: [
      'ambulatory encounters',
      ambulatory_encounters
    ]
  },

  {
    define: [
      'pharyngitis medication',
      pharyngitis_medication
    ]
  },

  {
    define: [
      'pharyngitis encounters',
      pharyngitis_encounters
    ]
  },

  {
    define: [
      'pharyngitis encounter followed by pharyngitis meds',
      pharyngitis_encounter_followed_by_pharyngitis_meds
    ]
  },

  {
    define: [
      'pharyngitis meds before ambulatory encounter',
      meds_before_ambulatory_encounter
    ]
  },

  {
    except: {
      left: { from: 'pharyngitis encounter followed by pharyngitis meds' },
      right: { from: 'pharyngitis meds before ambulatory encounter' }
    }
  }
]
