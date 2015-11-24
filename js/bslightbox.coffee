---
---

$ ->

	modal = """
	<div class=\"modal fade\" id=\"bslightboxModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"bslightboxModalLabel\" aria-hidden=\"true\">
		<div class=\"modal-dialog modal-lg\">
			<div class=\"modal-content\">
				<div class=\"modal-header\">
					<button type=\"button\" class=\"close\" data-dismiss=\"modal\"><span aria-hidden=\"true\">&times;</span><span class=\"sr-only\">Close</span></button>
					<h4 class=\"modal-title\" id=\"myModalLabel\">Modal title</h4>
				</div>
				<div class=\"modal-body text-center\">
					<img class=\"img-thumbnail\">
				</div>
			</div>
		</div>
	</div>
	"""

	$(modal).prependTo "body"

	$('[data-bslightbox="true"]').click ->
		$('#bslightboxModal').find('.modal-title').text $(this).attr('title')
		$("#bslightboxModal").find(".modal-body img").attr "src", $(this).attr("src")
		$('#bslightboxModal').modal 'show'