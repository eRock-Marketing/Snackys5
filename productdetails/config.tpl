{block name='productdetails-config'}
{if isset($Artikel->oKonfig_arr) && $Artikel->oKonfig_arr|@count > 0}
	{assign var="configRequired" value=false}
    <div class="product-configuration{if $snackyConfig.configuratorMode == 1} no-pop{/if}">
        <div class="{if $snackyConfig.configuratorMode == 0}modal modal-dialog {/if}blanklist in" tabindex="-1" id="config-popup">
            {if $snackyConfig.configuratorMode == 0}
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title h5">
                        {lang key="yourConfiguration" section="global"}
                    </div>
                    <button type="button" class="close-btn" data-dismiss="modal" aria-label="Close" id="close-configmodal"></button>
                </div>
                <div class="modal-body">
            {/if}
            <div id="cfg-container">
                {foreach $Artikel->oKonfig_arr as $oGruppe}
                    {if $oGruppe->getItemCount() > 0}
                        {assign var=oSprache value=$oGruppe->getSprache()}
                        {assign var=cBildPfad value=$oGruppe->getBildPfad()}
                        {assign var=kKonfiggruppe value=$oGruppe->getKonfiggruppe()}
                        <div class="cfg-group panel{if $oGruppe->getMin() > 0} required{assign var="configRequired" value=true}{/if}{if $oGruppe@iteration == 1} seen{/if}" data-id="{$kKonfiggruppe}">
                            <div class="cfg-title h5 dpflex-a-c m0" aria-expanded="{if $oGruppe@first}true{else}false{/if}" data-target="#cfg-grp-cllps-{$oGruppe@iteration}" data-toggle="collapse">
                                <span class="cfg-cntr">{$oGruppe@iteration}</span> {$oSprache->getName()}
                                <span class="cfg-cntr cfg-ar"><span class="ar ar-d"></span></span>
                            </div>
                            <div class="group panel-body collapse{if $oGruppe@first} show{/if}" id="cfg-grp-cllps-{$oGruppe@iteration}" data-parent="#cfg-container">
                                <div class="cfg-group-info sticky-top mb-sm">
                                    {if !empty($oGruppe->getMin()) || !empty($oGruppe->getMax())}
                                        <div class="alert alert-info small">
                                            {if $oGruppe->getMin() === 1 && $oGruppe->getMax() === 1}
                                                {lang key='configChooseOneComponent' section='productDetails'}
                                            {elseif $oGruppe->getMin() === $oGruppe->getMax()}
                                                {lang key='configChooseNumberComponents' section='productDetails' printf=$oGruppe->getMin()}
                                            {elseif !empty($oGruppe->getMin()) && $oGruppe->getMax()<$oGruppe->getItemCount()}
                                                {lang key='configChooseMinMaxComponents' section='productDetails' printf=$oGruppe->getMin()|cat:':::'|cat:$oGruppe->getMax()}
                                            {elseif !empty($oGruppe->getMin())}
                                                    {lang key='configChooseMinComponents' section='productDetails' printf=$oGruppe->getMin()}
                                            {elseif $oGruppe->getMax()<$oGruppe->getItemCount()}
                                                {lang key='configChooseMaxComponents' section='productDetails' printf=$oGruppe->getMax()}
                                            {else}
                                                {lang key='optional'}
                                            {/if}
                                        </div>
                                    {elseif $oGruppe->getMin() == 0}
                                        <div class="alert alert-info small">{lang key='optional'}</div>
                                    {/if}
                                </div>
                                {if !empty($cBildPfad) || $oSprache->hatBeschreibung()}
                                    <div class="row mb-sm dpflex-a-c">
                                        {if !empty($cBildPfad)}
                                            <div class="hidden-xs col-sm-2">
                                                <span class="img-ct contain">
                                                    <img src="{$ShopURL}/{$cBildPfad}" alt="{$oSprache->getName()}" id="img{$kKonfiggruppe}" class="w100" />
                                                </span>
                                            </div>
                                        {/if}
                                        {if $oSprache->hatBeschreibung()}
                                             <div class="desc col-12{if !empty($cBildPfad)} col-sm-10{/if}">{$oSprache->getBeschreibung()}</div>
                                        {/if}
                                    </div>
                                {/if}
                                <div class="group-items mb-sm">
                                    <div class="list-group{if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX} typ-cb{elseif $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO} typ-rd{elseif $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN} typ-dd{elseif $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI} typ-dd typ-ddm{/if}{if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO} row row-multi{/if}">
                                        {foreach $oGruppe->oItem_arr as $oItem}
                                            {if $oItem->isInStock()}
                                                {assign var=bSelectable value=1}
                                            {else}
                                                {assign var=bSelectable value=0}
                                            {/if}
                                            <div class="list-group-item{if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO} col-6 col-md-4 col-lg-3{/if}{if empty($bSelectable)} disable{/if}" data-id="{$oItem->getKonfigitem()}">
                                                {assign var=kKonfigitem value=$oItem->getKonfigitem()}
                                                {assign var=cKurzBeschreibung value=$oItem->getKurzBeschreibung()}
                                                {if !empty($cKurzBeschreibung)}
                                                    {assign var=cBeschreibung value=$oItem->getKurzBeschreibung()}
                                                {else}
                                                    {assign var=cBeschreibung value=$oItem->getBeschreibung()}
                                                {/if}
                                                <label class="btn-block" for="item{$oItem->getKonfigitem()}">
                                                    <input class="hidden" type="{if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}checkbox{else}radio{/if}"
                                                       name="item[{$kKonfiggruppe}][]"
                                                       id="item{$oItem->getKonfigitem()}"
                                                       value="{$oItem->getKonfigitem()}"
                                                       {if empty($bSelectable)} disabled{/if}
                                                       {if isset($nKonfigitem_arr)} data-selected="{if in_array($oItem->getKonfigitem(), $nKonfigitem_arr)}true{else}false{/if}"{else}
                                                       {if (!empty($aKonfigerror_arr) && isset($smarty.post.item) && isset($smarty.post.item[$kKonfiggruppe]) && $oItem->getKonfigitem()|in_array:$smarty.post.item[$kKonfiggruppe]) || ($oItem->getSelektiert() && (!isset($aKonfigerror_arr) || !$aKonfigerror_arr))} checked="checked"{/if}{/if}
                                                       {if ($oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN) && $oItem@first && $oGruppe->getMin() > 0}required="required"{/if}
                                                       />
                                                    <span class="block cfg-ct{if $oItem->getEmpfohlen()} highlighted{/if}{if empty($bSelectable)} disable{/if}">
                                                        {if !empty($oItem->getBildPfad())}
                                                            <span class="img-ct mb-xs">
                                                                {assign var="oItemImgSrc" value="{$ShopURL}/{$oItem->getBildPfad()}"}
                                                                {image lazy=true webp=true src=$oItemImgSrc alt=$oItem->getName()}
                                                            </span>
                                                        {/if}
                                                        <span class="caption{if empty($oItem->getBildPfad())} w100{/if}">
                                                            <span class="block text">
                                                                {if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI}{$oItem->getInitial()}x {/if}{$oItem->getName()}{if empty($bSelectable)} - {lang section="productDetails" key="productOutOfStock"}{/if}
                                                                {if $smarty.session.Kundengruppe->mayViewPrices()}
                                                                    <span class="tag">
                                                                        {if $oItem->hasRabatt() && $oItem->showRabatt()}
                                                                            {$oItem->getRabattLocalized()} {lang key="discount"}
                                                                        {elseif $oItem->hasZuschlag() && $oItem->showZuschlag()}
                                                                            {$oItem->getZuschlagLocalized()} {lang key="additionalCharge"}
                                                                        {/if}
                                                                        {$oItem->getPreisLocalized()}
                                                                    </span>
                                                                {/if}
                                                                {if !empty($cBeschreibung) && ($oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO)}
                                                                    <span class="dropdown small desc-dd">
                                                                        <a class="desc-tgl" data-toggle="dropdown">
                                                                            i
                                                                        </a>
                                                                        <span class="dropdown-menu">
                                                                            {$cBeschreibung}
                                                                        </span>
                                                                    </span>
                                                                {/if}
                                                            </span>
                                                            {if !empty($cBeschreibung) && ($oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN_MULTI)}
                                                                <div class="small desc">
                                                                    {$cBeschreibung}
                                                                </div>
                                                            {/if}
                                                            <span class="check"></span>
                                                                
                                                            {if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_CHECKBOX || $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_RADIO}
                                                                {assign var=itemQuantity value=$oItem->getInitial()}
                                                                {if !empty($nKonfigitemAnzahl_arr[$oItem->getKonfigitem()])}
                                                                    {assign var=itemQuantity value=$nKonfigitemAnzahl_arr[$oItem->getKonfigitem()]}
                                                                {/if}
                                                                {if $oItem->getMin() === $oItem->getMax()}
                                                                    <div class="item_quantity">
                                                                        <input type="hidden" id="item_quantity{$oItem->getKonfigitem()}"
                                                                               name="item_quantity[{$oItem->getKonfigitem()}]"
                                                                               value="{$itemQuantity}" />
                                                                    </div>
                                                                {else}
                                                                    <div class="qt-wp form-group">
                                                                        <input class="small text-center" size="2" type="number"
                                                                           id="item_quantity{$oItem->getKonfigitem()}"
                                                                           name="item_quantity[{$oItem->getKonfigitem()}]"
                                                                           value="{$itemQuantity}" autocomplete="off"
                                                                           min="{$oItem->getMin()}" max="{$oItem->getMax()}" inputmode="numeric" pattern="[0-9]*" />
                                                                    </div>
                                                                {/if}
                                                            {/if}
                                                            </span>
                                                                
                                                            {if $oGruppe->getAnzeigeTyp() == $smarty.const.KONFIG_ANZEIGE_TYP_DROPDOWN}
                                                                {assign var=itemQuantity value=$oItem->getInitial()}
                                                                {if !empty($nKonfigitemAnzahl_arr[$oItem->getKonfigitem()])}
                                                                    {assign var=itemQuantity value=$nKonfigitemAnzahl_arr[$oItem->getKonfigitem()]}
                                                                {/if}
                                                                {if $oItem->getMin() === $oItem->getMax()}
                                                                    <div class="item_quantity">
                                                                        <input type="hidden" id="item_quantity{$oItem->getKonfigitem()}"
                                                                               name="item_quantity[{$oItem->getKonfigitem()}]"
                                                                               value="{$itemQuantity}" />
                                                                    </div>
                                                                {else}
                                                                    <div class="qt-wp form-group">
                                                                        <input class="small text-center" size="2" type="number"
                                                                           id="item_quantity{$oItem->getKonfigitem()}"
                                                                           name="item_quantity[{$oItem->getKonfigitem()}]"
                                                                           value="{$itemQuantity}" autocomplete="off"
                                                                           min="{$oItem->getMin()}" max="{$oItem->getMax()}" inputmode="numeric" pattern="[0-9]*" />
                                                                    </div>
                                                                {/if}
                                                            {/if}
                                                        </span>
                                                    </label>
                                                {if isset($aKonfigitemerror_arr[$kKonfigitem]) && $aKonfigitemerror_arr[$kKonfigitem]}
                                                    <p class="box_error alert alert-danger">{$aKonfigitemerror_arr[$kKonfigitem]}</p>
                                                {/if}                                               
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                                {if !$oGruppe@last}
                                    <div class="cfg-ftr text-center">
                                        <a href="#" data-target="#cfg-grp-cllps-{$oGruppe@iteration+1}" data-toggle="collapse" class="btn btn-primary">{lang key='nextConfigurationGroup' section='productDetails'}</a>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/if}
                {/foreach}
                {if $snackyConfig.configuratorMode == 0}
                <hr class="invisible">
                <label for="close-configmodal" class="btn btn-primary btn-lg w100 text-center pointer">{lang key="configSet" section="custom"}</label>
                {/if}
            </div>
                {if $snackyConfig.configuratorMode == 0}
                </div>
            </div>
            {/if}
        </div>
        
            <div id="product-configuration-sidebar">
                <div class="panel panel-primary no-margin">
                    {*<div class="panel-heading">
                        <h5 class="panel-title">{lang key="yourConfiguration"}</h5>
                    </div>*}
                    <table class="table table-striped m0">
                        <tbody class="summary"></tbody>
                        <tfoot>
                        <tr>
                            <td colspan="3" class="text-right word-break">
                                <small class="text-muted block mb-xxs">{lang key='priceAsConfigured' section='productDetails'}</small>
                                <strong class="price"></strong>
                                <p class="vat_info text-muted">
                                    <small>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}</small>
                                </p>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                    <div class="panel-footer m0">   
                        {if $snackyConfig.configuratorMode == 0}
        <a href="#" data-toggle="modal" data-target="#config-popup" title="{lang key="configButton" section="custom" printf=$Artikel->oKonfig_arr|@count}" class="btn btn-block btn-info btn-config">
            {lang key="configButton" section="custom" printf=$Artikel->oKonfig_arr|@count}
        </a>
          <hr class="hr-xs invisible">
                        {/if}
                        
                        {if $Artikel->inWarenkorbLegbar == 1}
							{* Prüfen ob in Warenkorb legbar *}
							{assign var="configRequired" value=false}
							{foreach from=$Artikel->oKonfig_arr item=oGruppe}
								{assign var="curGroup" value=$oGruppe->getMin()}
								{foreach from=$oGruppe->oItem_arr item=oItem name=konfigitem}
									{if $oItem->getSelektiert()}
										{assign var="curGroup" value=$curGroup-1}
									{/if}
								{/foreach}
								{if $curGroup>0}
									{assign var="configRequired" value=true}
								{/if}
							{/foreach}
							
							
							
                            <div id="quantity-grp" class="choose_quantity dpflex">
                                <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}"{if $Artikel->fAbnahmeintervall > 0} required step="{$Artikel->fAbnahmeintervall}"{/if} id="quantity"
                                       class="quantity form-control text-right" name="anzahl"
                                       value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{elseif isset($fAnzahl)}{$fAnzahl}{else}1{/if}" />
                                
                                    <button name="inWarenkorb" type="submit" value="{lang key="addToCart"}"
                                            class="submit btn btn-primary btn-block{if $configRequired} config-required{/if}"
											{if $configRequired} disabled{/if}>
                                        {if isset($kEditKonfig)}
                                            {lang key="applyChanges"}
                                        {else}
                                            {lang key="addToCart"}
                                        {/if}
										{if $configRequired}
											<span class="config-required-info">{lang key="configRequiredInfo" section="custom"}</span>
										{/if}
                                    </button>
                            </div>
                            {if $Artikel->kVariKindArtikel > 0}
                                <input type="hidden" name="a2" value="{$Artikel->kVariKindArtikel}"/>
                            {/if}
                            {if isset($kEditKonfig)}
                                <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
    </div>
{/if}
{/block}