# TimeWindow: All office visits within 30 days of an Old MI
# time_window creates a 30 day window around every occurrence of an Old MI.
# The during node then checks each office visit to see if it occurred within this window
{
  during: {
    left: { cpt: '99214' },
    right: {
      time_window: [
        { icd9: '412' },
        { start: '-30d', end: '30d' }
      ]
    }
  }
}

