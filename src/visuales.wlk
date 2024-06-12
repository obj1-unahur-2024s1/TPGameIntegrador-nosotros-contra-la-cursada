import wollok.game.*
import juego.*

class ObjectoRandom {
	
	var property position = game.at(0,0)
	const imagenes = [corazon.imagen(),aroiris.imagen(),cerveza.imagen(),herradura.imagen(),moneda.imagen(),monio.imagen(),trebol.imagen()]
	const property ficha = 0.randomUpTo(7).truncate(0)
	const property puntajes= [corazon.puntaje(), aroiris.puntaje(),cerveza.puntaje(),herradura.puntaje(),moneda.puntaje(),monio.puntaje(),trebol.puntaje()]
	
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
	
	override method imagen()= "Fichas/corazon.png"
	
	override method puntaje()= 55
}

object aroiris inherits Ficha {
	
	override method imagen()= "Fichas/arcoiris.png"
	
	override method puntaje()= 85
}

object cerveza inherits Ficha {
	
	override method imagen()= "Fichas/cerveza.png"
	
	override method puntaje()= 40
}

object herradura inherits Ficha {
	
	override method imagen()= "Fichas/herradura.png"
	
	override method puntaje()= 130
}

object moneda inherits Ficha {
	
	override method imagen()= "Fichas/moneda.png"
	
	override method puntaje()= 100
}

object monio inherits Ficha {
	
	override method imagen()= "Fichas/monio.png"
	
	override method puntaje()= 110
}

object trebol inherits Ficha {
	
	override method imagen()= "Fichas/trebol.png"
	
	override method puntaje()= 70
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
}