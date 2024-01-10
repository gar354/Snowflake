class Particle {
  float x, y;
  float radius;
  
  boolean stopped = false;
  
  void show() {
    fill(0,0,0,0);
    stroke(255);
    ellipse(x, y, radius * 2, radius * 2);
  }
  
  void tick() {
    x -= 1;
    y += (float)linearInterpolate(-1.5d, 1.5d, Math.random());
  }
  
  void move(Particle particle, ArrayList<Particle> _particles) {
     while (!particle.stopped) {
       particle.tick();
       particle.stopped = isParticleColliding(_particles, particle);
    }
  }
  

  
  Particle(float _x, float _y) {
    x = _x;
    y = _y;
    radius = 5;
  }
  
  Particle() {
    this((float)width, 0.0);
  }
}
