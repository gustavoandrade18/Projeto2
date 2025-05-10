int telaAtual = 0;

String[] categorias = {
  "Consumo Consciente", 
  "Turismo Cultural", 
  "Parques e Áreas Verdes", 
  "Alimentação Saudável"
};

int itemLargura = 200;
int itemAltura = 40;
int itemEspaco = 10;
int itemOffsetY = 20;

float[] hoverAlphas = new float[categorias.length];
float easing = 0.1;

void setup() {
  size(1070, 720);
  textSize(15);
}

void draw() {
  background(255); 

  boolean hovering = false;

  for (int i = 0; i < categorias.length; i++) {
    int y = itemOffsetY + i * (itemAltura + itemEspaco);

    boolean mouseSobre = mouseEstaSobre(0, itemLargura, y, y + itemAltura);
    hovering = hovering || mouseSobre;

    float alvo = mouseSobre ? 1.0 : 0.0;
    hoverAlphas[i] = lerp(hoverAlphas[i], alvo, easing);

    float cor = lerp(255, 230, hoverAlphas[i]);
    fill(cor);
    noStroke();
    rect(0, y, itemLargura, itemAltura);


    fill(0);
    text(categorias[i], 10, y + 25);
  }


  if (hovering) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}

boolean mouseEstaSobre(int xInicial, int xFinal, int yInicial, int yFinal) {
  return mouseX > xInicial && mouseX < xFinal && mouseY > yInicial && mouseY < yFinal;
}
