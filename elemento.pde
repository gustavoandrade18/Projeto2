class Elemento{
  public String tipo;  
  
  public String conteudo;
  
  Elemento(String tipo, String conteudo){
    this.tipo = tipo;
    this.conteudo = conteudo;
  }
  
  void interpretarElemento(){
    switch(this.tipo){
      case "TITLE": 
        textSize(27);
        text(this.conteudo, 200, this.offset); 
        break;
      case "TEXT": 
        textSize(17);
        text(this.conteudo, 200, this.offset, 800,200); 
        break;
      case "IMAGE": 
        image(loadImage("./imagens/" + this.conteudo), 200, this.offset); 
        break;
    }
  
  }

}
