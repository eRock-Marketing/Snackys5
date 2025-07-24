{block name='productdetails-image'}
	<div class="row">
		{block name='productdetails-image-close-lightbox'}
			<span id="close-lightbox" class="close-btn flx-jc"></span>
		{/block}
		{block name="product-image-thumbs-wrapper"}
			{if $Artikel->Bilder|count > 1 && !$isMobile}
				<div id="gallery-thumbs" class="col-12 col-md-2 col-lg-2{if $Artikel->Bilder|count > 5} two-cols flx-jb flx-w{/if}"> 
					{block name="product-image-thumbs"}
						{foreach $Artikel->Bilder as $image name="thumbnails"}
							{strip}
								<div class="img-w{if $smarty.foreach.thumbnails.first} active{/if}">
									<div class="img-ct">
										{image alt=$image->cAltAttribut|escape:'quotes'
											class="product-image"
											fluid=true
											lazy=true
											webp=true
											src="{$image->cURLKlein}"
											data=["list"=>"{$image->galleryJSON|escape:"html"}"]
										}
									</div>
								</div>
							{/strip}
						{/foreach}
					{/block}
				</div>   
			{/if}
		{/block}
		{block name="product-image-wrapper"}
    		<div id="gallery" class="{if $Artikel->Bilder|count > 1 && !$isMobile}col-12 col-md-10 col-lg-10{else}col-12{/if}{if $snackyConfig.productZoom==1} zoom{/if}{if $Artikel->Bilder|count == 1 && $Artikel->Bilder[0]->cURLMini|strstr:'keinBild.gif'} no-lb{/if}">
				{block name="product-image-mobile-prev"}
					{if $Artikel->Bilder|count > 1 && $isMobile}
						<div id="gallery-prev" class="sl-ar sl-pr">
							<div class="ar ar-l"></div>
						</div>
					{/if}
				{/block}
				{block name="product-image-wrapper-inner"}
					<div class="inner">
        				{block name="product-image"}
        					{foreach $Artikel->Bilder as $image name="gallery"}
            					{strip}
                					<a href="#" data-href="{$image->cURLGross}"{if $smarty.foreach.gallery.first} class="active"{/if}>
                    					<div class="img-ct" data-src="{$image->cURLGross}">
											{assign var="isLazy" value=true}
											{if $smarty.foreach.gallery.first && $snackyConfig.nolazyloadProductdetails == 'Y'}
												{assign var="isLazy" value=false}
											{/if}
											{if $image->cURLGross|webpExists}
												{image alt=$image->cAltAttribut|escape:'quotes'
													class="product-image"
													fluid=true
													lazy=$isLazy
													webp=true
													src="{$image->cURLMini}"
													srcset="{$image->cURLMini} {$image->imageSizes->xs->size->width}w,
														{$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
														{$image->cURLNormal} {$image->imageSizes->md->size->width}w,
														{$image->cURLGross} {$image->imageSizes->lg->size->width}w"
													data=["list"=>"{$image->galleryJSON|escape:"html"}", "index"=>$image@index, "big"=>"{$image->cURLGross}","big-webp"=>"{$image->cURLGross|getWebpURL}"]
												}
											{else}
												{image alt=$image->cAltAttribut|escape:'quotes'
												class="product-image"
												fluid=true
												lazy=$isLazy
												webp=true
												src="{$image->cURLMini}"
												srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
														{$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
														{$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w,
														{$image->cURLGross} {$Einstellungen.bilder.bilder_artikel_gross_breite}w"
														data=["list"=>"{$image->galleryJSON|escape:"html"}", "index"=>$image@index, "sizes"=>"auto","big"=>"{$image->cURLGross}"]
														}
											{/if}
										</div>
									</a>
								{/strip}
							{/foreach}
						{/block}
					</div>
				{/block}
				{block name="product-image-mobile-next"}
					{if $Artikel->Bilder|count > 1 && $isMobile}
						<div id="gallery-next" class=" sl-ar sl-nx">
							<div class="ar ar-r"></div>
						</div>
					{/if}   
				{/block}
			</div>         
		{/block}
	</div>
{/block}