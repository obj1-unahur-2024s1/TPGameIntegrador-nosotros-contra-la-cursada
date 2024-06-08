import wollok.game.*
import fondos.*
import visuales.*


object juego {
	var puntos = 0
	var juegoTerminado = false
	method puntos(){
		return puntos
	}
	
	method iniciar(){
		
		game.title("Collect Coins")
		//fondo menu
		game.addVisualIn(fondo,game.at(0,0))
		
		//tamanio de la ventana
		game.cellSize(110)
		game.width(14)
		game.height(10)
		
		//Movimientos y teclas
		
		keyboard.enter().onPressDo{self.configurate()}
		//keyboard.w().onPressDo{ if(selector.puedeMoverArriba()) selector.subirGema()}
		//keyboard.r().onPressDo{ self.reiniciar()}
	
		//keyboard.s().onPressDo{ if(selector.puedeMoverAbajo()) selector.bajarGema()}
		//keyboard.d().onPressDo{ if(selector.puedeMoverDerecha()) selector.moverDerechaGema()}
		//keyboard.a().onPressDo{ if(selector.puedeMoverIzquierda()) selector.moverIzquierdaGema()}
		keyboard.up().onPressDo{ selector.moverArriba()}
		keyboard.down().onPressDo{ selector.moverAbajo()}
		keyboard.left().onPressDo{ selector.moverIzquierda()}
		keyboard.right().onPressDo{ selector.moverDerecha()}
				
	}
	method AgregarObjEnPosicion(col,fila){
		game.addVisual(new ObjectoRandom(position=game.at(col,fila)))
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
	
	method configurate(){
		fondo.image(fondo.imagenNivel1())
		game.addVisualIn(marco, game.at(3,1))
		self.IniciarObjetosEnTablero()
		game.addVisual(selector)
	}
	
	
}
