

(
SynthDef( 'funsynth' , {
	arg pitch = 200;
	var sound = SinOsc.ar(pitch, mul:0.2);
	var linen = Env.linen(0.01, sustainTime:0, releaseTIme:1);
	var env = EnvGen.kr(linen, doneAction:2);
	Out.ar(0, sound * env);
} ).add;
)

NetAddr.localAddr

(
OSCdef( \starlistener ,  {
	Synth( 'funsynth' , [pitch:50.rrand(600) ] );
} , "/starhit" );
)


/*NetAddr.localAddr
NetAddr.langPort*/