# After: All MIs that occurred after a male's 50th birthday
# Person results default to the person's date of birth for the start and end date.
# By adjusting the date forward by 50 years, we find a patient's 50th birthday.
# Then we can find all diagnoses that occurred after a patient turns 50.
{
  after: {
    left: { icd9: '412' },
    right: {
      time_window: [
        { gender: 'Male' },
        {
          start: '50y',
          end: '50y'
        }
      ]
    }
  }
}

