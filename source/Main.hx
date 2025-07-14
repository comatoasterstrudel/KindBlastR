package;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(960, 540, MenuState));
		#if desktop
		FlxG.mouse.visible = false;
		#end
		SaveData.load();
	}
}
