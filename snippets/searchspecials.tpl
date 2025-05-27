{*
	In Snackys as text, not real images
	{block name='snippets-searchspecials'}
	<img class="overlay-img hidden-xs"
		 srcset="{$Artikel->oSuchspecialBild->getURL($smarty.const.IMAGE_SIZE_XS)},
				 {$Artikel->oSuchspecialBild->getURL($smarty.const.IMAGE_SIZE_SM)} 2x,
				 {$Artikel->oSuchspecialBild->getURL($smarty.const.IMAGE_SIZE_MD)} 3x,
				 {$Artikel->oSuchspecialBild->getURL($smarty.const.IMAGE_SIZE_LG)} 4x"
		 src="{$src}"
		 alt="{if isset($Artikel->oSuchspecialBild->getName())}{$Artikel->oSuchspecialBild->getName()}{else}{$alt}{/if}"/>
	{/block}
*}