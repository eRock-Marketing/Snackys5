{block name='productdetails-mediafile-youtube-embed'}
	{$height     = 'auto'}
	{$width      = '100%'}
	{$related    = '?rel=0'}
	{$fullscreen = ' allowfullscreen'}
	{if (isset($oMedienDatei->oMedienDateiAttribut_arr) && count($oMedienDatei->oMedienDateiAttribut_arr) > 0)}
		{foreach $oMedienDatei->oMedienDateiAttribut_arr as $attr}
			{if $attr->cName === 'related' && $attr->cWert === '1'}
				{$related = ''}
			{elseif $attr->cName === 'width' && is_numeric($attr->cWert)}
				{$width = $attr->cWert}
			{elseif ($attr->cName === 'height' && is_numeric($attr->cWert))}
				{$height = $attr->cWert}
			{elseif ($attr->cName === 'fullscreen' && ($attr->cWert === '0' || $attr->cWert === 'false'))}
				{$fullscreen = ''}
			{/if}
		{/foreach}
	{/if}
	{$search                     = ['https://', 'youtu.be/', 'watch?v=']}
	{$replace                    = ['//', 'youtube.com/embed/', 'embed/']}
	{$embedURL                   = str_replace($search, $replace, $oMedienDatei->cURL)}
	<div class="img-ct rt16x9 consent-ct">
		<a href="#" class="trigger give-consent btn btn-primary btn-xs" data-consent="youtube">Youtube Consent geben</a>
		<iframe class="needs-consent youtube"
				data-consent="youtube"
				width="{$width}"
				height="{$height}"
				data-src="{$embedURL}{$related}"
				frameborder="0"{$fullscreen}>
		</iframe>
	</div>
{/block}