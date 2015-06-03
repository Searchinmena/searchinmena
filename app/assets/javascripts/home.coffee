$ ->
  $(window).on "load", (e) ->
    if window.location.hash is "#_=_"
      window.location.hash = "" # for older browsers, leaves a # behind
      history.pushState "", document.title, window.location.pathname
      e.preventDefault()
