import wollok.game.*

object sonido {
	
	var sonido 
	
	//nombres de archivos de audio
    const musicaDeTablero = "musicaTablero.mp3"
    const sonidoInicio = "inicio.mp3"
    const musicaMenu = "musicaMenu.mp3"
    const error = "error.mp3"
    const match = "match.mp3"
    const reinicio = "reinicio.mp3"
    const finDelJuego = "finDelJuego.mp3"
    const ganaste = "ganaste.mp3" 
    const nivelSuperado = "nivelSuperado.mp3"
    
    var musicaDeFondo 
    
    var silenciado = false
    
    var musica = true
     
    method sonido() = sonido 
     
    method sonido(tipo){
   	 sonido = self.guardarSonido(tipo)
    }
    
    method guardarSonido(tipo){
    	return game.sound("sonidos/"+tipo)
    }
   
    method malMovimiento() {
    	if(not silenciado){
    		self.sonido(error)
    		sonido.play()
    	}
    }

    method musicaDeFondo(){
    	if(not silenciado)
    		musicaDeFondo = self.guardarSonido(musicaDeTablero)
        	musicaDeFondo.shouldLoop(true)
        	musicaDeFondo.volume(0.1)
        	musicaDeFondo.play()
        	self.sonido(sonidoInicio)
    }
    
    method musica() = musicaDeFondo
    
    
    method musicaMenu(){
    	self.sonido(musicaMenu)
    	sonido.shouldLoop(true)
       	game.schedule(200,{sonido.play() sonido.volume(0.2)})
        	
    }
    
    method silenciar(){
    	if(not silenciado)
    		silenciado=true
    	else
    		silenciado=false
    }

    method borrarFicha() {
    	if(not silenciado)
    		self.sonido(match)
    		sonido.play()
    }

	method reiniciar(){
		if(not silenciado)
			
			self.sonido(reinicio)
			sonido.play()
	}

	method nivelSuperado(){
		if(not silenciado)
			self.sonido(nivelSuperado)
			sonido.volume(0.5)
			sonido.play()
	}

	method finDelJuego(){
		if(not silenciado){
			self.sonido(finDelJuego)
			sonido.volume(0.5)
			sonido.play()
		}
	}
	
	method ganaste(){
		if(not silenciado){
			self.sonido(ganaste)
			sonido.volume(0.5)
			sonido.play()
		}
	}
	
	method mutear(){
		if(musica){
	    	musica=false
	    	musicaDeFondo.volume(0.0)
	    }else{
	    	musica=true
	   		musicaDeFondo.volume(0.5)
	    }
	}
}