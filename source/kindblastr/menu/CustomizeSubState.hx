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
	var hatList:Array<String> = [
		'Bald',
		'Basic Cap',
		'Rock Cap',
		'Whimsy Cap',
		'Strand Cap',
		'Pizza Cap',
		'Cotton Cap'
	];

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
    
	/**
	 * the player who tries on some new colors
	 */
	var colorTester:Player;

	/**
	 * the list of available colors
	 */
	var colorList:Array<FlxColor> = [
		FlxColor.YELLOW,
		FlxColor.ORANGE,
		FlxColor.RED,
		FlxColor.PURPLE,
		FlxColor.PINK,
		FlxColor.BLUE,
		FlxColor.CYAN,
		FlxColor.GREEN,
		FlxColor.LIME,
		FlxColor.WHITE,
		FlxColor.GRAY,
	];

	/**
	 * which color you have selected
	 */
	var selectedColor:Int = 0;

	/**
	 * the text that shows the description of your color
	 */
	var colorText:FlxText;

	var splatSound:FlxSound;

	var clotheSound:FlxSound;
	
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
	var colorLeft:FlxButton;

	var colorRight:FlxButton;
	#end
    
	var busy:Bool = false;
	
    public function new(endFunction:Void->Void):Void{
        super();
        
        this.endFunction = endFunction;
        
        fadeSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        fadeSprite.alpha = .9;
        add(fadeSprite);

		#if desktop
		busy = true;
		new FlxTimer().start(.1, function(f):Void
		{
			busy = false;
		});
		
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

		for (i in 0...colorList.length)
		{
			if (SaveData.savedColor == colorList[i])
			{
				selectedColor = i;
			}
		}

		colorTester = new Player();
		colorTester.scale.set(4, 4);
		colorTester.updateHitbox();
		colorTester.screenCenter();
		add(colorTester);
		colorSprites.push(colorTester);

		colorText = new FlxText(0, 0, 0, 'Customize what?', 40);
		colorText.setFormat('assets/fonts/andy.ttf', 25, FlxColor.WHITE);
		colorText.screenCenter(X);
		colorText.y = 400;
		add(colorText);
		colorSprites.push(colorText);

		changeSelectedColor();
		
		customizeText = new FlxText(0, 0, 0, 'Customize what?', 40);
		customizeText.setFormat('assets/fonts/andy.ttf', 40, FlxColor.WHITE);
		customizeText.screenCenter(X);
		customizeText.y = 20;
		add(customizeText);

		#if android
		colorsButton = new FlxButton(0, 0, function():Void
		{
			addColorsMenu();
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

		colorLeft = new FlxButton(0, 0, function():Void
		{
			changeSelectedColor(-1);
		});
		colorLeft.loadGraphic('assets/images/mobilecontrols/hatselect.png');
		colorLeft.scale.set(1.5, 1.5);
		colorLeft.updateHitbox();
		colorLeft.antialiasing = false;
		colorLeft.screenCenter();
		colorLeft.x -= 400;
		colorLeft.alpha = .6;
		add(colorLeft);

		colorSprites.push(colorLeft);

		colorRight = new FlxButton(0, 0, function():Void
		{
			changeSelectedColor(1);
		});
		colorRight.loadGraphic('assets/images/mobilecontrols/hatselect.png');
		colorRight.flipX = true;
		colorRight.scale.set(1.5, 1.5);
		colorRight.updateHitbox();
		colorRight.antialiasing = false;
		colorRight.screenCenter();
		colorRight.x += 400;
		colorRight.alpha = .6;
		add(colorRight);

		colorSprites.push(colorRight);

		backButton = new FlxButton(0, 0, function():Void
		{
			FlxG.sound.play('assets/sounds/uiback.ogg', .35).persist = true;

			switch (curMenu)
			{
				case 'main':
					leave();
				case 'hat' | 'color':
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
		if (!busy)
		{
			switch (curMenu)
			{
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
						switch (mainCurSelected)
						{
							case 0:
								addColorsMenu();
							case 1:
								addHatsMenu();
						}
					}
					if (PcControls.getControl('BACK', 'RELEASE'))
					{
						FlxG.sound.play('assets/sounds/uiback.ogg', .35).persist = true;
						leave();
					}
				case 'color':
					if (PcControls.getControl('LEFT', 'RELEASE'))
					{
						changeSelectedColor(-1);
					}
					if (PcControls.getControl('RIGHT', 'RELEASE'))
					{
						changeSelectedColor(1);
					}
					if (PcControls.getControl('BACK', 'RELEASE'))
					{
						FlxG.sound.play('assets/sounds/uiback.ogg', .35).persist = true;
						addMainMenu();
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
						FlxG.sound.play('assets/sounds/uiback.ogg', .35).persist = true;
						addMainMenu();
					}
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
		if (curMenu == 'color')
		{
			if (selectedColor == 0)
			{
				colorLeft.visible = false;
			}
			else
			{
				colorLeft.visible = true;
			}

			if (selectedColor == colorList.length - 1)
			{
				colorRight.visible = false;
			}
			else
			{
				colorRight.visible = true;
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
		if (curMenu == 'color')
		{
			colorTester.angle = Utilities.lerpThing(colorTester.angle, 0, elapsed, 5);
		}
	}

	function changeSelectedColor(amount:Int = 0):Void
	{
		if (selectedColor + amount >= colorList.length)
			return;
		if (selectedColor + amount < 0)
			return;

		selectedColor += amount;

		colorTester.angle = 0;

		if (amount != 0)
		{
			if (splatSound != null && splatSound.active)
				splatSound.pause();

			splatSound = FlxG.sound.play('assets/sounds/splat.ogg', .4);
			splatSound.pitch = FlxG.random.float(.7, 1.3);

			if (amount > 0)
			{
				colorTester.angle = 20;
			}
			else
			{
				colorTester.angle = -20;
			}
		}

		SaveData.savedColor = colorList[selectedColor];

		switch (colorList[selectedColor])
		{
			case FlxColor.YELLOW:
				colorText.text = '- Yellow -\nYour true self.. but it\'s okay to express yourself, too!';
			case FlxColor.ORANGE:
				colorText.text = '- Orange -\nLike the food.';
			case FlxColor.RED:
				colorText.text = '- Red -\nAngry, are you?!';
			case FlxColor.WHITE:
				colorText.text = '- White -\n255 255 255';
			case FlxColor.PURPLE:
				colorText.text = '- Violet -\nYou\'re turning violet, Violet!';
			case FlxColor.BLUE:
				colorText.text = '- Blue -\nWater.. so nice!';
			case FlxColor.CYAN:
				colorText.text = '- Cyan -\nIs it green or blue?';
			case FlxColor.GREEN:
				colorText.text = '- Green -\nNo green?';
			case FlxColor.LIME:
				colorText.text = '- Lime -\nLike the food.';
			case FlxColor.PINK:
				colorText.text = '- Pink -\nReminds me of someone..';
			case FlxColor.GRAY:
				colorText.text = '- Gray -\nYour color.. it\'s fading!';
		}

		colorText.color = colorList[selectedColor];

		colorTester.color = colorList[selectedColor];

		SaveData.savedColor = colorList[selectedColor];

		colorText.y = 400;
		colorText.scale.x = 1.1;
		colorText.screenCenter(X);
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
					if (clotheSound != null && clotheSound.active)
						clotheSound.pause();

					clotheSound = FlxG.sound.play('assets/sounds/clothes.ogg');
					clotheSound.pitch = FlxG.random.float(.7, 1.3);
			
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
				hatText.color = SaveData.savedColor;
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
			case 'Cotton Cap':
				hatText.text = '- Cotton Cap -\nReminds me of someone..';
				hatText.color = FlxColor.PINK;

		}

		hatText.y = 400;
		hatText.scale.x = 1.1;
		hatText.screenCenter(X);
	}

	#if desktop
	function changeSelection(amount:Int = 0):Void
	{
		mainCurSelected += amount;

		if (mainCurSelected >= spriteList.length)
			mainCurSelected = 0;
		if (mainCurSelected < 0)
			mainCurSelected = spriteList.length - 1;

		for (i in spriteList)
		{
			if (i.ID == mainCurSelected)
				i.alpha = 1;
			else
				i.alpha = .2;
		}
		if (amount != 0)
		{
			FlxG.sound.play('assets/sounds/uiscroll.ogg', 0.5).persist = true;
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
	 * call this to add the colors menu
	 */
	function addColorsMenu():Void
	{
		FlxG.sound.play('assets/sounds/uiselect.ogg', 1).persist = true;

		curMenu = 'color';

		for (i in mainSprites)
		{
			i.visible = false;
		}

		for (i in colorSprites)
		{
			i.visible = true;
		}

		for (i in hatSprites)
		{
			i.visible = false;
		}

		customizeText.text = 'Customize your Color!';
		customizeText.screenCenter(X);

		changeSelectedColor();
	}
	
	/**
	 * call this to add the main menu
	 */
	function addHatsMenu():Void
	{
		FlxG.sound.play('assets/sounds/uiselect.ogg', 1).persist = true;
		
		hatTester.color = SaveData.savedColor;
		
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