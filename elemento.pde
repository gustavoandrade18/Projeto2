class Elemento{
  public String tipo;  
  
  public String conteudo;
  
  public int offset;
  
  public Movie video;
  
  public Elemento(String tipo, String conteudo, int offset){
    this.tipo = tipo;
    this.conteudo = conteudo;
    this.offset = offset;
    if (tipo.equals("VIDEO")) {
      video = new Movie(Projeto.this, conteudo);
      video.loop(); // Começa o loop ao inicializar
    }
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
      case "VIDEO":
        if (video.available()) {
          video.read();
        }
        image(video, 200, this.offset);
        break;
    }
  
  }

}
