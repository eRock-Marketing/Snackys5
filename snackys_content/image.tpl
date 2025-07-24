{block name='snackys-content-image'}
	<div class="image {$entry->cClass}">
		{if $entry->cLink != ""}<a href="{$entry->cLink}">{/if}
		{block name='snackys-content-image-image'}
			<span class="img-ct">
				{if $entry->cBild|webpExists}
					{image src=$entry->cBild alt="{$entry->cAltTag}" lazy=true webp=true}
				{else}
					{image src=$entry->cBild alt="{$entry->cAltTag}" lazy=true}
				{/if}
			</span>
		{/block}
		{block name='snackys-content-image-caption'}
			{if $entry->cCaption != ""}
				<span class="block caption">{$entry->cCaption}</span>
			{/if}
		{/block}
		{if $entry->cLink != ""}</a>{/if}
	</div>
{/block}