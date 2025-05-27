{block name='account-feedback'}
	{block name='account-feedback-headline'}
		<h1 class="h2 mb-sm">{lang key='allRatings'}</h1>
	{/block}
	{if JTL\Session\Frontend::getCustomer()->getID() === 0}
		{block name='account-feedback-nocustomer'}
			<div class="alert alert-danger">{lang key='loginFirst' section='product rating'}</div>
		{/block}
	{elseif $bewertungen|count == 0}
		{block name='account-feedback-nofeedback'}
			<div class="alert alert-danger">{lang key='no feedback' section='product rating'}</div>
		{/block}
	{else}
		{block name='account-feedbacks'}
			{foreach $bewertungen as $Bewertung}
				<div class="card review">
					{block name='account-feedbacks-header'}
						<div class="card-header">
							<div class="flx-jb">
								<div class="block">
									<strong>{$Bewertung->cTitel}</strong>
									<small class="text-muted block">{$Bewertung->dDatum|date_format:"%d.%m.%Y"}</small>
								</div>
								<span class="right">{include file='productdetails/rating.tpl' stars=$Bewertung->nSterne}</span>
							</div>
						</div>
					{/block}
					{block name='account-feedbacks-content'}
						<div class="card-body">
							{block name='account-feedbacks-content-feedback'}
								<div class="flx-jb mb-xs">
									{$Bewertung->cText}
									<div class="right ml-xs">
										<a title="{lang key='edit' section='product rating'}" href="{get_static_route id='bewertung.php'}?a={$Bewertung->kArtikel}&bfa=1&token={$smarty.session.jtl_token}"} class="btn btn-ic">
											<span class="img-ct icon">
												<svg>
												  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
												</svg>
											</span>
										</a>
									</div>
								</div>
							{/block}
							{block name='account-feedbacks-content-answer'}
								{if !empty($Bewertung->cAntwort)}
									<div class="review card mb-xs">
										<div class="panel">
											<strong>{lang key='reply' section='product rating'} {$cShopName}:</strong>
											<hr class="hr-sm">
											<div class="answer">
												{$Bewertung->cAntwort}
												<small class="block text-muted">{$Bewertung->dAntwortDatum|date_format:"%d.%m.%Y"}</small>
											</div>
										</div>
									</div>
								{/if}
							{/block}
							{block name='account-feedbacks-content-info'}
								<div class="small">
									{if !empty($Bewertung->fGuthabenBonus)}
										{lang key='balance bonus' section='product rating'}: {$Bewertung->fGuthabenBonusLocalized} | 
									{/if}
									{if $Bewertung->nAktiv == 1}
										{lang key='feedback activated' section='product rating'}
									{else}
										{lang key='feedback deactivated' section='product rating'}
									{/if}
								</div>
							{/block}
						</div>
					{/block}
				</div>
				{block name='account-feedbacks-content-spacer'}
					<hr class="invisible hr-sm">
				{/block}
			{/foreach}
		{/block}
	{/if}
{/block}