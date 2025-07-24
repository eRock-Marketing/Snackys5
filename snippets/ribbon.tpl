{block name='snippets-ribbon'}
    {if !empty($Artikel->Preise->Sonderpreis_aktiv)}
        {$sale = $Artikel->Preise->discountPercentage}
    {/if}

    {block name="km-sonderpreis-bis"}
        {if !empty($Artikel->dSonderpreisEnde_de) && $Artikel->dSonderpreisEnde_de|date_format:"%y%m%d" >= $smarty.now|date_format:"%y%m%d" && $Artikel->dSonderpreisStart_de|date_format:"%y%m%d" <= $smarty.now|date_format:"%y%m%d"}
            {if $snackyConfig.specialpriceDate == "C"}
                {assign var="uid" value="art_c_{$Artikel->kArtikel}_{1|mt_rand:20}"}
                <div id="{$uid}" class="sale-ct">
                    <div class="dpflex-j-c text-center">
                        <div class="ct-wp days{if $Artikel->dSonderpreisEnde_de|date_format:"%y%m%d" == $smarty.now|date_format:"%y%m%d"} d-none{/if}">
                            <div class="ct-it"></div>
                            <div class="ct-un">{lang key='days'}</div>
                        </div>
                        <div class="ct-wp hours">
                            <div class="ct-it"></div>
                            <div class="ct-un">{lang key='hours'}</div>
                        </div>
                        <div class="ct-wp minutes">
                            <div class="ct-it"></div>
                            <div class="ct-un">{lang key='minutes'}</div>
                        </div>
                        <div class="ct-wp seconds{if $Artikel->dSonderpreisEnde_de|date_format:"%y%m%d" > $smarty.now|date_format:"%y%m%d"} d-none{/if}">
                            <div class="ct-it"></div>
                            <div class="ct-un">{lang key='seconds'}</div>
                        </div>
                    </div>
                </div>                
                {inline_script}<script>
                    $(() => {
                        let until = new Date("{$Artikel->dSonderpreisEnde_de|date_format:"Y-m-d"}T23:59:59");
                        let countDownDate = until.getTime();
                        let timeout = setInterval(update, 1000);

                        update();
                        $(window).trigger('resize');

                        function update()
                        {
                            let now      = new Date().getTime();
                            let distance = countDownDate - now; 
                            let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
                            let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                            let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                            let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

                            if (distance <= 0) {
                                clearInterval(timeout);
                                days    = 0;
                                hours   = 0;
                                minutes = 0;
                                seconds = 0;
                                $("#{$uid}").hide();
                                $(window).trigger('resize');
                            }

                            $("#{$uid} .days .ct-it").html(days);
                            $("#{$uid} .hours .ct-it").html(hours);
                            $("#{$uid} .minutes .ct-it").html(minutes);
                            $("#{$uid} .seconds .ct-it").html(seconds);
                        }
                    });
                </script>{/inline_script}
            {elseif $snackyConfig.specialpriceDate == "D"}
                <div class="ov-t ov-t-sp">{lang key="sonderpreisBis" section="custom"} {$Artikel->dSonderpreisEnde_de|date_format:"{$snackyConfig.deliveryDateFormat}"}</div>
            {/if}
        {/if}
    {/block}

    {block name='snippets-ribbon-main'}
        {if $Artikel->oSuchspecialBild->getType() == 2 && $snackyConfig.saleprozent == 'Y'}
            {assign var="rabatt" value=($Artikel->Preise->alterVKNetto-$Artikel->Preise->fVKNetto)/$Artikel->Preise->alterVKNetto*100}
            <span class="ov-t ov-t-2">- {$rabatt|round:0}%</span>
        {else}
            <span class="ov-t
                ov-t-{$Artikel->oSuchspecialBild->getType()}">
                {block name='snippets-ribbon-content'}
                    {lang key='ribbon-'|cat:$Artikel->oSuchspecialBild->getType() section='productOverview' printf=$sale|default:''|cat:'%'}
                {/block}
            </span>
        {/if}
    {/block}
{/block}
