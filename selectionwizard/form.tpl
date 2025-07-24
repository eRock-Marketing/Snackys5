{block name='selectionwizard-form'}
{if isset($AWA)}
    <p class="selection-wizard-desc h4">
        {$AWA->getDescription()}
    </p>
    <div class="list-group selection-wizard">
        {foreach $AWA->getQuestions() as $nQuestion => $oFrage}
            {if $AWA->getConf('auswahlassistent_allefragen') === 'Y' || $nQuestion <= $AWA->getCurQuestion()}
                {include file='selectionwizard/question.tpl' AWA=$AWA nQuestion=$nQuestion oFrage=$oFrage}
            {/if}
        {/foreach}
    </div>
{/if}
{/block}