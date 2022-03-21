
public abstract class ShapeDecorator implements shape {

	
	protected shape decoratedShape;

	
	public ShapeDecorator(shape decoratedShape)
	{
		
		this.decoratedShape = decoratedShape;
	}
	public void draw() { decoratedShape.draw(); }
}

