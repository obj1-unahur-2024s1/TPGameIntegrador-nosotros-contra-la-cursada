import wollok.game.*
import juego.*
import sonidos.*

class FichaRandom {
	
	var property position = game.at(0,0)
	const imagenes = [corazon.imagen(),arcoiris.imagen(),cerveza.imagen(),herradura.imagen(),moneda.imagen(),monio.imagen(),trebol.imagen()]
	const property ficha = 0.randomUpTo(7).truncate(0)
	
	method image()= imagenes.get(ficha)
	method esUnaFicha() = true
	
	method borrarse(){
		game.removeVisual(self)
	}
	
	// intercambio De Fichas
	method subir(){		
		self.subirFicha()
		game.getObjectsIn(self.position()).filter({f=> f.esUnaFicha() and f != self }).first().bajarFicha()
	}
	method bajar(){
		self.bajarFicha()
		game.getObjectsIn(self.position()).filter({f=> f.esUnaFicha() and f != self }).first().subirFicha()
	}
	method moverDerecha(){
		self.derFicha()
		game.getObjectsIn(self.position()).filter({f=> f.esUnaFicha() and f != self }).first().izqFicha()
	}
	method moverIzquierda(){
		self.izqFicha()
		game.getObjectsIn(self.position()).filter({f=> f.esUnaFicha() and f != self }).first().derFicha()
	}	
	
	
	// movimientos De Fichas	
	method subirFicha(){position = position.up(1)}
	method bajarFicha(){position = position.down(1)}
	method derFicha(){position = position.right(1)}
	method izqFicha(){position = position.left(1)}
	//	
	
	// BORRAR MATCHS POR TIPO
	method borrarMatchVerticalQuintuple(){
		self.borrarMatchVerticalCuadruple()
		self.fichaAbajo(4).borrarse()
		game.addVisual(new FichaRandom(position = game.at(self.position().x(), self.position().y()-4)))
	}
	
	method borrarMatchVerticalCuadruple(){
		self.borrarMatchVertical()
		self.fichaAbajo(3).borrarse()
		game.addVisual(new FichaRandom(position = game.at(self.position().x(), self.position().y()-3)))
	}
	
	method borrarMatchVertical(){
		self.borrarse()
		self.fichaAbajo(1).borrarse()
		self.fichaAbajo(2).borrarse()
		game.addVisual(new FichaRandom(position = self.position()))
		game.addVisual(new FichaRandom(position = game.at(self.position().x(), self.position().y()-1)))
		game.addVisual(new FichaRandom(position = game.at(self.position().x(), self.position().y()-2)))	
	}
	
	method borrarMatchHorizontalQuintuple(){
		self.borrarMatchHorizontalCuadruple()
		self.fichaALaDerecha(4).borrarse()	
		game.addVisual(new FichaRandom(position = game.at(self.position().x()+4, self.position().y())))	
	}
	
	method borrarMatchHorizontalCuadruple(){
		self.borrarMatchHorizontal()
		self.fichaALaDerecha(3).borrarse()	
		game.addVisual(new FichaRandom(position = game.at(self.position().x()+3, self.position().y())))	
	}
	
	method borrarMatchHorizontal(){
		self.borrarse()
		self.fichaALaDerecha(1).borrarse()
		self.fichaALaDerecha(2).borrarse()
		game.addVisual(new FichaRandom(position = self.position()))
		game.addVisual(new FichaRandom(position = game.at(self.position().x()+1, self.position().y())))
		game.addVisual(new FichaRandom(position = game.at(self.position().x()+2, self.position().y())))	
		
	}
	
	
	// VERIFICA QUE TIPO ES MATCH ES
	method tieneMatch(){
		return self.tieneMatchVertical() or self.tieneMatchHorizontal()
	}
	
	method tieneMatchHorizontalQuintuple(){
		return self.tieneFichasALaDerecha(4) and (self.ficha() == self.fichaALaDerecha(1).ficha() and self.ficha() == self.fichaALaDerecha(2).ficha() and self.ficha() == self.fichaALaDerecha(3).ficha()) and self.ficha() == self.fichaALaDerecha(4).ficha()}
	
	method tieneMatchHorizontalCuadruple(){
		return self.tieneFichasALaDerecha(3) and (self.ficha() == self.fichaALaDerecha(1).ficha() and self.ficha() == self.fichaALaDerecha(2).ficha() and self.ficha() == self.fichaALaDerecha(3).ficha())}
	
	method tieneMatchHorizontal(){
		return self.tieneFichasALaDerecha(2) and (self.ficha() == self.fichaALaDerecha(1).ficha() and self.ficha() == self.fichaALaDerecha(2).ficha())} 
	
	method tieneMatchVerticalQuintuple(){
		return self.tieneFichasAbajo(4) and (self.ficha() == self.fichaAbajo(1).ficha() and self.ficha() == self.fichaAbajo(2).ficha() and self.ficha() == self.fichaAbajo(3).ficha() and self.ficha() == self.fichaAbajo(4).ficha())}
	
	method tieneMatchVerticalCuadruple(){
		return self.tieneFichasAbajo(3) and (self.ficha() == self.fichaAbajo(1).ficha() and self.ficha() == self.fichaAbajo(2).ficha() and self.ficha() == self.fichaAbajo(3).ficha())}
	
	method tieneMatchVertical(){
		return self.tieneFichasAbajo(2) and (self.ficha() == self.fichaAbajo(1).ficha() and self.ficha() == self.fichaAbajo(2).ficha())
	}
	
	// verificarFichasAdyacentes
	method tieneFichasALaDerecha(cantidad){
		return game.getObjectsIn(self.position().right(cantidad)).size() >= 1
	}
	
	method tieneFichasAbajo(cantidad){
		return game.getObjectsIn(self.position().down(cantidad)).size() >= 1
	}
	//
	
	// returnDeGemasEnPosicion
	method fichaALaDerecha(veces)= game.getObjectsIn(self.position().right(veces)).filter({f=>f.esUnaFicha()}).first()	
	method fichaAbajo(veces)= game.getObjectsIn(self.position().down(veces)).filter({f=>f.esUnaFicha()}).first()
	//
}

class Ficha {
	method imagen()
	method esUnaFicha() = true
}

object corazon inherits Ficha {override method imagen()= "Fichas/corazon.png"}

object arcoiris inherits Ficha {override method imagen()= "Fichas/arcoiris.png"}

object cerveza inherits Ficha {override method imagen()= "Fichas/cerveza.png"}

object herradura inherits Ficha {override method imagen()= "Fichas/herradura.png"}

object moneda inherits Ficha {override method imagen()= "Fichas/moneda.png"}

object monio inherits Ficha {override method imagen()= "Fichas/monio.png"}

object trebol inherits Ficha {override method imagen()= "Fichas/trebol.png"}

object selector{
	var property image = "selector.png"
	var property position = game.center()
	const maximaFila = 8
	const maximaColumna = 10
	const minimaFila = 1
	const minimaColumna = 3
	
	method esUnaFicha() = false
	
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
            sonido.malMovimiento()
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
            sonido.malMovimiento()
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
            sonido.malMovimiento()
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
            sonido.malMovimiento()
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
	method valorD3() = (juego.monedas() % 100).div(10)
	override method position() = game.at(6,9)
	override method image() = listaNumeros.get(self.valorD3()).image()
}

object digito2 inherits Digito{
	method valorD4()= juego.monedas() % 10
	override method position() = game.at(7,9)
	override method image() = listaNumeros.get(self.valorD4()).image()
}

object mov1 inherits Digito{
	method valorD1()= (juego.movimientos() % 100).div(10)
	override method position() = game.at(1,9)
	override method image() = listaNumeros.get(self.valorD1()).image()
}

object mov2 inherits Digito{
	method valorD2()= juego.movimientos() % 10
	override method position() = game.at(2,9)
	override method image() = listaNumeros.get(self.valorD2()).image()
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
