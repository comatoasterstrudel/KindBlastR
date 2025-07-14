package kindblastr.game.player;

class Hat extends FlxSprite{    
    /**
     * which hat is currently added
     */
    var hatName:String = '';
    
    /**
     * the player to follow
     */
    var player:Player;
    
    var snapped:Bool = false;
    
    var hatOffset:Float = -2;
    
    public function new(hatName:String, player:Player):Void{
        super();
        
        this.hatName = hatName;
        this.player = player;

        loadGraphic('assets/images/player/hats/hat_' + hatName + '.png');
        scale.set(2,2);
        updateHitbox();
        antialiasing = false;
        
        FlxTween.tween(this, {hatOffset: 2}, 3, {ease: FlxEase.smoothStepInOut, type: PINGPONG});
    }
    
    override public function update(elapsed:Float):Void{
        super.update(elapsed);
        
        var offsetX:Float = 0;
        var offsetY:Float = 0;

        offsetY += hatOffset;
        
        if(!snapped){
            snapped = true;
            setPosition(player.x + offsetX, player.y + offsetY);            
        }
        
		this.x = Utilities.lerpThing(this.x, player.x + offsetX, elapsed, 30);
		this.y = Utilities.lerpThing(this.y, player.y + offsetY, elapsed, 30);
		this.angle = player.angle;
    }
}