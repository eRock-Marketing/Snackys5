{block name='boxes-box-last-seen'}
{if $isMobile && $oBox->getPosition() == 'left'}
{else}
    {lang key='lastViewed' assign='boxtitle'}
    <section class="box box-last-seen box-normal panel" id="sidebox{$oBox->getID()}"}>
        {block name='boxes-box-last-seen-content'}
            {block name='boxes-box-last-seen-title'}
                <div class="h5 panel-heading dpflex-a-c">
                    {$boxtitle}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-last-seen-image-link'}
                <div class="panel-body">
                    <ul class="nav">
                        {foreach $oBox->getProducts() as $product}
                            <li class="dpflex-a-center nav-it">
                                <a class="img-ct icon ic-lg icon-wt" href="{$product->cURLFull}">
                                    {include file='snippets/image.tpl' item=$product srcSize='sm'}
                                </a>
                                <div class="block">
                                    {link class="productbox-title" href=$product->cURLFull}
                                        {$product->cKurzbezeichnung}
                                    {/link}
                                    {* include file='productdetails/price.tpl' Artikel=$product tplscope='box' *}
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {/block}
        {/block}
    </section>
{/if}
{/block}