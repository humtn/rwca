int fR = 300; // Frame rate
int particleNumber = 10000; // Amount of particle being created
int n=0;
float mag =2; // Magnitude of the attraction towards the individual curve point
float size = 0.5; // Size of the particle
float noiseIntensityX = 1; // Intensity of the perlin noise on every particles x-axis
float noiseIntensityY = 0.5; // Intensity of the perlin noise on every particles y-axis

Particle[] particles; 

class Particle{
  
  PVector coords; 
  float t; 
  float mag; 
  float size; 
  float noiseIntensityX; 
  float noiseIntensityY; 
  
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
     
     PVector noise = new PVector (map(noise(t), 0, 1, -noiseIntensityX, noiseIntensityX), map(noise(t/2), 0, 1, -noiseIntensityY, noiseIntensityY));
     coords.add(noise);
     
     PVector fPoint = new PVector(width/2 + 300*cos(t), height/2 + 300*(sin(t)));
     
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
  
  for(int i= 0; i<particleNumber; i++){
    particles[i] = new Particle(mag, size, noiseIntensityX, noiseIntensityY);
  }
  
}

void draw(){
  
  background(255);
  fill(0);
  noStroke();
  
  for(int i= 0; i<particleNumber-1; i++){
    
    particles[i].move();
    particles[i].draw();
  
  }
  
}
