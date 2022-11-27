<script>
  import {onMount} from "svelte";
  onMount(async () => {
    update();
  })

  import Settings from './Settings.svelte';
  let show_settings = false;
  let is_bass = false;
  const change_show_settings = () => {
    show_settings = !show_settings;
    update();
  }
  const change_is_bass = () => is_bass = !is_bass;

  import Note from './Note.svelte';
  let noteComponent = null;
  const runs_per_round = 50;
  let runs = runs_per_round;
  let score = 0;
  let correct_in_row = 0;

  const notes = [
    ["e/3", null, "1/2/3", "e"],
    ["f/3", null, "1/3", "f"],
    ["f/3", "#", "2/3", "fis"],
    ["g/3", null, "1/2", "g"],
    ["a/3", "b", "1", "as"],
    ["a/3", null, "2", "a"],
    ["b/3", "b", "0", "b"],
    ["b/3", null, "1/2/3", "h"],
    ["c/4", null, "1/3", "c1"],
    ["d/4", null, "1/2", "d1"],
    ["e/4", "b", "1", "es1"],
    ["e/4", null, "2", "e1"],
    ["f/4", null, "0", "f'"],
    ["f/4", "#", "2/3", "fis'"],
    ["g/4", null, "1/2", "g'"],
    ["a/4", "b", "1", "as'"],
    ["a/4", null, "2", "a'"],
    ["b/4", "b", "0", "b'"],
    ["b/4", null, "1/2", "h'"],
    ["c/5", null, "1", "c'"],
    ["d/5", null, "0", "d'"],
    ["e/5", "b", "1", "es'"],
  ];
  const notes_bass = [
    ["e/2", "b", "1/4", "Es"],
    ["e/2", null, "2/4 (1/2/3)", "E"],
    ["f/2", null, "4 (1/3)", "F"],
    ["f/2", "#", "2/3", "Fis"],
    ["g/2", null, "1/2", "G"],
    ["a/2", "b", "1", "As"],
    ["a/2", null, "2", "A"],
    ["b/2", "b", "0", "B"],
    ["b/2", null, "2/4 (1/2/3)", "H"],
    ["c/3", null, "4 (1/3)", "c"],
    ["d/3", null, "1/2", "d"],
    ["e/3", "b", "1", "es"],
    ["e/3", null, "2", "e"],
    ["f/3", null, "0", "f"],
    ["f/3", "#", "2/3", "fis"],
    ["g/3", null, "1/2", "g"],
    ["a/3", "b", "1", "as"],
    ["a/3", null, "2", "a"],
    ["b/3", "b", "0", "b"],
    ["b/3", null, "1/2", "h"],
    ["c/4", null, "1", "c'"],
    ["d/4", null, "0", "d'"],
    ["e/4", "b", "1", "es'"],
  ];
  let current_note =  null;

  const modes = [
    ["name", "Wie heißt diese Note?", 3],
    ["finger", "Wie greift man diese Note?", 2],
  ]

  const shuffle = d => {
    let out = [...d];
    for (var c = out.length - 1; c > 0; c--) {
      var b = Math.floor(Math.random() * (c + 1));
      var a = out[c];
      out[c] = out[b];
      out[b] = a;
    }
    return out;
  };

  const remove_note = (notes, name) => notes.filter(note => note[2] !== name);

  const update = () => {
    // get mode
    const mode = shuffle(modes)[0][2];
    // generate options
    let options = [];
    let tmp_notes = shuffle(is_bass ? notes_bass: notes);
    for (let i=0 ; i<4 ; i++){
      options.push(tmp_notes[0]);
      tmp_notes = remove_note(tmp_notes, tmp_notes[0][2]);
    }
    // set current_note
    current_note = options[0];
    noteComponent.setNote(current_note[0], current_note[1]);
    // set options
    options = shuffle(options);
    document.getElementById('button1').innerHTML = options[0][mode];
    document.getElementById('button2').innerHTML = options[1][mode];
    document.getElementById('button3').innerHTML = options[2][mode];
    document.getElementById('button4').innerHTML = options[3][mode];
    document.getElementById('button1').onclick = () => evaluate(options[0]);
    document.getElementById('button2').onclick = () => evaluate(options[1]);
    document.getElementById('button3').onclick = () => evaluate(options[2]);
    document.getElementById('button4').onclick = () => evaluate(options[3]);
  };

  const evaluate = note => {
    if ( note === current_note) {
      correct_in_row += 1;
      score += correct_in_row;
      update();
    } else {
      correct_in_row = 0;
    }
    if (runs === 0) {
      alert("Du hast " + score + " Punkte erreicht");
      runs = runs_per_round;
      score = 0;
      correct_in_row = 0;
      return;
    }
    runs -= 1;
  }

</script>

<style>
  #note {
    flex: 1;
    background-color: #DDDDDD;
  }

  #buttons {
    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
    justify-content: flex-start;
    align-items: stretch;
  }

  button {
    margin: 0;
    padding: 0;
    font-size: 4em;
  }

  .flex {
    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
    justify-content: flex-start;
    align-items: stretch;
  }
  #btn_settings {
    text-align: center;
    margin-right: 1em;
  }

  #btn_settings:hover {
    background-color: #555555;
  }
</style>

<main class="div-fill flex">
  <div class='div-fill flex' style={show_settings && 'display: none'}>
    <p id='btn_settings' on:click={change_show_settings}>Einstellungen</p>
    <p>Verbleibende Durchläufe: {runs}</p>
    <p>Punkte: {score}</p>
    <p>Richtig in Folge: {correct_in_row}</p>
    <div id='note'>
      <Note
        is_bass={is_bass}
        bind:this={noteComponent}
      />
    </div>
    <div id="buttons">
      <button id='button1'>Answer 1</button>
      <button id='button2'>Answer 2</button>
      <button id='button3'>Answer 3</button>
      <button id='button4'>Answer 4</button>
    </div>
  </div>
  <div class='div-fill flex' style={!show_settings && 'display: none'}>
    <Settings
      change_show_settings={change_show_settings}
      change_is_bass={change_is_bass}
      is_bass={is_bass}
    />
  </div>
</main>
