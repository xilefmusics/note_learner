<script>
  export let change_show_settings;
  export let change_is_bass;
  export let is_bass;

</script>

<style>
  #main {
    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
    justify-content: flex-start;
    align-items: stretch;
  }

  p {
    text-align: center;
    margin-right: 1em;
  }

  p:hover {
    background-color: #555555;
  }

  .line {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    justify-content: flex-start;
    align-items: stretch;
    padding: 1em;
  }

  label {
    padding-left: 0.5em;
  }

</style>

<div id='main'>
  <p on:click={change_show_settings}>Zurück</p>
  <div class='line'>
    <input type="checkbox" value={is_bass} on:click={change_is_bass} />
    <label>Bassschlüssel</label>
  </div>
</div>
