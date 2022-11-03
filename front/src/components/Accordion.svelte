<script>
	import Item from './Item.svelte'

  export let desc;
  export let keywords;

	const data = {
		'続きを読む': [desc, keywords.split("/").join("　")],
	}
</script>
{#each Object.entries(data) as entry}
<Item {entry} />
{/each}