class Ball{  
  double circleX, circleY;
  double vx = random(10);
  double vy = random(10);
  float col;
  float r = random(20, 60);
  float m = r/10;
  Ball(){
    circleX = random(width);
    circleY = random(height);
    col = random(155, 255);
  }
  void displayBall(){
    fill(col);
    float x = (float) circleX;
    float y = (float) circleY;
    ellipse(x, y, r*2, r*2);
  }
  
  void moveBall(){
    circleX = circleX + vx;
    circleY = circleY + vy;
    if(circleX > width-r){
      circleX = width-r;
      vx = -vx;
    }if(circleX < r){
      circleX = r;
      vx = -vx;
    }
    if(circleY > height-r){
      circleY = height-r;
      vy = -vy;
    }if(circleY < r){
      circleY = r;
      vy = -vy;
    }
  }
}

void collide(Ball[] balls){
  for(int i = 0; i < total; i++){
    for(int j = i+1; j < total; j++){ //<>// //<>//
      Ball b1 = balls[i];
      Ball b2 = balls[j];
      float x1 = (float) b1.circleX;
      float y1 = (float) b1.circleY;
      float x2 = (float) b2.circleX;
      float y2 = (float) b2.circleY;
      float d = dist(x1, y1, x2, y2);
      float dx = x1 - x2;
      float dy = y1 - y2;
      float ov = (b1.r + b2.r)-d;
      
      if(d < (b1.r+b2.r)){
        if(b1.r > b2.r){
        musics[i].setGain(map(b1.r, 20, 30, -10, 10));
        musics[i].rewind();
        musics[i].play();
        }else{
        musics[j].setGain(map(b2.r, 20, 30, -10, 10));
        musics[j].rewind();
        musics[j].play();
        }
        double angle = Math.atan2(dx, dy);
        double sin = Math.sin(angle);
        double cos = Math.cos(angle);
        
        double vx1 =  cos*b1.vx + sin*b1.vy; 
        double vy1 =  -sin*b1.vx + cos*b1.vy;
        double vx2 =  cos*b2.vx + sin*b2.vy;
        double vy2 = -sin*b2.vx + cos*b2.vy;
        
        double vx1final = (((b1.m - b2.m) * vx1) + 2 * b2.m * vx2)/(b1.m + b2.m);
        double vx2final = (((b2.m - b1.m) * vx2) + 2 * b1.m * vx1)/(b2.m + b1.m);
        double vy1final = (((b1.m - b2.m) * vy1) + 2 * b2.m * vy2)/(b1.m + b2.m);
        double vy2final = (((b2.m - b1.m) * vy2) + 2 * b1.m * vy1)/(b2.m + b1.m);

        
        b1.vx = cos*vx1final-sin*vy1final;
        b1.vy = sin*vx1final+cos*vy1final;
        b2.vx = cos*vx2final-sin*vy2final;
        b2.vy = sin*vx2final+cos*vy2final;
        
        double b1dx = Math.signum(b1.vx);
        double b1dy = Math.signum(b1.vy);
        double b2dx = Math.signum(b2.vx);
        double b2dy = Math.signum(b2.vy);
        
        if((b1dx == b2dx) && (b1dy == b2dy)){
          double b1dx_ = b1.vx - b2.vx;
          double b1dy_ = b1.vy - b2.vy;
          double b2dx_ = b2.vx - b1.vx;
          double b2dy_ = b2.vy - b1.vy;
          
          b1.circleX = b1.circleX + (ov/2)*b1dx_;
          b1.circleY = b1.circleY + (ov/2)*b1dy_;
          b2.circleX = b2.circleX + (ov/2)*b2dx_;
          b2.circleY = b2.circleY + (ov/2)*b2dy_;
        }else{
          
          b1.circleX = b1.circleX + (ov/2)*b1dx;
          b1.circleY = b1.circleY + (ov/2)*b1dy;
          b2.circleX = b2.circleX + (ov/2)*b2dx;
          b2.circleY = b2.circleY + (ov/2)*b2dy;
        }
      }
    }
  }
}
