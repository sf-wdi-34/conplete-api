# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Conference.destroy_all

cancun_con_con = Conference.create({ name: 'Con Con', location: 'Cancun' })

conference_start = 0.days.from_now.at_midnight + 8.hours

tuscon_con = Conference.create({ name: 'Tuscon Con', location: 'Tuscon' })

talks_data = [
  {
    title: "Branding",
    speaker_name: "Brett",
    start_offset: 3.hours,
    duration: 1.5.hours
  },
  {
    title: "Debugging",
    speaker_name: "Dani",
    start_offset: 5.hours,
    duration: 0.5.hours
  },
  {
    title: "Efficiency",
    speaker_name: "Ezra",
    start_offset: 6.hours,
    duration: 1.5.hours
  },
  {
    title: "Freelancing",
    speaker_name: "Figaro",
    start_offset: 7.hours,
    duration: 0.5.hours
  },
  {
    title: "Go",
    speaker_name: "Geoff",
    start_offset: 2.hours,
    duration: 0.75.hours
  },
  {
    title: "Iteration",
    speaker_name: "Ida",
    start_offset: 0.hours,
    duration: 0.75.hours
  },
  {
    title: "Lunch",
    speaker_name: "Linda",
    start_offset: 4.hours,
    duration: 1.hours
  },
  {
    title: "Marketing",
    speaker_name: "Madge",
    start_offset: 5.hours,
    duration: 0.75.hours
  },
  {
    title: "Questing",
    speaker_name: "Quintain",
    start_offset: 7.25.hours,
    duration: 1.hours
  },
  {
    title: "Randomization",
    speaker_name: "Ronaldo",
    start_offset: 4.5.hours,
    duration: 0.5.hours
  },
  {
    title: "Streams",
    speaker_name: "Sam",
    start_offset: 3.75.hours,
    duration: 1.hours
  },
  {
    title: "Zero",
    speaker_name: "Zorro",
    start_offset: 2.25.hours,
    duration: 0.5.hours
  }
]

talks_data.each_with_index do |talk_data, i|
  talk = Talk.create({
      title: talk_data[:title],
      speaker_name: talk_data[:speaker_name],
      start_time: conference_start + talk_data[:start_offset],
      end_time: conference_start + talk_data[:start_offset] + talk_data[:duration]
  })
  cancun_con_con.talks << talk
end
