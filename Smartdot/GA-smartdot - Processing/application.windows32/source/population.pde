class population {
  dot[] dots;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  int minStep= 400;

  population(int size) {
    dots = new dot[size];  
    for (int i = 0; i < dots.length; i++) {
      dots[i] = new dot();
    }
  }
  // --------------------------------------------

  void naturalSelection() {
    dot[] newdots = new dot[dots.length];  
    setBestDot();
    calculateFitnessSum();

    newdots[0] = dots[bestDot].gimmeBaby();
    newdots[0].isBest = true;
    for (int i = 1; i < dots.length; i++) {
      dot parent = selectparent();
      newdots[i] = parent.gimmeBaby();
    }

    dots = newdots.clone();
    gen++;
  }



  // --------------------------------------------

  void show() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  // --------------------------------------------

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }

  // --------------------------------------------

  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  // --------------------------------------------

  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }

  // --------------------------------------------
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }


  dot selectparent() {
    float rand = random(fitnessSum);
    float runningSum = 0;

    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }
    //should never get to this point
    return null;
  }

  // --------------------------------------------

  void mutateDemBabies() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  // --------------------------------------------

  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;

    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("step: ", minStep);
    }
  }
}
