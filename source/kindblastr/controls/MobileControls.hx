package kindblastr.controls;

class MobileControls extends FlxTypedGroup<FlxButton>
{
	var buttonLeft:FlxButton;
   
    var buttonRight:FlxButton;
   
    public var left:Bool = false;
   
    public var right:Bool = false;
   
    public function new():Void{
    	super(2);
    
		buttonLeft = new FlxButton();
		buttonLeft.loadGraphic('assets/images/mobilecontrols/movementbutton.png');
		buttonLeft.x = 0;
		buttonLeft.antialiasing = false;
		buttonLeft.color = FlxColor.BLUE;
		buttonLeft.alpha = 0;
		add(buttonLeft);
		
		buttonRight = new FlxButton();
		buttonRight.loadGraphic('assets/images/mobilecontrols/movementbutton.png');
		buttonRight.x = buttonRight.x + buttonRight.width;
		buttonRight.antialiasing = false;
		buttonRight.color = FlxColor.RED;
		buttonRight.alpha = 0;
		buttonRight.flipX = true;
		add(buttonRight);
   	}
	
	override function update(elapsed:Float):Void{
		super.update(elapsed);
		
		if(buttonLeft.pressed){
			left = true;
			buttonLeft.alpha = 0.1;
		} else {
			left = false;
			buttonLeft.alpha = 0;
		}
		
		if(buttonRight.pressed){
			right = true;
			buttonRight.alpha = 0.1;
		} else {
			right = false;
			buttonRight.alpha = 0;
		}
	}
}