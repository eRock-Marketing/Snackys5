{block name='boxes-box-last-seen'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{lang key='lastViewed' assign='boxtitle'}
		<section class="box box-last-seen box-normal panel" id="sidebox{$oBox->getID()}">
			{block name='boxes-box-last-seen-content'}
				{block name='boxes-box-last-seen-title'}
					<div class="h5 panel-heading flx-ac">
						{$boxtitle}
						{if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
					</div>
				{/block}
				{block name='boxes-box-last-seen-image-link'}
					<div class="panel-body">
						<ul class="nav">
							{foreach $oBox->getProducts() as $product}
								<li class="nav-it">
									<a class="flx-ac" href="{$product->cURLFull}">
										<span class="img-ct icon ic-lg icon-wt">
											{include file='snippets/image.tpl' item=$product srcSize='sm' sizes= '(min-width: 1300px) 10vw, (min-width: 992px) 13vw, (min-width: 768px) 34vw, 50vw'}
										</span>
										<span class="block">
											{$product->cKurzbezeichnung}
										</span>
									</a>
								</li>
							{/foreach}
						</ul>
					</div>
				{/block}
			{/block}
		</section>
	{/if}
{/block}