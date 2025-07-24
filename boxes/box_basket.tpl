{block name='boxes-box-basket'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{if $smarty.session.Warenkorb->PositionenArr|@count > 0}
			<section class="panel small" id="sidebox{$oBox->getID()}">
				{block name='boxes-box-basket-content'}
					{block name='boxes-box-basket-title'}
						<div class="h5 panel-heading flx-ac">
							{lang key='yourBasket'}
							{if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
						</div>
					{/block}
					{block name='boxes-box-basket-body'}
						<div class="panel-body">
							<div class="flx-ac mb-xs">
								{block name='boxes-box-basket-icon'}
									<div class="ic-bd flx-ac flx-jc icon-wt">
										<span class="img-ct icon ic-lg">
											<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
											</svg>
										</span>
									</div>
								{/block}
								{block name='boxes-box-basket-text'}
									{$Warenkorbtext}
								{/block}
							</div>
							{block name='boxes-box-basket-link'}
								<a href="{get_static_route id='warenkorb.php'}" class="btn btn-block btn-primary btn-xs">
									{lang key='gotoBasket'}
								</a>
							{/block}
						</div>
					{/block}
				{/block}
			</section>
		{/if}
	{/if}
{/block}