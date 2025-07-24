{if $id}
	{assign var="snackys_id" value=$id|replace:"opc_":""}
	{snackys_content id=$snackys_id title=$title}
	{assign var="opc_id" value="opc_"|cat:$id}
	{opcMountPoint id=$opc_id title=$title}
{/if}