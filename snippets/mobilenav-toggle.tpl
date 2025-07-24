{block name='snippets-mobilenav-toggle'}
	<button id="mob-nt" aria-label="{lang key='mobileNavigationOpen' section='custom'}" 
	onclick="
          setTimeout(() => {
            const firstMenuLink = document.querySelector('#cat-ul > li > a');
            if (firstMenuLink) firstMenuLink.focus();
          }, 100);
          return false;">
		<span class="burger-line first"></span>
		<span class="burger-line middle"></span>
		<span class="burger-line last"></span>
	</button>	
{/block}