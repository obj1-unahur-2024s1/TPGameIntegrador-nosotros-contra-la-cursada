import wollok.game.*

object sonido {
    const property musicaDeInicio = game.sound("musica.mp3")
    const sonidoInicio = game.sound("inicio.mp3")
    
    var silenciado = false
    
    var musica = true
   
    method fichaIncorrecta() {
    	if(not silenciado)
    	game.sound("fichaIncorrecta.mp3").play()
    }

    override method initialize(){
    	if(not silenciado)
        musicaDeInicio.shouldLoop(true)
        musicaDeInicio.volume(0.1)
        musicaDeInicio.play()
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
	

    method borrarFicha() {
    	if(not silenciado)
    		game.sound("fichaBorrada.mp3").play()
    	
    }

	method reiniciar(){
		if(not silenciado)
		game.sound("reiniciar.mp3").play()
	}

	method victoria(){
		if(not silenciado)
		game.sound("victoria.mp3").play()
		
	}
	
	method reproducirSiSePuede(){
		if( self.estaEnPausa())
			musicaDeInicio.resume()
	}
	method pausarSiSePuede(){
		if(! self.estaEnPausa())
			musicaDeInicio.pause()
		
	}
	
	method estaEnPausa() = musicaDeInicio.paused()
	
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