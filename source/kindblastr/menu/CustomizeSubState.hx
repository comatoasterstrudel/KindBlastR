package kindblastr.menu;

class CustomizeSubState extends FlxSubState
{
    /**
     * sprite to fade out the background
     */
    var fadeSprite:FlxSprite;
    
    /**
     * which menu this is right now. this can be 'main', 'color', or 'hat'
     */
    var curMenu:String = 'main';
    
	/**
	 * the list of all sprites on the main menu
	 */
	var mainSprites:Array<FlxSprite> = [];

	/**
	 * the list of all sprites on the colors menu
	 */
	var colorSprites:Array<FlxSprite> = [];

	/**
	 * the list of all sprites on the hats menu
	 */
	var hatSprites:Array<FlxSprite> = [];

	/**
	 * the text at the top of the screen
	 */
    var customizeText:FlxText;

	/**
	 * the function to run when you leave the menu
	 */
	var endFunction:Void->Void;

	/**
	 * list of all hats
	 */
	var hatList:Array<String> = ['Bald', 'Basic Cap', 'Rock Cap', 'Whimsy Cap', 'Strand Cap', 'Pizza Cap'];

	/**
	 * the hat sprites on the hat select menu
	 */
	var hats:Array<FlxSprite> = [];

	/**
	 * the player on the hat menu
	 */
	var hatTester:Player;

	/**
	 * which hat you have selected
	 */
	var selectedHat:Int = 0;

	/**
	 * text that shows the description of each hat
	 */
	var hatText:FlxText;
    
	#if desktop
    /**
     * which option is selected on the main menu
     */
	public static var mainCurSelected:Int = 0;
    
    /**
     * hat customize sprite
     */
    var colorsSprite:FlxSprite;
    
    /**
     * hat customize sprite
     */
    var hatsSprite:FlxSprite;
	/**
	 * which option is selected
	 */
	var curSelected:Int = 0;

	/**
	 * list of the sprites
	 */
	var spriteList:Array<FlxSprite> = [];
    #end
    
	#if android
    /**
	 * hat customize sprite
     */
	var colorsButton:FlxButton;

	/**
	 * hat customize sprite
	 */
	var hatButton:FlxButton;

	/**
	 * the mobile back button
	 */
	var backButton:FlxButton;

	var hatLeft:FlxButton;

	var hatRight:FlxButton;
	#end
    
    public function new(endFunction:Void->Void):Void{
        super();
        
        this.endFunction = endFunction;
        
        fadeSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        fadeSprite.alpha = .9;
        add(fadeSprite);

		#if desktop
		colorsSprite = new FlxSprite().loadGraphic('assets/images/menu/customize/colorchange.png');
		colorsSprite.scale.set(2, 2);
		colorsSprite.antialiasing = false;
		colorsSprite.screenCenter();
		colorsSprite.y += 30;
		colorsSprite.x -= 200;
		colorsSprite.ID = 0;
		add(colorsSprite);

		hatsSprite = new FlxSprite().loadGraphic('assets/images/menu/customize/hatchange.png');
		hatsSprite.scale.set(2, 2);
		hatsSprite.antialiasing = false;
		hatsSprite.screenCenter();
		hatsSprite.y += 30;
		hatsSprite.x += 200;
		hatsSprite.ID = 1;
		add(hatsSprite);
		spriteList = [colorsSprite, hatsSprite];

		mainSprites.push(colorsSprite);
		mainSprites.push(hatsSprite);

		changeSelection();
		#end
		hatTester = new Player();
		hatTester.scale.set(4, 4);
		hatTester.updateHitbox();
		hatTester.screenCenter();
		add(hatTester);

		hatSprites.push(hatTester);

		for (i in 0...hatList.length)
		{
			if (SaveData.savedHat == hatList[i])
				selectedHat = i;

			var thing = new Hat(hatList[i], hatTester);
			thing.scale.set(4, 4);
			thing.updateHitbox();
			thing.ID = i;
			add(thing);
			hats.push(thing);
			hatSprites.push(thing);
		}

		hatText = new FlxText(0, 0, 0, 'Customize what?', 40);
		hatText.setFormat('assets/fonts/andy.ttf', 25, FlxColor.WHITE);
		hatText.screenCenter(X);
		hatText.y = 400;
		add(hatText);

		hatSprites.push(hatText);

		changeSelectedHat();

		customizeText = new FlxText(0, 0, 0, 'Customize what?', 40);
		customizeText.setFormat('assets/fonts/andy.ttf', 40, FlxColor.WHITE);
		customizeText.screenCenter(X);
		customizeText.y = 20;
		add(customizeText);

		#if android
		colorsButton = new FlxButton(0, 0, function():Void
		{
			//
		});
		colorsButton.loadGraphic('assets/images/menu/customize/colorchange.png');
		colorsButton.scale.set(1.7, 1.7);
		colorsButton.antialiasing = false;
		colorsButton.screenCenter();
		colorsButton.y += 30;
		colorsButton.x -= 200;
		add(colorsButton);

		hatButton = new FlxButton(0, 0, function():Void
		{
			addHatsMenu();
		});
		hatButton.loadGraphic('assets/images/menu/customize/hatchange.png');
		hatButton.scale.set(1.7, 1.7);
		hatButton.antialiasing = false;
		hatButton.screenCenter();
		hatButton.y += 30;
		hatButton.x += 200;
		add(hatButton);

		mainSprites.push(colorsButton);
		mainSprites.push(hatButton);

		hatLeft = new FlxButton(0, 0, function():Void
		{
			changeSelectedHat(-1);
		});
		hatLeft.loadGraphic('assets/images/mobilecontrols/hatselect.png');
		hatLeft.scale.set(1.5, 1.5);
		hatLeft.updateHitbox();
		hatLeft.antialiasing = false;
		hatLeft.screenCenter();
		hatLeft.x -= 400;
		hatLeft.alpha = .6;
		add(hatLeft);

		hatSprites.push(hatLeft);

		hatRight = new FlxButton(0, 0, function():Void
		{
			changeSelectedHat(1);
		});
		hatRight.loadGraphic('assets/images/mobilecontrols/hatselect.png');
		hatRight.flipX = true;
		hatRight.scale.set(1.5, 1.5);
		hatRight.updateHitbox();
		hatRight.antialiasing = false;
		hatRight.screenCenter();
		hatRight.x += 400;
		hatRight.alpha = .6;
		add(hatRight);

		hatSprites.push(hatRight);

		backButton = new FlxButton(0, 0, function():Void
		{
			switch (curMenu)
			{
				case 'main':
					leave();
				case 'hat':
					addMainMenu();
			}
		});
		backButton.loadGraphic('assets/images/mobilecontrols/exit.png');
		backButton.scale.set(1.5, 1.5);
		backButton.updateHitbox();
		backButton.antialiasing = false;
		backButton.y = FlxG.height - backButton.height - 5;
		backButton.x = FlxG.width - backButton.width - 5;
		backButton.alpha = .6;
		add(backButton);
		#end
		addMainMenu();
    }
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);
        
        #if desktop
        switch(curMenu){
            case 'main':
				if (PcControls.getControl('LEFT', 'RELEASE'))
				{
					changeSelection(-1);
				}
				if (PcControls.getControl('RIGHT', 'RELEASE'))
				{
					changeSelection(1);
				}
				if (PcControls.getControl('ACCEPT', 'RELEASE'))
				{
					switch (curSelected)
					{
						case 0:

						case 1:
							addHatsMenu();
					}
                }
                if(PcControls.getControl('BACK', 'RELEASE')){
                    leave();
                }
			case 'hat':
				if (PcControls.getControl('LEFT', 'RELEASE'))
				{
					changeSelectedHat(-1);
				}
				if (PcControls.getControl('RIGHT', 'RELEASE'))
				{
					changeSelectedHat(1);
				}
				if (PcControls.getControl('BACK', 'RELEASE'))
				{
					addMainMenu();
				}
		}
		#end

		#if android
		if (curMenu == 'hat')
		{
			if (selectedHat == 0)
			{
				hatLeft.visible = false;
			}
			else
			{
				hatLeft.visible = true;
			}

			if (selectedHat == hatList.length - 1)
			{
				hatRight.visible = false;
			}
			else
			{
				hatRight.visible = true;
			}
		}
		#end
		if (curMenu == 'hat')
		{
			hatTester.angle = Utilities.lerpThing(hatTester.angle, 0, elapsed, 5);

			for (i in hats)
			{
				i.angle = Utilities.lerpThing(i.angle, 0, elapsed, 5);
			}
		}
	}

	function changeSelectedHat(amount:Int = 0):Void
	{
		if (selectedHat + amount >= hatList.length)
			return;
		if (selectedHat + amount < 0)
			return;

		selectedHat += amount;

		hatTester.angle = 0;

		for (i in hats)
		{
			i.angle = 0;

			if (i.ID == selectedHat)
			{
				i.visible = true;

				if (amount != 0)
				{
					if (amount > 0)
					{
						i.angle = 20;
						hatTester.angle = 20;
					}
					else
					{
						i.angle = -20;
						hatTester.angle = -20;
					}
				}
			}
			else
			{
				i.visible = false;
			}
		}

		SaveData.savedHat = hatList[selectedHat];

		switch (hatList[selectedHat])
		{
			case 'Bald':
				hatText.text = '- Bald -\nYour true self.. but it\'s okay to express yourself, too!';
				hatText.color = FlxColor.YELLOW;
			case 'Basic Cap':
				hatText.text = '- Basic Cap -\nA nice red hat. Simple but pleasing!';
				hatText.color = FlxColor.RED;
			case 'Rock Cap':
				hatText.text = '- Rock Cap -\nYour best friend!!';
				hatText.color = FlxColor.GRAY;
			case 'Whimsy Cap':
				hatText.text = '- Whimsy Cap -\nHow joyous!';
				hatText.color = FlxColor.PURPLE;
			case 'Strand Cap':
				hatText.text = '- Strand Cap -\nYou know youre supposed to keep your hat on! You\'ll catch cold!';
				hatText.color = FlxColor.WHITE;
			case 'Pizza Cap':
				hatText.text = '- Pizza Cap -\nDoesn\'t look like any other pizza hat I\'ve seen..';
				hatText.color = FlxColor.LIME;
		}

		hatText.y = 400;
		hatText.scale.x = 1.1;
		hatText.screenCenter(X);
	}

	#if desktop
	function changeSelection(amount:Int = 0):Void
	{
		curSelected += amount;

		if (curSelected >= spriteList.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = spriteList.length - 1;

		for (i in spriteList)
		{
			if (i.ID == curSelected)
				i.alpha = 1;
			else
				i.alpha = .2;
		}
	}
	#end
	/**
	 * call this to add the main menu
	 */
	function addMainMenu():Void
	{
		curMenu = 'main';

		for (i in mainSprites)
		{
			i.visible = true;
		}

		for (i in colorSprites)
		{
			i.visible = false;
		}

		for (i in hatSprites)
		{
			i.visible = false;
		}

		customizeText.text = 'Customize what?';
		customizeText.screenCenter(X);
	}

	/**
	 * call this to add the main menu
	 */
	function addHatsMenu():Void
	{
		curMenu = 'hat';

		for (i in mainSprites)
		{
			i.visible = false;
		}

		for (i in colorSprites)
		{
			i.visible = false;
		}

		for (i in hatSprites)
		{
			i.visible = true;
		}

		customizeText.text = 'Customize your Hat!';
		customizeText.screenCenter(X);

		changeSelectedHat();
	}
    
    function leave():Void{
		SaveData.save();
        close();
        endFunction();
    }
}