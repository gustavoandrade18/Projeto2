class Elemento{
  public String tipo;  
  
  public String conteudo;
  
  public int offset;
  
  Elemento(String tipo, String conteudo, int offset){
    this.tipo = tipo;
    this.conteudo = conteudo;
    this.offset = offset;
  }
  
  void interpretarElemento(){
    switch(this.tipo){
      case "TITLE": 
        textSize(27);
        text(this.conteudo, 200, this.offset); 
        break;
      case "TEXT": 
        textSize(17);
        text(this.conteudo, 200, this.offset); 
        break;
      case "IMAGE": 
        image(loadImage("./imagens/" + this.conteudo), 200, this.offset); 
        break;
    }
  
  }

}
