package kindblastr.helpers;

/**
 * A class that has basic functions that makes other code easier to write. - Coma
 */
class Utilities
{
	public static function clamp(value:Float, min:Float, max:Float):Float
	{
		return value < min ? min : (value > max ? max : value);
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}

	public static function lerpThing(initialnum:Float, target:Float, elapsed:Float, speed:Float = 15):Float
	{
		return FlxMath.lerp(target, initialnum, Utilities.boundTo(1 - (elapsed * speed), 0, 1));
	}
}