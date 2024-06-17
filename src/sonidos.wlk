import wollok.game.*

object sonido {
    const property musicaDeTablero = game.sound("sonidos/musicaTablero.mp3")
    const sonidoInicio = game.sound("sonidos/inicio.mp3")
    const property musicaMenu = game.sound("sonidos/musicaMenu.mp3")
    
    var silenciado = false
    
    var musica = true
   
    method malMovimiento() {
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

    method borrarFicha() {
    	if(not silenciado)
    		game.sound("match.mpeg").play()
    	
    }

	method reiniciar(){
		if(not silenciado)
		game.sound("reinicio.mp3").play()
	}

	method nivelSuperado(){
		if(not silenciado)
			game.sound("nivelSuperado.mp3").play()
	}


	method finDelJuego(){
		if(not silenciado){
			game.sound("finDelJuego.mp3").play()
		}
	}
	
	
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