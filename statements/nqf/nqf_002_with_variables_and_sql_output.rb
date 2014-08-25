# Quality: NQF 002 using Variables and SQL Output
# There are several examples of this statement in the Sandbox.
#
# This example replaces the "vsac" nodes in other examples with cpt/icd9/etc codes from the value sets called for in the measure definition.  This allows us to generate an actual SQL statement.
# This example uses variables to break up the statement into sub-concepts and reuse several sub-concepts through the statement.
# Lastly, this example doesn't limit the measure period to a single year and instead defines the measure period to be any time a person was between 2 and 18 between the years 2000 through 2099.
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
        cpt: %w(99201 99202 99203 99204 99205 99212 99213 99214 99215 99218 99219 99220 99281 99282 99283 99284 99285 99381 99382 99383 99384 99385 99386 99387 99391 99392 99393 99394 99395 99396 99397)
      }
    },
    right: { recall: 'Initial Population' }
  }
}

pharyngitis_medication = {
  intersect: [
    { rxnorm: %w(1013662 1013665 1043022 1043027 1043030 105152 105170 105171 108449 1113012 1148107 1244762 1249602 1302650 1302659 1302664 1302669 1302674 1373014 141962 141963 142118 1423080 1483787 197449 197450 197451 197452 197453 197454 197511 197512 197516 197517 197518 197595 197596) },
    { drug_type_concept: %w(38000175 38000176 38000177 38000179) }
  ]
}

pharyngitis_encounters = {
  intersect: [
    { recall: 'Ambulatory Encounters' },
    {
      visit_occurrence: {
        union: [
          { icd9: %w(034.0 462) },
          { icd10: %w(J02.0 J02.9) }
        ]
      }
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
