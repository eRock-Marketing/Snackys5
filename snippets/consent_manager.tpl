{block name='snippets-consent-manager'}
<div id="consent-manager" data-nosnippet >
	{$privacyURL = ''}
	{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
		{$privacyURL = $oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}
	{/if}
	{block name='snippets-consent-manager-banner'}
		<div id="consent-banner">
			{block name='snippets-consent-manager-banner-icon'}
				<div class="consent-banner-icon">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256.12 245.96c-13.25 0-24 10.74-24 24 1.14 72.25-8.14 141.9-27.7 211.55-2.73 9.72 2.15 30.49 23.12 30.49 10.48 0 20.11-6.92 23.09-17.52 13.53-47.91 31.04-125.41 29.48-224.52.01-13.25-10.73-24-23.99-24zm-.86-81.73C194 164.16 151.25 211.3 152.1 265.32c.75 47.94-3.75 95.91-13.37 142.55-2.69 12.98 5.67 25.69 18.64 28.36 13.05 2.67 25.67-5.66 28.36-18.64 10.34-50.09 15.17-101.58 14.37-153.02-.41-25.95 19.92-52.49 54.45-52.34 31.31.47 57.15 25.34 57.62 55.47.77 48.05-2.81 96.33-10.61 143.55-2.17 13.06 6.69 25.42 19.76 27.58 19.97 3.33 26.81-15.1 27.58-19.77 8.28-50.03 12.06-101.21 11.27-152.11-.88-55.8-47.94-101.88-104.91-102.72zm-110.69-19.78c-10.3-8.34-25.37-6.8-33.76 3.48-25.62 31.5-39.39 71.28-38.75 112 .59 37.58-2.47 75.27-9.11 112.05-2.34 13.05 6.31 25.53 19.36 27.89 20.11 3.5 27.07-14.81 27.89-19.36 7.19-39.84 10.5-80.66 9.86-121.33-.47-29.88 9.2-57.88 28-80.97 8.35-10.28 6.79-25.39-3.49-33.76zm109.47-62.33c-15.41-.41-30.87 1.44-45.78 4.97-12.89 3.06-20.87 15.98-17.83 28.89 3.06 12.89 16 20.83 28.89 17.83 11.05-2.61 22.47-3.77 34-3.69 75.43 1.13 137.73 61.5 138.88 134.58.59 37.88-1.28 76.11-5.58 113.63-1.5 13.17 7.95 25.08 21.11 26.58 16.72 1.95 25.51-11.88 26.58-21.11a929.06 929.06 0 0 0 5.89-119.85c-1.56-98.75-85.07-180.33-186.16-181.83zm252.07 121.45c-2.86-12.92-15.51-21.2-28.61-18.27-12.94 2.86-21.12 15.66-18.26 28.61 4.71 21.41 4.91 37.41 4.7 61.6-.11 13.27 10.55 24.09 23.8 24.2h.2c13.17 0 23.89-10.61 24-23.8.18-22.18.4-44.11-5.83-72.34zm-40.12-90.72C417.29 43.46 337.6 1.29 252.81.02 183.02-.82 118.47 24.91 70.46 72.94 24.09 119.37-.9 181.04.14 246.65l-.12 21.47c-.39 13.25 10.03 24.31 23.28 24.69.23.02.48.02.72.02 12.92 0 23.59-10.3 23.97-23.3l.16-23.64c-.83-52.5 19.16-101.86 56.28-139 38.76-38.8 91.34-59.67 147.68-58.86 69.45 1.03 134.73 35.56 174.62 92.39 7.61 10.86 22.56 13.45 33.42 5.86 10.84-7.62 13.46-22.59 5.84-33.43z"/></svg>
				</div>
			{/block}
			{block name='snippets-consent-manager-banner-body'}
				<div class="consent-banner-body">
					{block name='snippets-consent-manager-banner-body-description'}
						<div class="consent-banner-description">
							{block name='snippets-consent-manager-banner-body-description-title'}
								<span class="consent-display-2">{lang key='howWeUseCookies' section='consent'}</span>
							{/block}
							{$items = []}
							{foreach $consentItems as $item}{$items[] = $item->getName()}{/foreach}
							{block name='snippets-consent-manager-banner-body-description-description'}
								<p>{lang key='consentDescription' section='consent' printf=implode(', ', $items)|cat:':::'|cat:$privacyURL}</p>
							{/block}
						</div>
					{/block}
					{block name='snippets-consent-manager-banner-body-actions'}
						<div class="consent-banner-actions">
							<div class="consent-btn-helper">
								<div class="consent-accept">
									<button type="button" class="consent-btn consent-btn-tertiary btn-block" id="consent-banner-btn-all">{lang key='consentAll' section='consent'}</button>
								</div>
								<div>
									<button type="button"
											class="consent-btn consent-btn-outline-primary btn-block"
											id="consent-banner-btn-close"
											title="{lang key='close' section='consent'}">
										{lang key='close' section='consent'}
									</button>
								</div>
								<div>
									<button type="button" class="consent-btn consent-btn-secondary btn-block" id="consent-banner-btn-settings">{lang key='configure' section='consent'}</button>
								</div>
							</div>
						</div>
					{/block}
				</div>
			{/block}
		</div>
	{/block}
	{block name='snippets-consent-manager-settings'}
		<div id="consent-settings" class="consent-modal">
			<div class="consent-modal-content">
				{block name='snippets-consent-manager-settings-close'}
					<button type="button" class="consent-modal-close" data-toggle="consent-close">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="currentColor" d="M207.6 256l107.72-107.72c6.23-6.23 6.23-16.34 0-22.58l-25.03-25.03c-6.23-6.23-16.34-6.23-22.58 0L160 208.4 52.28 100.68c-6.23-6.23-16.34-6.23-22.58 0L4.68 125.7c-6.23 6.23-6.23 16.34 0 22.58L112.4 256 4.68 363.72c-6.23 6.23-6.23 16.34 0 22.58l25.03 25.03c6.23 6.23 16.34 6.23 22.58 0L160 303.6l107.72 107.72c6.23 6.23 16.34 6.23 22.58 0l25.03-25.03c6.23-6.23 6.23-16.34 0-22.58L207.6 256z"/></svg>
					</button>
				{/block}
				{block name='snippets-consent-manager-settings-icon'}
					<div class="consent-modal-icon">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256.12 245.96c-13.25 0-24 10.74-24 24 1.14 72.25-8.14 141.9-27.7 211.55-2.73 9.72 2.15 30.49 23.12 30.49 10.48 0 20.11-6.92 23.09-17.52 13.53-47.91 31.04-125.41 29.48-224.52.01-13.25-10.73-24-23.99-24zm-.86-81.73C194 164.16 151.25 211.3 152.1 265.32c.75 47.94-3.75 95.91-13.37 142.55-2.69 12.98 5.67 25.69 18.64 28.36 13.05 2.67 25.67-5.66 28.36-18.64 10.34-50.09 15.17-101.58 14.37-153.02-.41-25.95 19.92-52.49 54.45-52.34 31.31.47 57.15 25.34 57.62 55.47.77 48.05-2.81 96.33-10.61 143.55-2.17 13.06 6.69 25.42 19.76 27.58 19.97 3.33 26.81-15.1 27.58-19.77 8.28-50.03 12.06-101.21 11.27-152.11-.88-55.8-47.94-101.88-104.91-102.72zm-110.69-19.78c-10.3-8.34-25.37-6.8-33.76 3.48-25.62 31.5-39.39 71.28-38.75 112 .59 37.58-2.47 75.27-9.11 112.05-2.34 13.05 6.31 25.53 19.36 27.89 20.11 3.5 27.07-14.81 27.89-19.36 7.19-39.84 10.5-80.66 9.86-121.33-.47-29.88 9.2-57.88 28-80.97 8.35-10.28 6.79-25.39-3.49-33.76zm109.47-62.33c-15.41-.41-30.87 1.44-45.78 4.97-12.89 3.06-20.87 15.98-17.83 28.89 3.06 12.89 16 20.83 28.89 17.83 11.05-2.61 22.47-3.77 34-3.69 75.43 1.13 137.73 61.5 138.88 134.58.59 37.88-1.28 76.11-5.58 113.63-1.5 13.17 7.95 25.08 21.11 26.58 16.72 1.95 25.51-11.88 26.58-21.11a929.06 929.06 0 0 0 5.89-119.85c-1.56-98.75-85.07-180.33-186.16-181.83zm252.07 121.45c-2.86-12.92-15.51-21.2-28.61-18.27-12.94 2.86-21.12 15.66-18.26 28.61 4.71 21.41 4.91 37.41 4.7 61.6-.11 13.27 10.55 24.09 23.8 24.2h.2c13.17 0 23.89-10.61 24-23.8.18-22.18.4-44.11-5.83-72.34zm-40.12-90.72C417.29 43.46 337.6 1.29 252.81.02 183.02-.82 118.47 24.91 70.46 72.94 24.09 119.37-.9 181.04.14 246.65l-.12 21.47c-.39 13.25 10.03 24.31 23.28 24.69.23.02.48.02.72.02 12.92 0 23.59-10.3 23.97-23.3l.16-23.64c-.83-52.5 19.16-101.86 56.28-139 38.76-38.8 91.34-59.67 147.68-58.86 69.45 1.03 134.73 35.56 174.62 92.39 7.61 10.86 22.56 13.45 33.42 5.86 10.84-7.62 13.46-22.59 5.84-33.43z"/></svg>
					</div>
				{/block}
				{block name='snippets-consent-manager-settings-title'}
					<span class="consent-display-1">{lang key='cookieSettings' section='consent'}</span>
				{/block}
				{block name='snippets-consent-manager-settings-description'}
					<p>{lang key='cookieSettingsDescription' section='consent' printf=$privacyURL}</p>
				{/block}
				{block name='snippets-consent-manager-settings-buttons-top'}
					<div class="consent-btn-holder">
						<div class="consent-switch">
							<input type="checkbox" class="consent-input" id="consent-all-1" name="consent-all-1" data-toggle="consent-all">
							<label class="consent-label consent-label-secondary" for="consent-all-1"><span>{lang key='selectAll' section='consent'}</span></label>
						</div>
						<div class="consent-accept">
							<button type="button" class="consent-btn consent-btn-tertiary consent-btn-block consent-btn-primary consent-btn-sm d-md-none" data-toggle="consent-close">
								{lang key='apply' section='consent'}
							</button>
						</div>
					</div>
				{/block}
				{block name='snippets-consent-manager-settings-hr'}
					<hr />
				{/block}
				{block name='snippets-consent-manager-settings-items'}
					{foreach $consentItems as $item}
						{$id = $item->getID()}
						<div class="consent-switch">
							{block name='snippets-consent-manager-settings-items-checkbox'}
								<input type="checkbox" class="consent-input" id="consent-{$id}" name="consent-{$id}" data-storage-key="{$item->getItemID()}">
								<label class="consent-label" for="consent-{$id}">{$item->getName()}</label>
							{/block}
							{block name='snippets-consent-manager-settings-items-more-button'}
								<a class="consent-show-more" href="#" data-collapse="consent-{$id}-description">
									{lang key='moreInformation' section='consent'}<span class="consent-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256 8C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm0 110c23.196 0 42 18.804 42 42s-18.804 42-42 42-42-18.804-42-42 18.804-42 42-42zm56 254c0 6.627-5.373 12-12 12h-88c-6.627 0-12-5.373-12-12v-24c0-6.627 5.373-12 12-12h12v-64h-12c-6.627 0-12-5.373-12-12v-24c0-6.627 5.373-12 12-12h64c6.627 0 12 5.373 12 12v100h12c6.627 0 12 5.373 12 12v24z"/></svg></span>
								</a>
							{/block}
							{block name='snippets-consent-manager-settings-items-help'}
								<div class="consent-help">
									<p>{$item->getDescription()}</p>
								</div>
							{/block}
							{block name='snippets-consent-manager-settings-items-more-content'}
								<div class="consent-help consent-more-description consent-hidden" id="consent-{$id}-description">
									<span class="consent-display-3 consent-no-space">{lang key='description' section='consent'}:</span>
									<p>{$item->getPurpose()}</p>
									<span class="consent-display-3 consent-no-space">{lang key='company' section='consent'}:</span>
									<p>{$item->getCompany()}</p>
									<span class="consent-display-3 consent-no-space">{lang key='terms' section='consent'}:</span>
									<a href="{$item->getPrivacyPolicy()}" target="_blank" rel="noopener">{lang key='link' section='consent'}</a>
								</div>
							{/block}
						</div>
						{block name='snippets-consent-manager-settings-items-hr'}
							<hr />
						{/block}
					{/foreach}
				{/block}
				{block name='snippets-consent-manager-settings-buttons-bottom'}
					<div class="consent-btn-holder">
						<div class="consent-switch">
							<input type="checkbox" class="consent-input" id="consent-all-2" name="consent-all-2" data-toggle="consent-all">
							<label class="consent-label consent-label-secondary" for="consent-all-2"><span>{lang key='selectAll' section='consent'}</span></label>
						</div>
						<div class="consent-accept">
							<button type="button" class="consent-btn consent-btn-tertiary consent-btn-block consent-btn-primary consent-btn-sm" data-toggle="consent-close">
								{lang key='apply' section='consent'}
							</button>
						</div>
					</div>
				{/block}
			</div>
		</div>
	{/block}

	{block name='snippets-consent-manager-button'}
		<button type="button" class="consent-btn consent-btn-outline-primary" id="consent-settings-btn" title="{lang key='cookieSettings' section='consent'}">
			<span class="consent-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256.12 245.96c-13.25 0-24 10.74-24 24 1.14 72.25-8.14 141.9-27.7 211.55-2.73 9.72 2.15 30.49 23.12 30.49 10.48 0 20.11-6.92 23.09-17.52 13.53-47.91 31.04-125.41 29.48-224.52.01-13.25-10.73-24-23.99-24zm-.86-81.73C194 164.16 151.25 211.3 152.1 265.32c.75 47.94-3.75 95.91-13.37 142.55-2.69 12.98 5.67 25.69 18.64 28.36 13.05 2.67 25.67-5.66 28.36-18.64 10.34-50.09 15.17-101.58 14.37-153.02-.41-25.95 19.92-52.49 54.45-52.34 31.31.47 57.15 25.34 57.62 55.47.77 48.05-2.81 96.33-10.61 143.55-2.17 13.06 6.69 25.42 19.76 27.58 19.97 3.33 26.81-15.1 27.58-19.77 8.28-50.03 12.06-101.21 11.27-152.11-.88-55.8-47.94-101.88-104.91-102.72zm-110.69-19.78c-10.3-8.34-25.37-6.8-33.76 3.48-25.62 31.5-39.39 71.28-38.75 112 .59 37.58-2.47 75.27-9.11 112.05-2.34 13.05 6.31 25.53 19.36 27.89 20.11 3.5 27.07-14.81 27.89-19.36 7.19-39.84 10.5-80.66 9.86-121.33-.47-29.88 9.2-57.88 28-80.97 8.35-10.28 6.79-25.39-3.49-33.76zm109.47-62.33c-15.41-.41-30.87 1.44-45.78 4.97-12.89 3.06-20.87 15.98-17.83 28.89 3.06 12.89 16 20.83 28.89 17.83 11.05-2.61 22.47-3.77 34-3.69 75.43 1.13 137.73 61.5 138.88 134.58.59 37.88-1.28 76.11-5.58 113.63-1.5 13.17 7.95 25.08 21.11 26.58 16.72 1.95 25.51-11.88 26.58-21.11a929.06 929.06 0 0 0 5.89-119.85c-1.56-98.75-85.07-180.33-186.16-181.83zm252.07 121.45c-2.86-12.92-15.51-21.2-28.61-18.27-12.94 2.86-21.12 15.66-18.26 28.61 4.71 21.41 4.91 37.41 4.7 61.6-.11 13.27 10.55 24.09 23.8 24.2h.2c13.17 0 23.89-10.61 24-23.8.18-22.18.4-44.11-5.83-72.34zm-40.12-90.72C417.29 43.46 337.6 1.29 252.81.02 183.02-.82 118.47 24.91 70.46 72.94 24.09 119.37-.9 181.04.14 246.65l-.12 21.47c-.39 13.25 10.03 24.31 23.28 24.69.23.02.48.02.72.02 12.92 0 23.59-10.3 23.97-23.3l.16-23.64c-.83-52.5 19.16-101.86 56.28-139 38.76-38.8 91.34-59.67 147.68-58.86 69.45 1.03 134.73 35.56 174.62 92.39 7.61 10.86 22.56 13.45 33.42 5.86 10.84-7.62 13.46-22.59 5.84-33.43z"/></svg></span>
		</button>
	{/block}

	{block name='snippets-consent-manager-confirm'}
		<div id="consent-confirm" class="consent-modal">
			{block name='snippets-consent-manager-confirm-hidden'}
				<input type="hidden" id="consent-confirm-key">
			{/block}
			{block name='snippets-consent-manager-confirm-content'}
				<div class="consent-modal-content">
					{block name='snippets-consent-manager-confirm-close'}
						<button type="button" class="consent-modal-close" data-toggle="consent-close">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="currentColor" d="M207.6 256l107.72-107.72c6.23-6.23 6.23-16.34 0-22.58l-25.03-25.03c-6.23-6.23-16.34-6.23-22.58 0L160 208.4 52.28 100.68c-6.23-6.23-16.34-6.23-22.58 0L4.68 125.7c-6.23 6.23-6.23 16.34 0 22.58L112.4 256 4.68 363.72c-6.23 6.23-6.23 16.34 0 22.58l25.03 25.03c6.23 6.23 16.34 6.23 22.58 0L160 303.6l107.72 107.72c6.23 6.23 16.34 6.23 22.58 0l25.03-25.03c6.23-6.23 6.23-16.34 0-22.58L207.6 256z"/></svg>
						</button>
					{/block}
					{block name='snippets-consent-manager-confirm-icon'}
						<div class="consent-modal-icon">
							<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256.12 245.96c-13.25 0-24 10.74-24 24 1.14 72.25-8.14 141.9-27.7 211.55-2.73 9.72 2.15 30.49 23.12 30.49 10.48 0 20.11-6.92 23.09-17.52 13.53-47.91 31.04-125.41 29.48-224.52.01-13.25-10.73-24-23.99-24zm-.86-81.73C194 164.16 151.25 211.3 152.1 265.32c.75 47.94-3.75 95.91-13.37 142.55-2.69 12.98 5.67 25.69 18.64 28.36 13.05 2.67 25.67-5.66 28.36-18.64 10.34-50.09 15.17-101.58 14.37-153.02-.41-25.95 19.92-52.49 54.45-52.34 31.31.47 57.15 25.34 57.62 55.47.77 48.05-2.81 96.33-10.61 143.55-2.17 13.06 6.69 25.42 19.76 27.58 19.97 3.33 26.81-15.1 27.58-19.77 8.28-50.03 12.06-101.21 11.27-152.11-.88-55.8-47.94-101.88-104.91-102.72zm-110.69-19.78c-10.3-8.34-25.37-6.8-33.76 3.48-25.62 31.5-39.39 71.28-38.75 112 .59 37.58-2.47 75.27-9.11 112.05-2.34 13.05 6.31 25.53 19.36 27.89 20.11 3.5 27.07-14.81 27.89-19.36 7.19-39.84 10.5-80.66 9.86-121.33-.47-29.88 9.2-57.88 28-80.97 8.35-10.28 6.79-25.39-3.49-33.76zm109.47-62.33c-15.41-.41-30.87 1.44-45.78 4.97-12.89 3.06-20.87 15.98-17.83 28.89 3.06 12.89 16 20.83 28.89 17.83 11.05-2.61 22.47-3.77 34-3.69 75.43 1.13 137.73 61.5 138.88 134.58.59 37.88-1.28 76.11-5.58 113.63-1.5 13.17 7.95 25.08 21.11 26.58 16.72 1.95 25.51-11.88 26.58-21.11a929.06 929.06 0 0 0 5.89-119.85c-1.56-98.75-85.07-180.33-186.16-181.83zm252.07 121.45c-2.86-12.92-15.51-21.2-28.61-18.27-12.94 2.86-21.12 15.66-18.26 28.61 4.71 21.41 4.91 37.41 4.7 61.6-.11 13.27 10.55 24.09 23.8 24.2h.2c13.17 0 23.89-10.61 24-23.8.18-22.18.4-44.11-5.83-72.34zm-40.12-90.72C417.29 43.46 337.6 1.29 252.81.02 183.02-.82 118.47 24.91 70.46 72.94 24.09 119.37-.9 181.04.14 246.65l-.12 21.47c-.39 13.25 10.03 24.31 23.28 24.69.23.02.48.02.72.02 12.92 0 23.59-10.3 23.97-23.3l.16-23.64c-.83-52.5 19.16-101.86 56.28-139 38.76-38.8 91.34-59.67 147.68-58.86 69.45 1.03 134.73 35.56 174.62 92.39 7.61 10.86 22.56 13.45 33.42 5.86 10.84-7.62 13.46-22.59 5.84-33.43z"/></svg>
						</div>
					{/block}
					{block name='snippets-consent-manager-confirm-title'}
						<span class="consent-display-1">{lang key='dataProtection' section='consent'}</span>
					{/block}
					{block name='snippets-consent-manager-confirm-description'}
						<p>{lang key='dataProtectionDescription' section='consent' printf=$privacyURL}</p>
					{/block}
					{block name='snippets-consent-manager-confirm-info'}
						<div class="consent-info">
							{block name='snippets-consent-manager-confirm-info-more-button'}
								<a class="consent-show-more" href="#" data-collapse="consent-confirm-info-description">
									{lang key='moreInformation' section='consent'}<span class="consent-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" d="M256 8C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm0 110c23.196 0 42 18.804 42 42s-18.804 42-42 42-42-18.804-42-42 18.804-42 42-42zm56 254c0 6.627-5.373 12-12 12h-88c-6.627 0-12-5.373-12-12v-24c0-6.627 5.373-12 12-12h12v-64h-12c-6.627 0-12-5.373-12-12v-24c0-6.627 5.373-12 12-12h64c6.627 0 12 5.373 12 12v100h12c6.627 0 12 5.373 12 12v24z"/></svg></span>
								</a>
							{/block}
							{block name='snippets-consent-manager-confirm-info-more-content'}
								{literal}
								<span class="consent-display-2" id="consent-confirm-info-headline">{{headline}}</span>
								<span class="consent-help" id="consent-confirm-info-help">{{description}}</span>
								<div class="consent-help consent-more-description consent-hidden" id="consent-confirm-info-description"></div>
								{/literal}
							{/block}
						</div>
					{/block}
					{block name='snippets-consent-manager-confirm-buttons'}
						<div class="consent-btn-helper">
							<div>
								<button type="button" class="consent-btn consent-btn-outline-primary btn-block" id="consent-btn-once">{lang key='consentOnce' section='consent'}</button>
							</div>
							<div>
								<button type="button" class="consent-btn consent-btn-tertiary btn-block" id="consent-btn-always">{lang key='consentAlways' section='consent'}</button>
							</div>
						</div>
					{/block}
				</div>
			{/block}
		</div>
	{/block}
</div>
{/block}
