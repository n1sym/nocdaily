<script>
	export let entry
	let isOpen = false
	const toggle = () => isOpen = !isOpen
</script>
<style>
  .desc {line-height: 1.4;}
  .tuduki {float: left; padding-left: 4px;}
  .keywords { line-height: 1.3; color: #aa7700; font-size: 14px; font-family: "Hiragino Kaku Gothic Pro", "ヒラギノ角ゴ Pro W3","ＭＳ Ｐゴシック", "MS P Gothic", "Arial", "Helvetica", "sans-serif";}
  p {padding-left: 4px; padding-right: 4px;}
	button { width: 100%; border: none; background: rgb(234, 236, 236); display:block; color: rgb(92, 90, 90); font-size: 16px; cursor: pointer; margin: 0; padding: 0}
</style>
<button on:click={toggle} aria-expanded={isOpen}>
  <span class="tuduki"> {entry[0]}</span>
</button>
{#if isOpen}
	<p class="desc">{entry[1][0]}</p>
  <p class="keywords">{entry[1][1]}</p>
{/if}