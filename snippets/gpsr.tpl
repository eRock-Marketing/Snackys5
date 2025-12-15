{block name="snackys-gpsr"}
    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_homepage) 
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_email)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_country)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_state)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_city)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_housenumber)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_street)
        || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_name)
    }
        {assign var="hasGPSR" value=true}
    {/if}
    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_homepage) 
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_email)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_country)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_state)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_city)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_postalcode)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_housenumber)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_street)
        || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_name)
    }
        {assign var="hasResponsiblePerson" value=true}
    {/if}
    {if $snackyConfig.gpsr_shown == 1}
        {if !isset($hideTitle)}
            <hr class="invisible">
            <div class="h5">{lang key='gpsrHeadline' section='custom'}</div>
        {/if}
        {$Artikel->cHerstellerBeschreibung}
    {elseif $snackyConfig.gpsr_shown == 2}
        {assign var="splitManuDesc" value="####"|explode:$Artikel->cHerstellerBeschreibung}
        {if count($splitManuDesc)>1}
            {if !isset($hideTitle)}
                <hr class="invisible">
                <div class="h5">{lang key='gpsrHeadline' section='custom'}</div>
            {/if}
            {$splitManuDesc[1]}
        {/if}
    {elseif (isset($hasGPSR) && $hasGPSR) || (isset($hasResponsiblePerson) && $hasResponsiblePerson)}
        {if !isset($hideTitle)}
            <hr class="invisible">
            <div class="h5">{lang key='gpsrHeadline' section='custom'}</div>
        {/if}
        <div class="row">
            {if isset($hasGPSR) && $hasGPSR}
                <div class="col-12{if isset($isTabs) && $isTabs && $snackyConfig.positionArticleTabs != 1} col-lg-6{/if}">
                    <strong class="block mb-xxs">{lang key='gpsrManufacturer' section='custom'}</strong>
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_name)}
                        {lang key='name'}: {$Artikel->FunktionsAttribute.gpsr_manufacturer_name}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_street) || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_housenumber)}
                        <br>{lang key='street' section='account data'}: 
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_street)}
                        {$Artikel->FunktionsAttribute.gpsr_manufacturer_street}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_housenumber)}
                        {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_street)} {/if}
                        {$Artikel->FunktionsAttribute.gpsr_manufacturer_housenumber}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode) || isset($Artikel->FunktionsAttribute.gpsr_manufacturer_city)}
                        <br>{lang key='plz' section='account data'}, {lang key='city' section='account data'}: 
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode)}
                        {$Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_city)}
                        {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode)}
                            , 
                        {/if}
                        {$Artikel->FunktionsAttribute.gpsr_manufacturer_city}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_country)}
                        <br>{lang key='country' section='account data'}: {$Artikel->FunktionsAttribute.gpsr_manufacturer_country}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_state)}
                        <br>{lang key='state' section='account data'}: {$Artikel->FunktionsAttribute.gpsr_manufacturer_state}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_email)}
                        <br>{lang key='email' section='account data'}: <a href="mailto:{$Artikel->FunktionsAttribute.gpsr_manufacturer_email}" title="{lang key='email' section='account data'}">{$Artikel->FunktionsAttribute.gpsr_manufacturer_email}</a>
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_homepage)}
                        <br>{lang key='homepage' section='account data'}: <a href="{$Artikel->FunktionsAttribute.gpsr_manufacturer_homepage}" title="{lang key='homepage' section='account data'}" target="_blank">{$Artikel->FunktionsAttribute.gpsr_manufacturer_homepage}</a>
                    {/if}
                </div>
            {/if}
            {if isset($hasResponsiblePerson) && $hasResponsiblePerson}
                <div class="col-12{if isset($isTabs) && $isTabs && $snackyConfig.positionArticleTabs != 1} col-lg-6{/if}">
                    <strong class="block mb-xxs">{lang key='gpsrResponsiblePerson' section='custom'}</strong>
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_name)}
                        {lang key='name'}: {$Artikel->FunktionsAttribute.gpsr_responsibleperson_name}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_street) || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_housenumber)}
                        <br>{lang key='street' section='account data'}: 
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_street)}
                        {$Artikel->FunktionsAttribute.gpsr_responsibleperson_street}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_housenumber)}
                        {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_street)} {/if}
                        {$Artikel->FunktionsAttribute.gpsr_responsibleperson_housenumber}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_postalcode) || isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_city)}
                        <br>{lang key='plz' section='account data'}, {lang key='city' section='account data'}: 
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_postalcode)}
                        {$Artikel->FunktionsAttribute.gpsr_responsibleperson_postalcode}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_city)}
                        {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_postalcode)}
                            , 
                        {/if}
                        {$Artikel->FunktionsAttribute.gpsr_responsibleperson_city}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_country)}
                        <br>{lang key='country' section='account data'}: {$Artikel->FunktionsAttribute.gpsr_responsibleperson_country}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_state)}
                        <br>{lang key='state' section='account data'}: {$Artikel->FunktionsAttribute.gpsr_responsibleperson_state}
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_email)}
                        <br>{lang key='email' section='account data'}: <a href="mailto:{$Artikel->FunktionsAttribute.gpsr_responsibleperson_email}" title="{lang key='email' section='account data'}">{$Artikel->FunktionsAttribute.gpsr_responsibleperson_email}</a>
                    {/if}
                    {if isset($Artikel->FunktionsAttribute.gpsr_responsibleperson_homepage)}
                        <br>{lang key='homepage' section='account data'}: <a href="{$Artikel->FunktionsAttribute.gpsr_responsibleperson_homepage}" title="{lang key='homepage' section='account data'}" target="_blank">{$Artikel->FunktionsAttribute.gpsr_responsibleperson_homepage}</a>
                    {/if}
                </div>
            {/if}
        </div>
    {/if}
{/block}