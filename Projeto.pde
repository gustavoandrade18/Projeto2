import java.util.Map;
import java.util.HashMap;

// Variável que representa o estado ou tela atual
int telaAtual = 0;
int offsetArtigo = 20;
Elemento[] artigoAtivo;

// Lista de categorias disponíveis
String[] categorias = {
  "Consumo Consciente", 
  "Turismo Cultural", 
  "Parques e Áreas Verdes", 
  "Alimentação Sustentavel",
  "Transporte Ecológico"
};
Elemento[] artigo1 = {
  new Elemento("TITLE", "Um titulo daora", 50),
  new Elemento("TEXT", "bastante textoasdasdadadadadadasdasdadsasdadsasdasdasds", 120),
  new Elemento("IMAGE", "landscape1.jpeg", 200)
};

Elemento[] artigo2 = {
  new Elemento("TITLE", "Um titulo daora2", 50),
  new Elemento("TEXT", "bastante textoasdasdadadadadadasdasdadsasdadsasdasdasds2", 120)
};
// Títulos dos cartões para cada categoria
String[][] titulos = {
  {"Empório Kaminski", "Feira do Largo da Ordem"},
  {"Museu Oscar Niemeyer", "Solar do Rosário"},
  {"Jardim Botânico", "Parque Barigui"},
  {"Feira do Água Verde", "Feira do Batel"}
};

// URLs ou nomes dos arquivos de imagem para cada cartão
String[][] URLImagens = {
  {"kaminski.jpg", "largo.jpg"},
  {"mon.jpg", "solar.jpg"},
  {"botanico.jpg", "barigui.jpg"},
  {"aguaverde.jpg", "batel.jpg"}
};

// Descrições dos cartões para cada categoria
String[][] descricoes = {
  {"kaminski", "largo"},
  {"mon", "solar"},
  {"botanico", "barigui"},
  {"água verde", "batel"}
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
    Cartao[] cartoesArray = new Cartao[titulos[i].length];
    int offset = 70;

    // Cria os cartões com título, descrição e imagem
    for (int j = 0; j < titulos[i].length; j++) {
      Cartao cartao = new Cartao(URLImagens[i][j], titulos[i][j], descricoes[i][j], offset, artigo1);
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
  background(#EAF6FF); // Fundo branco
  if(telaAtual == 0){
    boolean hovering = false; // Controla se o mouse está sobre alguma categoria

    // Renderiza os botões das categorias
    for (int i = 0; i < categorias.length; i++) {
      int y = itemOffsetY + i * (itemAltura + itemEspaco);
  
      boolean mouseSobre = mouseEstaSobre(0, itemLargura, y, y + itemAltura);
      hovering = hovering || mouseSobre;
  
      // Animação de hover (transição de cor)
      float alvo = mouseSobre ? 1.0 : 0.0;
      hoverAlphas[i] = lerp(hoverAlphas[i], alvo, easing);
      color cor = color(lerp(220, 195, hoverAlphas[i]), lerp(255, 220, hoverAlphas[i]), lerp(220, 195, hoverAlphas[i]));
  
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
      boolean estaSobreCartao = mouseEstaSobre(220, 220 + 800, cartaoAtivo.y, cartaoAtivo.y + 200);
      print(estaSobreCartao);
      if(flagMousePressed && estaSobreCartao) telaAtual = 1;
      artigoAtivo = cartaoAtivo.artigo;
      cartaoAtivo.display();
    }
  }else if(telaAtual == 1){
     image(loadImage("./imagens/flecha.png"), 20, 20, 20, 20);
     if(mouseEstaSobre(20, 40, 20, 40) && flagMousePressed) telaAtual = 0;
     for(Elemento elemento: artigoAtivo){
       elemento.interpretarElemento();
     }
     
     
  }
  

  // Reset da flag de clique
  flagMousePressed = false;
}

// Detecta clique do mouse
void mousePressed() {
  flagMousePressed = true;
}
