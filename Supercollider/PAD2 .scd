(
SynthDef.new(\sine, {
	arg freq=440, atk=0.005, rel=0.3, amp=1, gate=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0], [atk, rel], [1, -1]), gate);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);

}).add;
)

(
Pbindef(\a,
		\instrument, \sine,
		\dur, Pseq([1/16], inf),
		\stretch, 1.875,
		\note, Pxrand([0,3,5,9,10,12], inf),
		\gtranspose, -1,
		\atk, 0.005,
		\rel, Pexprand(0.01, 0.5, inf),
		\amp, Pexprand(0.05, 0.5,inf),
		\pan, Pwhite(-0.8, 0.8, inf),
).play;
)


y = Synth.new(\sine, [\gate, 1])

(
OSCdef.new(
	\pad2OPENGATE, {

Pbindef(\a).play;

	}, "/pad2OPENGATE"

);

OSCdef.new(
	\pad2CLOSEGATE,

	{


Pbindef(\a).stop;

	}, "/pad2CLOSEGATE"

);

OSCdef.new(
	\pad2TRANSPOSE,

	{
		arg msg;
		Pbindef(\a, \gtranspose, msg[1]);

	}, "/pad2TRANSPOSE"

);
)

