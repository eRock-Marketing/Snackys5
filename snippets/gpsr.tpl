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
    {elseif isset($hasGPSR) && $hasGPSR}
        {if !isset($hideTitle)}
            <hr class="invisible">
            <div class="h5">{lang key='gpsrHeadline' section='custom'}</div>
        {/if}
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
    {/if}
{/block}