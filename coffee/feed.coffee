# RSS Feed Framework
define ['jquery', 'google!feeds,1','render'], ($, feedParser, render) ->

  feed = (config) ->

    storage = window.localStorage
    items = []

    init = (cb) ->
      _clearCache()

      _resolve (feedItems) ->
        $.each feedItems, (index, item) ->
          item.visited = _checkStorage item
          items.push item
          cb()

    _onVisit = () ->
      $('li').on 'click', () ->
        link = $(this).data 'link'
        $(this).addClass 'visited'
        storage.setItem link, new Date().getTime()
        location.href = link

    _checkStorage = (item) ->
      if localStorage.getItem item.link
        return 'visited'
      return ''

    _clearCache = () ->
      $.each storage, (url, time) ->
        if (time + (60 * 1000 * 60 * 24)) < new Date().getTime()
          storage.removeItem url

    _resolve = (cb) ->
      rssFeed = new google.feeds.Feed config.url
      rssFeed.setNumEntries(config.count);
      rssFeed.load (result) ->
        if !result.feed or !result.feed.entries
          cb []

        feedItems = []

        $.each result.feed.entries, (index, entry) ->
          feedItems.push
            title: entry.title
            link: entry.link
            image: $('<div></div>').html(entry.content).find('img').attr('src')

        cb feedItems

    return {
      title: config.title
      url: config.url
      items: items
      init: init,
      render: render config.node, config.template, {items: items, title: config.title, logo: config.logo, color: config.color}, _onVisit
    }

  return feed
