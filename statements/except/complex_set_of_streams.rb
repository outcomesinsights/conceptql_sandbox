# Except: Conditions, and People, and Procedures
# Passes three streams downstream:
#   - a stream of Conditions that are MI but not reported in Inpatient Header
#   - a stream of People that are Male but not White
#   - a stream of Procedures that are office visits (this stream is completely unaffected by the right-hand stream)
#
# This illustrates how left-hand streams are only affected by right-hand streams of the same type.
{
  except: {
    left: {
      union: [
        { icd9: '412' },
        { gender: 'Male' },
        { cpt: '99214' }
      ]
    },
    right: {
      union: [
        { condition_type: :inpatient_header },
        { race: 'White' },
      ]
    }
  }
}

