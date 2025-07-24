{block name='snippets-social-profiles'}
	<ul class="social-icons {if isset($tplscope) && $tplscope == 'footer'}flx-ac flx-jc flx-w blanklist{else}list-inline{/if}">
		{block name='social-facebook'}
			{if !empty($snackyConfig.facebook)}
				<li>
					<a href="{if strpos($snackyConfig.facebook, 'http') !== 0}https://{/if}{$snackyConfig.facebook}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.twitter, 'http') !== 0}https://{/if}{$snackyConfig.twitter}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.youtube, 'http') !== 0}https://{/if}{$snackyConfig.youtube}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.vimeo, 'http') !== 0}https://{/if}{$snackyConfig.vimeo}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.pinterest, 'http') !== 0}https://{/if}{$snackyConfig.pinterest}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.instagram, 'http') !== 0}https://{/if}{$snackyConfig.instagram}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.skype, 'http') !== 0}https://{/if}{$snackyConfig.skype}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-skype" title="Skype" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.xing, 'http') !== 0}https://{/if}{$snackyConfig.xing}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-xing" title="Xing" target="_blank" rel="noopener">
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
					<a href="{if strpos($snackyConfig.linkedin, 'http') !== 0}https://{/if}{$snackyConfig.linkedin}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social flx-ac flx-jc{else}img-ct{/if} icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
							<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-linkedin"></use>
						</svg>
					</a>
				</li>
			{/if}
		{/block}
	</ul>
{/block}