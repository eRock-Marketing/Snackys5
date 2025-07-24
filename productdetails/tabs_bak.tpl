{block name='productdetails-tabs'}
{$tabanzeige = $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen !== 'N'}
{$showProductWeight = false}
{$showShippingWeight = false}
{if isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0
    && $Einstellungen.artikeldetails.artikeldetails_artikelgewicht_anzeigen === 'Y'}
    {$showProductWeight = true}
{/if}
{if isset($Artikel->cGewicht) && $Artikel->fGewicht > 0
    && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y'}
    {$showShippingWeight = true}
{/if}
{$dimension = $Artikel->getDimension()}
{$funcAttr = $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0}
{$showAttributesTable = ($Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'
    && !empty($Artikel->oMerkmale_arr) || $showProductWeight || $showShippingWeight
    || $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'
    && (!empty($dimension['length']) || !empty($dimension['width']) || !empty($dimension['height']))
    || isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0
    && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1)
    || ($Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y' || $funcAttr == 1)
    && !empty($Artikel->Attribute))}
{$useDescriptionWithMediaGroup = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YA'
    && $Artikel->cMedienDateiAnzeige !== 'tab') || $Artikel->cMedienDateiAnzeige === 'beschreibung')
    && !empty($Artikel->getMediaTypes()))}
{$useDescription = (($Artikel->cBeschreibung|strlen > 0) || $useDescriptionWithMediaGroup || $showAttributesTable)}
{$useDownloads = (isset($Artikel->oDownload_arr) && $Artikel->oDownload_arr|@count > 0)}
{$useVotes = $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
{$useQuestionOnItem = $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}
{$usePriceFlow = ($Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && $bPreisverlauf)}
{$useAvailabilityNotification = ($verfuegbarkeitsBenachrichtigung === 1)}
{$useMediaGroup = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YM'
    && $Artikel->cMedienDateiAnzeige !== 'beschreibung') || $Artikel->cMedienDateiAnzeige === 'tab')
    && !empty($Artikel->getMediaTypes()))}
{$hasVotesHash = isset($smarty.get.ratings_nPage)
    || isset($smarty.get.bewertung_anzeigen)
    || isset($smarty.get.ratings_nItemsPerPage)
    || isset($smarty.get.ratings_nSortByDir)
    || isset($smarty.get.btgsterne)}
{section name=iterator start=1 loop=10}
    {$tab = tab}
    {$tabname = $tab|cat:$smarty.section.iterator.index|cat:" name"}
    {$tabinhalt = $tab|cat:$smarty.section.iterator.index|cat:" inhalt"}
    {if isset($Artikel->AttributeAssoc[$tabname]) && $Artikel->AttributeAssoc[$tabname]
        && $Artikel->AttributeAssoc[$tabinhalt]}
        {$separatedTabs[{$tabname|replace:' ':'-'}] = [
        'id'      => {$tabname|replace:' ':'-'},
        'name'   => {$Artikel->AttributeAssoc[$tabname]},
        'content' => {$Artikel->AttributeAssoc[$tabinhalt]}
        ]}
    {/if}
{/section}
{$setActiveClass = [
    'description'    => (!$hasVotesHash),
    'downloads'      => (!$hasVotesHash && !$useDescription),
    'separatedTabs'  => (!$hasVotesHash && !$useDescription && !$useDownloads),
    'votes'          => ($hasVotesHash || !$useDescription && !$useDownloads && empty($separatedTabs)),
    'questionOnItem' => (!$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs) && !$useVotes),
    'priceFlow'      => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs)
        && !$useQuestionOnItem),
    'availabilityNotification' => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads
        && empty($separatedTabs) && !$useQuestionOnItem && !$usePriceFlow),
    'mediaGroup' => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs)
        && !$useQuestionOnItem && !$usePriceFlow && !$useAvailabilityNotification)
]}

{if useDescription || $useDownloads || $useDescriptionWithMediaGroup || $useVotes || $useQuestionOnItem || $usePriceFlow
    || $useAvailabilityNotification || $useMediaGroup || !empty($separatedTabs)}
	{include file="snippets/zonen.tpl" id="opc_before_tabs"}
    {include file="snippets/zonen.tpl" id="before_tabs" title="before_tabs"}
    {block name="tab-nav-block"}
    <ul class="blanklist dpflex-a-end nav nav-tabs" role="tablist" id="article-tab-nav">
        {if $useDescription}
            <li role="presentation" {if $setActiveClass.description} class="active"{/if}>
                <span aria-controls="tab-description" role="tab" data-toggle="tab">
                    {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                </span>
            </li>
        {/if}
        {if $useDownloads}
            <li role="presentation" {if $setActiveClass.downloads} class="active"{/if}>
                <span aria-controls="tab-downloads" role="tab" data-toggle="tab">
                    {lang section="productDownloads" key="downloadSection"}
                </span>
            </li>
        {/if}
        {if !empty($separatedTabs)}
            {foreach from=$separatedTabs item=separatedTab name="separatedTabsHeader"}
                <li role="presentation"
                    {if $setActiveClass.separatedTabs && $smarty.foreach.separatedTabsHeader.first}
                        class="active"
                    {/if}>
                    <span aria-controls="tab-{$separatedTab.id}" role="tab" data-toggle="tab">
                        {$separatedTab.name}
                    </span>
                </li>
            {/foreach}
        {/if}
        {if $useVotes}
            <li role="presentation" {if $setActiveClass.votes} class="active"{/if}>
                <span aria-controls="tab-votes" role="tab" data-toggle="tab">
                    {lang key="Votes" section="global"}
                </span>
            </li>
        {/if}
        {if $useQuestionOnItem}
            <li role="presentation" {if $setActiveClass.questionOnItem} class="active" {/if}>
                <span aria-controls="tab-questionOnItem" role="tab" data-toggle="tab">
                    {lang key="productQuestion" section="productDetails"}
                </span>
            </li>
        {/if}
        {if $usePriceFlow}
            <li role="presentation" {if $setActiveClass.priceFlow} class="active"{/if}>
                <span aria-controls="tab-priceFlow" role="tab" data-toggle="tab">
                    {lang key="priceFlow" section="productDetails"}
                </span>
            </li>
        {/if}
        {if $useAvailabilityNotification}
            <li role="presentation"
                {if $setActiveClass.availabilityNotification} class="active"{/if}>
                <span aria-controls="tab-availabilityNotification" role="tab" data-toggle="tab">
                    {lang key="notifyMeWhenProductAvailableAgain" section="global"}
                </span>
            </li>
        {/if}
        {if $useMediaGroup}
            {foreach $Artikel->getMediaTypes() as $mediaType}
                {$cMedienTypId = $mediaType->name|@seofy}
                <li role="presentation"
                    {if $setActiveClass.mediaGroup && $mediaType@first} class="active"{/if}>
                    <span aria-controls="tab-{$cMedienTypId}" role="tab" data-toggle="tab">
                        {$mediaType->name} ({$mediaType->count})
                    </span>
                </li>
            {/foreach}
        {/if}

        {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
            <li role="presentation">
                <span aria-controls="p-slider-related" role="tab" data-toggle="tab">
                    {lang key='RelatedProducts' section='productDetails'}
                </span>
            </li>

        {/if}	
    </ul>
    {/block}
    {block name="tab-content-block"}
    <div class="tab-content" id="article-tabs">
        {block name="tabs-desc"}
            {if $useDescription}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.description} in active{/if}" id="tab-description">
                    <div class="tab-content-wrapper">
                        {block name="tab-description-content"}
                            {include file="snippets/zonen.tpl" id="opc_before_desc"}
                            <div class="desc">
                                {if $snackyConfig.optimize_artikel == "Y"}{$Artikel->cBeschreibung|optimize}{else}{$Artikel->cBeschreibung}{/if}
                                {if $useDescriptionWithMediaGroup}
                                    {if $Artikel->cBeschreibung|strlen > 0}
                                        <hr>
                                    {/if}
                                    {foreach $Artikel->getMediaTypes() as $mediaType}
                                        <div class="media">
                                            {include file='productdetails/mediafile.tpl'}
                                        </div>
                                    {/foreach}
                                {/if}
                            </div>
                            {include file="snippets/zonen.tpl" id="opc_after_desc"}
                        {/block}
                        {block name="tab-description-attributes"}
                            {if (!empty($Artikel->cBeschreibung) || $useDescriptionWithMediaGroup) && $showAttributesTable}
                                <hr>
                            {/if}
                            {include file='productdetails/attributes.tpl' tplscope='details'
                                showProductWeight=$showProductWeight showShippingWeight=$showShippingWeight
                                dimension=$dimension showAttributesTable=$showAttributesTable}
                        {/block}
                    </div>
                </div>
            {/if}
        {/block}
        {block name="tabs-downloads"}
            {if $useDownloads}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.downloads} in active{/if}" id="tab-downloads">
                    {include file="productdetails/download.tpl"}
                </div>
            {/if}
        {/block}
        {block name="tabs-separated"}
            {if !empty($separatedTabs)}
                {foreach $separatedTabs as $separatedTab}
                    <div role="tabpanel" class="tab-pane fade {if $setActiveClass.separatedTabs && $separatedTab@first} in active{/if}" id="tab-{$separatedTab.id}">
                        {$separatedTab.content}
                    </div>
                {/foreach}
            {/if}
        {/block}
        {block name="tabs-votes"}
            {if $useVotes}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.votes} in active{/if}" id="tab-votes">
                    {include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
                </div>
        {/if}
        {/block}
        {block name="tabs-question"}
            {if $useQuestionOnItem}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.questionOnItem} in active{/if}" id="tab-questionOnItem">
                    {include file="productdetails/question_on_item.tpl" position="tab"}
                </div>
            {/if}
        {/block}
        {block name="tabs-priceflow"}
            {if $usePriceFlow}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.priceFlow} in active{/if}" id="tab-priceFlow">
                    {include file="productdetails/price_history.tpl"}
                </div>
            {/if}
        {/block}
        {block name="tabs-avail-note"}
            {if $useAvailabilityNotification}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.availabilityNotification} in active{/if}" id="tab-availabilityNotification">
                    {include file="productdetails/availability_notification_form.tpl" position="tab"}
                </div>
            {/if}
        {/block}
        {block name="tabs-mediagroup"}
            {if $useMediaGroup}
                {foreach $Artikel->getMediaTypes() as $mediaType}
                    {$cMedienTypId = $mediaType->name|@seofy}
                    <div role="tabpanel" class="tab-pane fade {if $setActiveClass.mediaGroup && $mediaType@first} in active{/if}" id="tab-{$cMedienTypId}">
                        {include file="productdetails/mediafile.tpl"}
                    </div>
                {/foreach}
            {/if}
        {/block}
        {block name="tabs-aehnliche"}
            {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                <div role="tabpanel" class="tab-pane fade" id="p-slider-related">
                    {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                    {include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                </div>
            {/if}
        {/block}
    </div>
    {/block}
{/if}
{/block}