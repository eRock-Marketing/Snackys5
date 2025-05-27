{block name='layout-header-shopnav-user'}
	<div class="modal modal-dialog blanklist" tabindex="-1" id="login-popup">
		<div class="modal-content">
			{block name='shopnav-user-modal-header'}
				<div class="modal-header">
					<span class="modal-title block h5">
						{if JTL\Session\Frontend::getCustomer()->getID() === 0}
							{lang key="login" section="global"}
						{else}
							{lang key='hello'} {$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname|entferneFehlerzeichen}
						{/if}
					</span>
					<button type="button" class="close-btn" data-dismiss="modal" aria-label="Close">
					</button>
				</div>
			{/block}
			{block name='shopnav-user-modal-body'}
				<div class="modal-body">
					{if JTL\Session\Frontend::getCustomer()->getID() === 0}
            			{block name='layout-header-shopnav-user-offline'}
							<form action="{get_static_route id='jtl.php' secure=true}" method="post" class="form jtl-validate">
								{$jtl_token}
								{block name='user-form-mail'}
									<div class="form-group">
										<label for="email_quick">{lang key='emailadress'}</label>
										<input type="email" name="email" id="email_quick" class="form-control" placeholder="{lang key='emailadress'}" required spellcheck="false" autocorrect="off"/>
									</div>
								{/block}
								{block name='user-form-password'}
									<div class="form-group">
										<label for="password_quick">{lang key='password'}</label>
										<input type="password"  autocomplete="on" name="passwort" id="password_quick" class="form-control" placeholder="{lang key='password'}" required/>
									</div>
								{/block}
								{block name='user-form-captcha'}
									{if isset($showLoginCaptcha) && $showLoginCaptcha}
										<div class="form-group text-center float-label-control">
											{captchaMarkup getBody=true}
										</div>
									{/if}
								{/block}
								{block name='user-form-submit'}
									<div class="form-group">
										<input type="hidden" name="login" value="1"/>
										{if !empty($oRedirect->cURL)}
											{foreach name=parameter from=$oRedirect->oParameter_arr item=oParameter}
												<input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
											{/foreach}
											<input type="hidden" name="r" value="{$oRedirect->nRedirect} "/>
											<input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
										{/if}
										<button type="submit" id="submit-btn" class="btn btn-primary btn-block btn-lg">{lang key="login" section="global"}</button>
									</div>
								{/block}
							</form>
							{block name='user-form-forgot-password'}
								<div class="text-center">
									<a href="{get_static_route id='pass.php'}" rel="nofollow" title="{lang key='forgotPassword'}" class="link-underline">{lang key='forgotPassword'}?</a>
								</div>
							{/block}
							{block name='user-form-new-here'}							
								<hr>
								<span class="text-center block h4">{lang key='newHere'}</span>
								<a href="{get_static_route id='registrieren.php'}" title="{lang key='registerNow'}" class="btn btn-block btn-lg">{lang key='registerNow'}</a>
            				{/block}
            			{/block}
					{else}
            			{block name='layout-header-shopnav-user-online'}
							<div class="nav blanklist">
                				{block name='layout-header-shopnav-user-user'}
                					{get_static_route id='jtl.php' secure=true assign='secureAccountURL'}
									<a href="{$secureAccountURL}" title="{lang key='myAccount'}" class="flx-ac flx-jb nav-it defaultlink">
										{lang key='myAccount'}
										<span class="img-ct icon icon-wt ic-md">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user"></use>
											</svg>
										</span>
									</a>
                				{/block}
								{block name='layout-header-shopnav-user-orders'}
									<a href="{$secureAccountURL}?bestellungen=1" class="flx-ac flx-jb nav-it defaultlink">
										{lang key="orders" section="account data"}
										<span class="img-ct icon icon icon-wt ic-md">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
											</svg>
										</span>
									</a>
								{/block}
								{block name='layout-header-shopnav-user-adress'}
									<a href="{$secureAccountURL}?editRechnungsadresse=1" class="flx-ac flx-jb nav-it defaultlink">
										{lang key="billingAdress" section="account data"}
										<span class="img-ct icon icon icon-wt ic-md">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-house"></use>
											</svg>
										</span>
									</a>
								{/block}
								{block name='layout-header-shopnav-user-shipadress'}
									<a href="{$secureAccountURL}?editLieferadresse=1" class="flx-ac flx-jb nav-it defaultlink">
										{lang key="myShippingAddresses"}
										<span class="img-ct icon icon icon-wt ic-md">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-house"></use>
											</svg>
										</span>
									</a>
								{/block}
								{block name='layout-header-shopnav-user-wishlist'}
									{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
										<a href="{$secureAccountURL}?wllist=1" class="flx-ac flx-jb nav-it defaultlink">
											{lang key="wishlists" section="account data"}
											<span class="img-ct icon icon icon-wt ic-md">
												<svg>
												  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
												</svg>
											</span>
										</a>
									{/if}
								{/block}
								{block name='layout-header-shopnav-user-compare'}
									{if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y' && !empty($smarty.session.Vergleichsliste->oArtikel_arr) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 0}
										<a href="{get_static_route id='vergleichsliste.php'}" class="flx-ac flx-jb nav-it defaultlink">
											{lang key="compare" sektion="global"}
											<span class="img-ct icon icon icon-wt ic-md">
												<svg>
												  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
												</svg>
											</span>
										</a>
									{/if}
								{/block}
								{block name='layout-header-shopnav-user-reviews'}
									{if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
										<a href="{$secureAccountURL}?bewertungen=1" class="flx-ac flx-jb nav-it defaultlink">
											{lang key='allRatings'}
											<span class="img-ct icon icon icon-wt ic-md">
												<svg>
												  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-reviews"></use>
												</svg>
											</span>
										</a>
									{/if}
								{/block}
							</div>
						{/block}
    				{/if}
				</div>
			{/block}
			{block name='shopnav-user-modal-footer'}
				{if JTL\Session\Frontend::getCustomer()->getID() !== 0}
					<div class="modal-footer">            
						<a href="{$secureAccountURL}?logout=1" title="{lang key='logOut'}" class="btn btn-block">{lang key='logOut'}</a>
					</div>
				{/if}
			{/block}
		</div>
	</div>
{/block}