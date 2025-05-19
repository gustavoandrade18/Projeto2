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
        text(this.conteudo, 150, this.offset); 
        break;
      case "SUBTITLE":
        textSize(22);
        text(this.conteudo, 150, this.offset); 
        break;
      case "TEXT": 
        textSize(17);
        text(this.conteudo, 150, this.offset, 800,200); 
        break;
      case "IMAGE": 
        tint(255, 100);
        

        background(#F5FFF6);
        image(loadImage("./imagens/"+ this.conteudo), 0, 0, width*1.1, height*1.1);
        
        
        tint(255, 255);
        break;
      case "VIDEO":
        if (video.available()) {
          video.read();
        }
        if( e == 0)image(video, 0, this.offset, 1070, 600);
        
        
        break;
    }
  
  }

}
