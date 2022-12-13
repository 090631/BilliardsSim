import java.lang.Math;
import ddf.minim.*;
Minim minim;
AudioPlayer music;
Ball[] balls = new Ball[15];
AudioPlayer[] musics = new AudioPlayer[15];
int total = 2;


void setup(){
  frameRate(60);
  size(1800, 850, P2D);
  for(int i = 0; i < balls.length; i++){
    balls[i] = new Ball();
  }
  minim = new Minim(this);
  
  for(int i = 0; i < balls.length; i++){
    musics[i] = minim.loadFile("assets/poolballx.wav");
  }
}

void draw(){
  background(0);
  for(int i = 0; i < total; i++){
    balls[i].displayBall();
    balls[i].moveBall();
  }
  collide(balls);
}

void mousePressed(){
  total = total + 1;
  balls[total-1].circleX = mouseX;
  balls[total-1].circleY = mouseY;
}

void keyPressed(){
  total = total - 1;
}
