require.config
  baseUrl: './'
  paths:
    jquery: 'bower_components/jquery/dist/jquery.min'
    feed: 'js/feed'
    page: 'js/page'
    lodash: 'bower_components/lodash/dist/lodash.min'
    render: 'js/render',
    propertyParser: 'bower_components/requirejs-plugins/src/propertyParser',
    async: 'bower_components/requirejs-plugins/src/async',
    google: 'bower_components/requirejs-plugins/src/goog'

require ['jquery', 'feed', 'page'], ($, feed, page) ->

  feeds = {}

  applicationStart = new Date().getTime()

  $.get 'config.json', (config) ->

    $.each config.feeds, (index, item) ->
      feeds[item.url] = feed(item)
      feeds[item.url].init ->
        feeds[item.url].render()

    page.header config.header, () ->

  $(window).on 'focus', () ->
    if new Date().getTime() > applicationStart + (5 * 60 * 1000)
      window.location.reload()