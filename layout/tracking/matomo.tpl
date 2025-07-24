{block name='layout-matomo-tracking'}
<script type="text/javascript">
 
{* Add this data to Matomo - by Knoell Marketing *}
var _paq = window._paq = window._paq || [];

{if ($Einstellungen.consentmanager.consent_manager_active === 'Y' && ($snackyConfig.matomoConsent == 'Y' || $snackyConfig.matomoConsent == 'P')) || $Einstellungen.consentmanager.consent_manager_active !== 'Y'}
	{if $nSeitenTyp == 1}
		{assign var=i_kat value=($Brotnavi|@count)-2}
		{if $i_kat < 0}{assign var=i_kat value=0}{/if}
		_paq.push(['setEcommerceView',
			"{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}",
			"{$Artikel->cName|escape}",
			"{$Brotnavi[$i_kat]->getName()|escape}",
			{$Artikel->Preise->fVKNetto|number_format:2:".":""}
		]);
	{elseif $nSeitenTyp == 2}
		{assign var="listName" value="unknown"}
		{if !isset($oNavigationsinfo)
		|| (!$oNavigationsinfo->getManufacturer() && !$oNavigationsinfo->getCharacteristicValue() && !$oNavigationsinfo->getCategory())}
			{assign var="listName" value=$Suchergebnisse->getSearchTermWrite()}
		{elseif $oNavigationsinfo->getName()}
			{assign var="listName" value=$oNavigationsinfo->getName()}
		{/if}
		_paq.push(['setEcommerceView',
			false, 
			false,
			"{$listName}",
		]);
	{elseif $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
		{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
			{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
				_paq.push(['addEcommerceItem',
				  "{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}",
				  "{$prodid->Artikel->cName|escape}",
				  "",
				  {$prodid->Artikel->Preise->fVKNetto|number_format:2:".":""},
				  {$prodid->nAnzahl}
				]);		
			{/if}
		{/foreach}
		
		_paq.push(['trackEcommerceOrder',
			"{$Bestellung->cBestellNr}",
			{$Bestellung->fWarensummeNetto|number_format:2:".":""},
			0,
			{$Bestellung->fSteuern|number_format:2:".":""},
			{$Bestellung->fVersandNetto|number_format:2:".":""}
		]);
	{/if}
{/if}
</script>
{/block}