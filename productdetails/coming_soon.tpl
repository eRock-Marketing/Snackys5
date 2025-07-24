{block name="km-verfuegbar-ab"}
	{if $snackyConfig.availableDate == "C"}
		{assign var="uidCS" value="aval-ct"}
		<div id="{$uidCS}" class="sale-wp mb-sm mt-sm text-center panel">
			<div class="mb-xs h4">{lang key="productAvailableIn" section="custom"}</div>
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
			{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
				<div class="mt-xs text-muted">{lang key="preorderPossible" section="global"}</div>
			{/if}
		</div>             
		{inline_script}<script>
				var untilCS = new Date("{$Artikel->Erscheinungsdatum_de|date_format:"Y-m-d"}T00:00:00");
				var countDownDateCS = untilCS.getTime();
				var timeout_comingsoon = setInterval(update_comingsoon, 1000);

				update_comingsoon();
				$(window).trigger('resize');

				function update_comingsoon()
				{
					let now      = new Date().getTime();
					let distance = countDownDateCS - now; 
					let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
					let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
					let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
					let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

					if (distance <= 0) {
						clearInterval(timeout_comingsoon);
						days    = 0;
						hours   = 0;
						minutes = 0;
						seconds = 0;
						$("#{$uidCS}").hide();
						$(window).trigger('resize');
					}

					$("#{$uidCS} .days .ct-it").html(days);
					$("#{$uidCS} .hours .ct-it").html(hours);
					$("#{$uidCS} .minutes .ct-it").html(minutes);
					$("#{$uidCS} .seconds .ct-it").html(seconds);
				}
		</script>{/inline_script}
	{elseif $snackyConfig.availableDate == "D"}
		<div class="mb-sm mt-sm panel text-center">
			<div class="h4 m0">
				{lang key="productAvailableFrom" section="global"}: {$Artikel->Erscheinungsdatum_de}
			</div>
			{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
				<div class="mt-xxs text-muted">{lang key="preorderPossible" section="global"}</div>
			{/if}
		</div>
	{/if}
{/block}