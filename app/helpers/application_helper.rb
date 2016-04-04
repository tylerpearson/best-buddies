module ApplicationHelper

  SITE_TITLE = "BestBuddies"

  def full_title(page_title='')
    base_title = "Find who likes your photos the most on Instagram!"
    if page_title.empty?
      base_title
    else
      "#{page_title}"
    end
  end

  def current_url
    "https://bestbuddies.sweebleapp.com#{request.fullpath}"
  end

  def og_tags(custom_tags='')
    if custom_tags.empty?
      %{
        <meta property="og:title" content="Find out who are your top friends on Instagram!">
        <meta property="og:image" content="#{asset_path("og-image.png")}">
        <meta property="og:site_name" content="Find out who are your top friends on Instagram">
        <meta property="og:description" content="Find out which of your friends like your photos the most on Instagram. Built by Sweeble, a beautifully simple way to spend time with people's photos and videos.">
        <meta property="og:url" content="https://bestbuddies.sweebleapp.com">
        <meta property="fb:admins" content="25817727,25827335,25831332,100000606987196">

        <!-- Twitter -->
        <meta name="twitter:title" content="Find out who are your top friends on Instagram!">
        <meta name="twitter:card" content="summary">
        <meta name="twitter:site" content="@SweebleApp">
        <meta name="twitter:description" content="Find out which of your friends like your photos the most on Instagram. Built by Sweeble, a beautifully simple way to spend time with people's photos and videos.">
        <meta name="twitter:image" content="#{asset_path("og-image.png")}">
        <meta name="twitter:url" content="https://bestbuddies.sweebleapp.com">
        <meta property="twitter:account_id" content="4503599630993522" />

        <meta name="description" content="Find out which of your friends like your photos the most on Instagram. Built by Sweeble, a beautifully simple way to spend time with people's photos and videos.">
      }.html_safe
    else
      custom_tags
    end
  end

end
