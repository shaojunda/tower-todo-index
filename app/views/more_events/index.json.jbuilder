json.size @events.size
json.template render partial: "events/show_events", locals: { group_events: @group_events }, formats: [:html]
