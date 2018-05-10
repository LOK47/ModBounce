/*Welcome to the M O D B O U N C E sound engine. Each synth and pattern is the result of much experimentation, with the aid of various tutorials and examples.

Credit to: Eli Fieldsteel, for sharing his extensive knowledge and expertise. All of the
following sounds are modifcations of his YouTube tutorials! :)

** Open MODBOUNCE in Processing as this will ensure sound is gated

** Evaluate all code individually and in consecutive order. I cannot guarantee it will work otherwise! */



//1. initialize global variables
(
   ~out = 0;
   ~path = PathName(thisProcess.nowExecutingPath).parentPath++"buffers/";

)


//2. define piece-specific functions
(
	b = Dictionary.new;
	PathName(~path).entries.do{
		arg subfolder;
		b.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					Buffer.read(s, subfolder.entries[i].fullPath);
				}
			)
		);
	};

)

NetAddr.localAddr;


//3. SynthDefs

(
SynthDef.new(\bpfsaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1),
	freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2,
	lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
	sig = Saw.ar(freq * {LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;


SynthDef.new(\Sinetone, {
	arg freq=40, nharm=12, detune=0.2, gate=0,
	pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05, 0.1, 0.5, 3), gate);
	sig = Blip.ar(freq * LFNoise1.kr(0.2!16).bipolar(detune.neg,detune).midiratio, nharm);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef.new(\bpfbuf, {
	arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
	buf=0, rate=1, spos=0, freq=440, rq=1, bpfmix=0,
	pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf),startPos:spos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig * env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;

SynthDef.new(\bpfbuf2, {
	arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
	buf=0, rate=1, spos=0, freq=440, rq=1, bpfmix=0,
	pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf),startPos:spos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig * env;
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2);
	Out.ar(out, sig);
}).add;
);




//4. Reverb bus and synth
(
   ~reverbBus = Bus.audio(s, 2);

)

(
r = Synth.new(\reverb, [\in, ~reverbBus2], s, \addToTail);


//5a. Pad1 synth + OSC messages

x = Synth.new(\Sinetone, [\out, 0], s);

OSCdef.new(
	\pad1GATE, {
		arg msg, time, addr, port;
		x.set(\gate, msg[1]);
	}, "/pad1GATE"
);

OSCdef.new(
	\pad1FREQ, {
		arg msg, time, addr, port;
		x.set(\freq, msg[1]);
	}, "/pad1FREQ"
);

OSCdef.new(
	\pad1DETUNE, {
		arg msg, time, addr, port;
		x.set(\detune, [msg[1]]);
	}, "/pad1DETUNE"
);

OSCdef.new(
	\pad1HARMONICS, {
		arg msg, time, addr, port;
		x.set(\nharm, msg[1]);
	}, "/pad1HARMONICS"
);

OSCdef.new(
	\pad1AMP, {
		arg msg, time, addr, port;
		x.set(\amp, msg[1]);
	}, "/pad1AMP"
);


//5b. Pad2 pattern + OSC messages

y = Synth.new(\bpfsaw, [\gate, 1, \out, 0], s);

	Pbindef(\chords,
			\instrument, \bpfsaw,
			\dur, Pwhite(4.5,7.0),
			\midinote, Pxrand([
				[23,35,54,63,64],
				[45,52,54,59,61,64],
				[28,40,47,56,59,63],
				[42,52,57,61,63]
			], inf),
			\ctranspose, -3,
	        \stretch, 0.5,
			\detune, 0,
			\cfmin, 100,
			\cfmax, 1500,
			\rqmin, Pexprand(0.01,0.15),
			\atk, Pwhite(2.0,2.5),
			\rel, Pwhite(6.5,10.0),
			\ldb, 6,
			\out, 0,
		);


OSCdef.new(
	\pad2OPENGATE, {
		Pbindef(\chords).play;
	}, "/pad2OPENGATE"
);

OSCdef.new(
	\pad2CLOSEGATE, {
		Pbindef(\chords).stop;
	}, "/pad2CLOSEGATE"
);

OSCdef.new(
	\pad2TRANSPOSE, {
		arg msg;
		Pbindef(\chords, \ctranspose, msg[1]);
	}, "/pad2TRANSPOSE"
);

OSCdef.new(
	\pad2STRETCH, {
		arg msg;
		Pbindef(\chords, \stretch, msg[1]);
	}, "/pad2STRETCH"
);

OSCdef.new(
	\pad2DETUNE, {
		arg msg;
		Pbindef(\chords, \detune, msg[1]);
	}, "/pad2DETUNE"
);

OSCdef.new(
	\pad2AMP, {
		arg msg, time, addr, port;
		Pbindef(\chords, \amp, msg[1]);
	}, "/pad2AMP"
);




//5c. Pad3 pattern + OSC messages

Pbindef(\clicks,
		\instrument, \bpfbuf2,
		\dur, Pseq([1/9], inf),
		\stretch, 1.872,
		\buf, Prand(b[\clicks], inf),
		\rate, 0.5,
		\amp, Pseq([0.5, Pexprand(0.005, 0.2, 7)], inf),
		\out, 0,
	);

OSCdef.new(
	\pad3OPENGATE, {
		Pbindef(\clicks).play;
	}, "/pad3OPENGATE"
);

OSCdef.new(
	\pad3CLOSEGATE, {
		Pbindef(\clicks).stop;
	}, "/pad3CLOSEGATE"
);

OSCdef.new(
	\pad3STRETCH, {
		arg msg;
		Pbindef(\clicks, \stretch, msg[1]);
	}, "/pad3STRETCH"
);

OSCdef.new(
	\pad3DURATION, {
		arg msg;
		Pbindef(\clicks, \dur, Pseq([1/msg[1]], inf));
	}, "/pad3DURATION"
);

OSCdef.new(
	\pad3RATE, {
		arg msg;
		Pbindef(\clicks, \rate, msg[1]);

	}, "/pad3RATE"
);

OSCdef.new(
	\pad3AMP, {
		arg msg, time, addr, port;
		Pbindef(\clicks, \amp, msg[1]);
	}, "/pad3AMP"
);



//5d. Pad 4 pattern + OSC messages

	Pbindef(\rhythm,
		\instrument, \bpfbuf,
		\dur, Pseq([1/9], inf),
		\stretch, 1.872,
		\buf, Prand(b[\percs], inf),
		\rate, 0.5,
		\amp, Pseq([0.5, Pexprand(0.005, 0.2, 7)], inf),
		\out, 0,
	);

OSCdef.new(
	\pad4OPENGATE, {
		Pbindef(\rhythm).play;
	}, "/pad4OPENGATE"
);

OSCdef.new(
	\pad4CLOSEGATE, {
		Pbindef(\rhythm).stop;
	}, "/pad4CLOSEGATE"
);

OSCdef.new(
	\pad4STRETCH, {
		arg msg;
		Pbindef(\rhythm, \stretch, msg[1]);
	}, "/pad4STRETCH"
);

OSCdef.new(
	\pad4DURATION, {
		arg msg;
		Pbindef(\rhythm, \dur, Pseq([1/msg[1]], inf));
	}, "/pad4DURATION"
);

OSCdef.new(
	\pad4RATE, {
		arg msg;
		Pbindef(\rhythm, \rate, msg[1]);

	}, "/pad4RATE"
);

OSCdef.new(
	\pad4AMP, {
		arg msg, time, addr, port;
		Pbindef(\rhythm, \amp, msg[1]);
	}, "/pad4AMP"
);
)

