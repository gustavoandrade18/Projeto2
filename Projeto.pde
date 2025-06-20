import java.util.Map;
import java.util.HashMap;
import processing.video.*;

// Variável que representa o estado ou tela atual
int telaAtual = 0;
int offsetArtigo = 20;
Elemento[] artigoAtivo;
float scrollY = 0;  // deslocamento vertical
float scrollSpeed = 20;

// Lista de categorias disponíveis
String[] categorias = {
  "Consumo Consciente", 
  "Turismo Cultural", 
  "Parques e Áreas Verdes", 
  "Alimentação Sustentavel"
};

Map<String, Elemento[]> artigos;

// Títulos dos cartões para cada categoria
String[][] titulos = {
  {"Empório Kaminski", "Feira do Largo da Ordem"},
  {"Museu Oscar Niemeyer", "Solar do Rosário"},
  {"Jardim Botânico", "Parque Barigui"},
  {"Feira do Água Verde", "Feira do Batel"},
  
};

// URLs ou nomes dos arquivos de imagem para cada cartão
String[][] URLImagens = {
  {"kaminski.jpg", "largo.jpg"},
  {"mon.jpg", "solar.jpg"},
  {"botanico.jpg", "barigui.jpg"},
  {"aguaverde.jpg", "batel.jpg"},
  
};

// Descrições dos cartões para cada categoria
String[][] descricoes = {
  {"O Empório Kaminski é um charmoso espaço gastronômico que valoriza os produtos frecos locais. Fica localizado na rua Sete de Setembro no Centro de Curitiba, seus horários são de segunda à sexta das 8h às 20h, e nos sábados as 9h às 18h.", "A Feira do Largo da Ordem é um restaurante histórico que celebra a gastronomia local. Fica localizada no largo da Ordem de Curitiba, seus horários de funcionamento são de Terça à Domingo, das 11h às 22h."},
  {"O Museu Oscar Niemeyer, conhecido como MON, é um dos principais espaços culturais de Curitiba, famoso por sua arquitetura moderna e suas exposições de arte contemporânea. Sua localização é na Avenida Presidente Getúlio Vargas em Água Verde de Curitiba, e seus horários de funcionamento são de Terça à Domingo das 10h às 18h.", "O Solar do Rosário é um charmoso espaço cultural localizado em Curitiba, conhecido por sua bela arquitetura colonial e um ambiente acolhedor. Fica localizada na Rua do rosário em São Francisco e Curitiba, seus horários de funcionamento são de Terça à Domingo das 10h às 18h."},
  {"O Jardim Botânico de Curitiba é um dos mais icônicos cartões-postais da cidade. Com sua estufa de vidro em estilo art nouveau e belos jardins, o local é um espaço perfeito para apreciar a natureza, realizar caminhadas e relaxar. Fica localizada na rua Engenho Ostoja Roguski no Jardim Botânico em Curitiba, seus horários de funcionamento são todos os dias da semana das 6h às 20h(com exceção ao estufa, que abre às 9h e fecha as 17h.", "O Parque Barigui é um dos maiores e mais populares parques de Curitiba, oferecendo uma extensa área verde ideal para caminhadas, corridas e atividades ao ar livre. Fica localizada na Avenida Barigui no Bairro Barigui em Curitiba, seus horários de funcionamento são todos os dias das 6h às 20h."},
  {"A Feira do Água Verde é um dos mercados tradicionais de Curitiba, oferecendo uma variedade de produtos frescos, como frutas, verduras, legumes, queijos e artesanato. Fica localizada na Praça do Japão em Água Verde de Curitiba, seus horários de funcinamento são nos Sábados das 8h às 13h.", "A Feira do Batel é um mercado popular e bem frequentado, conhecido por sua variedade de produtos frescos, incluindo frutas, verduras, legumes, queijos e itens de artesanato. Fica localizada na Praça Nossa Senhora de Salete em Batel de Curitiba, seus horários de funcionamento são nos Sábados das 8h às 13h."},
  
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
float easing = 0.4; // Suavidade da transição de hover

// Mapa que associa cada categoria a um array de cartões
Map<String, Cartao[]> cartoes = new HashMap<String, Cartao[]>(); 

void setup() {
  size(1070, 720); // Tamanho da janela
  textSize(15); // Tamanho do texto


  artigos = new HashMap<>() {{
            put(
                "Empório Kaminski",
                new Elemento[] {
                    new Elemento("IMAGE","Emporio.jpg",0),
                    new Elemento("TITLE", "Empório Kaminski", 100),
                    new Elemento("TEXT", "Um dos estabelecimentos mais icônicos de Curitiba, o Empório Kaminski une quase um século de história familiar com uma experiência gastronômica diversificada. Fundado em 1930, é referência em panificação artesanal, café colonial e serviços para eventos, mantendo viva a tradição polonesa da família"+
                    " Fundado em 1930, é referência em panificação artesanal, café colonial e serviços para eventos, mantendo viva a tradição polonesa da família", 115),
                    new Elemento("SUBTITLE", "O Que Você Precisa Saber:", 250),
                    new Elemento("TEXT", "Origem Humilde: Tudo começou com Alexandre Kaminski, um imigrante polonês que, em 1930, fundou a Padaria Universal. Na época, as entregas eram feitas com carroças puxadas por cavalos, que percorriam Curitiba com pães, leite e biscoitos",270),
                    new Elemento("TEXT", "Evolução: De carroças a Kombis, e depois a um empório moderno, a família adaptou-se às mudanças sem perder a essência. O nome \"Kaminski\" só foi adotado em 1994, após décadas como Padaria Universal e Kamille", 350),
                    new Elemento("SUBTITLE", "O Que Experimentar?", 440),
                    new Elemento ("TEXT", "Rocambole de Doce de Leite: Receita original da década de 1960, criada por Maresca (esposa de Nelson), ainda irresistível\n" +
                    "Cardápio Variado: Mais de 600 itens, incluindo croissants, tortas finas, tapiocas, pizzas e um buffet de café colonial com doces e salgados\n"+ 
                    "Cestas Especiais: Opções para presentear, como a \"Cesta Kaminski\" (R$ 129,80), com pães, frios e geleias",460),
                    new Elemento("SUBTITLE", "Unidades", 600),
                    new Elemento ("TEXT", "Empório Kaminski (Av. Sete de Setembro, 6355): Funciona como mercearia, restaurante e espaço para eventos. Abre diariamente das 6h30 às 22h\n"+
                    "Kaminski Padaria (Av. Iguaçu, 2735): Focada em produção de pães. Horário: 6h30 às 20h (segunda a sábado)",620),
 
              }
            );
            put(
                "Feira do Largo da Ordem",
                new Elemento[] {
                new Elemento("IMAGE","FeiraOrdem.jpg",0),
                new Elemento("TITLE", "Feira do Largo da Ordem", 100),
                new Elemento("TEXT", "A Feira do Largo da Ordem é a feira de artesanato mais tradicional de Curitiba, realizada todo domingo no histórico Largo da Ordem. Com mais de 40 anos de existência, reúne artesãos, músicos e comerciantes em um ambiente cultural vibrante.", 115),
                new Elemento("SUBTITLE", "O Que Você Precisa Saber:", 250),
                new Elemento("TEXT", "História: Criada na década de 1970 como pequena feira de antiguidades, transformou-se em importante ponto turístico e cultural da cidade, preservando o charme do centro histórico.", 270),
                new Elemento("TEXT", "Localização: Ocorre no Largo da Ordem, coração do Setor Histórico, rodeado por construções coloniais como a Igreja da Ordem Terceira de São Francisco das Chagas (1737).", 350),
                new Elemento("SUBTITLE", "O Que Encontrar?", 440),
                new Elemento("TEXT", "Artesanato: Peças em madeira, cerâmica, couro e técnicas tradicionais\n" +
                "Comidas Típicas: Barreado, pão com linguiça, pierogi e doces caseiros\n" +
                "Cultura: Apresentações musicais e intervenções artísticas durante todo o dia", 460),
                new Elemento("SUBTITLE", "Informações Práticas", 600),
                new Elemento("TEXT", "Horário: Domingos das 9h às 14h\n" +
                "Local: Largo Coronel Enéas / Rua Kellers, Setor Histórico\n" +
                "Dica: Chegue cedo para aproveitar melhor e evitar aglomerações", 620),
                new Elemento("VIDEO", "largo2.mov", 700)
                }
            );
            put(
              "Museu Oscar Niemeyer",
              new Elemento[] {
              new Elemento("IMAGE","MuseuOlho.jpg",0),
              new Elemento("TITLE", "Museu Oscar Niemeyer", 100),
              new Elemento("TEXT", "Conhecido como 'Museu do Olho' por sua arquitetura icônica, o MON é o maior museu de arte da América Latina. Projetado por Oscar Niemeyer, reúne exposições nacionais e internacionais em um espaço de 35 mil m².", 115),
              new Elemento("SUBTITLE", "Destaques do Museu", 250),
              new Elemento("TEXT", "Arquitetura: O anexo em forma de olho suspenso é símbolo de Curitiba, com 30m de altura e estrutura futurista que dialoga com o prédio principal.", 270),
              new Elemento("TEXT", "Acervo: Mais de 7 mil obras, incluindo arte contemporânea, asiática e africana, além de exposições temporárias de artistas renomados.", 350),
              new Elemento("SUBTITLE", "Experiência do Visitante", 440),
              new Elemento("TEXT", "Coleções Permanentes: Arte paranaense (Poty Lazzarotto), obras de Tarsila do Amaral e Andy Warhol\n" +
              "Jardim das Esculturas: Área externa com obras integradas à natureza\n" +
              "Programação Cultural: Oficinas, palestras e visitas mediadas para todas as idades", 460),
              new Elemento("SUBTITLE", "Informações Úteis", 600),
              new Elemento("TEXT", "Horário: Terça a domingo, 10h às 18h\n" +
              "Ingressos: R$30 (inteira) / R$15 (meia) - Grátis às quartas\n" +
              "Localização: Rua Marechal Hermes, 999 - Centro Cívico", 620),
                new Elemento("VIDEO", "Museu do olho.mp4", 700)
                }
            );
            put(
              "Solar do Rosário", 
              new Elemento[] {
              new Elemento("IMAGE","SolarRosario.jpg",0),
              new Elemento("TITLE", "Solar do Rosário", 100),
              new Elemento("TEXT", "O Solar do Rosário é um dos espaços culturais mais charmosos de Curitiba, instalado em um casarão histórico do século XIX. Combinando arquitetura colonial, jardins encantadores e programação cultural diversificada, é um refúgio de arte e história no coração da cidade.", 115),
              new Elemento("SUBTITLE", "História e Arquitetura", 250),
              new Elemento("TEXT", "O casarão foi construído em 1890 e restaurado nos anos 1990, mantendo características originais como pisos de madeira, vitrais e a capela particular. O nome homenageia Nossa Senhora do Rosário, cuja imagem adorna o local.", 270),
              new Elemento("TEXT", "Os jardins foram projetados por Burle Marx, com espécies nativas e um caramanchão que se tornou cenário para eventos.", 350),
              new Elemento("SUBTITLE", "O Que Oferece", 440),
              new Elemento("TEXT", "Galeria de Arte: Exposições temporárias de artistas brasileiros e internacionais\n" +
              "Café Cultural: Cardápio com quitutes e chás servidos em louças vintage\n" +
              "Loja de Artesanato: Peças exclusivas de artistas locais e livros de arte\n" +
              "Cursos: Oficinas de pintura, fotografia e história da arte", 460),
              new Elemento("SUBTITLE", "Visitação", 600),
              new Elemento("TEXT", "Horário: Terça a sábado das 10h às 19h | Domingo 10h-14h\n" +
              "Endereço: Rua Duque de Caxias, 4 - Centro Histórico\n" +
              "Entrada: Gratuita (exposições temporárias podem ter ingresso separado)", 620)
    }
);
            put(
              "Jardim Botânico",
              new Elemento[] {
              new Elemento("IMAGE","JardimBotanico.jpg",0),
              new Elemento("TITLE", "Jardim Botânico de Curitiba", 100),
              new Elemento("TEXT", "Principal cartão-postal da cidade, o Jardim Botânico Francisca Maria Garfunkel Richbieter foi inaugurado em 1991 e se destaca pela estufa de vidro em estilo art nouveau. Com 278 mil m², é um santuário de biodiversidade que recebe 1,8 milhão de visitantes anualmente.", 115),
              new Elemento("SUBTITLE", "Atrativos Imperdíveis", 250),
              new Elemento("TEXT", "Estufa de 458m²: Abriga espécies da Mata Atlântica em 3 cúpulas com temperatura controlada (18°C)", 270),
              new Elemento("TEXT", "Jardim Sensorial: Percurso com 200 plantas aromáticas e táteis para experiência inclusiva", 350),
              new Elemento("SUBTITLE", "Estrutura Completa", 440),
              new Elemento("TEXT", "Museu Botânico: Herbário com 400 mil amostras e biblioteca especializada\n" +
              "Trilhas Ecológicas: 1,5km de caminhos pela mata nativa com placas educativas\n" +
              "Jardim das Esculturas: 28 obras de arte ao ar livre\n" +
              "Espaço Cultural: Exposições temporárias no antigo portal da estrada de ferro", 460),
              new Elemento("SUBTITLE", "Dicas de Visita", 600),
              new Elemento("TEXT", "Horário: Diariamente das 6h às 19h30 (inverno) e 20h (verão)\n" +
              "Melhor período: Manhãs de terça a sexta para evitar multidões\n" +
              "Acessibilidade: Rota especial para cadeirantes e carrinhos\n" +
              "Estacionamento: R$ 5,00 por 3 horas (vagas limitadas)", 620),
              new Elemento("VIDEO", "Jardim Botanico.mp4", 700)
          }
            );
            put(
                "Parque Barigui",
                new Elemento[] {
                new Elemento("IMAGE","ParqueBarigui.jpg",0),
                new Elemento("TITLE", "Parque Barigui", 100),
                new Elemento("TEXT", "Com 1.4 milhão de m², o Parque Barigui é o maior e mais frequentado parque urbano de Curitiba. Inaugurado em 1972 pelo prefeito Jaime Lerner, destaca-se pela represa de 140.000m² e pela população fixa de capivaras que se tornaram símbolo do local.", 115),
                new Elemento("SUBTITLE", "Ecossistema e Preservação", 250),
                new Elemento("TEXT", "Reserva Ambiental: 400 espécies de fauna, incluindo 30 capivaras residentes e aves migratórias", 270),
                new Elemento("TEXT", "Projeto Águas: Sistema de filtragem natural que mantém a qualidade da represa desde 2015", 350),
                new Elemento("SUBTITLE", "Estrutura Completa", 440),
                new Elemento("TEXT", "17km de ciclovias: Circuito completo ao redor do parque com bicicletários\n" +
                "Centro de Exposições: 5.000m² para eventos, com arquitetura de Abrão Assad\n" +
                "Museu do Automóvel: 70 veículos antigos em exposição permanente\n" +
                "Quiosques Sustentáveis: Alimentação com reciclagem obrigatória de resíduos", 460),
                new Elemento("SUBTITLE", "Dicas de Visita", 600),
                new Elemento("TEXT", "Horário: Aberto 24h com segurança monitorada\n" +
                "Melhor Acesso: Entrada principal pela Av. Cândido Hartmann\n" +
                "Estacionamento: 500 vagas (R$ 6 por 4 horas)\n" +
                "Aluguel de bikes: R$ 15/hora nos finais de semana", 620),
                new Elemento("VIDEO", "Barigui.mp4", 700)
            }
            );
            put(
                "Feira do Água Verde",
                new Elemento[] {
                new Elemento("IMAGE","FeiraAguaVerde.jpg",0),
                new Elemento("TITLE", "Feira do Água Verde", 100),
                new Elemento("TEXT", "Conhecida carinhosamente como 'Feira Hippie', a Feira do Água Verde é um marco cultural desde 1979. Aos domingos, transforma a Praça João Paulo II num ecossistema de economia criativa, com forte compromisso ambiental e apoio aos artesãos locais.", 115),
                new Elemento("SUBTITLE", "Sustentabilidade na Prática", 250),
                new Elemento("TEXT", "Reciclagem: 100% dos resíduos são triados - cooperativas coletam 2 toneladas de materiais recicláveis mensalmente", 270),
                new Elemento("TEXT", "Energia limpa: 30% dos expositores usam painéis solares em suas bancas desde 2021", 350),
                new Elemento("SUBTITLE", "Experiência Completa", 440),
                new Elemento("TEXT", "Artesanato sustentável: Bonecos de fibra natural, bijuterias com sementes e ecojoias\n" +
                "Comida consciente: Lanches orgânicos, cucas coloniais e o famoso pão com mortadela gigante\n" +
                "Viveiro de mudas: Espaço permanente para doação de árvores nativas\n" +
                "Atrações: Música ao vivo das 10h às 13h no palco de madeira reciclada", 460),
                new Elemento("SUBTITLE", "Planejando Sua Visita", 600),
                new Elemento("TEXT", "Horário: Domingos das 7h às 15h (pico às 11h)\n" +
                "Local: Praça João Paulo II (estacionamento no Shopping Água Verde)\n" +
                "Dicas: Leve moeda trocada e sua caneca reutilizável para drinks", 620),
                new Elemento("VIDEO", "Feira Agua verde.mp4", 700)
    }
            );
            put(
               "Feira do Batel", 
                new Elemento[] {
                new Elemento("IMAGE","FeiraBatel.jpg",0),
                new Elemento("TITLE", "Feira do Batel", 100),
                new Elemento("TEXT", "A Feira do Batel é o epicentro gastronômico sofisticado de Curitiba, realizada todo sábado na charmosa Praça da Ucrânia. Desde 2012, combina produtos gourmet com práticas sustentáveis, sendo pioneira na valorização de produtores locais e embalagens ecológicas.", 115),
                new Elemento("SUBTITLE", "Gastronomia Sustentável", 250),
                new Elemento("TEXT", "Produtos orgânicos: 70% dos hortifrútis vêm de pequenos produtores da região metropolitana, com certificação agroecológica", 270),
                new Elemento("TEXT", "Embalagens: Redução de plásticos - os food trucks utilizam recipientes biodegradáveis desde 2018", 350),
                new Elemento("SUBTITLE", "Experiência Gourmet", 440),
                new Elemento("TEXT", "Delicatessen: Queijos artesanais do Paraná e Minas, vinhos de pequenas vinícolas nacionais\n" +
                "Chefs Convidados: Aos sábados, demonstrações com ingredientes locais (programação no Instagram @feiradobatel)\n" +
                "Café Especial: Bistrô com grãos de torra local e copos retornáveis", 460),
                new Elemento("SUBTITLE", "Informações Úteis", 600),
                new Elemento("TEXT", "Horário: Sábados das 8h30 às 14h (melhor horário: 10h-12h)\n" +
                "Local: Praça da Ucrânia - Batel (estacionamento no Shopping Batel)\n" +
                "Dica: Leve sua ecobag e caneca reutilizável", 620),
                new Elemento("VIDEO", "Feira Batel.mp4", 700)
    }
            );
        }};


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
}

Botao[] botoes = {new Botao("Instruçoes", 450, 500, 1), new Botao("Opçoes", 450, 550, 2)};

boolean imagemCarregada = false;
void draw() {
  if(telaAtual == 0){
    if(!imagemCarregada){
       image(loadImage("./imagens/CuritibaTelaInicial.png"), 0, 0, width, height);
       imagemCarregada = true;
    }
    
    textSize(55);
    fill(#131C15);
    text("EcoTrip Curitiba", 350, 200);
    for(Botao botao:botoes){
      botao.display(flagMousePressed);
    }
  }else if(telaAtual == 1){
    background(255);
    imagemCarregada = false;
    image(loadImage("./imagens/flecha.png"), 20, 20, 20, 20);
    if(mouseEstaSobre(20, 40, 20, 40) && flagMousePressed) telaAtual = 0;
    
    fill(34, 139, 34); // verde escuro
    textSize(40);
    text("Bem-vindo ao EcoTrip Curitiba", 270, 100);
    
    // Subtítulo
    textSize(24);
    fill(60);
    text("Instruções de uso do aplicativo", 270, 160);
    
    // Caixa de instruções
    fill(255);
    stroke(200);
    strokeWeight(2);
    rectMode(CENTER);
    rect(width/2, height/2 + 30, 800, 400, 20);
    
    // Texto das instruções
    fill(50);
    textSize(18);
    text("- Escolha a categoria de turismo desejada;",550, 500, 760, 400);
    text("- Clique no local para ter mais informaçoes sobre ele;",550, 520, 760, 400);
    text("- Volte para a tela principal para ver informaçoes de mais locais.",550, 540, 760, 400);
    rectMode(CORNER);
  }else if(telaAtual == 2){
    boolean hovering = false; // Controla se o mouse está sobre alguma categoria
    if(!imagemCarregada){
      if (categoriaAtiva == "Consumo Consciente")
      {
        image(loadImage("./imagens/MercadoMunicipal.jpg"), 0, 0, width, height);
      }
     else if(categoriaAtiva == "Turismo Cultural")
     {
       image(loadImage("./imagens/MuseuEgipicio.jpg"), 0, 0, width, height);
     }
     else if(categoriaAtiva == "Parques e Áreas Verdes")
     {
       image(loadImage("./imagens/Parques.jpg"), 0, 0, width, height);
     }
     else if(categoriaAtiva == "Alimentação Sustentavel")
     {
       image(loadImage("./imagens/Feira.jpg"), 0, 0, width, height);
     }
     else if(categoriaAtiva == "Transporte Ecológico")
     {
       image(loadImage("./imagens/Transporte.jpg"), 0, 0, width, height);
     }
     imagemCarregada = true;
    }
    
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
      if(flagMousePressed && estaSobreCartao){
        telaAtual = 3;
        imagemCarregada = false;
        artigoAtivo = cartaoAtivo.artigo;
        return;
      }
      
      cartaoAtivo.display();
    }
  }else if(telaAtual == 3){
     if(mouseEstaSobre(20, 40, 20, 40) && flagMousePressed) {telaAtual = 2;imagemCarregada = false;};
      // Aplica a translação de rolagem
      pushMatrix();
      translate(0, scrollY);
     for(Elemento elemento: artigoAtivo){
       elemento.interpretarElemento();
     }
      popMatrix();
      image(loadImage("./imagens/flecha.png"), 20, 20, 20, 20);
 
  }
  
  // Reset da flag de clique
  flagMousePressed = false;
}

float e;
void mouseWheel(MouseEvent event) {
  e = event.getCount();
  print(e);
  scrollY += -e * scrollSpeed;
  
  // Limites opcionais
  scrollY = constrain(scrollY, -3000, 0);  // ajusta conforme o conteúdo
}

void movieEvent(Movie m) {
  m.read();
}

// Detecta clique do mouse
void mousePressed() {
  flagMousePressed = true;
}
