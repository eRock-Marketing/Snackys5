{block name='comparelist-index'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
	{include file="snippets/zonen.tpl" id="opc_before_heading"}
	
    <h1 class="text-center mb-sm">{lang key="compare" section="global"}</h1>

    {include file="snippets/extension.tpl"}

    {if $oVergleichsliste->oArtikel_arr|@count >1}
		{include file="snippets/zonen.tpl" id="opc_before_compare_list"}
        {* Image Row *}
        <div class="row cpr-f dpflex-j-center first">
        {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
            <div class="col- text-center">
                <div class="is">
                    <a href="{$oArtikel->cURLFull}" class="block">
                        <span class="img-w block mb-sm">
                            <span class="img-ct">
                                {image src=$oArtikel->cVorschaubild alt=$oArtikel->cName class="image"}
                            </span>
                        </span>
                        <span class="title h4 mt-xs block m0">{$oArtikel->cName}</span>
                    </a>
                    <a href="{$oArtikel->cURLDEL}" data-id="{$oArtikel->kArtikel}" class="close-btn">
                    </a>
                </div>
            </div>
        {/foreach}
        </div>
        {* Price Row *}
        <div class="row cpr-f dpflex-j-center mt-xxs">
        {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
            <div class="col- text-center">
                {if $oArtikel->getOption('nShowOnlyOnSEORequest', 0) === 1}
                    <span class="block small">{lang key='productOutOfStock' section='productDetails'}</span>
                {elseif $oArtikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                    <span class="block small">{lang key='priceOnApplication' section='global'}</span>
                {else}
                    <span>
                        {include file='productdetails/price.tpl' Artikel=$oArtikel tplscope='detail'}
                    </span>
                {/if}
                <div class="mt-xs">
                    <a href="{$oArtikel->cURLFull}" class="btn btn-primary btn-block">{lang key="details"}</a>
                </div>
            </div>
        {/foreach}
        </div>
        {foreach $prioRows as $row}
            {if $row['key'] !== 'Merkmale' && $row['key'] !== 'Variationen'}
                <div class="row cpr-f dpflex-j-center {if isset($bAjaxRequest) && $bAjaxRequest}mt-sm{else}mt-lg{/if} title">
                {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                    <div class="col-">
                        {if $oArtikel@index == 0}
                        <div class="{if isset($bAjaxRequest) && $bAjaxRequest}h4{else}h3{/if} m0">{$row['name']}</div>
                        {/if}
                    </div>
                {/foreach}
                </div>
                <div class="row cpr-f dpflex-j-center{if isset($bAjaxRequest) && $bAjaxRequest}{else} text-lg{/if}" data-id="row-{$row['key']}">
                    {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        {if $row['key'] === 'verfuegbarkeit'}
                            <div class="col- text-center">
                                {include file='productdetails/stock.tpl' Artikel=$oArtikel availability=true}
                                {if $oArtikel->nErscheinendesProdukt}
                                    <div>
                                        {lang key='productAvailableFrom' section='global'}: <strong>{$oArtikel->Erscheinungsdatum_de}</strong>
                                        {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $oArtikel->inWarenkorbLegbar == 1}
                                            ({lang key='preorderPossible' section='global'})
                                        {/if}
                                    </div>
                                {/if}
                            </div>
                        {elseif $row['key'] === 'lieferzeit'}
                            <div class="col- text-center">{include file='productdetails/stock.tpl' Artikel=$oArtikel shippingTime=true}</div>
                        {elseif $oArtikel->$row['key'] !== ''}
                            <div class="col- text-center">
                                {if $row['key'] === 'fArtikelgewicht' || $row['key'] === 'fGewicht'}
                                    {$oArtikel->$row['key']} {lang key='weightUnit' section='comparelist'}
                                {else}
                                    {$oArtikel->$row['key']}
                                {/if}
                            </div>
                        {else}
                            <div class="col- text-center">--</div>
                        {/if}
                    {/foreach}
                </div>
            {/if}
            {if $row['key'] === 'Merkmale'}
                {foreach $oMerkmale_arr as $oMerkmale}
                    <div class="row cpr-f dpflex-j-center {if isset($bAjaxRequest) && $bAjaxRequest}mt-sm{else}mt-lg{/if} title">
                    {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                        <div class="col-">
                            {if $oArtikel@index == 0}
                            <div class="{if isset($bAjaxRequest) && $bAjaxRequest}h4{else}h3{/if} m0">{$oMerkmale->cName}</div>
                            {/if}
                        </div>
                    {/foreach}
                    </div>
                    <div class="row cpr-f dpflex-j-center{if isset($bAjaxRequest) && $bAjaxRequest}{else} text-lg{/if}" data-id="row-attr-{$oMerkmale->cName}">
                        {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                            <div class="col- text-center">
                                {if count($oArtikel->oMerkmale_arr) > 0}
                                    {foreach $oArtikel->oMerkmale_arr as $oMerkmaleArtikel}
                                        {if $oMerkmale->cName == $oMerkmaleArtikel->cName}
                                            {foreach $oMerkmaleArtikel->oMerkmalWert_arr as $oMerkmalWert}
                                                {$oMerkmalWert->cWert}{if !$oMerkmalWert@last}, {/if}
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                {else}
                                    --
                                {/if}
                            </div>
                        {/foreach}
                    </div>
                {/foreach}
            {/if}
            {if $row['key'] === 'Variationen'}
                {foreach $oVariationen_arr as $oVariationen}
                    <div class="row cpr-f dpflex-j-center mt-xxs" data-id="row-vari-{$oVariationen->cName}">
                        {foreach $oVergleichsliste->oArtikel_arr as $oArtikel}
                            <div class="col- text-center">
                                {if isset($oArtikel->oVariationenNurKind_arr) && $oArtikel->oVariationenNurKind_arr|@count > 0}
                                    {foreach $oArtikel->oVariationenNurKind_arr as $oVariationenArtikel}
                                        {if $oVariationen->cName == $oVariationenArtikel->cName}
                                            {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                                {$oVariationsWerte->cName}
                                                {if $oArtikel->nVariationOhneFreifeldAnzahl == 1 && ($oArtikel->kVaterArtikel > 0 || $oArtikel->nIstVater == 1)}
                                                    {assign var=kEigenschaftWert value=$oVariationsWerte->kEigenschaftWert}
                                                    ({$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if !empty($oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}, {$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                {/if}
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                {elseif $oArtikel->Variationen|@count > 0}
                                    {foreach $oArtikel->Variationen as $oVariationenArtikel}
                                        {if $oVariationen->cName == $oVariationenArtikel->cName}
                                            {foreach $oVariationenArtikel->Werte as $oVariationsWerte}
                                                {$oVariationsWerte->cName}
                                                {if $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationsWerte->fAufpreisNetto != 0}
                                                    ({$oVariationsWerte->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise]}{/if})
                                                {elseif $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationsWerte->fAufpreisNetto != 0}
                                                    ({$oVariationsWerte->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                {/if}
                                                {if !$oVariationsWerte@last},{/if}
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                {else}
                                    &nbsp;
                                {/if}
                            </div>
                        {/foreach}
                    </div>
                {/foreach}
            {/if}
        {/foreach}
    {else}
        <div class="alert alert-info">{lang key="compareListNoItems"}</div>
    {/if}
    
    {if isset($bAjaxRequest) && $bAjaxRequest}
		{inline_script}
        <script type="text/javascript">
            $('.modal a.remove').click(function(e) {
                var kArtikel = $(e.currentTarget).data('id');
                $('section.box-compare li[data-id="' + kArtikel + '"]').remove();
                eModal.ajax({
                    size: 'lg',
                    url: e.currentTarget.href,
                    title: '{lang key="compare" section="global"}',
                    keyboard: true,
                    tabindex: -1
                });
    
                return false;
            });
            new function(){
                var clCount = {if isset($oVergleichsliste->oArtikel_arr)}{$oVergleichsliste->oArtikel_arr|count}{else}0{/if};
				$('.navbar-nav .compare-list-menu .badge em').html(clCount);
                if (clCount > 1) {
                    $('section.box-compare .panel-body').removeClass('hidden');
                } else {
                    $('.navbar-nav .compare-list-menu .link_to_comparelist').removeAttr('href').removeClass('popup');
                    eModal.close();
                }
            }();
        </script>
		{/inline_script}
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}