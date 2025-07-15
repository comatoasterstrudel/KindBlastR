package kindblastr.game.weapons;

class BlasterWeapon extends FlxSprite{    
    /**
     * the player to follow
     */
    var player:Player;
    
    /**
     * which side the weapon is on
     */
    var side:Bool = false; //false = left, true = right
    
    var snapped:Bool = false;
    
    public function new(player:Player, side:Bool):Void{
        super();
        
        this.player = player;
        this.side = side;

        loadGraphic('assets/images/player/weapons/hand.png');
        scale.set(2,2);
        updateHitbox();
        antialiasing = false;     
        color = player.color;   
        
        flipX = !side;
    }
    
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
        
        var desiredX:Float = 0;
        var desiredY:Float = 0;
                
        desiredY = player.y;
        desiredX = player.x + player.width / 2 - width / 2;
        
        if(side) desiredX += 100; else desiredX -= 100;
        
        if(!snapped){
            snapped = true;
            setPosition(desiredX, desiredY);            
        }
        
        x = Utilities.lerpThing(x, desiredX, elapsed, 5);
        y = Utilities.lerpThing(y, desiredY, elapsed, 5);
    }
}