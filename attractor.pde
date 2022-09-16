int fR = 300; // Frame rate
int particleNumber = 10000; // Amount of particle being created
int n=0;
float mag =2; // Magnitude of the attraction towards the individual curve point
float size = 0.5; // Size of the particle
float noiseIntensityX = 1; // Intensity of the perlin noise on every particles x-axis
float noiseIntensityY = 0.5; // Intensity of the perlin noise on every particles y-axis

Particle[] particles; // Array of "Particle" objects

class Particle{
  
  PVector coords; // Coordinates of the particle 
  float t; // Time
  float mag; // Magnitude of the attraction towards the individual curve point 
  float size; // Size
  float noiseIntensityX; // Intensity of the perlin noise on every particles x-axis
  float noiseIntensityY; // Intensity of the perlin noise on every particles y-axis
  
  Particle(float mag_, float size_, float noiseIntensityX_, float noiseIntensityY_){
    
     mag = mag_;
     size = size_;
     noiseIntensityX = noiseIntensityX_;
     noiseIntensityY = noiseIntensityY_;
     t = random(particleNumber); // Random starting time for every particle (if t= const => all particles have +- the same trajectory)
     coords = new PVector(3*width/4, 3*height/4); // Particle's origin coordinates
     
  }
   
  void move(){
    
     t += 0.01;
     
     // Creating a 2D noise vector mapping the noise at time t of the x-axis 
     // to a value of range 2 * noiseLevelX (symetrical wrt 0), same with
     // y-axis but this time using time t/2 to avoid having 
     // the same noise values for the x and y components of the vector (one noise map)
     PVector noise = new PVector (map(noise(t), 0, 1, -noiseIntensityX, noiseIntensityX), map(noise(t/2), 0, 1, -noiseIntensityY, noiseIntensityY));
     coords.add(noise);
     
     // Creating the point of attraction located on the curve at time t of the 
     // function (width/2 + 300 *cos,height/2 + 300*sin) - circle of radius 150 at the center of the window
     PVector fPoint = new PVector(width/2 + 300*cos(t), height/2 + 300*(sin(t)));
     
     // Substracting the current particles coordinates to the point of attraction coordinates
     // Setting the magnitude of that vector to be mag
     // Adding that velocity vector [ fPoint.sub(coords).setMag(mag) ] to the
     // Coordinates of the particle at time t
     coords.add(fPoint.sub(coords).setMag(mag));
     
   }
   
   void draw(){
     
     ellipse(coords.x, coords.y, size,size);
     
   }
}

void setup(){
  
  fullScreen(2);
  frameRate(fR);
  size(1280,720, P2D);
  particles = new Particle[particleNumber]; 
  
  // Looping through particles indexes to initialize every single 
  // Particle with the given parameters
  for(int i= 0; i<particleNumber; i++){
    particles[i] = new Particle(mag, size, noiseIntensityX, noiseIntensityY);
  }
  
}

void draw(){
  
  background(255);
  fill(0);
  noStroke();
  
  // Looping through all the particles in particles, make them move and draw
  for(int i= 0; i<particleNumber-1; i++){
    
    particles[i].move();
    particles[i].draw();
  
  }
  
  //saveFrame("output/frame-####.tif");
}
void mousePressed(){
  n+=1;
}
