# During: All Old MIs for the year 2010
# We use a date_range to define the start and end date for 2010
#
# Behind the scenes, a date_range generates a row per person in the person
# table and sets the start_date and end_date to the dates fed to the date_range
# node.
{
  during: {
    left: { icd9: '412' },
    right: {
      date_range: {
        start: '2010-01-01',
        end: '2010-12-31'
      }
    }
  }
}

