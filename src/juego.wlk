import wollok.game.*
import fondos.*
import visuales.*
import fondos.*
import sonidos.*


object juego {
	var puntos = 0
	var juegoTerminado = false
	var menuInicio = true

	method puntos(){
		return puntos
	}
	
	method iniciar(){
		
		game.title("Collect Coins")
	
	
		
		//tamaño de la ventana
		game.cellSize(110)
		game.width(14)
		game.height(10)
		//fondo menu
		game.addVisualIn(fondo,game.at(0,0))
		//iniciar modo juego
		keyboard.enter().onPressDo{if(menuInicio){self.configurate()}}
		// volver al menu
		keyboard.m().onPressDo {if (!menuInicio) {self.volverAlMenu()}}	
		//moverse en el menu
		keyboard.num1().onPressDo{if(menuInicio){fondo.sigFondo()}}
		keyboard.num2().onPressDo{if (menuInicio ){fondo.antFondo()}}
		//movimientos del selector con las teclas
		keyboard.up().onPressDo{ selector.moverArriba()}
		keyboard.down().onPressDo{ selector.moverAbajo()}
		keyboard.left().onPressDo{ selector.moverIzquierda()}
		keyboard.right().onPressDo{ selector.moverDerecha()}
	}
	method AgregarObjEnPosicion(col,fila){
		game.addVisual(new ObjectoRandom(position=game.at(col,fila)))
	}
	
	method borrarObjEnPosicion(col, fila) {
    game.getObjectsIn(game.at(col, fila))
        .filter({ f => f.esUnaFicha() and f != selector })
        .forEach({ f => game.removeVisual(f) })
	}
	method IniciarObjetosEnTablero(){
		(3..10).forEach{x =>						
		self.AgregarObjEnPosicion(x,1)
		self.AgregarObjEnPosicion(x,2) 
		self.AgregarObjEnPosicion(x,3)
		self.AgregarObjEnPosicion(x,4)
		self.AgregarObjEnPosicion(x,5)
		self.AgregarObjEnPosicion(x,6)
		self.AgregarObjEnPosicion(x,7) 
		self.AgregarObjEnPosicion(x,8)
		}
	}
	
		method borrarTablero(){
		(3..10).forEach{x =>
			self.borrarObjEnPosicion(x,1)
			self.borrarObjEnPosicion(x,2)
			self.borrarObjEnPosicion(x,3)
			self.borrarObjEnPosicion(x,4)
			self.borrarObjEnPosicion(x,5)
			self.borrarObjEnPosicion(x,6)
			self.borrarObjEnPosicion(x,7)
			self.borrarObjEnPosicion(x,8)
		}
	}
	//configuracion del modo juego
	method configurate(){
		fondo.image(fondo.imagenNivel1())
		game.addVisualIn(marco, game.at(3,1))
		self.IniciarObjetosEnTablero()
		game.addVisual(selector)
		menuInicio= false //cambia en modo juego y no podes ingresar a las instrucciones 
		
		game.addVisual(digito1)
		game.addVisual(digito2)
		game.addVisual(digito3)
		game.addVisual(digito4)
		
		self.borrarMatchesInvisible()
		puntos = 0
		if(not juegoTerminado){sonido.iniciarPartida()}
	}
	
	//volver al menu FALTA CORREGIR
	method volverAlMenu() {
    	self.borrarTablero()
    	fondo.image("fondoInicio0.png")
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

	method ganar(){
			puntos = 0
			juegoTerminado = true
			game.clear()
			//fondo.image(fondo.imagenVictoria())
			game.addVisualIn(fondo, game.at(0,0))
			sonido.pausarSiSePuede()
			sonido.victoria()
			game.schedule(500,{
				//fondo.image(fondo.imagenMenuSinHelp())
				game.clear()	
				self.iniciar()
			} )
	}
	
	method reiniciar(){ 
		self.borrarTablero()
		self.IniciarObjetosEnTablero()
		self.borrarMatchesInvisible()
		sonido.reiniciar()		
	}	


}
