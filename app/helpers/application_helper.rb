module ApplicationHelper
  def url_fix(link)
    if link.start_with?("http")
      return link
    else return "http://#{link}"
    end
  end

  def date_fix(date)
    if logged_in? && !current_user.time_zone.blank?
      date = date.in_time_zone(current_user.time_zone)
    end
    date.strftime("%a %d %b %y, at %I:%M %p %Z")
  end
end
