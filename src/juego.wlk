import wollok.game.*
import fondos.*
import visuales.*
import fondos.*
import sonidos.*

object juego {
	var puntos = 0
	var nivel1Terminado = false
	var	nivel2Terminado = false
	var nivel3Terminado = false
	var juegoTerminado = false
	var menuInicio = true
	var movimientos = 100

	method puntos(){
		return puntos
	}
	
	method movimientos(){
		return movimientos
	}
	
	method iniciar(){
		
		game.title("Collect Coins")
	
		//tamaño de la ventana
		game.cellSize(110)
		game.width(14)
		game.height(10)
		
		//fondo menu
		game.addVisualIn(fondo,game.at(0,0))
		
		//configurar teclas
		self.configurarTeclas()
		
		//condiciones para terminar el juego
		game.onTick(250, "nivel 1", {
			(if(puntos > 1500 and movimientos > 0){
				nivel1Terminado = true
				self.nivel2()
			}
		)})
		
		
		game.onTick(250, "nivel 2", {
			(if(puntos > 2500 and movimientos > 0){
				nivel2Terminado = true
				self.nivel3()
			}
		)})
		
		game.onTick(250, "nivel 3", {
			(if(puntos > 3500 and movimientos > 0){
				nivel3Terminado = true
				self.ganar()
			} else if(puntos < 3500 and movimientos == 0){
				self.gameOver()
			}
		)})
	}
	
	method configurarTeclas(){
		
		//iniciar modo juego
		keyboard.enter().onPressDo{if(menuInicio){self.nivel1() sonido.reproducirSiSePuede()}}
		
		// volver al menu
		keyboard.m().onPressDo {if (!menuInicio) {self.volverAlMenu()}}	
		
		//moverse en el menu
		keyboard.num1().onPressDo{if(menuInicio){fondo.sigFondo()}}
		keyboard.num2().onPressDo{if (menuInicio ){fondo.antFondo()}}
		
		//apaga musica del juego
		keyboard.p().onPressDo{sonido.mutear()}
		
		//apaga todos los sonidos del juego
		keyboard.o().onPressDo{sonido.silenciar()}
		
		//movimientos del selector con las teclas
		keyboard.up().onPressDo{ selector.moverArriba()}
		keyboard.down().onPressDo{ selector.moverAbajo()}
		keyboard.left().onPressDo{ selector.moverIzquierda()}
		keyboard.right().onPressDo{ selector.moverDerecha()}
		
		//movimientos de fichas
		keyboard.w().onPressDo{ 
			if(selector.puedeMoverArriba() /*and self.hayMatchUp()*/){
				selector.subirFicha() 
				movimientos--
			}
		}
		keyboard.a().onPressDo{ 
			if(selector.puedeMoverIzquierda() /*and self.hayMatchLeft()*/){
				selector.moverIzquierdaFicha() 
				movimientos--
			}
		}
		keyboard.s().onPressDo{ 
			if(selector.puedeMoverAbajo() /*and self.hayMatchUp()*/){
				selector.bajarFicha() 
				movimientos--
			}
		}
		keyboard.d().onPressDo{ 
			if(selector.puedeMoverDerecha() /*and self.hayMatchUp()*/){
				selector.moverDerechaFicha() 
				movimientos--
			}
		}
		//nuevo tablero
		keyboard.r().onPressDo{ self.reiniciar()}
	}
	
	
	/* 
	method fichaActual() = game.getObjectsIn(selector.position()).filter({f=>f.esUnaFicha()}).first()
	
	method fichaEn(x,y) = game.getObjectsIn(game.at(x,y)).filter({f=>f.esUnaFicha()}).first()
	
	method hayMatchs(){
		return (self.hayMatchUp() or
				self.hayMatchDown() or
				self.hayMatchRight() or
				self.hayMatchLeft()
		)
	}
	
	method hayMatchUp(){
		return ( self.hayMatchArriba("derecha") or
				self.hayMatchArriba("izquierda") or
				self.hayMatchArriba("arriba")
		)
	}
	
	
	method hayMatchArriba(direccion){
		const x = selector.position().x()
		const y = selector.position().y()
		
		if(direccion == "derecha"){
			return (self.fichaEn(x+1,y+1).ficha() == self.fichaActual().ficha() and self.fichaEn(x+2,y+1).ficha() == self.fichaActual().ficha())
		} else if (direccion == "izquierda"){
			return (self.fichaEn(x-1,y+1).ficha() == self.fichaActual().ficha() and self.fichaEn(x-2,y+1).ficha() == self.fichaActual().ficha())
		} else if (direccion == "arriba"){
			return (self.fichaEn(x,y+2).ficha() == self.fichaActual().ficha() and self.fichaEn(x,y+3).ficha() == self.fichaActual().ficha())
		} 
		return null
	}
	
	method hayMatchDown(){
		return ( self.hayMatchAbajo("derecha") or
				self.hayMatchAbajo("izquierda") or
				self.hayMatchAbajo("abajo") 
		)
	}
	
	method hayMatchAbajo(direccion){
		const x = selector.position().x()
		const y = selector.position().y()
		
		if(direccion == "derecha"){
			return (self.fichaEn(x+1,y-1).ficha() == self.fichaActual().ficha() and self.fichaEn(x+2,y-1).ficha() == self.fichaActual().ficha())
		} else if (direccion == "izquierda"){
			return (self.fichaEn(x-1,y-1).ficha() == self.fichaActual().ficha() and self.fichaEn(x-2,y-1).ficha() == self.fichaActual().ficha())
		} else if (direccion == "abajo"){
			return (self.fichaEn(x,y-2).ficha() == self.fichaActual().ficha() and self.fichaEn(x,y-3).ficha() == self.fichaActual().ficha())
		} 
		return null
	}
	
	method hayMatchRight(){
		return ( self.hayMatchDerecha("derecha") or
				self.hayMatchDerecha("abajo") or
				self.hayMatchDerecha("arriba") 
		)
	}
	
	
	method hayMatchDerecha(direccion){
		const x = selector.position().x()
		const y = selector.position().y()
		
		if(direccion == "derecha"){
			return (self.fichaEn(x+2,y).ficha() == self.fichaActual().ficha() and self.fichaEn(x+3,y).ficha() == self.fichaActual().ficha())
		} else if (direccion == "abajo"){
			return (self.fichaEn(x+1,y-1).ficha() == self.fichaActual().ficha() and self.fichaEn(x+1,y-2).ficha() == self.fichaActual().ficha())
		} else if (direccion == "arriba"){
			return (self.fichaEn(x+1,y+1).ficha() == self.fichaActual().ficha() and self.fichaEn(x+1,y+2).ficha() == self.fichaActual().ficha())	
		} 
		return null
	}
	
	method hayMatchLeft(){
		return ( self.hayMatchIzquierda("arriba") or
				self.hayMatchIzquierda("izquierda") or
				self.hayMatchIzquierda("abajo") 
		)
	}
	
	method hayMatchIzquierda(direccion){
		const x = selector.position().x()
		const y = selector.position().y()
		
		if(direccion == "arriba"){	
			return (self.fichaEn(x-1,y+1).ficha() == self.fichaActual().ficha() and self.fichaEn(x-1,y+2).ficha() == self.fichaActual().ficha())
		} else if (direccion == "izquierda"){
			return (self.fichaEn(x-2,y).ficha() == self.fichaActual().ficha() and self.fichaEn(x-3,y).ficha() == self.fichaActual().ficha())
		} else if (direccion == "abajo"){
			return (self.fichaEn(x-1,y-1).ficha() == self.fichaActual().ficha() and self.fichaEn(x-1,y-2).ficha() == self.fichaActual().ficha())
		}
		return null
	}
	*/
	method agregarFichaEnPosicion(col,fila){
		game.addVisual(new FichaRandom(position=game.at(col,fila)))
	}
	
	method borrarFichaEnPosicion(col, fila) {
    game.getObjectsIn(game.at(col, fila))
        .filter({ f => f.esUnaFicha() and f != selector })
        .forEach({ f => game.removeVisual(f) })
	}
	
	method iniciarFichasEnTablero(){
		(3..10).forEach{x =>						
		self.agregarFichaEnPosicion(x,1)
		self.agregarFichaEnPosicion(x,2) 
		self.agregarFichaEnPosicion(x,3)
		self.agregarFichaEnPosicion(x,4)
		self.agregarFichaEnPosicion(x,5)
		self.agregarFichaEnPosicion(x,6)
		self.agregarFichaEnPosicion(x,7) 
		self.agregarFichaEnPosicion(x,8)
		}
	}
	
	method borrarTablero(){
		(3..10).forEach{x =>
			self.borrarFichaEnPosicion(x,1)
			self.borrarFichaEnPosicion(x,2)
			self.borrarFichaEnPosicion(x,3)
			self.borrarFichaEnPosicion(x,4)
			self.borrarFichaEnPosicion(x,5)
			self.borrarFichaEnPosicion(x,6)
			self.borrarFichaEnPosicion(x,7)
			self.borrarFichaEnPosicion(x,8)
		}
	}
	
	method volverAlMenu() {
    	self.borrarTablero()
    	fondo.image("fondoInicio0.png")
    	game.removeVisual(marco)
    	game.removeVisual(selector)
    	self.borrarPuntuacion()
    	self.borrarMovimientos()
    	sonido.pausarSiSePuede()
    	menuInicio = true
	}
	
	method hayMatchEnTablero()= not self.fichasConMatch().isEmpty()
	
	method borrarMatches() {
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontalCuadruple()){
				puntos += ficha.puntaje() * 2
				ficha.borrarMatchHorizontalCuadruple()}})
		
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVerticalCuadruple()){
				puntos += ficha.puntaje() * 2
				ficha.borrarMatchVerticalCuadruple()}})
				
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontal()){
				puntos += ficha.puntaje()
				ficha.borrarMatchHorizontal()}})
				
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVertical()){
				puntos += ficha.puntaje()
				ficha.borrarMatchVertical()}})
			
		if(self.hayMatchEnTablero()){
			self.borrarMatchesInvisible()
		}                         
		
	}
	
	method fichasConMatch()= self.todasLasFichas().filter({ficha => ficha.tieneMatch() })
	
	method borrarMatchesInvisible(){
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontal()){
				ficha.borrarMatchHorizontal()}
		})
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVertical()){
				ficha.borrarMatchVertical()}
			})
		if(self.hayMatchEnTablero()){		
			self.borrarMatchesInvisible()	
		}
	}
	
	method todasLasFichas()= game.allVisuals().filter({ficha => ficha.esUnaFicha()})

	method nivel1(){
		
		fondo.image(fondo.imagenNivel1())
		game.addVisualIn(marco, game.at(3,1))
		self.iniciarFichasEnTablero()
		game.addVisual(selector)
		menuInicio= false 
			
		self.agregarPuntuacion()
		self.agregarMovimientos()
		self.borrarMatchesInvisible()
		
		puntos = 0
		movimientos = 30
		
		if(not juegoTerminado){sonido.iniciarPartida()}
		
	}
	
	method agregarMovimientos(){
		//cantidad de movimientos restantes
		game.addVisual(mov1)
		game.addVisual(mov2)
	}
	
	method borrarMovimientos(){
		//cantidad de movimientos restantes
		game.removeVisual(mov1)
		game.removeVisual(mov2)
	}
	
	method agregarPuntuacion(){
		//numeros de puntuacion
		game.addVisual(digito1)
		game.addVisual(digito2)
		game.addVisual(digito3)
		game.addVisual(digito4)
	}
	
	method borrarPuntuacion(){
		//numeros de puntuacion
		game.removeVisual(digito1)
    	game.removeVisual(digito2)
    	game.removeVisual(digito3)
    	game.removeVisual(digito4)
	}
	
	method nivelSuperado(){
		fondo.image(fondo.nivelSuperado())
		game.addVisualIn(fondo, game.at(0,0))
		sonido.pausarSiSePuede()
		sonido.nivelSuperado()
	}

	method nivel2(){
		game.removeTickEvent("nivel 1")
		if(nivel1Terminado){
			puntos = 0
			movimientos = 25
			fondo.image(fondo.imagenNivel2())
			game.addVisualIn(marco, game.at(3,1))
			self.iniciarFichasEnTablero()
			game.addVisual(selector)
			menuInicio= false 
				
			self.agregarPuntuacion()
			self.agregarMovimientos()
			self.borrarMatchesInvisible()
			
			if(not juegoTerminado){sonido.iniciarPartida()}
		}
		
		
	}
	
	method nivel3(){
		game.removeTickEvent("nivel 2")
		if(nivel2Terminado){
			puntos = 0
			movimientos = 20
			fondo.image(fondo.imagenNivel3())
			game.addVisualIn(marco, game.at(3,1))
			self.iniciarFichasEnTablero()
			game.addVisual(selector)
			menuInicio= false 
				
			self.agregarPuntuacion()
			self.agregarMovimientos()
			self.borrarMatchesInvisible()
			
			if(not juegoTerminado){sonido.iniciarPartida()}
		}
		
		
	}
	
	method ganar(){
		game.removeTickEvent("nivel 3")
		puntos = 0
		game.clear()
		fondo.image(fondo.finDelJuego())
		game.addVisualIn(fondo, game.at(0,0))
		sonido.pausarSiSePuede()
		sonido.finDelJuego()
		game.schedule(500,{
			
			self.volverAlMenu()	
			
			self.iniciar()
		} )
	}
	
	method gameOver(){
		game.removeTickEvent("nivel 3")
		puntos = 0
		game.clear()
		fondo.image(fondo.finDelJuego())
		game.addVisualIn(fondo, game.at(0,0))
		sonido.pausarSiSePuede()
		sonido.finDelJuego()
	}
	
	method reiniciar(){ 
		self.borrarTablero()
		self.iniciarFichasEnTablero()
		self.borrarMatchesInvisible()
		sonido.reiniciar()		
	}	


}

