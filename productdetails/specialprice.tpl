{block name="km-sonderpreis-bis"}	
	{if $snackyConfig.specialpriceDate == "C"}
		{block name="specialprice-countdown"}
			{block name="specialprice-countdown-assigns"}
				{assign var="uidSP" value="art_c_{$Artikel->kArtikel}_{1|mt_rand:20}"}
			{/block}
			{block name="specialprice-countdown-wrapper"}
				<div id="{$uidSP}" class="sale-wp mb-sm mt-sm text-center panel">
					<div class="mb-xs h4">{lang key="sonderpreisBisDetail" section="custom"}</div>
					<div class="flx-jc">
						<div class="ct-wp days">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='days'}</div>
						</div>
						<div class="ct-wp hours">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='hours'}</div>
						</div>
						<div class="ct-wp minutes">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='minutes'}</div>
						</div>
						<div class="ct-wp seconds">
							<div class="ct-it">0</div>
							<div class="ct-un">{lang key='seconds'}</div>
						</div>
					</div>
				</div>
			{/block}
			{block name="specialprice-countdown-javscript"}
				{inline_script}<script>
						var untilSP = new Date("{$Artikel->dSonderpreisEnde_de|date_format:"Y-m-d"}T23:59:59");
						var countDownDateSP = untilSP.getTime();
						var timeout_specialprice = setInterval(update_specialprice, 1000);

						update_specialprice();
						$(window).trigger('resize');

						function update_specialprice()
						{
							let now      = new Date().getTime();
							let distance = countDownDateSP - now; 
							let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
							let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
							let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
							let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

							if (distance <= 0) {
								clearInterval(timeout_specialprice);
								days    = 0;
								hours   = 0;
								minutes = 0;
								seconds = 0;
								$("#{$uidSP}").hide();
								$(window).trigger('resize');
							}

							$("#{$uidSP} .days .ct-it").html(days);
							$("#{$uidSP} .hours .ct-it").html(hours);
							$("#{$uidSP} .minutes .ct-it").html(minutes);
							$("#{$uidSP} .seconds .ct-it").html(seconds);
						}
				</script>{/inline_script}
			{/block}
		{/block}
	{elseif $snackyConfig.specialpriceDate == "D"}
		{block name="specialprice-date"}
			<div class="mb-sm mt-sm panel text-center">
				<div class="h4 m0">
					{lang key="sonderpreisBisDetail" section="custom"} {$Artikel->dSonderpreisEnde_de|date_format:"{$snackyConfig.deliveryDateFormat}"}
				</div>
			</div>
		{/block}
	{/if}
{/block}