void desenharSombraRect(float x, float y, float w, float h, float radius, float offset, int alpha) {
  noStroke();
  fill(0, alpha);
  rect(x + offset, y + offset, w, h, radius);
  filter(BLUR, 0);
}

boolean mouseEstaSobre(int xInicial, int xFinal, int yInicial, int yFinal) {
  return mouseX > xInicial && mouseX < xFinal && mouseY > yInicial && mouseY < yFinal;
}


int incrementarOffset(Elemento elemento, int offset){
  switch(elemento.tipo){
    case "TITLE": 
      offset += 200;
      break;
    case "TEXT": 
      offset += elemento.conteudo.length();
      break;
    case "IMAGE": 
      offset += 300;
      break;
  }
  return offset;
}
