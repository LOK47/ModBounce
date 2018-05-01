

(
SynthDef( 'funsynth' , {
	arg pitch = 200;
	var sound = SinOsc.ar(pitch, mul:0.2);
	var linen = Env.linen(0.01, sustainTime:0, releaseTIme:1);
	var env = EnvGen.kr(linen, doneAction:2);
	Out.ar(1, Pan2.ar(sound * env, 0, 1)
	);

} ).add;
)

NetAddr.localAddr

(
OSCdef( \starlistener ,  {
	Synth( 'funsynth' , [pitch:50.rrand(600) ] );
} , "/starhit" );
)


(
	SynthDef('fullkickdrum', {

		var subosc, subenv, suboutput, clickosc, clickenv, clickoutput;
	    var pitch;

		subosc = {SinOsc.ar(pitch)};
		subenv = {Env.perc(0.01, 1, 1, -4)};

		clickosc = {LPF.ar(WhiteNoise.ar(1),1500)};
		clickenv = {Line.ar(1, 0, 0.02)};

		suboutput = (subosc * subenv);
		clickoutput = (clickosc * clickenv);

		Out.ar(0,
			Pan2.ar(suboutput + clickoutput, 0, 1)
		)

	}).add;
)

   t = Synth('fullkickdrum');
pitch = OSCFunc

(
OSCdef( \kickdrum ,  {
	Synth( 'fullkickdrum' , [pitch:60] );
} , "/kickdrum" );
)