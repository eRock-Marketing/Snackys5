{block name='snippets-video'}
	<div class="video-background">
		<video autoplay loop muted preload="auto" {if !empty($snackyConfig.videoPhURL)}poster="{$snackyConfig.videoPhURL|escape:'html'}"{/if} playsinline>
			<source src="{$snackyConfig.youtubeID|escape:'html'}" type="video/mp4">
		</video>
	</div>
{/block}