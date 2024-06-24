import wollok.game.*

object sonido {
	
	var sonido 
	var musicaDeFondo
	
	
	//nombres de archivos de audio
    const musicaDeTablero = "sonidos/musicaTablero.mp3"
    const musicaMenu = "sonidos/musicaMenu.mp3"
    const error = "error.mp3"
    const match = "match.mp3"
    const reinicio = "reinicio.mp3"
    const finDelJuego = "finDelJuego.mp3"
    const ganaste = "ganaste.mp3" 
    const nivelSuperado = "nivelSuperado.mp3"
    
    var silenciado = false
    
    var musica = true
     
    method sonido() = sonido 
    method musicaDeFondo() = musicaDeFondo
    
    method sonido(tipo){
   	 sonido = self.guardarSonido(tipo)
    }
    
    method guardarSonido(tipo){
    	return game.sound("sonidos/"+tipo)
    }
    
    method mutear(){
		if(musica){
	    	musica=false
	    	musicaDeFondo.volume(0.0)
	    }else{
	    	musica=true
	    	musicaDeFondo.volume(0.2)
	    }
	}
   
    method silenciar(){
    	if(not silenciado)
    		silenciado=true
    	else
    		silenciado=false
    }
	
    method musicaNivel(){
        musicaDeFondo = game.sound(musicaDeTablero)
        musicaDeFondo.play()
        musicaDeFondo.shouldLoop(true)
        musicaDeFondo.volume(if(musica){0.2}else{0.0})
    }
    
    
    method musicaMenu(){
    	musicaDeFondo = game.sound(musicaMenu)
    	musicaDeFondo.shouldLoop(true)
       	game.schedule(200,{musicaDeFondo.play() musicaDeFondo.volume(if(musica){0.2}else{0.0})})
        	
    }
    
    method malMovimiento() {
    	if(not silenciado){
    		self.sonido(error)
    		sonido.volume(0.5)
    		sonido.play()
    	}
    }

    method borrarFicha() {
    	if(not silenciado){
    		self.sonido(match)
    		sonido.volume(0.5)
    		sonido.play()
    	}
    }

	method reiniciar(){
		if(not silenciado){
			self.sonido(reinicio)
			sonido.volume(0.5)
			sonido.play()
		}
	}

	method nivelSuperado(){
		if(not silenciado){
			self.sonido(nivelSuperado)
			sonido.volume(0.5)
			sonido.play()
		}
	}

	method finDelJuego(){
		if(not silenciado){
			self.sonido(finDelJuego)
			musicaDeFondo.volume(0.0)
			sonido.volume(0.5)
			sonido.play()
		}
	}
	
	method ganaste(){
		if(not silenciado){
			self.sonido(ganaste)
			musicaDeFondo.volume(0.0)
			sonido.volume(0.5)
			sonido.play()
		}
	}
	
	
}