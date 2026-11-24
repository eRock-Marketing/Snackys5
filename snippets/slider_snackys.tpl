{block name='snippets-slider'}
    {if isset($oSlider) && count($oSlider->getSlides()) > 0}
        {if $snackyConfig.old_content_ids === 'Y'}
            {include file="snippets/zonen.tpl" id="opc_before_slider"}
        {else}
            {include file="snippets/zonen.tpl" id="before_slider"}
        {/if}
        <div class="sl-w panel-slider t-{$oSlider->getTheme()}">
            {if $oSlider->getDirectionNav()}
                <div class="sl-ar sl-pr btn">
                    <span class="ar ar-l"></span>
                </div>
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
            {if $oSlider->getDirectionNav()}
                <div class="sl-ar sl-nx btn">
                    <span class="ar ar-r"></span>
                </div>
            {/if}
            {if $oSlider->getPauseTime()>300}
                <div class="sl-stp">
                    <button type="button" class="btn play" aria-label="{lang key='play' section='aria'}">
                        <span class="play">⏵︎</span>
                    </button>
                    <button type="button" class="btn pause" aria-label="{lang key='pause' section='aria'}">
                        <span class="pause">⏸︎</span>
                    </button>
                </div>
            {/if}
            {if $oSlider->getControlNav()}
                <div class="sl-dots flx-ac flx-jc">
                    {foreach from=$oSlider->getSlides() item=oSlide name="dots"}
                        <button type="button" data-slide="{$smarty.foreach.dots.iteration}" aria-label="Slide {$smarty.foreach.dots.iteration}"{if $smarty.foreach.dots.iteration == 1} class="active"{/if}></button>
                    {/foreach}
                </div>
            {/if}
        </div>
        
        {assign var="firstSlide" value=$oSlider->getSlides()}
        {getSizeBySrc src="{$firstSlide[0]->getAbsoluteImage()}" cAssign="sliderSize"}
        {if !empty($sliderSize.padding)}
        <style type="text/css">
        .fw-sl .img-ct:before {ldelim} padding-top: {$sliderSize.padding}%;{rdelim}
        </style>
        {/if}
        {if $snackyConfig.old_content_ids === 'Y'}
            {include file="snippets/zonen.tpl" id="opc_after_slider"}
        {else}
            {include file="snippets/zonen.tpl" id="after_slider"}
        {/if}
    {/if}
{/block}