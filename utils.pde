void desenharSombraRect(float x, float y, float w, float h, float radius, float offset, int alpha) {
  noStroke();
  fill(0, alpha);
  rect(x + offset, y + offset, w, h, radius);
  filter(BLUR, 0);
}

boolean mouseEstaSobre(int xInicial, int xFinal, int yInicial, int yFinal) {
  return mouseX > xInicial && mouseX < xFinal && mouseY > yInicial && mouseY < yFinal;
}

PVector calcularTextoCentralizado(float btnX, float btnY, float btnLargura, float btnAltura, int numCaracteres, float tamanhoFonte) {
  // Estimativa da largura total do texto (caracteres * tamanhoFonte * fator de ajuste)
  float larguraTexto = numCaracteres * tamanhoFonte * 0.47;
  float alturaTexto = tamanhoFonte; // Altura do texto ≈ tamanho da fonte
  
  // Calcula posição para centralizar dentro do botão
  float textoX = btnX + (btnLargura - larguraTexto) / 2;
  float textoY = btnY + (btnAltura + alturaTexto) / 2 - 3; // -3 é ajuste fino para melhor alinhamento vertical

  return new PVector(textoX, textoY);
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
