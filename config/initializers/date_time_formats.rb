shared_formats = {
  :full_date => "%B %d, %Y",
  :full_date_and_time => "%b %e, %Y, %I:%M %p %Z"
}
Time::DATE_FORMATS.merge!(shared_formats)
Date::DATE_FORMATS.merge!(shared_formats)
