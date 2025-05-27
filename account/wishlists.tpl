{block name='account-wishlists'}
	{block name='account-wishlists-headline'}
		<h1 class="menu-title h2">{block name="account-wishlist-title"}{lang key="myWishlists"}{/block}</h1>
	{/block}
	{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
		{block name='account-wishlist-main'}
			{block name='account-wishlist-body'}
				{if !empty($oWunschliste_arr[0]->kWunschliste)}
					<div class="card mb-sm">
						<div class="card-body">
							{foreach $oWunschliste_arr as $Wunschliste}
								{block name='account-wishlists-item'}
									<div class="flx-ac item">
										{block name='account-wishlists-item-name-count'}
											<div class="w100">
												{block name='account-wishlists-item-name'}
													<a href="{get_static_route id='wunschliste.php'}?wl={$Wunschliste->kWunschliste}">
														<strong class="block">{$Wunschliste->cName}</strong>
													</a>
												{/block}
												{block name='account-wishlists-item-count'}
													<span class="block text-muted">{lang key="products"}: {$Wunschliste->productCount}</span>
												{/block}
											</div>
										{/block}
										{block name='account-wishlists-item-buttons'}
											<div class="text-right">
												<form method="post" action="{get_static_route id='jtl.php'}?wllist=1">
													<input type="hidden" name="wl" value="{$Wunschliste->kWunschliste}"/>
													{$jtl_token}
													{block name='account-wishlists-item-buttons-inner'}
														<span class="btn-group btn-group-sm">
															{block name='account-wishlists-item-buttons-standard'}
																<button class="btn-blank btn-sm btn flx-ac" name="wls" value="{$Wunschliste->kWunschliste}" title="{lang key="wishlistStandard" section="login"}">
																	<span class="img-ct icon {if $Wunschliste->nStandard != 1}inactive{else}active{/if}">
																		<svg>
																		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-circle"></use>
																		</svg>
																	</span>
																</button>
															{/block}
															{if $Wunschliste->nOeffentlich == 1}
																{block name='account-wishlists-item-buttons-public'}
																	<button type="submit" class="btn-blank btn-sm btn flx-ac" name="wlAction" value="setPrivate" title="{lang key="wishlistPrivat" section="login"}">
																		<span class="img-ct icon">
																			<svg>
																			  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-hide"></use>
																			</svg>
																		</span>
																	</button>
																{/block}
															{/if}
															{if $Wunschliste->nOeffentlich == 0}
																{block name='account-wishlists-item-buttons-not-public'}
																	<button type="submit" class="btn-blank btn-sm btn flx-ac" name="wlAction" value="setPublic" title="{lang key="wishlistNotPrivat" section="login"}">
																		<span class="img-ct icon">
																			<svg>
																			  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-show"></use>
																			</svg>
																		</span>
																	</button>
																{/block}
															{/if}
															{block name='account-wishlists-item-buttons-delete'}
																<button type="submit" class="btn-blank btn-sm btn flx-ac" name="wllo" value="{$Wunschliste->kWunschliste}" title="{lang key='wishlisteDelete' section='login'}">
																	<span class="img-ct icon">
																		<svg>
																		  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
																		</svg>
																	</span>
																</button>
															{/block}
														</span>
													{/block}
												</form>
											</div>
										{/block}
									</div>
								{/block}
							{/foreach}
						</div>
					</div>
				{/if}
				{block name='account-wishlists-new-wishlist'}
					<form method="post" action="{get_static_route id='jtl.php'}?wllist=1" class="form form-inline">
						{$jtl_token}
						<input name="wlh" type="hidden" value="1" />
						<div class="input-group w100">
							<input name="cWunschlisteName" type="text" class="form-control input-sm" placeholder="{lang key="wishlistAddNew" section="login"}" size="25" aria-label="{lang key="wishlistAddNew" section="login"}">
							<span class="input-group-btn">
								<input type="submit" class="btn btn-default btn-sm" name="submit" value="{lang key="wishlistSaveNew" section="login"}" />
							</span>
						</div>
					</form>
				{/block}
			{/block}
		{/block}
	{/if}
{/block}