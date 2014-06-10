module ApplicationHelper
  def url_fix(link)
    if link.start_with?("http")
      return link
    else return "http://#{link}"
    end
  end

  def date_fix(date)
    date.strftime("%a %d %b %y, at %I:%M %p")
  end
end
