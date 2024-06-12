import wollok.game.*


object sonido {
    const property musicaDeTablero = game.sound("sonidos/musicaTablero.mp3")
    const sonidoInicio = game.sound("sonidos/inicio.mp3")
    const property musicaMenu = game.sound("sonidos/musicaMenu.mp3")
    
    var silenciado = false
    
    var musica = true
   
    method 	malMovimiento() {
    	if(not silenciado)
    	game.sound("sonidos/error.mpeg").play()
    }

    override method initialize(){
    	if(not silenciado)
        musicaDeTablero.shouldLoop(true)
        musicaDeTablero.volume(0.1)
        musicaDeTablero.play()
    }

    method iniciarPartida() {
    	if(not silenciado)
        sonidoInicio.volume(0.03)
        sonidoInicio.play()
    }
    
    method silenciar(){
    	if(not silenciado)
    		silenciado=true
    	else
    		silenciado=false
    }
	

    /*method borrarFichaIzquierda() {
    	if(not silenciado)
    		game.sound("gemaBorrada1.mp3").play()
    	
    }

    method borrarFichaDerecha() {
    	if(not silenciado)
        game.sound("gemaBorrada2.mp3").play()
    }

    method borrarFichaArriba() {
    	if(not silenciado)
        game.sound("gemaBorrada3.mp3").play()
    }

    method borrarFichaAbajo() {
    	if(not silenciado)
        game.sound("gemaBorrada4.mp3").play()
    }

	method reiniciar(){
		if(not silenciado)
		game.sound("reiniciar.mp3").play()
	}

	method victoria(){
		if(not silenciado)
		game.sound("victoria.mp3").play()
		
	}*/
	
	// agregue (franco) esto para resolver el sonido cuando ganas o perdes.
	method reproducirSiSePuede(){
		if( self.estaEnPausa())
			musicaDeTablero.resume()
	}
	method pausarSiSePuede(){
		if(! self.estaEnPausa())
			musicaDeTablero.pause()
		
	}
	
	method estaEnPausa() = musicaDeTablero.paused()
	
	method mutear(){
		if(musica){
	    	musica=false
	    	self.pausarSiSePuede()
	    }else{
	    	musica=true
	    	self.reproducirSiSePuede()
	    }
    	
	}
}