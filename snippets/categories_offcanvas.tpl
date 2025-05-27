{block name='snippets-categories-offcanvas'}
{lang key="view" assign="view_"}
<h5>{$result->current->getName()}</h5>
<ul class="nav navbar-nav">
    <li class="clearfix">
        <a href="#" class="nav-sub" data-ref="0">{lang key="showAll" section="global"}</a>
        <a href="#" class="nav-sub" data-ref="{$result->current->kOberKategorie}">{lang key="back" section="global"}</a>
    </li>
    <li><a href="{$result->current->getURL()}" class="nav-active">{$result->current->getName()} {$view_|lower}</a></li>
    {include file='snippets/categories_recursive.tpl' i=0 categoryId=$result->current->getID() limit=2 caret='right'}
</ul>
{/block}