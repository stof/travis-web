@Travis.StatusImageFormatter =
  slug: null
  url: null
  branch: null

  format: (version, slug, branch) ->
    @slug = slug
    @branch = branch
    @url = @urlRepo()

    switch version
      when 'Image URL' then @statusImageUrl()
      when 'Markdown' then @markdownStatusImage()
      when 'Textile' then @textileStatusImage()
      when 'Rdoc' then @rdocStatusImage()
      when 'AsciiDoc' then @asciidocStatusImage()
      when 'Rst' then @rstStatusImage()
      when 'Pod' then @podStatusImage()
      when 'CCTray' then @ccxmlStatusUrl()

  urlRepo: (->
    "https://#{location.host}/#{@slug}"
  )

  statusImageUrl: (->
    Travis.Urls.statusImage(@slug, @branch)
  )

  markdownStatusImage: (->
    "[![Build Status](#{@statusImageUrl()})](#{@url})"
  )

  textileStatusImage: (->
    "!#{@statusImageUrl()}!:#{@url}"
  )

  rdocStatusImage: (->
    "{<img src=\"#{@statusImageUrl()}\" alt=\"Build Status\" />}[#{@url}]"
  )

  asciidocStatusImage: (->
    "image:#{@statusImageUrl()}[\"Build Status\", link=\"#{@url}\"]"
  )

  rstStatusImage: (->
    ".. image:: #{@statusImageUrl()}\n    :target: #{@url}"
  )

  podStatusImage: (->
    "=for HTML <a href=\"#{@url}\"><img src=\"#{@statusImageUrl()}\"></a>"
  )

  ccxmlStatusUrl: (->
    Travis.Urls.ccXml(@slug)
  )
