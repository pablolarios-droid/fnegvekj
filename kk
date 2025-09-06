<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Monito con WASD + Space cambia color</title>
    <style>
      body {
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 20px; 
        height: 100vh;
        background: url("Fondo.jpg"); 
        background-size: cover;
        font-family: Arial, sans-serif;
      }

      canvas {
        border: 2px solid black;
      }

      #canvas {
        width: 800px;
        height: 600px;
      }

      .instructions {
        width: 200px;
        height: 600px;
        background: rgba(255,255,255,0.8);
        border: 2px solid black;
        padding: 15px;
        font-size: 16px;
        line-height: 1.5em;
      }

      .instructions h2 {
        text-align: center;
        font-size: 20px;
        margin-bottom: 10px;
      }
    </style>
  </head>
  <body>
    <!-- instrucciones izquierda -->
    <div class="instructions">
      <h2>Controles</h2>
      <p>W = Mostrar HelloKitty</p>
      <p>A = Mostrar Cinnamoroll</p>
      <p>S = Mostrar Kuromi</p>
      <p>D = Mostrar Pochaco</p>
      <p>SPACE = Cambiar color fondo</p>
    </div>

    <!-- canvas principal -->
    <canvas id="canvas" width="800" height="600"></canvas>

    <!-- instrucciones derecha -->
    <div class="instructions">
      <h2>¿Qué hacer aquí?</h2>
      <p>Presiona <b>W, A, S, D</b> para mostrar diferentes personajes en el mismo lugar.</p>
      <p>Presiona <b>SPACE</b> para cambiar el color de fondo del canvas:</p>
      <ul>
        <li>Blanco → Rojo</li>
        <li>Rojo → Azul</li>
        <li>Azul → Blanco</li>
      </ul>
    </div>
    
    <script>
    const Keycode = {
      W: 87,
      A: 65,
      S: 83,
      D: 68,
      SPACE: 32
    };

    let canvas, context;
    let currentKey = null;
    let images = {};
    let keysPressed = {};

    // El monito ya no se moverá, siempre en el mismo lugar
    let player = { x: 350, y: 250, size: 300 };

    // Colores posibles del fondo
    let colors = ["white", "red", "blue"];
    let currentColorIndex = 0;

    function loadImages() {
      images["W"] = new Image();
      images["W"].src = "Ussop.jpg";

      images["A"] = new Image();
      images["A"].src = "luffy,jpg";

      images["S"] = new Image();
      images["S"].src = "NICO";

      images["D"] = new Image();
      images["D"].src = "DESCARGA";
    }

    window.onload = function () {
      canvas = document.getElementById("canvas");
      context = canvas.getContext("2d");
      loadImages();
      gameLoop();
    };

    function draw() {
      // Fondo dinámico
      context.fillStyle = colors[currentColorIndex];
      context.fillRect(0, 0, canvas.width, canvas.height);

      if (currentKey) {
        context.fillStyle = "purple";
        context.font = "40px Arial";
        context.fillText(currentKey, player.x, player.y - 10);

        let img = images[currentKey];
        if (img && img.complete) {
          // Mantener proporción original
          let aspect = img.width / img.height;
          let drawHeight = player.size;
          let drawWidth = player.size * aspect;
          context.drawImage(img, player.x, player.y, drawWidth, drawHeight);
        }
      }
    }

    // update ya no mueve al monito
    function update() {
      // vacío: el monito ya no se mueve
    }

    function gameLoop() {
      update();
      draw();
      requestAnimationFrame(gameLoop);
    }

    function onKeyDown(event) {
      if (event.keyCode === Keycode.SPACE && !keysPressed[Keycode.SPACE]) {
        // Cambiar color cuando se presiona Space
        currentColorIndex = (currentColorIndex + 1) % colors.length;
      }

      // Guardamos la tecla actual si es WASD
      if (event.keyCode === Keycode.W) currentKey = "W";
      if (event.keyCode === Keycode.A) currentKey = "A";
      if (event.keyCode === Keycode.S) currentKey = "S";
      if (event.keyCode === Keycode.D) currentKey = "D";

      keysPressed[event.keyCode] = true;
    }

    function onKeyUp(event) {
      keysPressed[event.keyCode] = false;
    }

    window.addEventListener('keydown', onKeyDown, false);
    window.addEventListener('keyup', onKeyUp, false);
    </script>
  </body>
</html>