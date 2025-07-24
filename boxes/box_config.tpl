{* Not available in Shop5 *}
{*
{block name='boxes-box-config'}
<section class="panel panel-default box autoscroll box-config hidden" id="sidebox{$oBox->getID()}">
    <div class="panel-heading">
        <div class="panel-title">{lang key='yourConfiguration'}</div>
        {if ($snackyConfig.filterOpen == 1 && $oBox->position == 'left') || $oBox->position == 'bottom'}<span class="caret"></span>{/if}
    </div>
    <div class="box-body panel-body">
        <div id="box_config_list">
            <!-- ul itemlist -->
        </div>
        <div id="box_config_price">
            <span class="price_div">{lang key='priceAsConfigured' section='productDetails'}</span>
            <span class="price updateable"><!-- price --></span>
            {if $Artikel->cLocalizedVPE[$NettoPreise]}
                <small class="price_base updateable">{$Artikel->cLocalizedVPE[$NettoPreise]}</small>
                <br />
            {/if}
            <span class="vat_info">
                {include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
            </span>
        </div>
    </div>
</section>
{/block}
*}