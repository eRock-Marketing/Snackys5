{block name='productdetails-attributes'}
{if $showAttributesTable}
    <ul class="product-attributes blanklist p-att">
    {block name='productdetails-attributes-main'}
        {if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
            {block name='productdetails-attributes-characteristics'}
                {foreach $Artikel->oMerkmale_arr as $oMerkmal}
                    <li class="dpflex">
                        <strong class="first mr-xxs">{$oMerkmal->cName}: </strong>
                        {strip}
                        <span class="right dpflex-a-c dpflex-wrap">
                            {foreach $oMerkmal->oMerkmalWert_arr as $oMerkmalWert}
                                {if $oMerkmal->cTyp === 'TEXT' || $oMerkmal->cTyp === 'SELECTBOX' || $oMerkmal->cTyp === ''}
                                    <a href="{$oMerkmalWert->cURLFull}" class="tag">{$oMerkmalWert->cWert|escape:'html'}</a>
                                {else}
                                    <a href="{$oMerkmalWert->cURLFull}" data-toggle="tooltip" data-placement="top" title="{$oMerkmalWert->cWert|escape:'html'}">
                                        {if $oMerkmalWert->cBildpfadKlein !== 'gfx/keinBild_kl.gif'}
                                            <span class="img-ct icon icon-xl">
                                            {include file='snippets/image.tpl'
                                                item=$oMerkmalWert
                                                square=false
                                                srcSize='xs'
                                                sizes='40px'
                                                width='40'
                                                height='40'
                                                class='img-aspect-ratio'
                                                alt=$oMerkmalWert->cWert}
                                            </span>
                                        {else}
                                            <span class="tag">{$oMerkmalWert->cWert|escape:'html'}</span>
                                        {/if}
                                    </a>
                                {/if}
                            {/foreach}
                        </span>
                        {/strip}
                    </li>
                {/foreach}
            {/block}
        {/if}

        {if $showShippingWeight}
            {block name='productdetails-attributes-shipping-weight'}
                <li class="dpflex-a-c">
                    <strong class="first mr-xxs">{lang key='shippingWeight' section='global'}: </strong>
                    <span class="tag">{$Artikel->cGewicht} {lang key='weightUnit' section='global'}</span>
                </li>
            {/block}
        {/if}

        {if $showProductWeight}
            {block name='productdetails-attributes-product-weight'}
                <li class="dpflex-a-c">
                    <strong class="first mr-xxs">{lang key='productWeight' section='global'}: </strong>
                    <span class="tag">{$Artikel->cArtikelgewicht} {lang key='weightUnit' section='global'}</span>
                </li>
            {/block}
        {/if}

        {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
            {block name='productdetails-attributes-unit'}
                <li class="dpflex-a-c">
                    <strong class="first mr-xxs">{lang key='contents' section='productDetails'}: </strong>
                    <span class="tag">{$Artikel->cMassMenge} {$Artikel->cMasseinheitName}</span>
                </li>
            {/block}
        {/if}

        {if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
            {block name='productdetails-attributes-dimensions'}
                {assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
                {if $dimensionArr|count > 0}
                    <li class="dpflex-a-c">
                        <strong class="first mr-xxs">{lang key='dimensions' section='productDetails'}
                            <br><small>({foreach $dimensionArr as $dimkey => $dim}
                            {$dimkey}{if $dim@last}{else} &times; {/if}
                            {/foreach}):</small>
                        </strong>
                        <span class="tag">
                        {foreach $dimensionArr as $dim}
                            {$dim}{if $dim@last} cm {else} &times; {/if}
                        {/foreach}
                        </span>
                    </li>
                {/if}
            {/block}
        {/if}

        {assign var=funcAttrVal value=$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0}
        {if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $funcAttrVal == 1}
            {block name='productdetails-attributes-shop-attributes'}
                {foreach $Artikel->Attribute as $Attribut}
                    <li class="dpflex-a-c">
                        <strong class="first mr-xxs">{$Attribut->cName}: </strong>
                        <span class="tag">{$Attribut->cWert}</span>
                    </li>
                {/foreach}
            {/block}
        {/if}
    {/block}
    </ul>
{/if}
{/block}
