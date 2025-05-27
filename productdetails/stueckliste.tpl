{block name='productdetails-stueckliste'}
    {block name='stueckliste-assigns'}
        {if !isset($tplscope)}
            {assign var="tplscope" value=0}
        {/if}
    {/block}
    {block name='stueckliste-slider'}
        <section class="panel-slider panel-default mb-lg"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
            {block name='stueckliste-slider-heading'}
                <div class="panel-heading">
                    <div class="panel-title flx-ac flx-jb mb-xs">
                        {block name='stueckliste-slider-heading-title'}
                            <span class="h2 m0 block">{$title}</span>
                        {/block}
                        {block name='stueckliste-slider-heading-desktop-arrows'}
                            <div class="right">
                                {if !$isMobile}
                                    <div class="ar-ct btn-group{if $productlist|@count > $snackyConfig.css_listElmXl} show-xl{/if}{if $productlist|@count > $snackyConfig.css_listElmLg} show-lg{/if}{if $productlist|@count > $snackyConfig.css_listElmMd} show-md{/if}{if $productlist|@count > $snackyConfig.css_listElmSm} show-sm{/if}{if $productlist|@count > $snackyConfig.css_listElmXs} show-xs{/if}">
                                        <span class="sl-ar sl-pr btn inactive">
                                            <span class="ar ar-l"></span>
                                        </span>
                                        <span class="sl-ar sl-nx btn">
                                            <span class="ar ar-r"></span>
                                        </span>
                                    </div>
                                {/if}
                            </div>
                        {/block}
                    </div>
                </div>
            {/block}
            {block name='stueckliste-slider-body'}
                <div class="panel-body">
                    {block name='stueckliste-slider-body-mobile-arrows'}
                        {if $isMobile}
                            <div class="row ar-ct-m">
                                <div class="col-12 ar-ct{if $productlist|@count > $snackyConfig.css_listElmXl} show-xl{/if}{if $productlist|@count > $snackyConfig.css_listElmLg} show-lg{/if}{if $productlist|@count > $snackyConfig.css_listElmMd} show-md{/if}{if $productlist|@count > $snackyConfig.css_listElmSm} show-sm{/if}{if $productlist|@count > $snackyConfig.css_listElmXs} show-xs{/if}">
                                    <span class="sl-ar sl-pr btn inactive">
                                        <span class="ar ar-l"></span>
                                    </span>
                                    <span class="sl-ar sl-nx btn">
                                        <span class="ar ar-r"></span>
                                    </span>
                                </div>
                            </div>
                        {/if}
                    {/block}
                    {block name='stueckliste-slider-body-items'}
                        <div class="row p-sl no-scrollbar flx-nw{if isset($isBox)} sidebar{/if}">
                            {foreach name="sliderproducts" from=$productlist item='product'}
                                <div class="col-lg-2 p-w{if isset($style)} {$style}{/if}">
                                    {include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
                                </div>
                            {/foreach}
                        </div>
                    {/block}
                </div>
            {/block}
        </section>
    {/block}
{/block}