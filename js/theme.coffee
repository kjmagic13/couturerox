---
---

$ ->

	# json api
	# $.getJSON 'http://kaymic.storenvy.com/collections.json?callback=?', (result) ->
	# 	console.log result
	# 	for collection in result.collections
	# 		$('#products').append $('<li>').text(collection.name)
	# 	return

	# swipe capable carousel
	$('.carousel').swiperight ->
		$(this).carousel 'prev'
		return
	$('.carousel').swipeleft ->
		$(this).carousel 'next'
		return

	# beacon
	$('#btn-open').click (event) ->
		event.preventDefault()
		HS.beacon.open()
		return

	# tooltips
	$('[data-toggle="tooltip"]').tooltip()
	$('[data-toggle="popover"]').popover
		trigger: 'hover'

	# destroy remote modals after hidden for refresh
	$('body').on 'hidden.bs.modal', '#defaultModal', ->
		$(this).removeData 'bs.modal'
		return

	# scroll tos
	$('.to-top').click (event) ->
		event.preventDefault()
		$('#bs-example-navbar-collapse-1').collapse('hide')
		$('html, body').animate { scrollTop: $('body').offset().top - 74 }, 1000
		return

	$('.to-year').click (event) ->
		event.preventDefault()
		$('#bs-example-navbar-collapse-1').collapse('hide')
		$('html, body').animate { scrollTop: $('#year'+$(this).data('year')).offset().top - 74 }, 1000
		return

	$('.next-section').click (event) ->
		event.preventDefault()
		$('html, body').animate { scrollTop: $(this).closest('section').next().offset().top - 0 }, 1000

	$('.prev-section').click (event) ->
		event.preventDefault()
		$('html, body').animate { scrollTop: $(this).closest('section').prev().offset().top - 0 }, 1000

	$('.height-full').each ->
		winHeight = (window.innerHeight - 0)
		$(this).css 'min-height', winHeight + 'px'
		return

	# auto height
	resizeAutoHeights = ->
		currentTallest = 0
		$('.auto-height').each ->
			$autoHeight = $(this).find('.auto-height-elem')
			$autoHeight.each ->
				currentTallest = ($(this).height() + 15) if $(this).height() > currentTallest
				return
			$autoHeight.each ->
				$(this).height 'auto'
				$(this).outerHeight currentTallest
				return
			return
		return
	window.onload = resizeAutoHeights
	$(window).resize ->
		resizeAutoHeights()

	# passed meeting dates
	$('.meeting.media').each ->
		today = new Date
		theDate = new Date($(this).data('date'))
		unless theDate >= today
			$(this).find('.meeting-rsvp').hide()

	# affix width
	$('.affix').each ->
		parentWidth = $(this).parent().width()
		$(this).width parentWidth + 'px'
