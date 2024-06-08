import wollok.game.*


object marco{
	method image()= "tablero.png"
	method position()= game.at(3,1)

	}

	object fondo {
		var property image = self.imagenMenu()
		
		method imagenMenu()= "fondoInicio.png"
		method imagenNivel1()="fondoTablero1.png"
		method imagenNivel2()="fondoTablero2.png"

	}