import java.util.Map;
import java.util.HashMap;

int telaAtual = 0;

String[] categorias = {
  "Consumo Consciente", 
  "Turismo Cultural", 
  "Parques e Áreas Verdes", 
  "Alimentação Saudável"
};

String[][] titulos = {{"titulo1Cat1", "titulo2Cat1"},
                      {"titulo1Cat2", "titulo2Cat2"},
                      {"titulo1Cat3", "titulo2Cat3"},
                      {"titulo1Cat4", "titulo2Cat4"}};
String[][] URLImagens = {{"landscape1.jpeg", "landscape2.jpg"},
                        {"landscape2.jpg", "landscape1.jpeg"},
                        {"landscape1.jpeg", "landscape2.jpg"},
                        {"landscape1.jpeg", "landscape2.jpg"}};
String[][] descricoes = {{"descricao1Cat1", "descricao2Cat1"},
                        {"descricao1Cat2", "descricao2Cat2"},
                        {"descricao1Cat3", "descricao2Cat3"},
                        {"descricao1Cat4", "descricao2Cat4"}};

int itemLargura = 200;
int itemAltura = 40;
int itemEspaco = 10;
int itemOffsetY = 20;
String categoriaAtiva = "Consumo Consciente";

boolean flagMousePressed = false;
float[] hoverAlphas = new float[categorias.length];
float easing = 0.2;

Map<String, Cartao[]> cartoes = new HashMap<String, Cartao[]>(); 

void setup() {
  size(1070, 720);
  textSize(15);
  for(int i = 0;i < categorias.length;i++){
    Cartao[] cartoesArray = new Cartao[titulos[0].length];
    int offset = 70;
    for(int j = 0;j < titulos[0].length;j++){
      Cartao cartao = new Cartao(URLImagens[i][j], titulos[i][j], descricoes[i][j], offset);
      cartoesArray[j] = cartao;
      offset += 240;
    }
    cartoes.put(categorias[i], cartoesArray);
  }
  print(cartoes);
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
    if(flagMousePressed && mouseSobre) categoriaAtiva = categorias[i];

    fill(0);
    text(categorias[i], 10, y + 25);
  }


  if (hovering) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  
  for(Cartao cartaoAtivos:cartoes.get(categoriaAtiva)){
    cartaoAtivos.display();
  }
  flagMousePressed = false;
}

void mousePressed(){
  flagMousePressed = true;
}
