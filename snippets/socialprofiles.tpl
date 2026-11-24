{block name='snippets-social-profiles'}
	<ul class="social-icons {if isset($tplscope) && $tplscope == 'footer'}flx-ac flx-jc flx-w blanklist{else}list-inline{/if}">
		{block name='social-facebook'}
			{if !empty($snackyConfig.facebook)}
				<li>
					<a href="{if strpos($snackyConfig.facebook, 'http') !== 0}https://{/if}{$snackyConfig.facebook|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-facebook" title="Facebook" aria-label="Facebook" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-facebook"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-twitter'}
			{if !empty($snackyConfig.twitter)}
				<li>
					<a href="{if strpos($snackyConfig.twitter, 'http') !== 0}https://{/if}{$snackyConfig.twitter|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-twitter" title="Twitter" aria-label="Twitter" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-twitter"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-youtube'}
			{if !empty($snackyConfig.youtube)}
				<li>
					<a href="{if strpos($snackyConfig.youtube, 'http') !== 0}https://{/if}{$snackyConfig.youtube|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-youtube" title="YouTube" aria-label="YouTube" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-youtube"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-vimeo'}
			{if !empty($snackyConfig.vimeo)}
				<li>
					<a href="{if strpos($snackyConfig.vimeo, 'http') !== 0}https://{/if}{$snackyConfig.vimeo|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-vimeo" title="Vimeo" aria-label="Vimeo" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-vimeo"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-pinterest'}
			{if !empty($snackyConfig.pinterest)}
				<li>
					<a href="{if strpos($snackyConfig.pinterest, 'http') !== 0}https://{/if}{$snackyConfig.pinterest|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-pinterest" title="Pinterest" arial-label="Pinterest" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-pinterest"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-instagram'}
			{if !empty($snackyConfig.instagram)}
				<li>
					<a href="{if strpos($snackyConfig.instagram, 'http') !== 0}https://{/if}{$snackyConfig.instagram|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-instagram" title="Instagram" aria-label="Instagram" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-instagram"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-skype'}
			{if !empty($snackyConfig.skype)}
				<li>
					<a href="{if strpos($snackyConfig.skype, 'http') !== 0}https://{/if}{$snackyConfig.skype|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-skype" title="Skype" aria-label="Skype" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-skype"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-xing'}
			{if !empty($snackyConfig.xing)}
				<li>
					<a href="{if strpos($snackyConfig.xing, 'http') !== 0}https://{/if}{$snackyConfig.xing|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-xing" title="Xing" aria-label="Xing" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-xing"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-linkedin'}
			{if !empty($snackyConfig.linkedin)}
				<li>
					<a href="{if strpos($snackyConfig.linkedin, 'http') !== 0}https://{/if}{$snackyConfig.linkedin|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-linkedin" title="Linkedin" aria-label="Linkedin" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-linkedin"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
		{block name='social-tiktok'}
			{if !empty($snackyConfig.tiktok)}
				<li>
					<a href="{if strpos($snackyConfig.tiktok, 'http') !== 0}https://{/if}{$snackyConfig.tiktok|escape:'html'}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-tiktok" title="TikTok" aria-label="TikTok" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-tiktok"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
	</ul>
{/block}