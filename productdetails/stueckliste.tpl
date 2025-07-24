{block name='productdetails-stueckliste'}
<section class="panel-slider panel-default mb-spacer"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
    <div class="panel-heading">
        <div class="panel-title dpflex-a-center dpflex-j-between mb-spacer mb-xs">
            <span class="h2 m0 block">{$title}</span>
            {if $tplscope !== 'box'}
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
            {/if}
        </div>
    </div>
	<div class="panel-body">
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
		<div class="row p-sl no-scrollbar dpflex-nowrap{if isset($isBox)} sidebar{/if}">
			{foreach name="sliderproducts" from=$productlist item='product'}
                <div class="col-lg-2 p-w{if isset($style)} {$style}{/if}">
                    {include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
                </div>
			{/foreach}
		</div>
	</div>
</section>
{/block}