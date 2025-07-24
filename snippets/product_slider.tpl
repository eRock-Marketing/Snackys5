{block name='snippets-product-slider'}
{strip}
{if $productlist|@count > 0}
    {if !isset($tplscope)}
        {assign var='tplscope' value='slider'}
    {/if}
    <section class="panel-slider{if $title|strlen > 0} panel-default{/if}{if $tplscope === 'box'} box b-sl panel{/if}{if isset($class) && $class|strlen > 0} {$class}{/if}{if $nSeitenTyp === 18} mb-spacer{/if}"{if isset($id) && $id|strlen > 0} id="{$id}"{/if}>
        <div class="panel-heading">
            <div class="panel-title{if !isset($isBox)} dpflex-a-center dpflex-j-between mb-spacer mb-xs{/if}{if $tplscope == 'box'} h5 m0 dpflex-a-center dpflex-j-between{/if}">
                {if $title|strlen > 0}   
                    {if $tplscope !== 'box'}
                        <span class="{if !isset($isBox)}h2 m0 block{else}h5 block{/if}">{$title}</span>
                    {else}
                        {$title}
                    {/if}
                    {assign var="gtagTitle" value="PSlider - {$title|escape}"}
                {else}
                    {assign var="gtagTitle" value="Produkt Slider"}
                {/if}
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
                    {if !empty($moreLink)}
                        <a class="btn btn-primary" href="{$moreLink}" title="{$moreTitle}" data-toggle="tooltip" data-placement="auto right" aria-label="{$moreTitle}">
                            <span class="hidden-xs">
                            {lang key="showAll" section="global"}
                            </span>
                            <span class="visible-xs">
                                <span class="ar ar-r"></span>
                            </span>
                        </a>
                    {/if}
                </div>
                {else}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                {/if}
            </div>
            {if !empty($desc)}<div class="desc mb-spacer mb-xs">{$desc}</div>{/if}
        </div>
        <div class="panel-body">
			{if $isMobile || $tplscope === 'box'}
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
                    <div class="col-lg-2 p-w">
                        {include file='productlist/item_slider.tpl' Artikel=$product tplscope=$tplscope class=''}
                    </div>
                {/foreach}
            </div>
        </div>
    </section>{* /panel *}
{/if}
{/strip}
{/block}