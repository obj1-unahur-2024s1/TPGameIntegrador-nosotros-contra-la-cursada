import wollok.game.*
import juego.*
import sonidos.*

class ObjectoRandom {
	
	var property position = game.at(0,0)
	const imagenes = [corazon.imagen(),arcoiris.imagen(),cerveza.imagen(),herradura.imagen(),moneda.imagen(),monio.imagen(),trebol.imagen()]
	const property ficha = 0.randomUpTo(7).truncate(0)
	const property puntajes= [corazon.puntaje(), arcoiris.puntaje(),cerveza.puntaje(),herradura.puntaje(),moneda.puntaje(),monio.puntaje(),trebol.puntaje()]
	
	method puntaje() = puntajes.get(ficha)
	method image()= imagenes.get(ficha)
	method esUnaFicha(){}
	
	method borrarse(){
		game.removeVisual(self)
	}
	
		
}

class Ficha {
	method imagen()
	method puntaje()
	method esUnaFicha() = true
}

object corazon inherits Ficha {
	
	override method imagen()= "corazon.png"
	
	override method puntaje()= 80
}

object arcoiris inherits Ficha {
	
	override method imagen()= "arcoiris.png"
	
	override method puntaje()= 60
}

object cerveza inherits Ficha {
	
	override method imagen()= "cerveza.png"
	
	override method puntaje()= 250
}

object herradura inherits Ficha {
	
	override method imagen()= "herradura.png"
	
	override method puntaje()= 50
}

object moneda inherits Ficha {
	
	override method imagen()= "moneda.png"
	
	override method puntaje()= 500
}

object monio inherits Ficha {
	
	override method imagen()= "monio.png"
	
	override method puntaje()= 100
}

object trebol inherits Ficha {
	
	override method imagen()= "trebol.png"
	
	override method puntaje()= 150
}

object selector{
	var property image = "selector.png"
	var property position = game.center()
	const maximaFila = 8
	const maximaColumna = 10
	const minimaFila = 1
	const minimaColumna = 3
	
	//mover Selector
	method moverArriba(){
		if(self.puedeMoverArriba() )
			position = position.up(1)
	}
	method moverAbajo(){
		if(self.puedeMoverAbajo() )
		position = position.down(1)
	
	}
	method moverDerecha(){
		if( self.puedeMoverDerecha() )
		position = position.right(1)
	
	}
	method moverIzquierda(){
		if( self.puedeMoverIzquierda() )
		position = position.left(1)
	
	}

	method puedeMoverArriba()= position.y() < maximaFila
	method puedeMoverAbajo()= position.y() > minimaFila
	method puedeMoverDerecha()= position.x() < maximaColumna
	method puedeMoverIzquierda()= position.x() > minimaColumna
	
	method subirFicha(){
		self.fichaActual().subir()
		position = position.up(1)
        game.schedule(1, {=> if(juego.hayMatchEnTablero()){
            juego.borrarMatches()
            sonido.borrarFicha() 
        }
        else{
            sonido.fichaIncorrecta()
            self.fichaActual().bajar()
            position = position.down(1)
        }})
	}
	
	method bajarFicha(){
        self.fichaActual().bajar()
        position = position.down(1)
        game.schedule(1, {=>if(juego.hayMatchEnTablero()){
            juego.borrarMatches()
            sonido.borrarFicha()
        }
        else{
            sonido.fichaIncorrecta()
            self.fichaActual().subir()
            position = position.up(1)
        }})
    }
    
    method moverDerechaFicha(){
        self.fichaActual().moverDerecha()
        position = position.right(1)
        game.schedule(1, {=>if(juego.hayMatchEnTablero()){
            juego.borrarMatches()
            sonido.borrarFicha()
        }
        else{
            sonido.fichaIncorrecta()
            self.fichaActual().moverIzquierda()
            position = position.left(1)
        }})
    }
    
    method moverIzquierdaFicha(){
        self.fichaActual().moverIzquierda()
        position = position.left(1)
        game.schedule(1, {=>if(juego.hayMatchEnTablero()){
            juego.borrarMatches()
            sonido.borrarFicha()
        }
        else{
            sonido.fichaIncorrecta()
            self.fichaActual().moverDerecha()
            position = position.right(1)
        }})
    }
    
    method fichaActual(){
		return game.getObjectsIn(self.position()).filter({ficha=>ficha.esUnaFicha() and ficha != self}).first()
	}
}

class Digito{
	const property listaNumeros = [num0,num1,num2,num3,num4,num5,num6,num7,num8,num9]
	method esUnaFicha() = false
	method position()
	method image()
}

object digito1 inherits Digito{
	method valorD1() = juego.puntos().div(1000)
	override method position() = game.at(5,9)
	override method image() = listaNumeros.get(self.valorD1()).image()
}

object digito2 inherits Digito{
	method valorD2() = (juego.puntos() % 1000).div(100)
	override method position() = game.at(6,9)
	override method image() = listaNumeros.get(self.valorD2()).image()
}

object digito3 inherits Digito{
	method valorD3() = (juego.puntos() % 100).div(10)
	override method position() = game.at(7,9)
	override method image() = listaNumeros.get(self.valorD3()).image()
}

object digito4 inherits Digito{
	method valorD4()= juego.puntos() % 10
	override method position() = game.at(8,9)
	override method image() = listaNumeros.get(self.valorD4()).image()
}

object num0{
	var property image = "n0.png"
}

object num1{
	var property image = "n1.png"
}

object num2{
	var property image = "n2.png"
}

object num3{
	var property image = "n3.png"
}

object num4{
	var property image = "n4.png"
}

object num5{
	var property image = "n5.png"
}

object num6{
	var property image = "n6.png"
}

object num7{
	var property image = "n7.png"
}

object num8{
	var property image = "n8.png"
}

object num9{
	var property image = "n9.png"
}
