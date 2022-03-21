// DecoratorPatternDemo.java

// Class
// Main class
public class DecoratorPatternDemo {

	// Main driver method
	public static void main(String[] args)
	{
		// Creating an object of Shape interface
		// inside the main() method
		shape circle = new circle();

		shape redCircle = new RedShapeDecorator(new circle());
//		shape redRectangle	= new RedShapeDecorator(new rectangle());

		// Display message
		System.out.println("Circle with normal border");

		// Calling the draw method over the
		// object calls as created in
		// above classes

		// Call 1
		circle.draw();

		// Display message
		System.out.println("\nCircle of red border");

		// Call 2
		redCircle.draw();

		// Display message
		System.out.println("\nRectangle of red border");

		// Call 3
//		redRectangle.draw();
	}
}
