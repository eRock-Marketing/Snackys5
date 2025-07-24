{block name='checkout-inc-billing-address'}
{if $Kunde->cFirma}
    {$Kunde->cFirma|entferneFehlerzeichen}
    <br />
{/if}
{if $Kunde->cZusatz}
    {$Kunde->cZusatz|entferneFehlerzeichen}
    <br />
{/if}
{$Kunde->cTitel} {$Kunde->cVorname} {$Kunde->cNachname|entferneFehlerzeichen}
<br />{$Kunde->cStrasse|entferneFehlerzeichen} {$Kunde->cHausnummer}<br />{if $Kunde->cAdressZusatz}{$Kunde->cAdressZusatz}<br />{/if}
{$Kunde->cPLZ} {$Kunde->cOrt}<br />{if $Kunde->cBundesland}{$Kunde->cBundesland}<br />{/if}
{if $Kunde->angezeigtesLand}{$Kunde->angezeigtesLand}{else}{$Kunde->cLand}{/if}<br />
<br />{if $Kunde->cUSTID}{lang key="ustid" section="account data"}: {$Kunde->cUSTID}<br />{/if}
{if $Kunde->cTel}{lang key="tel" section="account data"}: {$Kunde->cTel}<br />{/if}
{if $Kunde->cFax}{lang key="fax" section="account data"}: {$Kunde->cFax}<br />{/if}
{if $Kunde->cMobil}{lang key="mobile" section="account data"}: {$Kunde->cMobil}<br />{/if}
{$Kunde->cMail}
{/block}
