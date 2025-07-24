{block name='productdetails-popups'}
	{block name='popups-assigns'}
		{assign var=kArtikel value=$Artikel->kArtikel}
		{if $Artikel->kArtikelVariKombi > 0}
			{assign var=kArtikel value=$Artikel->kArtikelVariKombi}
		{/if}
	{/block}
	{block name='popups-article-added'}
		{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
			{if !isset($kArtikel)}
				{assign var=kArtikel value=$Artikel->kArtikel}
				{if $Artikel->kArtikelVariKombi > 0}
					{assign var=kArtikel value=$Artikel->kArtikelVariKombi}
				{/if}
			{/if}
			<div id="popupa{$kArtikel}" class="hidden">
				{include file='productdetails/pushed.tpl' oArtikel=$Artikel fAnzahl=$bWarenkorbAnzahl}
			</div>
		{/if}
	{/block}
	{block name='popups-missing-information'}
		{if (isset($fehlendeAngaben_benachrichtigung) && count($fehlendeAngaben_benachrichtigung) > 0 && ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y') || (isset($fehlendeAngaben_fragezumprodukt) && $fehlendeAngaben_fragezumprodukt|@count > 0 && $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P')}
			{inline_script}
				<script type="text/javascript">
					$(function() {ldelim}
						{if isset($fehlendeAngaben_benachrichtigung) && count($fehlendeAngaben_benachrichtigung) > 0 && ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3)}
							show_popup('n{$kArtikel}', '{lang key="requestNotification" section="global"}');
						{/if}

						{if isset($fehlendeAngaben_fragezumprodukt) && $fehlendeAngaben_fragezumprodukt|@count > 0 && $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
							show_popup('z{$kArtikel}', '{lang key="productQuestion" section="productDetails"}');
						{/if}
					{rdelim});
					function show_popup(item, title) {ldelim}
						var html = $('#popup' + item).html();
						if (typeof title === 'undefined' || title.length === 0) {ldelim}
							title = $(html).find('h3').text();
						{rdelim}
						eModal(title,html);
					{rdelim}
				</script>
			{/inline_script}
		{/if}
	{/block}
{/block}