{block name='boxes-box-comparelist'}
{if $isMobile && $oBox->getPosition() == 'left'}
{else}
	{if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
    {assign var=maxItems value=$oBox->getItemCount()}
    {assign var=itemCount value=count($oBox->getProducts())}
    {if $itemCount > 0}
        <section class="panel box box-compare box-normal small" id="sidebox{$oBox->getID()}">
            {block name='boxes-box-comparelist-content'}
                {block name='boxes-box-comparelist-title'}
                    <div class="h5 panel-heading dpflex-a-center">
                        {lang key='compare'}
                        {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                    </div>
                {/block}
                {block name='boxes-box-comparelist-collapse'}
                <div class="panel-body">
                    {block name='boxes-box-comparelist-products'}
                        {$id = '"a"'|escape:'html'}
                        {foreach $oBox->getProducts() as $product}
                            {if $product@iteration > $maxItems}
                                {break}
                            {/if}
                            <div class="dpflex-a-center mb-xxs small" data-id="{$product->kArtikel}">
                                {block name='boxes-box-comparelist-dropdown-products-image-title'}
                                    {block name='boxes-box-comparelist-dropdown-products-image'}
                                        <a href="{$product->cURLFull}" class="img-ct icon ic-lg icon-wt">
                                            {include file='snippets/image.tpl' item=$product square=false srcSize='xs' sizes='45px'}
                                        </a>
                                    {/block}
                                    {block name='boxes-box-comparelist-dropdown-products-title'}
                                        <a href="$product->cURLFull}" class="defaultlink">{$product->cName|truncate:40:'...'}</a>
                                    {/block}
                                {/block}
                                {block name='boxes-box-comparelist-dropdown-products-remove'}
                                    {link href=$product->cURLDEL class="remove"
                                        title="{lang section="comparelist" key="removeFromCompareList"}"
                                        data=["name"=>"Vergleichsliste.remove",
                                        "toggle"=>"product-actions",
                                        "value"=>"{ldelim}{$id}:{$product->kArtikel}{rdelim}"]
                                        aria=["label"=>{lang section="comparelist" key="removeFromCompareList"}]}
                                        <span class="img-ct icon">
                                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                            </svg>
                                        </span>
                                    {/link}
                                {/block}
                            </td>
                            </div>
                        {/foreach}
                    {/block}
                    {if $itemCount > 1}
                        {block name='boxes-box-comparelist-link'}
                            <hr class="hr-sm">
                            {link
                                class="btn btn-outline-primary btn-sm btn-block{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'popup'} popup{/if}"
                                href="{get_static_route id='vergleichsliste.php'}"
                                target="{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'}_blank{else}_self{/if}"
                            }
                               {lang key='gotToCompare'}
                            {/link}
                        {/block}
                    {/if}
                </div>
                {/block}
            {/block}
        </section>
    {else}
        {block name='blog-preview-no-items'}
            <section class="d-none box-compare" id="sidebox{$oBox->getID()}"></section>
        {/block}
    {/if}
    {/if}
{/if}
{/block}