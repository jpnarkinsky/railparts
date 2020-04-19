_scale = 1;

module SetScale(scale) {
  echo(str("Setting scale to scale ", scale, "."));
  _scale = scale;
}

function Inches(n = 1) = 25.4 * _scale * n;
function Feet(n = 1) = Inches(12) * n;


