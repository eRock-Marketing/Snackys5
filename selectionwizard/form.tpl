{block name='selectionwizard-form'}
    {if isset($AWA)}
        {block name='selectionwizard-description'}
            <p class="selection-wizard-desc h4">
                {$AWA->getDescription()}
            </p>
        {/block}
        {block name='selectionwizard-list'}
            <div class="list-group selection-wizard">
                {foreach $AWA->getQuestions() as $nQuestion => $oFrage}
                    {block name='selectionwizard-list-question'}
                        {if $AWA->getConf('auswahlassistent_allefragen') === 'Y' || $nQuestion <= $AWA->getCurQuestion()}
                            {include file='selectionwizard/question.tpl' AWA=$AWA nQuestion=$nQuestion oFrage=$oFrage}
                        {/if}
                    {/block}
                {/foreach}
            </div>
        {/block}
    {/if}
{/block}