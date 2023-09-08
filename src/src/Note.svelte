<script>
  import vexflow from 'vexflow';
  export let is_bass;

  const setNote = (note, accidental) => {
    const clef = is_bass ? 'bass': 'treble';
    const div = document.getElementById("main");
    div.innerHTML = ""
    const renderer = new vexflow.Flow.Renderer(div, vexflow.Flow.Renderer.Backends.SVG);
    const context = renderer.getContext();
    const stave = new vexflow.Flow.Stave(10, 40, 200);
    stave.addClef(clef).addTimeSignature("4/4");
    stave.setContext(context).draw();
    const notes = accidental ? [
      new vexflow.Flow.StaveNote({clef: clef, keys: [note], duration: '1'}).addAccidental(0, new vexflow.Flow.Accidental(accidental)),
    ] : [
      new vexflow.Flow.StaveNote({clef: clef, keys: [note], duration: '1'}),
    ];
    const voice = new vexflow.Flow.Voice({num_beats: 4, beat_value: 4});
    voice.addTickables(notes);
    const formatter = new vexflow.Flow.Formatter().joinVoices([voice]).format([voice], 350);
    voice.draw(context, stave);
  }

  export {setNote}
</script>

<style>
</style>

<div id='main'>
</div>
