// contants (feel free to change this)
int spokeAmount = 6;
// ---

ArrayList<Particle> particles;

// proper casing for functions: https://www.oracle.com/java/technologies/javase/codeconventions-namingconventions.html
void setup() {
  size(1000, 1000);
  particles = new ArrayList<Particle>();
}

void draw() {
  background(0);
  particles.add(new Particle());
  Particle particle = particles.get(particles.size() - 1);
  particle.move(particle, particles);
  // particle drawing
  for (int i = 0; i < spokeAmount; i++) {
    pushMatrix();
    // move to the center and rotate
    translate(width / 2, height / 2);
    rotate(((2.0 * PI) / (float)spokeAmount) * i);
    
    // draw symetrically
    scale(1, -1);
    showParticles(particles);
    scale(1, -1);
    showParticles(particles);

    popMatrix();
  }
  
  // check if snowflake is finished
  if ((particle.x + particle.radius) > width / 2) {
    // reset snowflake
    particles.clear();
  }
}

// utility functions (replace default processing library functions)
double linearInterpolate(double x1, double x2, double weight) {
  return (1 - weight) * x1 + weight * x2;
}

float distSquared(float x1, float y1, float x2, float y2) {
  float xDiff = x1 - x2;
  float yDiff = y1 - y2;
  return (xDiff * xDiff) + (yDiff * yDiff);
}
// ---


// particle utility
void showParticles(ArrayList<Particle> _particles) {
  for (Particle particle : _particles) {
      particle.show();
  }
}

boolean isParticleColliding(ArrayList<Particle> _particles, Particle particle) {
  
  if ((particle.x - particle.radius) < 0) {
    // particle has reached the end
    return true;
  }
  
  for (Particle particle2 : _particles) {
    // if the particle is the same, skip the collision check
    if (particle2 == particle) {
      continue;
    }
    // use distance squared to perform optimized collision checking
    float minDistSquared = pow(particle2.radius + particle.radius, 2);
    if (distSquared(particle.x, particle.y, particle2.x, particle2.y) < minDistSquared) {
      return true;
    }
  }
  // no collisions have been found
  return false;
}
// ---
