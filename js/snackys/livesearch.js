var activeSearch;
var searchOpen = false;
var lastSearch;

function closeKMLivesearch()
{
	$('#km_snackys_search').empty();
	$('#km_snackys_search').addClass('hidden');
	$('#search-header').val('');
	$('#search-header-mobile-fixed').val('');
	searchOpen = false;
}


if($('#km_snackys_search').length > 0)
{
	$('#search-header, #search-header-mobile-fixed').on('input', function() {
		let search = $(this).val();
		lastSearch = search;
		searchOpen = true;
		clearTimeout(activeSearch);
		activeSearch = setTimeout(() => {
			if (search && search !== '0') {
				$.evo.loadContent($('#km_snackys_search').data('url') + '/?livesearch&suchausdruck=' + search, function() {
					if ($('#km_snackys_search').text() == '')
						closeKMLivesearch();
				}, function() {
					closeKMLivesearch();
				}, false, '#km_snackys_search');
			} else if (!search) {
				closeKMLivesearch();
			} else {
				// Nur "0" eingegeben: abwarten, Eingabe bleibt erhalten, keine Suche auslösen
				$('#km_snackys_search').empty();
				$('#km_snackys_search').addClass('hidden');
			}
		}, 350);
	});


	window.addEventListener('click', function(e){   
		if(searchOpen)
		{
			if (!document.getElementById('km_snackys_search').contains(e.target))
			{
				if(
					(document.getElementById('search-header') && !document.getElementById('search-header').contains(e.target))
					||
					(document.getElementById('search-header-mobile-fixed') && !document.getElementById('search-header-mobile-fixed').contains(e.target))
				)
					closeKMLivesearch();
			}
		}
	});

	$('#search-form').submit(function(event)
	{
		if(!lastSearch)
			event.preventDefault();
		else
			$('#search-header, #search-header-mobile-fixed').val(lastSearch);
	});
}