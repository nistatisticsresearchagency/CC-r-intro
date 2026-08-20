# solution to self guided coding in the YOUR TURN section
integrated_schools <- schools_enrolment %>%
  filter(integrated == "Yes") %>%
  select(
    school_name,
    district_council,
    total_enrolment
  ) %>%
  arrange(district_council)
