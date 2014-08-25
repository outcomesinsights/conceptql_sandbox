# Time Window: Shift the window for all MIs back by 2 years
# This changes the start_date and end_date to be two years earlier than they originally occurred.
{
  time_window: [
    { icd9: '412' },
    { start: '-2y', end: '-2y' }
  ]
}

