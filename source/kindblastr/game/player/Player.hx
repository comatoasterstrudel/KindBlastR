package kindblastr.game.player;

class Player extends FlxSprite
{
    /**
	 * player speed. you can change this!
	 */
	public var speed:Float = 200;
    
    var targetedAngle:Float = 0;
    
	var movedBefore:Bool = false;
    
    public function new():Void{
        super();
        
        loadGraphic('assets/images/player/player.png');
        scale.set(2,2);
        updateHitbox();
        antialiasing = false;
        screenCenter(X);
		y = FlxG.height - 150;
		color = SaveData.savedColor;
    }
    
    /**
     * call this to move the player
     * @param left mvoing left?
     * @param right moving right?
     */
    public function movePlayer(left:Bool, right:Bool):Void{
		movedBefore = true;
        
        velocity.x = 0;
        
		if(left && !right){
			velocity.x = -speed;
            flipX = false;
		}
		
		if(right && !left){
			velocity.x = speed;
            flipX = true;
		}
	}
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);
        
		if (movedBefore)
		{
			if (velocity.x == 0)
			{
				targetedAngle = Utilities.lerpThing(targetedAngle, 0, elapsed, 5);
			}
			else
			{
				if (flipX)
				{
					targetedAngle = Utilities.lerpThing(targetedAngle, 10, elapsed, 5);
				}
				else
				{
					targetedAngle = Utilities.lerpThing(targetedAngle, -10, elapsed, 5);
				}
			}

			angle = targetedAngle; 
        }
    }
}