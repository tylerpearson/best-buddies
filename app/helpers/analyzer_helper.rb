module AnalyzerHelper

  # this is pretty darn ugly
  def result_row(result, index)
    html = "<tr><td>" + (index + 1).to_s + ". </td>"
    html += '<td class="table-info">'
    html += image_tag(result.friend.avatar_url, width: 32, height: 32, class: "avatar", alt: "@#{result.friend.username} avatar")
    if result.friend.name.length > 0
      html += '<p class="username"><span>' + result.friend.name + " (</span>@#{result.friend.username}<span>)</span></p>"
    else
      html += '<p class="username">@' + result.friend.username + '</p>'
    end
    html += '</td><td class="table-stats">' + number_to_percentage((result.like_count.to_f / result.total_count.to_f) * 100, precision: 0) + '</td></tr>'
  end

end
