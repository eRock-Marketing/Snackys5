{block name='snippets-modal-general'}
{*
    Parameters:
        modalID    - unique id for the modal
        modalTitle - the modal dialogs title
        modalBody  - body text of the modal with more information
*}
<div class="modal fade" id="{$modalID}-modal" tabindex="-1" role="dialog" aria-labelledby="{$modalID}-label">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close' section='account data'}"><span aria-hidden="true">&times;</span></button>
                <div class="modal-title h5" id="{$modalID}-label">{$modalTitle}</div>
            </div>
            <div class="modal-body">
                {$modalBody}
            </div>
        </div>
    </div>
</div>
{/block}
