{block name='snackys-content-image'}
	<div class="image {$entry->cClass}">
		{if $entry->cLink != ""}<a href="{$entry->cLink}">{/if}
		{block name='snackys-content-image-image'}
			<span class="img-ct{if !empty($entry->cWidth) && !empty($entry->cHeight)} c-ratio{/if}">
				{if !empty($entry->cWidth) && !empty($entry->cHeight)}
					<span class="block" style="padding-top: calc({$entry->cHeight} / {$entry->cWidth} * 100%);"></span>
				{/if}
				{if $entry->cLazyLoading == "0"}
					{if $entry->cBild|webpExists}
						{image src=$entry->cBild alt="{$entry->cAltTag}" webp=true}
					{else}
						{image src=$entry->cBild alt="{$entry->cAltTag}"}
					{/if}
				{else} 
					{if $entry->cBild|webpExists}
						{image src=$entry->cBild alt="{$entry->cAltTag}" lazy=true webp=true}
					{else}
						{image src=$entry->cBild alt="{$entry->cAltTag}" lazy=true}
					{/if}
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