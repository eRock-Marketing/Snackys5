{block name='snippets-extension'}
{assign var='isQuickview' value=isset($smarty.get.quickView) && $smarty.get.quickView == 1}
{if !$isQuickview}
	{if $snackyConfig.fwSlider == 1}
		{assign "fwSlider" "false"}
	{else}
		{assign "fwSlider" "true"}
	{/if}
	{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5}
		{assign "fwHeader" "true"}
	{else}
		{assign "fwHeader" "false"}
	{/if}
    {if (isset($oSlider) && count($oSlider->getSlides()) > 0) || isset($oImageMap)}
        <div id="extension-container">
        {if (($snackyConfig.fullscreenElement != 1 && $fwHeader == 'true') || $fwHeader == 'false') && (isset($oSlider) && count($oSlider->getSlides()) > 0)}
            <div class="{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}mw-container {/if}mb-spacer">
              {include file="snippets/slider.tpl"}
            </div>
        {/if}
        {if (($snackyConfig.fullscreenElement != 2 && $fwHeader == 'true') || $fwHeader == 'false') && isset($oImageMap)}
            <div class="{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}mw-container {/if}mb-spacer">
              {include file="snippets/banner.tpl"}
            </div>
        {/if}
        </div>
    {/if}
{/if}
{/block}