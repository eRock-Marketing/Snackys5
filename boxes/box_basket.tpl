{block name='boxes-box-basket'}
{if $isMobile && $oBox->getPosition() == 'left'}
{else}
{if $smarty.session.Warenkorb->PositionenArr|@count > 0}
<section class="panel small" id="sidebox{$oBox->getID()}">
    {block name='boxes-box-basket-content'}
        {block name='boxes-box-basket-title'}
            <div class="h5 panel-heading dpflex-a-center">
                {lang key='yourBasket'}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
        {/block}
        {block name='boxes-box-basket-body'}
        <div class="panel-body">
            <div class="dpflex-a-center mb-xs">
                <div class="ic-bd dpflex-a-center dpflex-j-center icon-wt">
                    <span class="img-ct icon ic-lg">
                        <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                        </svg>
                    </span>
                </div>
                {$Warenkorbtext}
            </div>
            <a href="{get_static_route id='warenkorb.php'}" class="btn btn-block btn-primary btn-xs">
                {lang key='gotoBasket'}
            </a>
        </div>
        {/block}
    {/block}
</section>
{/if}
{/if}
{/block}