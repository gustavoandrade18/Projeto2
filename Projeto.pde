import java.util.Map;
import java.util.HashMap;

// Variável que representa o estado ou tela atual
int telaAtual = 0;

// Lista de categorias disponíveis
String[] categorias = {
  "Consumo Consciente", 
  "Turismo Cultural", 
  "Parques e Áreas Verdes", 
  "Alimentação Saudável"
};

// Títulos dos cartões para cada categoria
String[][] titulos = {
  {"titulo1Cat1", "titulo2Cat1"},
  {"titulo1Cat2", "titulo2Cat2"},
  {"titulo1Cat3", "titulo2Cat3"},
  {"titulo1Cat4", "titulo2Cat4"}
};

// URLs ou nomes dos arquivos de imagem para cada cartão
String[][] URLImagens = {
  {"landscape1.jpeg", "landscape2.jpg"},
  {"landscape2.jpg", "landscape1.jpeg"},
  {"landscape1.jpeg", "landscape2.jpg"},
  {"landscape1.jpeg", "landscape2.jpg"}
};

// Descrições dos cartões para cada categoria
String[][] descricoes = {
  {"descricao1Cat1", "descricao2Cat1"},
  {"descricao1Cat2", "descricao2Cat2"},
  {"descricao1Cat3", "descricao2Cat3"},
  {"descricao1Cat4", "descricao2Cat4"}
};

// Configuração de layout dos itens de menu
int itemLargura = 200;
int itemAltura = 40;
int itemEspaco = 10;
int itemOffsetY = 20;

// Categoria atualmente selecionada
String categoriaAtiva = "Consumo Consciente";

// Flag usada para detectar clique do mouse
boolean flagMousePressed = false;

// Array para controlar opacidade do hover em cada item de categoria
float[] hoverAlphas = new float[categorias.length];
float easing = 0.2; // Suavidade da transição de hover

// Mapa que associa cada categoria a um array de cartões
Map<String, Cartao[]> cartoes = new HashMap<String, Cartao[]>(); 

void setup() {
  size(1070, 720); // Tamanho da janela
  textSize(15); // Tamanho do texto

  // Inicializa o mapa de cartões para cada categoria
  for (int i = 0; i < categorias.length; i++) {
    Cartao[] cartoesArray = new Cartao[titulos[0].length];
    int offset = 70;

    // Cria os cartões com título, descrição e imagem
    for (int j = 0; j < titulos[0].length; j++) {
      Cartao cartao = new Cartao(URLImagens[i][j], titulos[i][j], descricoes[i][j], offset);
      cartoesArray[j] = cartao;
      offset += 240; // Espaçamento vertical entre os cartões
    }

    // Associa a categoria com seu array de cartões
    cartoes.put(categorias[i], cartoesArray);
  }

  // Apenas imprime o mapa no console
  print(cartoes);
}

void draw() {
  background(255); // Fundo branco

  boolean hovering = false; // Controla se o mouse está sobre alguma categoria

  // Renderiza os botões das categorias
  for (int i = 0; i < categorias.length; i++) {
    int y = itemOffsetY + i * (itemAltura + itemEspaco);

    boolean mouseSobre = mouseEstaSobre(0, itemLargura, y, y + itemAltura);
    hovering = hovering || mouseSobre;

    // Animação de hover (transição de cor)
    float alvo = mouseSobre ? 1.0 : 0.0;
    hoverAlphas[i] = lerp(hoverAlphas[i], alvo, easing);
    float cor = lerp(255, 230, hoverAlphas[i]);

    // Desenha o botão da categoria
    fill(cor);
    noStroke();
    rect(0, y, itemLargura, itemAltura);

    // Troca a categoria ativa se clicado
    if (flagMousePressed && mouseSobre) categoriaAtiva = categorias[i];

    // Desenha o texto da categoria
    fill(0);
    text(categorias[i], 10, y + 25);
  }

  // Muda o cursor se estiver sobre alguma categoria
  if (hovering) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }

  // Exibe os cartões da categoria ativa
  for (Cartao cartaoAtivo : cartoes.get(categoriaAtiva)) {
    cartaoAtivo.display();
  }

  // Reset da flag de clique
  flagMousePressed = false;
}

// Detecta clique do mouse
void mousePressed() {
  flagMousePressed = true;
}
