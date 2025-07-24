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
    {if $tabanzeige && !$isMobile}
    <ul class="blanklist dpflex-a-end nav nav-tabs" role="tablist" id="article-tab-nav">
        {if $useDescription}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.description} active{/if}" aria-controls="tab-description" role="tab" data-toggle="tab" href="#tab-description">
                    {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                </a>
            </li>
        {/if}
        {if $useDownloads}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.downloads} active{/if}" aria-controls="tab-downloads" role="tab" data-toggle="tab" href="#tab-downloads">
                    {lang section="productDownloads" key="downloadSection"}
                </a>
            </li>
        {/if}
        {if !empty($separatedTabs)}
            {foreach from=$separatedTabs item=separatedTab name="separatedTabsHeader"}
                <li role="presentation" class="nav-item">
                    <a class="nav-link{if $setActiveClass.separatedTabs && $smarty.foreach.separatedTabsHeader.first} active{/if}" aria-controls="tab-{$separatedTab.id}" role="tab" data-toggle="tab" href="#tab-{$separatedTab.id}">
                        {$separatedTab.name}
                    </a>
                </li>
            {/foreach}
        {/if}
        {if $useVotes}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.votes} active{/if}" aria-controls="tab-votes" role="tab" data-toggle="tab" href="#tab-votes">
                    {lang key="Votes" section="global"} {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}){/if}
                </a>
            </li>
        {/if}
        {if $useQuestionOnItem}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.questionOnItem} active{/if}" aria-controls="tab-questionOnItem" role="tab" data-toggle="tab" href="#tab-questionOnItem">
                    {lang key="productQuestion" section="productDetails"}
                </a>
            </li>
        {/if}
        {if $usePriceFlow}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.priceFlow} active{/if}" aria-controls="tab-priceFlow" role="tab" data-toggle="tab" href="#tab-priceFlow">
                    {lang key="priceFlow" section="productDetails"}
                </a>
            </li>
        {/if}
        {if $useAvailabilityNotification}
            <li role="presentation" class="nav-item">
                <a class="nav-link{if $setActiveClass.availabilityNotification} active{/if}" aria-controls="tab-availabilityNotification" role="tab" data-toggle="tab" href="#tab-availabilityNotification">
                    {lang key="notifyMeWhenProductAvailableAgain" section="global"}
                </a>
            </li>
        {/if}
        {if $useMediaGroup}
            {foreach $Artikel->getMediaTypes() as $mediaType}
                {$cMedienTypId = $mediaType->name|@seofy}
                <li role="presentation" class="nav-item">
                    <a class="nav-link{if $setActiveClass.mediaGroup && $mediaType@first} active{/if}" aria-controls="tab-{$cMedienTypId}" role="tab" data-toggle="tab" href="#tab-{$cMedienTypId}">
                        {$mediaType->name} ({$mediaType->count})
                    </a>
                </li>
            {/foreach}
        {/if}	
    </ul>
    {/if}
    {/block}
    {block name="details-tabs-outer"}
    <div class="tab-content" id="article-tabs">
        {block name='productdetails-tabs-inner'}{block name="tabs-desc"}
                {if $useDescription}
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.description} show active{/if}" id="tab-description">
                    <div class="panel-heading dpflex-j-between dpflex-a-c" data-toggle="collapse" href="#tab-description" role="button">
                        <div class="panel-title h3 m0">
                            {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                        </div>
                        <span class="img-ct icon">
                            <svg class="{if (isset($darkHead) && $darkHead == 'true') || (isset($darkMode) && $darkMode == 'true')}icon-darkmode{/if}">
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
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
	                                    {include file="snippets/zonen.tpl" id="opc_before_desc_media"}
                                        {foreach $Artikel->getMediaTypes() as $mediaType}
                                            <div class="media">
                                                {include file='productdetails/mediafile.tpl'}
                                            </div>
                                        {/foreach}
	                                    {include file="snippets/zonen.tpl" id="opc_after_desc_media"}
                                    {/if}
                                </div>
                                {include file="snippets/zonen.tpl" id="opc_after_desc"}
                            {/block}
                            {block name="tab-description-attributes"}
                                {if (!empty($Artikel->cBeschreibung) || $useDescriptionWithMediaGroup) && $showAttributesTable}
                                    <hr>
                                {/if}
                               {include file="snippets/zonen.tpl" id="opc_before_desc_attributes"}
                                {include file='productdetails/attributes.tpl' tplscope='details'
                                    showProductWeight=$showProductWeight showShippingWeight=$showShippingWeight
                                    dimension=$dimension showAttributesTable=$showAttributesTable}
                                {include file="snippets/zonen.tpl" id="opc_after_desc_attributes"}
                            {/block}
                        </div>
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-downloads"}
                {if $useDownloads}
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.downloads} show active{/if}" id="tab-downloads">
                    <div class="panel-heading dpflex-a-c dpflex-j-between" data-toggle="collapse" href="#tab-downloads" role="button">
                        <div class="panel-title h3 m0">{lang section="productDownloads" key="downloadSection"}</div>
                        <span class="img-ct icon">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="snippets/zonen.tpl" id="opc_before_downloads"}
                        {include file="productdetails/download.tpl"}
                        {include file="snippets/zonen.tpl" id="opc_after_downloads"}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-separated"}
                {if !empty($separatedTabs)}
                    {foreach $separatedTabs as $separatedTab}
                    <div class="tab-ct tab-pane panel-default{if $setActiveClass.separatedTabs && $separatedTab@first} show active{/if}" id="tab-{$separatedTab.id}">
                        <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-{$separatedTab.id}" role="button">
                            <div class="panel-title h3 m0">{$separatedTab.name}</div>
                            <span class="img-ct icon">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                                </svg>
                            </span>
                        </div>
                        <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                            {include file="snippets/zonen.tpl" id='opc_before_separated_'|cat:$separatedTab.id}
                            {$separatedTab.content}
                            {include file="snippets/zonen.tpl" id='opc_after_separated_'|cat:$separatedTab.id}
                        </div>
                    </div>
                    {/foreach}
                {/if}
            {/block}
            {block name="tabs-votes"}
                {if $useVotes}
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.votes} show active{/if}" id="tab-votes">
                    <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-votes" role="button">
                        <div class="panel-title h3 m0">{lang key="Votes" section="global"} {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}){/if}</div>
                        <span class="img-ct icon">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="snippets/zonen.tpl" id='opc_before_tab_reviews'}
                        {include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
                        {include file="snippets/zonen.tpl" id='opc_after_tab_reviews'}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-question"}
                {if $useQuestionOnItem}
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.questionOnItem} show active{/if}" id="tab-questionOnItem">
                    <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-questionOnItem" role="button">
                        <div class="panel-title h3 m0">{lang key="productQuestion" section="productDetails"}</div>
                        <span class="img-ct icon">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="snippets/zonen.tpl" id='opc_before_tab_question'}
                        {include file="productdetails/question_on_item.tpl"}
                        {include file="snippets/zonen.tpl" id='opc_after_tab_question'}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-priceflow"}
                {if $usePriceFlow} 
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.priceFlow} show active{/if}" id="tab-priceFlow">
                    <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-priceFlow" role="button">
                        <div class="panel-title h3 m0">{lang key="priceFlow" section="productDetails"}</div>
                        <span class="img-ct icon">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="snippets/zonen.tpl" id='opc_before_tab_history'}
                        {include file="productdetails/price_history.tpl"}
                        {include file="snippets/zonen.tpl" id='opc_after_tab_history'}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-avail-note"}
                {if $useAvailabilityNotification}
                <div class="tab-ct tab-pane panel-default{if $setActiveClass.availabilityNotification} show active{/if}" id="tab-availabilityNotification">
                    <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-availabilityNotification" role="button">
                        <div class="panel-title h3 m0">{lang key="notifyMeWhenProductAvailableAgain" section="global"}</div>
                        <span class="img-ct icon">
                            <svg>
                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
                            </svg>
                        </span>
                    </div>
                    <div class="panel-body{if !$tabanzeige} mb-md{/if}">
                        {include file="snippets/zonen.tpl" id='opc_before_tab_notification'}
                        {include file="productdetails/availability_notification_form.tpl" position="tab" tplscope="artikeldetails"}
                        {include file="snippets/zonen.tpl" id='opc_after_tab_notification'}
                    </div>
                </div>
                {/if}
            {/block}
            {block name="tabs-mediagroup"}
                {if $useMediaGroup}
                    {foreach $Artikel->getMediaTypes() as $mediaType}
                        {$cMedienTypId = $mediaType->name|@seofy}
                        {if $cMedienTypId !== 'videos'}
                            <div class="tab-ct tab-pane panel-default{if $setActiveClass.mediaGroup && $mediaType@first} show active{/if}" id="tab-{$cMedienTypId}">
                                <div class="panel-heading dpflex-a-center dpflex-j-between" data-toggle="collapse" href="#tab-{$cMedienTypId}" role="button">
                                    <div class="panel-title h3 m0">{$mediaType->name}</div>
                                    <span class="img-ct icon">
                                        <svg>
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-caret"></use>
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