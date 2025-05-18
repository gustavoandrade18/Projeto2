class Botao {
  public String texto;
  public int x;
  public int y;
  public int tela;
  
  Botao(String texto, int x, int y, int tela){
    this.texto = texto;
    this.x = x;
    this.y = y;
    this.tela = tela;
  }
  
  void display(boolean flagMousePressed){
    if(mouseEstaSobre(this.x, this.x + 150, this.y, this.y + 30)){
       fill(102, 205, 170, 80);
    }else{
      fill(102, 205, 170);
    }
    rect(this.x, this.y, 150, 30);
    fill(0);
    textSize(21);
    PVector pos = calcularTextoCentralizado(this.x, this.y, 150, 30, this.texto.length(), 21);
    text(this.texto, pos.x, pos.y);
    
    
    
    if(flagMousePressed && mouseEstaSobre(this.x, this.x + 150, this.y, this.y + 30)){
      telaAtual = tela;
    }
  }
}
