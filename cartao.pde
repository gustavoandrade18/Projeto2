// Classe que representa um cartão com imagem, título e descrição
class Cartao {
  // Caminho da imagem associada ao cartão
  public String URLImagem;

  // Título do cartão
  public String titulo;

  // Descrição do cartão
  public String descricao;

  // Posição vertical do cartão na tela
  public int y;

  // Construtor da classe Cartao
  Cartao(String URLImagem, String titulo, String descricao, int y) {
    this.titulo = titulo;          // Inicializa o título
    this.descricao = descricao;    // Inicializa a descrição
    this.y = y;                    // Define a posição vertical
    this.URLImagem = "./imagens/" + URLImagem;    // Define o caminho da imagem
  }

  // Método responsável por desenhar o cartão na tela
  void display() {
    stroke(0, 0, 0); // Borda preta

    // Desenha uma sombra atrás do cartão (função externa)
    desenharSombraRect(220, this.y, 800, 200, 20, 7, 5);

    // Desenha o retângulo principal do cartão
    fill(#D6EEFF); 
    rect(220, this.y, 800, 200, 20); // Cartão com bordas arredondadas

    // Desenha a imagem à esquerda do cartão
    fill(0);
    image(loadImage(this.URLImagem), 240, this.y + 15, 150, 150);

    // Desenha o título do cartão
    textSize(28);
    text(this.titulo, 440, this.y + 35, 800 - 35 - 200, 200); // Ajusta largura do texto

    // Desenha a descrição do cartão
    textSize(15);
    text(this.descricao, 440, this.y + 65, 800 - 35 - 200, 200); // Texto com quebra automática
  }
}
