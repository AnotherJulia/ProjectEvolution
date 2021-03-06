var population;
var lifespan = 400;
var lifeP;
var gen = 1;
var genP;
var count = 0;
var target;
var maxforce = 0.2;

var rx = 100;
var ry = 150;
var rw = 200;
var rh = 10;

function setup() {
  createCanvas(400, 600);
  population = new Population();
  lifeP = createP();
  target = createVector(width / 2, 50);
  genP = createP();
}

function draw() {
  background(200);
  population.run();
  lifeP.html(count);
  genP.html(gen);

  count++;
  if (count == lifespan) {
    population.evaluate();
    population.selection();
    count = 0;
    gen++;
  }
  fill(255);
  rect(rx, ry, rw, rh);
  ellipse(target.x, target.y, 16, 16);
}
