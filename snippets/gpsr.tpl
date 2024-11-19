{block name="snackys-gpsr"}
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
    {/if}
{/block}