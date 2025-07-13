package kindblastr.menu;

class MenuState extends FlxState
{
    /**
	 * the sprite for the bg.
	 */
	var bg:FlxSprite;
    
    /**
     * the games logo!!
     */
    var logo:FlxSprite;
    
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
    #end
    
    public function new():Void{
        super();
        
        #if desktop
        menuOptions.push('Exit');
        #end
        
        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
		add(bg);
        
        logo = new FlxSprite().loadGraphic('assets/images/menu/logo.png');
        logo.antialiasing = false;
        logo.screenCenter(X);
        logo.y = 10;
        add(logo);
        
        #if desktop
        for(i in 0...menuOptions.length){
            var text = new FlxText(0,0,0,menuOptions[i], 40);
            text.setFormat('assets/fonts/andy.ttf', 40);
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
            var button = new FlxButton(0,300 + (70 * i), menuOptions[i], function():Void{
                if(!busy) makeSelection(menuOptions[i]);
            });
            button.scale.set(3,3);
            button.updateHitbox();
            button.screenCenter(X);
            button.label.size = 30;
            button.label.font = 'assets/fonts/andy.ttf';
            button.label.fieldWidth = 0;
            button.label.y = button.y + button.height / 2 - button.label.height / 2;
            button.label.x += 50;
            add(button);
            menuButtons.push(button);
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
        
        for(i in menuText){
            if(i.ID == curSelected) i.alpha = 1; else i.alpha = .2;
        }
    }
    #end
    
    function makeSelection(buttonSelected:String):Void{
        switch(buttonSelected){
            case 'Play':
                FlxG.switchState(PlayState.new);
            case 'Customize':
                busy = true;
                
            #if desktop
            case 'Exit':
                Sys.exit(0);
            #end
        }
    }
}