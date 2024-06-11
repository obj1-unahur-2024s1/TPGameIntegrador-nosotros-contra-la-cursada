import wollok.game.*


object marco{
	method image()= "tablero.png"
	method position()= game.at(3,1)
	method esUnaFicha(){}

	}
	
object fondo{
	var nFondo=0
	var image ="fondoInicio0.png"
	method image() = image	
	method image(unaImage){image = unaImage}
	
	method sigFondo(){
		nFondo= 2.min(nFondo+1)
		self.image("fondoInicio"+nFondo+".png")
	}
	
	method antFondo(){
		nFondo= 0.max(nFondo-1)
		self.image("fondoInicio"+nFondo+".png")
	}
	method imagenNivel1()= "fondoTablero1.png"
	
	method imagenNivel2()= "fondoTablero2.png"
}