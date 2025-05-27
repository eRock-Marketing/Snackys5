{block name='snippets-slider'}
    {if isset($oSlider) && count($oSlider->getSlides()) > 0}
        {include file="snippets/zonen.tpl" id="opc_before_slider"}
        <div class="sl-w panel-slider t-{$oSlider->getTheme()}">
            {if isset($oSlider) && count($oSlider->getSlides()) > 1 && !$isMobile && $oSlider->getPauseTime()<=300}
                <span class="sl-ar sl-pr btn inactive">
                    <span class="ar ar-l"></span>
                </span>
            {/if}
            <div id="slider-{$oSlider->getID()}" class="fw-sl no-scrollbar"{if $oSlider->getPauseTime()>300} data-autoplay="{$oSlider->getPauseTime()}"{/if}>
                {foreach from=$oSlider->getSlides() item=oSlide name="slides"}
                    {assign var="slideTitle" value=$oSlide->getTitle()}
                    {if !empty($oSlide->getText())}
                        {assign var="slideTitle" value="#slide_caption_{$oSlide->getID()}"}
                    {/if}
                    {if !empty($oSlide->getLink())}
                        <a href="{$oSlide->getLink()}" class="slide" id="slide-{$oSlide->getID()}">
                    {else}
                        <div class="slide" id="slide-{$oSlide->getID()}">
                    {/if}
                    <div class="img-ct">
                        {if $smarty.foreach.slides.first && $snackyConfig.nolazyloadSlider == 'Y'}
                            {image src=$oSlide->getAbsoluteImage() lazy=false alt="{if !empty($oSlide->getTitle())}{$oSlide->getTitle()}{else}Slide{/if}"}
                        {else}
                            {image src=$oSlide->getAbsoluteImage() lazy=true alt="{if !empty($oSlide->getTitle())}{$oSlide->getTitle()}{else}Slide{/if}"}
                        {/if}
                    </div>
                    {if !empty($oSlide->getText()) || !empty($oSlide->getTitle())}
                        <div id="slide_caption_{$oSlide->getID()}" class="htmlcaption">
                            {if isset($oSlide->getTitle())}<strong class="title block">{$oSlide->getTitle()}</strong>{/if}
                            <p class="desc m0">{$oSlide->getText()}</p>
                        </div>
                    {/if}
                    {if !empty($oSlide->getLink())}
                        </a>
                    {else}
                        </div>
                    {/if}
                {/foreach}
            </div>
            {if isset($oSlider) && count($oSlider->getSlides()) > 1 && !$isMobile && $oSlider->getPauseTime()<=300}
                <span class="sl-ar sl-nx btn">
                    <span class="ar ar-r"></span>
                </span>
            {/if}
        </div>
        
        {assign var="firstSlide" value=$oSlider->getSlides()}
        {getSizeBySrc src="{$firstSlide[0]->getAbsoluteImage()}" cAssign="sliderSize"}
        {if !empty($sliderSize.padding)}
        <style type="text/css">
        .fw-sl .img-ct:before {ldelim} padding-top: {$sliderSize.padding}%;{rdelim}
        </style>
        {/if}
        {include file="snippets/zonen.tpl" id="opc_after_slider"}
    {/if}
{/block}