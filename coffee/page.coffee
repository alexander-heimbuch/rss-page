# RSS Feed Framework
define ['jquery', 'render'], ($, render) ->

  header = (header) ->
    render(header.node, header.template, header, () ->)()

  return {
    header: header
  }

  return page
