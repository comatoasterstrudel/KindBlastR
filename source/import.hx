import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import kindblastr.game.PlayState;
import kindblastr.game.player.Hat;
import kindblastr.game.player.Player;
import kindblastr.helpers.SaveData;
import kindblastr.helpers.Utilities;
import kindblastr.menu.CustomizeSubState;
import kindblastr.menu.MenuState;
import openfl.display.Sprite;

#if android
import kindblastr.controls.MobileControls;
#end

#if desktop
import Sys;
import kindblastr.controls.PcControls;
#end
