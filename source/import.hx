import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import kindblastr.game.PlayState;
import kindblastr.game.player.Hat;
import kindblastr.game.player.Player;
import kindblastr.helpers.Utilities;
import openfl.display.Sprite;


#if android
import kindblastr.controls.MobileControls;
#end

#if desktop
import kindblastr.controls.PcControls;
#end
