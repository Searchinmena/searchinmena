class MessageFormatter
  def perform(body)
    body.gsub("\n", "<br />")
    body.html_safe
  end
end
