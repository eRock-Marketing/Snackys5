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

{block name='productdetails-tabs-inner'}
{if useDescription || $useDownloads || $useDescriptionWithMediaGroup || $useVotes || $useQuestionOnItem || $usePriceFlow
    || $useAvailabilityNotification || $useMediaGroup || !empty($separatedTabs)}
	{include file="snippets/zonen.tpl" id="opc_before_tabs"}
    <div id="tab-wp" class="mb-lg">
    {block name="tab-nav-block"}
    {if $tabanzeige}
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
    </ul>
    {/if}
    {/block}
    {block name="details-tabs-outer"}
    <div class="tab-content notabs" id="article-tabs">
        {block name='productdetails-tabs-inner'}{block name="tabs-desc"}
                {if $useDescription}
                <div class="tab-ct panel-default open-show{if $setActiveClass.description} in active{/if}" id="tab-description">
                    <div class="panel-heading dpflex-j-between dpflex-a-c">
                        <h2 class="panel-title h3 m0">
                            {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                        </h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
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
                </div>
                {/if}
            {/block}
            {block name="tabs-downloads"}
                {if $useDownloads}
                <div class="tab-ct panel-default{if $setActiveClass.downloads} in active{/if}" id="tab-downloads">
                    <div class="panel-heading dpflex-a-c dpflex-j-between">
                        <h2 class="panel-title h3 m0">{lang section="productDownloads" key="downloadSection"}</h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                    {include file="productdetails/download.tpl"}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-separated"}
                {if !empty($separatedTabs)}
                    {foreach $separatedTabs as $separatedTab}
                    <div class="tab-ct panel-default{if $setActiveClass.separatedTabs && $separatedTab@first} in active{/if}" id="tab-{$separatedTab.id}">
                        <div class="panel-heading dpflex-a-center dpflex-j-between">
                            <h2 class="panel-title h3 m0">{$separatedTab.name}</h2>
                            <span class="img-ct icon">
                                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                                </svg>
                            </span>
                        </div>
                        <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {$separatedTab.content}
                        </div>
                    </div>
                    {/foreach}
                {/if}
            {/block}
            {block name="tabs-votes"}
                {if $useVotes}
                <div class="tab-ct panel-default{if $setActiveClass.votes} in active{/if}" id="tab-votes">
                    <div class="panel-heading dpflex-a-center dpflex-j-between">
                        <h2 class="panel-title h3 m0">{lang key="Votes" section="global"}</h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-question"}
                {if $useQuestionOnItem}
                <div class="tab-ct panel-default{if $setActiveClass.questionOnItem} in active{/if}" id="tab-questionOnItem">
                    <div class="panel-heading dpflex-a-center dpflex-j-between">
                        <h2 class="panel-title h3 m0">{lang key="productQuestion" section="productDetails"}</h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                    {include file="productdetails/question_on_item.tpl"}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-priceflow"}
                {if $usePriceFlow} 
                <div class="tab-ct panel-default{if $setActiveClass.priceFlow} in active{/if}" id="tab-priceFlow">
                    <div class="panel-heading dpflex-a-center dpflex-j-between">
                        <h2 class="panel-title h3 m0">{lang key="priceFlow" section="productDetails"}</h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                    {include file="productdetails/price_history.tpl"}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-avail-note"}
                {if $useAvailabilityNotification}
                <div class="tab-ct panel-default{if $setActiveClass.availabilityNotification} in active{/if}" id="tab-availabilityNotification">
                    <div class="panel-heading dpflex-a-center dpflex-j-between">
                        <h2 class="panel-title h3 m0">{lang key="notifyMeWhenProductAvailableAgain" section="global"}</h2>
                        <span class="img-ct icon">
                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                    {include file="productdetails/availability_notification_form.tpl" position="tab" tplscope="artikeldetails"}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-mediagroup"}
                {if $useMediaGroup}
                    {foreach $Artikel->getMediaTypes() as $mediaType}
                        {$cMedienTypId = $mediaType->name|@seofy}
                        {if $cMedienTypId !== 'videos'}
                            <div class="tab-ct panel-default{if $setActiveClass.mediaGroup && $mediaType@first} in active{/if}" id="tab-{$cMedienTypId}">
                                <div class="panel-heading dpflex-a-center dpflex-j-between">
                                    <h2 class="panel-title h3 m0">{$mediaType->name}</h2>
                                    <span class="img-ct icon">
                                        <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-caret"></use>
                                        </svg>
                                    </span>
                                </div>
                                <div class="panel-body">
                                {include file="productdetails/mediafile.tpl"}
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                {/if}
            {/block}
        {/block}
    </div>
    {/block}
    </div>
{/if}
{/block}
{/block}