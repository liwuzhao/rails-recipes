module EventsHelper

  def display_event_status(event)
    case event.status
      when "draft"
        "草稿"
      when "private"
        "私密"
      when "public"
        "公开"
    end
  end

end
