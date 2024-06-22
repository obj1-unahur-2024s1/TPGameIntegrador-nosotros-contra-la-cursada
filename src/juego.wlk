import wollok.game.*
import fondos.*
import visuales.*
import fondos.*
import sonidos.*

object juego {
	var monedas = 0
	var nivel1Terminado = false
	var	nivel2Terminado = false
	var nivel3Terminado = false
	var juegoTerminado = false
	var menuInicio = true
	var movimientos = 100

	method monedas() = monedas
	
	method movimientos() = movimientos
	
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
			(if(monedas > 5 and movimientos > 0){
				nivel1Terminado = true
				self.nivel2()
			}
		)})
		
		
		game.onTick(250, "nivel 2", {
			(if(monedas > 10 and movimientos > 0){
				nivel2Terminado = true
				self.nivel3()
			}
		)})
		
		game.onTick(250, "nivel 3", {
			(if(monedas > 15 and movimientos > 0){
				nivel3Terminado = true
				self.ganar()
			} else if(monedas < 15 and movimientos == 0){
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
			if(selector.puedeMoverArriba()){
				selector.subirFicha() 
				movimientos--
			}
		}
		keyboard.a().onPressDo{ 
			if(selector.puedeMoverIzquierda()){
				selector.moverIzquierdaFicha() 
				movimientos--
			}
		}
		keyboard.s().onPressDo{ 
			if(selector.puedeMoverAbajo()){
				selector.bajarFicha() 
				movimientos--
			}
		}
		keyboard.d().onPressDo{ 
			if(selector.puedeMoverDerecha()){
				selector.moverDerechaFicha() 
				movimientos--
			}
		}
		//nuevo tablero
		keyboard.r().onPressDo{ self.reiniciar()}
	}
	
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
	
	method sumarMonedas(cant){monedas += cant}
	
	method borrarMatches() {
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontalQuintuple()){
				if(ficha.ficha()==4){self.sumarMonedas(3)}
				ficha.borrarMatchHorizontalQuintuple()}})
				
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVerticalQuintuple()){
				if(ficha.ficha()==4){self.sumarMonedas(3)}
				ficha.borrarMatchVerticalQuintuple()}})
		
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontalCuadruple()){
				if(ficha.ficha()==4){self.sumarMonedas(2)}
				ficha.borrarMatchHorizontalCuadruple()}})
		
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVerticalCuadruple()){
				if(ficha.ficha()==4){self.sumarMonedas(2)}
				ficha.borrarMatchVerticalCuadruple()}})
				
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchHorizontal()){
				if(ficha.ficha()==4){self.sumarMonedas(1)}
				ficha.borrarMatchHorizontal()}})
				
		self.fichasConMatch().forEach({ ficha =>
			if(ficha.tieneMatchVertical()){
				if(ficha.ficha()==4){self.sumarMonedas(1)}
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
		
		monedas = 0
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
	}
	
	method borrarPuntuacion(){
		//numeros de puntuacion
		game.removeVisual(digito1)
    	game.removeVisual(digito2)
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
			monedas = 0
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
			monedas = 0
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
		monedas = 0
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
		monedas = 0
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

