package kindblastr.menu;

class MenuState extends FlxState
{
    /**
	 * the sprite for the bg.
	 */
	var bg:FlxSprite;
    
	var bgBottom:FlxBackdrop;

	var bgTop:FlxBackdrop;

	var bgCoverup:FlxSprite;
    
    /**
     * the games logo!!
     */
	var logoSprites:Array<FlxSprite> = [];

	var logoBg:Array<FlxSprite> = [];
    
    /**
     * which options are available on this menu
     */
    var menuOptions:Array<String> = ['Play', 'Customize'];
    
    /**
     * is the menu busy now?
     */
    var busy:Bool = false;
    
    #if desktop
    /**
     * the array of texts
     */
    var menuText:Array<FlxText> = [];
    
    /**
     * which option is selected
     */
    var curSelected:Int = 0;
    #end
    
    #if android
    var menuButtons:Array<FlxButton> = [];
	var menuText:Array<FlxText> = [];
    #end
    
    public function new():Void{
        super();
        
        #if desktop
        menuOptions.push('Exit');
        #end
        
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFFFFEC2);
		add(bg);
        
		bgBottom = new FlxBackdrop('assets/images/menu/bgbottom.png');
		bgBottom.screenCenter(X);
		bgBottom.velocity.y = 10;
		add(bgBottom);

		bgTop = new FlxBackdrop('assets/images/menu/bgtop.png');
		bgTop.screenCenter(X);
		bgTop.velocity.y = 30;
		add(bgTop);

		bgCoverup = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFFFF9D5);
		bgCoverup.alpha = .5;
		add(bgCoverup);

		for (i in 0...3)
		{
			var logo = new FlxSprite().loadGraphic('assets/images/menu/logobg.png');
			logo.antialiasing = false;
			logo.screenCenter(X);
			logo.y = 20;
			add(logo);

			switch (i)
			{
				case 0:
					logo.color = 0xFFFDC033;
					logo.y += 30;
				case 1:
					logo.color = 0xFFF9CC64;
					logo.y += 20;
				case 2:
					logo.color = 0xFFFFEEC7;
					logo.y += 10;
			}

			FlxTween.tween(logo, {y: logo.y + (10 * (3 - i))}, 2.5, {ease: FlxEase.smootherStepInOut, type: PINGPONG});
		}

		for (i in 0...10)
		{
			var logo = new FlxSprite().loadGraphic('assets/images/menu/logo' + (i + 1) + '.png');
			logo.antialiasing = false;
			logo.screenCenter(X);
			logo.y = 35;
			add(logo);
			logoSprites.push(logo);

			logo.y -= 5;

			FlxTween.tween(logo, {y: logo.y + 10}, 1, {startDelay: .1 * (i), ease: FlxEase.smootherStepInOut, type: PINGPONG});
		}
        
        #if desktop
        for(i in 0...menuOptions.length){
            var text = new FlxText(0,0,0,menuOptions[i], 40);
            text.setFormat('assets/fonts/andy.ttf', 40);
			text.color = FlxColor.ORANGE;
            text.screenCenter(X);
            text.y = 300 + (50 * i);
            text.ID = i;
            add(text);
            menuText.push(text);
        }
        changeSelection();
        #end
        
        #if android        
        for(i in 0...menuOptions.length){
			var button = new FlxButton(0, 300 + (100 * i), '', function():Void
			{
                if(!busy) makeSelection(menuOptions[i]);
            });
			button.loadGraphic('assets/images/mobilecontrols/mobilebutton.png');
			button.screenCenter(X);
            add(button);

            menuButtons.push(button);
			var text = new FlxText(0, 0, 0, menuOptions[i], 40);
			text.setFormat('assets/fonts/andy.ttf', 40);
			text.color = FlxColor.ORANGE;
			text.screenCenter(X);
			text.y = button.y + button.height / 2 - text.height / 2;
			text.ID = i;
			add(text);
			menuText.push(text);
        }
        #end                    
    }
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);
        
        #if desktop
        if(!busy){
            if(PcControls.getControl('UP', 'RELEASE')){
                changeSelection(-1);
            }
            
            if(PcControls.getControl('DOWN', 'RELEASE')){
                changeSelection(1);
            }
            
            if(PcControls.getControl('ACCEPT', 'RELEASE')){
                makeSelection(menuOptions[curSelected]);
            }   
        }
        #end
    }
    
    #if desktop 
    function changeSelection(amount:Int = 0):Void{
        curSelected += amount;
        
        if(curSelected >= menuOptions.length) curSelected = 0;
        if(curSelected < 0) curSelected = menuOptions.length - 1;
        
		if (amount != 0)
		{
			FlxG.sound.play('assets/sounds/uiscroll.ogg', 0.5).persist = true;
		}
        
        for(i in menuText){
			if (i.ID == curSelected)
				i.alpha = 1;
			else
				i.alpha = .4;
        }
    }
    #end
    
    function makeSelection(buttonSelected:String):Void{
		FlxG.sound.play('assets/sounds/uiselect.ogg').persist = true;
        
        switch(buttonSelected){
            case 'Play':
                FlxG.switchState(PlayState.new);
            case 'Customize':
                busy = true;
				persistentDraw = true;
				persistentUpdate = true;

				#if desktop
				for (i in menuText)
				{
					i.visible = false;
				}
				#end

				#if android
				for (i in menuButtons)
				{
					i.visible = false;
				}

				for (i in menuText)
				{
					i.visible = false;
				}
				#end
                
				openSubState(new CustomizeSubState(function():Void
				{
					busy = false;
					#if desktop
					for (i in menuText)
					{
						i.visible = true;
					}
					#end

					#if android
					for (i in menuButtons)
					{
						i.visible = true;
					}

					for (i in menuText)
					{
						i.visible = true;
					}
					#end
				}));
            #if desktop
            case 'Exit':
                Sys.exit(0);
            #end
        }
    }
}