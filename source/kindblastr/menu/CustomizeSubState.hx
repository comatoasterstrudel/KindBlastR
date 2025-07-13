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
    
    var customizeText:FlxText;
    
    #if desktop
    /**
     * which option is selected on the main menu
     */
    var mainCurSelected:Int = 0;
    
    /**
     * hat customize sprite
     */
    var colorsSprite:FlxSprite;
    
    /**
     * hat customize sprite
     */
    var hatsSprite:FlxSprite;
    #end
    
    /**
     * the function to run when you leave the menu
     */
    var endFunction:Void->Void;
    
    public function new(endFunction:Void->Void):Void{
        super();
        
        this.endFunction = endFunction;
        
        fadeSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        fadeSprite.alpha = .9;
        add(fadeSprite);
        
        customizeText = new FlxText(0,0,0,'Customize what?', 40);
        customizeText.setFormat('assets/fonts/andy.ttf', 40, FlxColor.WHITE);
        customizeText.screenCenter(X);
        customizeText.y = 20;
        add(customizeText);
            
        #if desktop
        colorsSprite = new FlxSprite().loadGraphic('assets/images/menu/customize/colorchange.png');
        colorsSprite.scale.set(2,2);
        colorsSprite.antialiasing = false;
        colorsSprite.screenCenter();
        colorsSprite.y += 30;
        colorsSprite.x -= 200;
        add(colorsSprite);
        
        hatsSprite = new FlxSprite().loadGraphic('assets/images/menu/customize/hatchange.png');
        hatsSprite.scale.set(2,2);
        hatsSprite.antialiasing = false;
        hatsSprite.screenCenter();
        hatsSprite.y += 30;
        hatsSprite.x += 200;
        add(hatsSprite);
        #end
    }
    
    override function update(elapsed:Float):Void{
        super.update(elapsed);
        
        #if desktop
        switch(curMenu){
            case 'main':
                if(PcControls.getControl('LEFT', 'RELEASE') || PcControls.getControl('RIGHT', 'RELEASE')){
                    //changeSelection();
                }
                if(PcControls.getControl('BACK', 'RELEASE')){
                    leave();
                }
        }
        #end
    }
    
    function leave():Void{
        close();
        endFunction();
    }
}