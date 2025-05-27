{block name='blog-preview'}
	<div class="panel pn-news">
		<a href="{$newsItem->getURL()}" class="block">
			{block name='blog-preview-image'}
				{if !empty($newsItem->getPreviewImage())}
					<div class="img-w">
						<span class="img-ct rt4x3">
							{include file='snippets/image.tpl'
								item=$newsItem
								square=false
								alt="{$newsItem->getTitle()|escape:'quotes'} - {$newsItem->getMetaTitle()|escape:'quotes'}"}
						</span>
					</div>
				{/if}
			{/block}
			{block name='blog-preview-title'}
				<span class="title block h4 m0">
					{$newsItem->getTitle()}
				</span>
			{/block}
			{block name='blog-preview-info'}
				<div class="text-muted small flx-ac v-box mt-xxs">
					{block name='blog-preview-info-author'}
						{if $newsItem->getAuthor() !== null}
							<div class="hidden-xs">{$newsItem->getAuthor()->cName}</div>
							<span class="sep">|</span>
						{/if}
					{/block}
					{block name='blog-preview-info-date'}
						{assign var='dDate' value=$newsItem->getDateValidFrom()->format('Y-m-d H:i:s')}
						{$newsItem->getDateValidFrom()->format('d.m.Y')}
					{/block}
					{block name='blog-preview-info-comments'}
						{if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
							<span class="sep">|</span>
							<span class="flx-ac">
								<span class="img-ct icon">
									<svg>
									<use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-comment"></use>
									</svg>
								</span>
								{$newsItem->getCommentCount()} <span class="sr-only">{lang key='newsComments' section='news'}</span>
							</span>
						{/if}
					{/block}
				</div>
			{/block}
			{block name='blog-preview-text'}
				<div class="panel-body mt-xs mb-xs">
					{if $newsItem->getPreview()|strip_tags|strlen > 0}
						{$newsItem->getPreview()|strip_tags}
					{else}
						{$newsItem->getContent()|strip_tags|truncate:300:"...":true}
					{/if}
				</div>
			{/block}
			{block name='blog-preview-morelink'}
				<span class="more">
					{lang key='moreLink' section='news'}
				</spam>
			{/block}
		</a>
	</div>
{/block}