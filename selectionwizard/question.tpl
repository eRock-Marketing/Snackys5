{block name='selectionwizard-question'}
    <div class="list-group-item selection-wizard-question {if $nQuestion > $AWA->getCurQuestion()}disabled{/if}">
        <hr class="hr-sm">
        {block name='selectionwizard-question-title'}
            <h4 class="list-group-item-heading selection-wizard-question-heading flx-ac">
                <span class="mr-xxs">{$oFrage->cFrage}</span>
                {if $nQuestion < $AWA->getCurQuestion()}
                    <a href="#" onclick="return resetSelectionWizardAnswerJS({$nQuestion});" class="btn btn-sm">{lang key="edit"}</a>
                {/if}
            </h4>
        {/block}
        {if $nQuestion < $AWA->getCurQuestion()}
            {block name='selectionwizard-question-answer'}
                <span class="selection-wizard-answer">
                    {assign var="oWert" value=$AWA->getSelectedValue($nQuestion)}
                    {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['B', 'BT'], true)}
                        <img src="{$imageBaseURL}{$oWert->cBildpfadKlein}" alt="{$oWert->getValue()}" title="{$oWert->getValue()}">
                    {/if}
                    {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['T', 'BT', 'S'], true)}
                        {$oWert->getValue()}
                    {/if}
                </span>
            {/block}
        {elseif $nQuestion === $AWA->getCurQuestion()}
            {if $AWA->getConf('auswahlassistent_anzeigeformat') === 'S'}
                {block name='selectionwizard-question-select'}
                    <label for="kMerkmalWert-{$nQuestion}" class="sr-only">{lang key='pleaseChoose' section='global'}</label>
                    <select id="kMerkmalWert-{$nQuestion}" onchange="return setSelectionWizardAnswerJS($(this).val());" class="form-control">
                        <option value="-1">{lang key='pleaseChoose' section='global'}</option>
                        {foreach $oFrage->oWert_arr as $oWert}
                            {if isset($oWert->nAnzahl)}
                                <option value="{$oWert->kMerkmalWert}">
                                    {$oWert->getValue()}
                                    {if $AWA->getConf('auswahlassistent_anzahl_anzeigen') === 'Y'}
                                        ({$oWert->nAnzahl})
                                    {/if}
                                </option>
                            {/if}
                        {/foreach}
                    </select>
                {/block}
            {else}
                {block name='selectionwizard-question-text'}
                    {foreach $oFrage->oWert_arr as $oWert}
                        {if isset($oWert->nAnzahl)}
                            <a class="selection-wizard-answer" href="#" onclick="return setSelectionWizardAnswerJS({$oWert->kMerkmalWert});">
                                {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['B', 'BT'], true)}
                                    <img src="{$imageBaseURL}{$oWert->cBildpfadKlein}" alt="{$oWert->getValue()}" title="{$oWert->getValue()}">
                                {/if}
                                {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['T', 'BT'], true)}
                                    <span>{$oWert->getValue()}</span>
                                    {if $AWA->getConf('auswahlassistent_anzahl_anzeigen') === 'Y'}
                                        <span class="badge">
                                        {$oWert->getCount()}
                                        </span>
                                    {/if}
                                {/if}
                            </a>
                        {/if}
                    {/foreach}
                {/block}
            {/if}
        {elseif $nQuestion > $AWA->getCurQuestion()}
            {if $AWA->getConf('auswahlassistent_anzeigeformat') === 'S'}
                {block name='selectionwizard-question-next-select'}
                    <label for="kMerkmalWert-{$nQuestion}" class="sr-only">{lang key="pleaseChoose" section="global"}</label>
                    <select id="kMerkmalWert-{$nQuestion}" disabled="disabled" class="form-control">
                        <option value="-1">{lang key="pleaseChoose" section="global"}</option>
                    </select>
                {/block}
            {else}
                {foreach $oFrage->oWert_arr as $oWert}
                    {block name='selectionwizard-question-next-text'}
                        {if $oWert->getCount() > 0}
                            <span class="selection-wizard-answer">
                                {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['B', 'BT'], true)}
                                    <img src="{$imageBaseURL}{$oWert->cBildpfadKlein}" alt="{$oWert->getValue()}" title="{$oWert->getValue()}">
                                {/if}
                                {if in_array($AWA->getConf('auswahlassistent_anzeigeformat'), ['T', 'BT'], true)}
                                    {$oWert->getValue()}
                                {/if}
                            </span>
                        {/if}
                    {/block}
                {/foreach}
            {/if}
        {/if}
    </div>
{/block}