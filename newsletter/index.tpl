{block name='newsletter-index'}
	{block name='newsletter-viewportimages'}
		{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
	{/block}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name="content"}
		{block name='newsletter-extension'}
    		{include file="snippets/extension.tpl"}
		{/block}	
		{block name='newsletter-index-heading'}
			{if !empty($Link->getTitle())}
				{include file="snippets/zonen.tpl" id="opc_before_newsletter_heading"}
				<h1>{$Link->getTitle()}</h1>
			{/if}
		{/block}
		{block name='newsletter-assigns'}	
    		{assign var=cPost_arr value=$cPost_arr|default:[]}
		{/block}
		{block name='newsletter-index-link-content'}
			{if !empty($Link->getContent())}
				{include file="snippets/zonen.tpl" id="opc_before_newsletter_content"}
				<div class="mb-sm">
					{$Link->getContent()}
				</div>
			{/if}
		{/block}
    	{if $cOption === 'eintragen'}
        	{if empty($bBereitsAbonnent)}
            	{block name="newsletter-subscribe"}
					{include file="snippets/zonen.tpl" id="before_newsletter_subscribe" title="before_newsletter_subscribe"}
            		<div id="newsletter-subscribe" class="mb-md">
                		<div class="panel panel-default">
							{block name="newsletter-subscribe-heading"}
								<div class="panel-heading">
									<h2 class="panel-title h3">{block name="newsletter-subscribe-title"}{lang key="newsletterSubscribe" section="newsletter"}{/block}</h2>
								</div>
							{/block}
							{block name="newsletter-subscribe-body-outer"}
                    			<div class="panel-body">
                        			{block name="newsletter-subscribe-body"}
										{block name="newsletter-subscribe-description"}
                        					<p>{lang key="newsletterSubscribeDesc" section="newsletter"}</p>
										{/block}
										{block name="newsletter-subscribe-form"}    
                        					<form method="post" action="{get_static_route id='newsletter.php'}" role="form" class="jtl-validate">
                            					<fieldset>
													<legend class="sr-only">{lang key="newsletterSubscribe" section="newsletter"}</legend>
													<div class="required-info small mb-xs">{lang key='requiredInfo' section='custom'}</div>
													{block name="newsletter-subscribe-form-firstname"}
														<div class="form-group float-label-control">
															<label for="newsletterfirstname" class="control-label">{lang key="newsletterfirstname" section="newsletter"}</label>
															<input type="text" name="cVorname" class="form-control" value="{if !empty($oPlausi->cPost_arr.cVorname)}{$oPlausi->cPost_arr.cVorname}{elseif !empty($oKunde->cVorname)}{$oKunde->cVorname}{/if}" id="newsletterfirstname" />
															{if !empty($oPlausi->nPlausi_arr.cVorname)}
																<div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
															{/if}
														</div>
													{/block}
													{block name="newsletter-subscribe-form-lastname"}
														<div class="form-group float-label-control">
															<label for="lastName" class="control-label">{lang key="newsletterlastname" section="newsletter"}</label>
															<input type="text" name="cNachname" class="form-control" value="{if !empty($oPlausi->cPost_arr.cNachname)}{$oPlausi->cPost_arr.cNachname}{elseif !empty($oKunde->cNachname)}{$oKunde->cNachname|entferneFehlerzeichen}{/if}" id="lastName" />
															{if !empty($oPlausi->nPlausi_arr.cNachname)}
																<div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
															{/if}
														</div>
													{/block}
													{block name="newsletter-subscribe-form-email"}
														<div class="form-group float-label-control{if !empty($oPlausi->nPlausi_arr.cEmail)} has-error{/if} required">
															<label for="email" class="control-label">{lang key="newsletteremail" section="newsletter"}</label>
															<input type="email" name="cEmail" class="form-control" required value="{if !empty($oPlausi->cPost_arr.cEmail)}{$oPlausi->cPost_arr.cEmail}{elseif !empty($oKunde->cMail)}{$oKunde->cMail}{/if}" id="email" />
															{if !empty($oPlausi->nPlausi_arr.cEmail)}
																<div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
															{/if}
														</div>
													{/block}
													{block name="newsletter-subscribe-form-captcha"}
                                						{if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) && isset($Einstellungen.newsletter.newsletter_sicherheitscode) && $Einstellungen.newsletter.newsletter_sicherheitscode !== 'N' && JTL\Session\Frontend::getCustomer()->getID() === 0}
                                							<hr>
                                    						{captchaMarkup getBody=true}
                                    						<hr>
														{/if}
													{/block}
													{block name="newsletter-subscribe-form-checkboxes"}
														{if isset($oPlausi->nPlausi_arr)}
															{assign var=plausiArr value=$oPlausi->nPlausi_arr}
														{else}
															{assign var=plausiArr value=array()}
														{/if}
														{hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
														{if $bHasCheckbox}
															<hr>
															{include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
															<hr>
														{/if}
													{/block}
													{block name="newsletter-subscribe-form-privacy"}
														{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
															<p class="privacy text-muted small">
																 {lang key='newsletterInformedConsent' section='newsletter' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}
															</p>
														{/if}
													{/block}
													{block name="newsletter-subscribe-form-submit"}
                                						<div class="form-group">
                                    						{$jtl_token}
                                        					<input type="hidden" name="abonnieren" value="1" />
															<button type="submit" class="btn btn-primary submit">
																<span>{lang key="newsletterSendSubscribe" section="newsletter"}</span>
															</button>
                                						</div>
													{/block}
												</fieldset>
											</form>
										{/block}
									{/block}
                    			</div>
							{/block}
						</div>
					</div>
				{/block}
			{/if}        
        	{block name="newsletter-unsubscribe"}
				{include file="snippets/zonen.tpl" id="opc_before_newsletter_unsubscribe"}
				<div id="newsletter-unsubscribe" class="panel-wrap top15">
            		<div class="panel panel-default">
						{block name="newsletter-unsubscribe-headline"}
                			<div class="panel-heading">
                				<h2 class="panel-title h3">{block name="newsletter-unsubscribe-title"}{lang key="newsletterUnsubscribe" section="newsletter"}{/block}</h2>
							</div>
						{/block}
						{block name="newsletter-unsubscribe-body-outer"}
                			<div class="panel-body">
                    			{block name="newsletter-unsubscribe-body"}
									{block name="newsletter-unsubscribe-description"}
                    					<p>{lang key="newsletterUnsubscribeDesc" section="newsletter"}</p>
									{/block}
									{block name="newsletter-unsubscribe-form"}    
                    					<form method="post" action="{get_static_route id='newsletter.php'}" name="newsletterabmelden" class="jtl-validate">
                        					<fieldset>
												<legend class="sr-only">{lang key="newsletterUnsubscribe" section="newsletter"}</legend>
												<div class="required-info small mb-xs">{lang key='requiredInfo' section='custom'}</div>
												{block name="newsletter-unsubscribe-form-mail"}
													<div class="form-group float-label-control required{if !empty($oFehlendeAngaben->cUnsubscribeEmail)} has-error{/if}">
														<label for="checkOut" class="control-label">{lang key="newsletteremail" section="newsletter"}</label>
														<input type="email" class="form-control" required name="cEmail" value="{if !empty($oKunde->cMail)}{$oKunde->cMail}{/if}" id="checkOut" />
														{if !empty($oFehlendeAngaben->cUnsubscribeEmail)}
															<div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
														{/if}
													</div>
												{/block}
                            					{$jtl_token}
												{block name="newsletter-unsubscribe-form-submit"}
													<input type="hidden" name="abmelden" value="1" />
													<button type="submit" class="submit btn btn-default">
														<span>{lang key="newsletterSendUnsubscribe" section="newsletter"}</span>
													</button>
												{/block}
                        					</fieldset>
										</form>
									{/block}
								{/block}
							</div>
						{/block}
					</div>
				</div>
			{/block}
		{elseif $cOption === 'anzeigen'}
        	{if isset($oNewsletterHistory) && $oNewsletterHistory->kNewsletterHistory > 0}
            	{block name="newsletter-history"}
					{block name="newsletter-history-headline"}
            			<h2 class="h3">{lang key="newsletterhistory" section="global"}</h2>
					{/block}
					{block name="newsletter-history-content"}
						<div id="newsletterContent">
							<ul class="nv blanklist">
								<li class="nav-it">
									<strong>{lang key="newsletterdraftsubject" section="newsletter"}:</strong> {$oNewsletterHistory->cBetreff}
								</li>
								<li class="nav-it">
									<strong>{lang key="newsletterdraftdate" section="newsletter"}:</strong> {$oNewsletterHistory->Datum}
								</li>
							</ul>

							<fieldset id="newsletterHtml">
								{$oNewsletterHistory->cHTMLStatic|replace:'src="http://':'src="//'}
							</fieldset>
						</div>
            		{/block}
				{/block}
			{else}
				<div class="alert alert-danger">{lang key="noEntriesAvailable" section="global"}</div>
			{/if}
		{/if}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}