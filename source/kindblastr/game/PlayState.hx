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
	
	var exitButton:FlxButton;

		
	override public function create()
	{
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		add(bg);
		
		player = new Player();
		add(player);
		
		hat = new Hat(SaveData.savedHat, player);
		add(hat);
		
		#if android
		mobileControls = new MobileControls();
		add(mobileControls);
		
		exitButton = new FlxButton(0, 0, function():Void
		{
			leaveGame();
		});
		exitButton.loadGraphic('assets/images/mobilecontrols/exit.png');
		exitButton.updateHitbox();
		exitButton.antialiasing = false;
		exitButton.y = 2;
		exitButton.x = FlxG.width - exitButton.width - 2;
		exitButton.alpha = .3;
		add(exitButton);
		#end
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		#if desktop
		player.movePlayer(PcControls.getControl('LEFT', 'HOLD'), PcControls.getControl('RIGHT', 'HOLD'));
		if (PcControls.getControl('BACK', 'RELEASE'))
		{
			leaveGame();
		}
		#end
		
		#if android
		player.movePlayer(mobileControls.left,mobileControls.right);
		#end
		
		super.update(elapsed);
	}
	function leaveGame():Void
	{
		FlxG.switchState(MenuState.new);
	}
}
