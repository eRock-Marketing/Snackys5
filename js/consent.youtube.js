document.addEventListener('consent.ready', function(e) {
	embedYoutube(e.detail);
});
document.addEventListener('consent.updated', function(e) {
	embedYoutube(e.detail);
});
function embedYoutube(detail) {
	if (detail !== null && typeof detail.youtube !== 'undefined' && detail.youtube === true) {
		var embeds = document.querySelectorAll('iframe.needs-consent.youtube');
		for (var i = 0; i < embeds.length; ++i) {
			embeds[i].src = embeds[i].dataset.src;
			embeds[i].className = 'youtube';
		}
		var notices = document.querySelectorAll('a[data-consent="youtube"]');
		for (var j = 0; j < notices.length; ++j) {
			notices[j].classList.add('hidden');
		}
	}
	if (detail !== null && typeof detail.vimeo !== 'undefined' && detail.vimeo === true) {
		var embeds = document.querySelectorAll('iframe.needs-consent.vimeo');
		for (var i = 0; i < embeds.length; ++i) {
			embeds[i].src = embeds[i].dataset.src;
			embeds[i].className = 'vimeo';
		}
		var notices = document.querySelectorAll('a[data-consent="vimeo"]');
		for (var j = 0; j < notices.length; ++j) {
			notices[j].classList.add('hidden');
		}
	}
}
