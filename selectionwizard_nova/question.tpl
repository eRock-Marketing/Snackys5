{block name='selectionwizard-question'}
    {if $nQuestion > $AWA->getCurQuestion()} <div class="list-group-wrapper disabled">{/if}
    {listgroupitem class="selection-wizard-question {if $nQuestion > $AWA->getCurQuestion()}disabled{else}px-0{/if}"}
        {block name='selectionwizard-question-heading'}
            <div class="h5 selection-wizard-question-heading">
                {$oFrage->cFrage}
                {if $nQuestion < $AWA->getCurQuestion()}
                    {link href="#" data=["value"=>$nQuestion] class="question-edit"}<i class="fa fa-edit"></i>{/link}
                {/if}
            </div>
        {/block}
        {if $nQuestion < $AWA->getCurQuestion()}
            {block name='selectionwizard-question-answer-smaller'}
                {row}
                    {col cols=4 sm=4 md=3 xl=2 class="selection-wizard-question-item"}
                        <span class="selection-wizard-answer">
                            {$characteristicValue = $AWA->getSelectedValue($nQuestion)}
                            {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['B', 'BT']:true}
                                {include file='snippets/image.tpl' item=$characteristicValue srcSize='sm'}
                            {/if}
                            {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['T', 'BT', 'S']:true}
                                {$characteristicValue->getValue()}
                            {/if}
                        </span>
                    {/col}
                {/row}
            {/block}
        {elseif $nQuestion === $AWA->getCurQuestion()}
            {if $AWA->getConf('auswahlassistent_anzeigeformat') === 'S'}
                {block name='selectionwizard-question-answer-equals-s'}
                    <label for="kMerkmalWert-{$nQuestion}" class="sr-only">{lang key='pleaseChoose' section='global'}</label>
                    {select id="kMerkmalWert-{$nQuestion}" class='custom-select'}
                        <option value="-1">{lang key='pleaseChoose' section='global'}</option>
                        {foreach $oFrage->oWert_arr as $characteristicValue}
                            {if $characteristicValue->getCount() > 0}
                                <option value="{$characteristicValue->getID()}">
                                    {$characteristicValue->getValue()}
                                    {if $AWA->getConf('auswahlassistent_anzahl_anzeigen') === 'Y'}
                                        ({$characteristicValue->nAnzahl})
                                    {/if}
                                </option>
                            {/if}
                        {/foreach}
                    {/select}
                {/block}
            {else}
                {block name='selectionwizard-question-answer-equals-other'}
                    {row}
                        {foreach $oFrage->oWert_arr as $characteristicValue}
                            {col cols=4 sm=4 md=3 xl=2 class="selection-wizard-question-item"}
                                {if $characteristicValue->getCount() > 0}
                                    {link class="selection-wizard-answer text-decoration-none-util" href="#" data=["value"=>$characteristicValue->getID()]}
                                        {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['B', 'BT']:true}
                                            {include file='snippets/image.tpl' item=$characteristicValue srcSize='sm'}
                                        {/if}
                                        {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['T', 'BT']:true}
                                            <span class="text-clamp-2">
                                                {$characteristicValue->getValue()}
                                                {if $AWA->getConf('auswahlassistent_anzahl_anzeigen') === 'Y'}
                                                    {badge variant="outline-secondary"}
                                                        {$characteristicValue->getCount()}
                                                    {/badge}
                                                {/if}
                                            </span>
                                        {/if}
                                    {/link}
                                {/if}
                            {/col}
                        {/foreach}
                    {/row}
                {/block}
            {/if}
        {elseif $nQuestion > $AWA->getCurQuestion()}
            {block name='selectionwizard-question-anwser-bigger'}
                {if $AWA->getConf('auswahlassistent_anzeigeformat') === 'S'}
                    <label for="kMerkmalWert-{$nQuestion}" class="sr-only">{lang key='pleaseChoose' section='global'}</label>
                    {select id="kMerkmalWert-{$nQuestion}" class='custom-select' disabled="disabled"}
                        <option value="-1">{lang key='pleaseChoose' section='global'}</option>
                    {/select}
                {else}
                    {row}
                        {foreach $oFrage->oWert_arr as $characteristicValue}
                            {col cols=4 sm=4 md=3 xl=2 class="selection-wizard-question-item"}
                                {if $characteristicValue->getCount() > 0}
                                    <span class="selection-wizard-answer">
                                        {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['B', 'BT']:true}
                                            {include file='snippets/image.tpl' item=$characteristicValue srcSize='sm'}
                                        {/if}
                                        {if $AWA->getConf('auswahlassistent_anzeigeformat')|in_array:['T', 'BT']:true}
                                            {$characteristicValue->getValue()}
                                        {/if}
                                    </span>
                                {/if}
                            {/col}
                        {/foreach}
                    {/row}
                {/if}
            {/block}
        {/if}
    {/listgroupitem}
    {if $nQuestion > $AWA->getCurQuestion()}</div>{/if}
{/block}
