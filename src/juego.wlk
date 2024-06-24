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
	var movimientos = 30

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
		
		//inicializar sonido
		sonido.musicaMenu()
		
		game.start()
		
	}
	
	method configurarTeclas(){
		
		//iniciar modo juego
		keyboard.enter().onPressDo{if(menuInicio){self.nivel1() sonido.musicaDeFondo().pause() sonido.musicaNivel()}}
		
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
				self.restarMovimientos(1)
			}
		}
		keyboard.a().onPressDo{ 
			if(selector.puedeMoverIzquierda()){
				selector.moverIzquierdaFicha() 
				self.restarMovimientos(1)
			}
		}
		keyboard.s().onPressDo{ 
			if(selector.puedeMoverAbajo()){
				selector.bajarFicha() 
				self.restarMovimientos(1)
			}
		}
		keyboard.d().onPressDo{ 
			if(selector.puedeMoverDerecha()){
				selector.moverDerechaFicha() 
				self.restarMovimientos(1)
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
		sonido.musicaDeFondo().pause()
		sonido.musicaMenu()
    	fondo.image("fondoInicio0.png")
    	self.quitarObjetos()
    	menuInicio = true
    	nivel1Terminado = false
		nivel2Terminado = false
		nivel3Terminado = false
	}
	
	method iniciarObjetos(){
		game.addVisualIn(marco, game.at(3,1))
		game.addVisual(selector)
		self.agregarPuntuacion()
		self.agregarMovimientos()
	}
	
	method quitarObjetos(){
		self.borrarTablero()
    	if(game.hasVisual(marco)){game.removeVisual(marco)}
    	if(game.hasVisual(selector)){game.removeVisual(selector)}
    	self.borrarPuntuacion()
    	self.borrarMovimientos()
	}
	
	method hayMatchEnTablero()= not self.fichasConMatch().isEmpty()
	
	method sumarMonedas(cant){monedas += cant}
	
	method restarMovimientos(cant){movimientos -= cant}
	
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
	
	method agregarMovimientos(){
		//cantidad de movimientos restantes
		game.addVisual(mov1)
		game.addVisual(mov2)
	}
	
	method borrarMovimientos(){
		//cantidad de movimientos restantes
		if(game.hasVisual(mov1)){game.removeVisual(mov1)}
		if(game.hasVisual(mov2)){game.removeVisual(mov2)}
	}
	
	method agregarPuntuacion(){
		//numeros de puntuacion
		game.addVisual(digito1)
		game.addVisual(digito2)
	}
	
	method borrarPuntuacion(){
		//numeros de puntuacion
		if(game.hasVisual(digito1)){game.removeVisual(digito1)}
    	if(game.hasVisual(digito2)){game.removeVisual(digito2)}
	}
	
	method pasasteNivel(){
		self.quitarObjetos()
		fondo.image(fondo.nivelSuperado())
		sonido.nivelSuperado()
	}
	
	method nivel1(){
		monedas = 0
		movimientos = 30
		fondo.image(fondo.imagenNivel1())
		self.iniciarObjetos()
		self.iniciarFichasEnTablero()
		menuInicio= false 
			
		self.borrarMatchesInvisible()
		
		game.onTick(250, "nivel1", {
			(if(monedas >= 5 and movimientos >= 0){
				nivel1Terminado = true
				self.pasasteNivel()
				game.removeTickEvent("nivel1")
				game.schedule(5000, {self.nivel2()})
			} else if(monedas < 5 and movimientos == 0){
				juegoTerminado = true
				game.removeTickEvent("nivel1")
				game.schedule(5000, {self.gameOver()})
			}
		)})
	}

	method nivel2(){
		if(nivel1Terminado){
			monedas = 0
			movimientos = 30
			self.iniciarObjetos()
			fondo.image(fondo.imagenNivel2())
			self.borrarTablero()
			self.iniciarFichasEnTablero()
			menuInicio= false 
			self.borrarMatchesInvisible()
			
			game.onTick(250, "nivel2", {
			(if(monedas >= 10 and movimientos >= 0){
				nivel2Terminado = true
				self.pasasteNivel()
				game.removeTickEvent("nivel2")
				game.schedule(5000, {self.nivel3()})
			} else if(monedas < 10 and movimientos == 0){
				juegoTerminado = true
				game.removeTickEvent("nivel2")
				game.schedule(5000, {self.gameOver()})
			}
		)})
		}
		
	}
	
	method nivel3(){
		if(nivel2Terminado){
			monedas = 0
			movimientos = 30
			self.iniciarObjetos()
			fondo.image(fondo.imagenNivel3())
			self.borrarTablero()
			self.iniciarFichasEnTablero()
			menuInicio= false 
			self.borrarMatchesInvisible()
			
			game.onTick(250, "nivel3", {
			(if(monedas >= 15 and movimientos >= 0){
				nivel3Terminado = true
				juegoTerminado = true
				game.removeTickEvent("nivel3")
				game.schedule(5000, {self.ganar()})
			} else if(monedas < 15 and movimientos == 0){
				juegoTerminado = true
				game.removeTickEvent("nivel3")
				game.schedule(5000, {self.gameOver()})
			}
		)})
		}
		
	}
	
	method ganar(){
		monedas = 0
		game.clear()
		fondo.image(fondo.ganaste())
		game.addVisualIn(fondo, game.at(0,0))
		if(juegoTerminado){
			sonido.ganaste()
		}
	}
	
	method gameOver(){
		monedas = 0
		self.quitarObjetos()
		fondo.image(fondo.finDelJuego())
		if(juegoTerminado){
			sonido.finDelJuego()
		}
		nivel1Terminado = false
		nivel2Terminado = false
		nivel3Terminado = false
		juegoTerminado = false
		
	}
	
	method reiniciar(){ 
		if(!nivel1Terminado){self.restarMovimientos(1)}
		else if(nivel1Terminado and !nivel2Terminado){if(movimientos < 2) movimientos = 0 else self.restarMovimientos(2)}
		else if(nivel2Terminado and !nivel3Terminado){if(movimientos < 3) movimientos = 0 else self.restarMovimientos(3)}
		self.borrarTablero()
		self.iniciarFichasEnTablero()
		self.borrarMatchesInvisible()
		sonido.reiniciar()		
	}	


}

