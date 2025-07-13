package kindblastr.game;

class PlayState extends FlxState
{
	/**
	 * the sprite for the bg. can be different for each level?
	 */
	var bg:FlxSprite;
	
	/**
	 * the player object
	 */
	var player:Player;
	
	/**
	 * your nice hat!
	 */
	var hat:Hat;
	
	#if android
	/**
	 * the controls for mobile version
	 */
	var mobileControls:MobileControls;
	#end
	
	override public function create()
	{
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		add(bg);
		
		player = new Player();
		add(player);
		
		hat = new Hat('Basic Cap', player);
		add(hat);
		
		#if android
		mobileControls = new MobileControls();
		add(mobileControls);
		#end
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		#if desktop
		player.movePlayer(PcControls.getControl('LEFT', 'HOLD'), PcControls.getControl('RIGHT', 'HOLD'));
		#end
		
		#if android
		player.movePlayer(mobileControls.left,mobileControls.right);
		#end
		
		super.update(elapsed);
	}
}
