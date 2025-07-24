{block name='boxes-box-direct-purchase'}
    <section class="panel box box-direct-purchase box-normal" id="sidebox{$oBox->getID()}"}>
        {block name='boxes-box-direct-purchase-title'}
            <div class="h5 panel-heading dpflex-a-c">
                {lang key='quickBuy'}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
        {/block}
        {block name='boxes-box-direct-purchase-form'}
        <div class="panel-body">
            {form action="{get_static_route id='warenkorb.php'}" method="post" slide=true}
                {input type="hidden" name="schnellkauf" value="1"}
                {inputgroup}
                    {input aria=["label"=>"{lang key='quickBuy'}"] type="text" placeholder="{lang key='productNoEAN'}"
                           name="ean" id="quick-purchase" class="small"}
                    <div class="input-group-btn">
                        {button type="submit" variant="secondary" title="{lang key='intoBasket'}"}
                            <span class="img-ct icon">
                                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                                </svg>
                            </span>
                        {/button}
                    </div>
                {/inputgroup}
            {/form}
        </div>
        {/block}
    </section>
{/block}
