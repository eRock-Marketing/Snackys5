<div class="h4">{$Suchergebnisse->getSearchTermWrite()}</div>

{if $Suchergebnisse->getProducts()|count > 0}
<ul class="blanklist nav">
    {foreach name=artikel from=$Suchergebnisse->getProducts() item=Artikel}
        <li class="nav-it">
			<a href="{$Artikel->getURL()}" class="flx-ac">
				<span class="img-ct">
					{include file='snippets/image.tpl'
						fluid=false
						item=$Artikel
						square=false
						srcSize='xs'
						sizes='45px'
						class='img-sm'}
				</span>
				{$Artikel->cKurzbezeichnung} 
			</a>
		</li>
    {/foreach}
</ul>
{/if}