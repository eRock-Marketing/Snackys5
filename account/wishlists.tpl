{block name='account-wishlists'}
<h1 class="menu-title h2">{block name="account-wishlist-title"}{lang key="myWishlists"}{/block}</h1>
{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
    {block name='account-wishlist-main'}
        {block name='account-wishlist-body'}
            {if !empty($oWunschliste_arr[0]->kWunschliste)}
                <div class="card mb-spacer mb-small">
                    <div class="card-body">
                    {foreach $oWunschliste_arr as $Wunschliste}
                        <div class="dpflex-a-center item">
                            <div class="w100">
                                <a href="{get_static_route id='wunschliste.php'}?wl={$Wunschliste->kWunschliste}"><strong class="block">{$Wunschliste->cName}</strong></a>
                                <span class="block text-muted">{lang key="products"}: {$Wunschliste->productCount}</span>
                            </div>
                            <td class="text-right">
                                <form method="post" action="{get_static_route id='jtl.php'}?wllist=1">
                                    <input type="hidden" name="wl" value="{$Wunschliste->kWunschliste}"/>
                                    {$jtl_token}
                                    <span class="btn-group btn-group-sm">
                                        <button class="btn-blank btn-sm btn dpflex-a-center" name="wls" value="{$Wunschliste->kWunschliste}" title="{lang key="wishlistStandard" section="login"}">
                                            <span class="img-ct icon {if $Wunschliste->nStandard != 1}inactive{else}active{/if}">
                                                <svg>
                                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-circle"></use>
                                                </svg>
                                            </span>
                                        </button>
                                        {if $Wunschliste->nOeffentlich == 1}
                                            <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wlAction" value="setPrivate" title="{lang key="wishlistPrivat" section="login"}">
                                                <span class="img-ct icon">
													<svg>
													  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-hide"></use>
													</svg>
												</span>
                                            </button>
                                        {/if}
                                        {if $Wunschliste->nOeffentlich == 0}
                                            <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wlAction" value="setPublic" title="{lang key="wishlistNotPrivat" section="login"}">
                                                <span class="img-ct icon">
													<svg>
													  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-show"></use>
													</svg>
												</span>
                                            </button>
                                        {/if}
                                        <button type="submit" class="btn-blank btn-sm btn dpflex-a-center" name="wllo" value="{$Wunschliste->kWunschliste}" title="{lang key='wishlisteDelete' section='login'}">
                                            <span class="img-ct icon">
												<svg>
												  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
												</svg>
                                            </span>
                                        </button>
                                    </span>
                                </form>
                            </td>
                        </div>
                    {/foreach}
                    </div>
                </div>
            {/if}
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
{/if}
{/block}