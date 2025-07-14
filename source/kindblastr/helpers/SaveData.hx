package kindblastr.helpers;

class SaveData{
	public static var savedColor:FlxColor = 0xFF000000;
    public static var savedHat:String = '';
    
	public static function load():Void
	{      
		if (FlxG.save.data.savedColor != null)
		{
			savedColor = FlxG.save.data.savedColor;
		}
		else
		{
			savedColor = FlxColor.YELLOW;
		}  
        
        if(FlxG.save.data.savedHat != null) {
            savedHat = FlxG.save.data.savedHat;
        } else {
            savedHat = 'Bald';
        }
        
        trace('Loaded Save Data');
    }
    
    public static function save():Void{
		FlxG.save.data.savedColor = savedColor;

        FlxG.save.data.savedHat = savedHat;
           
        FlxG.save.flush();
        
        trace('Saved Save Data');
    }   
}