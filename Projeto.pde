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

Map<String, Elemento[]> artigos = new HashMap<>() {{
            put(
                "Empório Kaminski",
                new Elemento[] {
                    new Elemento("TITLE", "Empório Kaminski"),
                    new Elemento("TEXT", "Um dos estabelecimentos mais icônicos de Curitiba, o Empório Kaminski une quase um século de história familiar com uma experiência gastronômica diversificada. Fundado em 1930, é referência em panificação artesanal, café colonial e serviços para eventos, mantendo viva a tradição polonesa da família"+
                    " Fundado em 1930, é referência em panificação artesanal, café colonial e serviços para eventos, mantendo viva a tradição polonesa da família")
                }
            );
            put(
                "Feira do Largo da Ordem",
                new Elemento[] {
                    new Elemento("TITLE", "Feira do Largo da Ordem"),
                }
            );
            put(
                "Museu Oscar Niemeyer",
                new Elemento[] {
                    new Elemento("TITLE", "Museu Oscar Niemeyer"),
                }
            );
            put(
                "Solar do Rosário",
                new Elemento[] {
                    new Elemento("TITLE", "Solar do Rosário"),
                }
            );
            put(
                "Jardim Botânico",
                new Elemento[] {
                    new Elemento("TITLE", "Jardim Botânico"),
                }
            );
            put(
                "Parque Barigui",
                new Elemento[] {
                    new Elemento("TITLE", "Parque Barigui"),
                }
            );
            put(
                "Feira do Água Verde",
                new Elemento[] {
                    new Elemento("TITLE", "Feira do Água Verde"),     
                }
            );
            put(
                "Feira do Batel",
                new Elemento[] {
                    new Elemento("TITLE", "Feira do Batel"),
                }
            );
        }};



// Títulos dos cartões para cada categoria
String[][] titulos = {
  {"Empório Kaminski", "Feira do Largo da Ordem"},
  {"Museu Oscar Niemeyer", "Solar do Rosário"},
  {"Jardim Botânico", "Parque Barigui"},
  {"Feira do Água Verde", "Feira do Batel"},
  {}
};

// URLs ou nomes dos arquivos de imagem para cada cartão
String[][] URLImagens = {
  {"kaminski.jpg", "largo.jpg"},
  {"mon.jpg", "solar.jpg"},
  {"botanico.jpg", "barigui.jpg"},
  {"aguaverde.jpg", "batel.jpg"},
  {}
};

// Descrições dos cartões para cada categoria
String[][] descricoes = {
  {"O Empório Kaminski é um charmoso espaço gastronômico que valoriza os produtos frecos locais. Fica localizado na rua Sete de Setembro no Centro de Curitiba, seus horários são de segunda à sexta das 8h às 20h, e nos sábados as 9h às 18h.", "A Feira do Largo da Ordem é um restaurante histórico que celebra a gastronomia local. Fica localizada no largo da Ordem de Curitiba, seus horários de funcionamento são de Terça à Domingo, das 11h às 22h."},
  {"O Museu Oscar Niemeyer, conhecido como MON, é um dos principais espaços culturais de Curitiba, famoso por sua arquitetura moderna e suas exposições de arte contemporânea. Sua localização é na Avenida Presidente Getúlio Vargas em Água Verde de Curitiba, e seus horários de funcionamento são de Terça à Domingo das 10h às 18h.", "O Solar do Rosário é um charmoso espaço cultural localizado em Curitiba, conhecido por sua bela arquitetura colonial e um ambiente acolhedor. Fica localizada na Rua do rosário em São Francisco e Curitiba, seus horários de funcionamento são de Terça à Domingo das 10h às 18h."},
  {"O Jardim Botânico de Curitiba é um dos mais icônicos cartões-postais da cidade. Com sua estufa de vidro em estilo art nouveau e belos jardins, o local é um espaço perfeito para apreciar a natureza, realizar caminhadas e relaxar. Fica localizada na rua Engenho Ostoja Roguski no Jardim Botânico em Curitiba, seus horários de funcionamento são todos os dias da semana das 6h às 20h(com exceção ao estufa, que abre às 9h e fecha as 17h.", "O Parque Barigui é um dos maiores e mais populares parques de Curitiba, oferecendo uma extensa área verde ideal para caminhadas, corridas e atividades ao ar livre. Fica localizada na Avenida Barigui no Bairro Barigui em Curitiba, seus horários de funcionamento são todos os dias das 6h às 20h."},
  {"A Feira do Água Verde é um dos mercados tradicionais de Curitiba, oferecendo uma variedade de produtos frescos, como frutas, verduras, legumes, queijos e artesanato. Fica localizada na Praça do Japão em Água Verde de Curitiba, seus horários de funcinamento são nos Sábados das 8h às 13h.", "A Feira do Batel é um mercado popular e bem frequentado, conhecido por sua variedade de produtos frescos, incluindo frutas, verduras, legumes, queijos e itens de artesanato. Fica localizada na Praça Nossa Senhora de Salete em Batel de Curitiba, seus horários de funcionamento são nos Sábados das 8h às 13h."},
  {}
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
      Cartao cartao = new Cartao(URLImagens[i][j], titulos[i][j], descricoes[i][j], offset, artigos.get(titulos[i][j]));
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
