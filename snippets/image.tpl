{block name='snippets-image'}
    {if $item !== null && !empty($item->getImage(\JTL\Media\Image::SIZE_XS))}
    {block name='snippets-image-variables'}
        {$square      = $square|default:true}
        {$fluid       = $fluid|default:true}
        {$lazy        = $lazy|default:true}
        {$webp        = $webp|default:true}
        {$sizes       = $sizes|default:'100vw'}
        {$class       = $class|default:''}
        {$squareClass = $squareClass|default:''}
        {$srcSize     = $srcSize|default:'md'}
        {$center      = $center|default:false}

        {if $srcSize === 'xs'}
            {$srcSize = \JTL\Media\Image::SIZE_XS}
        {elseif $srcSize === 'sm'}
            {$srcSize = \JTL\Media\Image::SIZE_SM}
        {elseif $srcSize === 'md'}
            {$srcSize = \JTL\Media\Image::SIZE_MD}
        {else}
            {$srcSize = \JTL\Media\Image::SIZE_LG}
        {/if}


        {$imageType = $item->getImageType()}
        {$mini      = $item->getImageWidth('xs')}
        {$klein     = $item->getImageWidth('sm')}
        {$normal    = $item->getImageWidth('md')}
        {$gross     = $item->getImageWidth('lg')}
        {$width     = $width|default:$item->getImageWidth('lg')}
        {$height    = $height|default:$item->getImageHeight('lg')}

        {if $imageType === \JTL\Media\Image::TYPE_CHARACTERISTIC_VALUE}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_merkmalwert_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_merkmalwert_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_merkmalwert_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_merkmalwert_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_merkmalwert_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_merkmalwert_gross_hoehe}
            {$alt    = $alt|default:$item->getValue()}
        {elseif $imageType === \JTL\Media\Image::TYPE_CHARACTERISTIC}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_merkmal_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_merkmal_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_merkmal_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_merkmal_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_merkmal_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_merkmal_gross_hoehe}
            {$alt    = $alt|default:$item->getName()}
        {elseif $imageType === \JTL\Media\Image::TYPE_PRODUCT}
            {$mini   = $item->Bilder[0]->imageSizes->xs->size->width}
            {$klein  = $item->Bilder[0]->imageSizes->sm->size->width}
            {$normal = $item->Bilder[0]->imageSizes->md->size->width}
            {$gross  = $item->Bilder[0]->imageSizes->lg->size->width}
            {$width  = $width|default:$Einstellungen.bilder.bilder_artikel_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_artikel_gross_hoehe}
            {if isset($item->Bilder[0]->cAltAttribut)}
                {$alt=$item->Bilder[0]->cAltAttribut|truncate:60}
            {else}
                {$alt=$item->cName|default:''}
            {/if}
        {elseif $imageType === \JTL\Media\Image::TYPE_VARIATION}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_variationen_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_variationen_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_variationen_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_variationen_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_variationen_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_variationen_gross_hoehe}
            {$alt    = $alt|default:$item->cName}
        {elseif $imageType === \JTL\Media\Image::TYPE_NEWS}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_news_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_news_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_news_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_news_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_news_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_news_gross_hoehe}
        {elseif $imageType === \JTL\Media\Image::TYPE_NEWSCATEGORY}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_newskategorie_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_newskategorie_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_newskategorie_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_newskategorie_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_newskategorie_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_newskategorie_gross_hoehe}
            {$alt    = $alt|default:$item->getName()}
        {elseif $imageType === \JTL\Media\Image::TYPE_CONFIGGROUP}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_konfiggruppe_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_konfiggruppe_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_konfiggruppe_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_konfiggruppe_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_konfiggruppe_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_konfiggruppe_gross_hoehe}
            {$alt    = $alt|default:$item->getSprache()->getName()}
        {elseif $imageType === \JTL\Media\Image::TYPE_MANUFACTURER}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_hersteller_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_hersteller_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_hersteller_normal_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_hersteller_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_hersteller_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_hersteller_gross_hoehe}
            {$alt    = $alt|default:$item->getName()}
        {else}
            {$mini   = $mini|default:$Einstellungen.bilder.bilder_kategorien_mini_breite}
            {$klein  = $klein|default:$Einstellungen.bilder.bilder_kategorien_klein_breite}
            {$normal = $normal|default:$Einstellungen.bilder.bilder_kategorien_breite}
            {$gross  = $gross|default:$Einstellungen.bilder.bilder_kategorien_gross_breite}
            {$width  = $width|default:$Einstellungen.bilder.bilder_kategorien_gross_breite}
            {$height = $height|default:$Einstellungen.bilder.bilder_kategorien_gross_hoehe}
            {$alt    = $alt|default:$item->getName()}
        {/if}
        {$alt = $alt|default:''}
    {/block}

    {block name='snippets-image-main'}
        {if $square}
        <div class="square square-image {$squareClass}">
            <div class="inner">
        {/if}
            {block name='snippets-image-main-image'}
                {image fluid=$fluid lazy=$lazy webp=$webp center=$center
                    src=$item->getImage($srcSize)
                    srcset="{$item->getImage(\JTL\Media\Image::SIZE_XS)} {$mini}w,
                            {$item->getImage(\JTL\Media\Image::SIZE_SM)} {$klein}w,
                            {$item->getImage(\JTL\Media\Image::SIZE_MD)} {$normal}w,
                            {$item->getImage(\JTL\Media\Image::SIZE_LG)} {$gross}w"
                    alt=$alt|strip_tags|escape:'quotes'
                    sizes=$sizes
                    class=$class
                }
            {/block}
        {if $square}
            </div>
        </div>
        {/if}
		{if isset($second) && !$isMobile}
			{if $square}
			<div class="square square-image {$squareClass}">
				<div class="inner">
			{/if}
				{block name='snippets-image-main-image'}
                {if strpos($item->getImage($srcSize), 'keinBild.gif') !== false}
                    {image fluid=$fluid lazy=$lazy webp=$webp center=$center
                        src=$item->getImage($srcSize)
                        alt=$alt|strip_tags|escape:'quotes'|escape:'html'
                        width=130
                        height= 130
                        class=$class
                    }
                {else}
                    {image fluid=$fluid lazy=$lazy webp=$webp center=$center
                        src=$item->getImage($srcSize)
                        srcset="{$item->getImage(\JTL\Media\Image::SIZE_XS)} {$mini}w,
                                {$item->getImage(\JTL\Media\Image::SIZE_SM)} {$klein}w,
                                {$item->getImage(\JTL\Media\Image::SIZE_MD)} {$normal}w,
                                {$item->getImage(\JTL\Media\Image::SIZE_LG)} {$gross}w"
                        alt=$alt|strip_tags|escape:'quotes'|escape:'html'
                        sizes=$sizes
                        width=$width
                        height=$height
                        class=$class
                    }
                {/if}
				{/block}
			{if $square}
				</div>
			</div>
			{/if}
		{/if}
    {/block}
    {/if}
{/block}