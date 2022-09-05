import("WindowsAPI");
var stage:Stage = null;
var sprite:FlxSprite;
var shader:CustomShader;
var thing:Float;
var transparency:Bool = true;
function create() {
	stage = loadStage('disability');
	PlayState.insert(0, sprite = new FlxSprite(-650, -100).loadGraphic(Paths.image('disability')));
	if (transparency) {
		WindowsAPI.setWindowTransparencyColor(0, 255, 0, 255);
		sprite.makeGraphic(9000, 9000, 0xff00ff00);
		PlayState.boyfriend.antialiasing = false;
		PlayState.gf.antialiasing = false;
		PlayState.dad.antialiasing = false;
	}
	sprite.scale.set(1.65, 1.65);
	shader = new CustomShader(Paths.shader('disability'));
	shader.data.uSpeed.value = [2.0];
	shader.data.uWaveAmplitude.value = [0.12];
	shader.data.uFrequency.value = [5.0];
	sprite.shader = shader;
	PlayState.dad.y -= 250;
}
var elapsedTime:Float = 0;
function update(elapsed) {
	elapsedTime += elapsed;
	shader.data.time.value = [elapsedTime];
	stage.update(elapsed);
	PlayState.playerStrums.forEach(function(spr:StrumNote)
		{
			if (transparency) spr.antialiasing = false;
			spr.angle += (Math.sin(elapsedTime * 2.5) + 1) * 5;
			spr.set_notesAngle(0);
		});
	PlayState.cpuStrums.forEach(function(spr:StrumNote)
		{
			if (transparency) spr.antialiasing = false;
			spr.angle += (Math.sin(elapsedTime * 2.5) + 1) * 5;
			spr.set_notesAngle(0);
		});
	PlayState.dad.y += (Math.sin(elapsedTime) * 0.5);
	switch (nPos) {
		case 0:
			PlayState.camFollow.x = PlayState.dad.getGraphicMidpoint().x - 45;
			PlayState.camFollow.y = PlayState.dad.getGraphicMidpoint().y;
		case 1:
			PlayState.camFollow.x = PlayState.dad.getGraphicMidpoint().x;
			PlayState.camFollow.y = PlayState.dad.getGraphicMidpoint().y + 45;
		case 2:
			PlayState.camFollow.x = PlayState.dad.getGraphicMidpoint().x;
			PlayState.camFollow.y = PlayState.dad.getGraphicMidpoint().y - 45;
		case 3:
			PlayState.camFollow.x = PlayState.dad.getGraphicMidpoint().x + 45;
			PlayState.camFollow.y = PlayState.dad.getGraphicMidpoint().y;
	}
	switch (nPos2) {
		case 0:
			PlayState.camFollow.x = PlayState.boyfriend.getGraphicMidpoint().x - 45;
			PlayState.camFollow.y = PlayState.boyfriend.getGraphicMidpoint().y;
		case 1:
			PlayState.camFollow.x = PlayState.boyfriend.getGraphicMidpoint().x;
			PlayState.camFollow.y = PlayState.boyfriend.getGraphicMidpoint().y + 45;
		case 2:
			PlayState.camFollow.x = PlayState.boyfriend.getGraphicMidpoint().x;
			PlayState.camFollow.y = PlayState.boyfriend.getGraphicMidpoint().y - 45;
		case 3:
			PlayState.camFollow.x = PlayState.boyfriend.getGraphicMidpoint().x + 45;
			PlayState.camFollow.y = PlayState.boyfriend.getGraphicMidpoint().y;
	}
}
function beatHit(curBeat) {
	stage.onBeat();
}

var nPos:Int;
var nPos2:Int;
function onDadHit(note:Note) {
	nPos2 = 4;
	if (!note.isSustainnote) nPos = note.get_noteDirection();
}
function onPlayerHit(note:Note) {
	nPos = 4;
	if (!note.isSustainnote) nPos2 = note.get_noteDirection();
}