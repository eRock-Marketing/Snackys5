{block name='snippets-social-profiles'}
<ul class="social-icons {if isset($tplscope) && $tplscope == 'footer'}dpflex-a-center dpflex-j-center dpflex-wrap blanklist{else}list-inline{/if}">
{if !empty($snackyConfig.facebook)}
	<li>
	<a href="{if $snackyConfig.facebook|strpos:'http' !== 0}https://{/if}{$snackyConfig.facebook}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-facebook"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.twitter)}
	<li>
	<a href="{if $snackyConfig.twitter|strpos:'http' !== 0}https://{/if}{$snackyConfig.twitter}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-twitter"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.googleplus)}
	<li>
	<a href="{if $snackyConfig.googleplus|strpos:'http' !== 0}https://{/if}{$snackyConfig.googleplus}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-googleplus" title="Google+" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-google-plus"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.youtube)}
	<li>
	<a href="{if $snackyConfig.youtube|strpos:'http' !== 0}https://{/if}{$snackyConfig.youtube}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-youtube"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.vimeo)}
	<li>
	<a href="{if $snackyConfig.vimeo|strpos:'http' !== 0}https://{/if}{$snackyConfig.vimeo}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-vimeo"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.pinterest)}
	<li>
	<a href="{if $snackyConfig.pinterest|strpos:'http' !== 0}https://{/if}{$snackyConfig.pinterest}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-pinterest"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.instagram)}
	<li>
	<a href="{if $snackyConfig.instagram|strpos:'http' !== 0}https://{/if}{$snackyConfig.instagram}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-instagram"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.skype)}
	<li>
	<a href="{if $snackyConfig.skype|strpos:'skype:' !== 0}skype:{$snackyConfig.skype}?add{else}{$snackyConfig.skype}{/if}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-skype" title="Skype" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-skype"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.xing)}
	<li>
	<a href="{if $snackyConfig.xing|strpos:'http' !== 0}https://{/if}{$snackyConfig.xing}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-xing" title="Xing" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-xing"></use>
		</svg>
	</a>
	</li>
{/if}
{if !empty($snackyConfig.linkedin)}
	<li>
	<a href="{if $snackyConfig.linkedin|strpos:'http' !== 0}https://{/if}{$snackyConfig.linkedin}" class="{if isset($tplscope) && $tplscope == 'footer'}btn-social dpflex-a-center dpflex-j-center{else}img-ct{/if} icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true' || (isset($tplscope) && $tplscope == 'footer')}icon-darkmode{/if}">
		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-linkedin"></use>
		</svg>
	</a>
	</li>
{/if}
</ul>
{/block}