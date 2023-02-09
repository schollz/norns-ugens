(
s.waitForBoot({

	SynthDef("softcut",{
		arg buf, gate=1,
		phase_out= -1, trig_out= -1, trig_in = -1,
		amp=0.2, rec=0.0, pre=0.0,
		rate=1, ratelag=0.1,
		start=0, end=1, fade=0.1, loop=1,
		fadeRec=1.0, fadePre = 1.0, recRun=0, offset=0,
		preLag=0.0005, recLag=0.0005, envTimeScale = 1.0, done=0;

		var snd, phase, tr;
		var brs;
		var cutfade;
		var trig;
		var sin;
		var aenv;

		brs = BufRateScale.kr(buf);

		trig = InTrig.kr(trig_in);
		sin = SinOsc.ar(440)*EnvGen.ar(Env.perc(),Impulse.kr(1));

		pre = Lag.ar(K2A.ar(pre), preLag);
		rec = Lag.ar(K2A.ar(rec), recLag);

		rate = Lag.ar(K2A.ar(rate), ratelag);

		cutfade =  SoftCutHead.ar(buf, sin, trig,
			rate * brs, start, end, fade, loop,
			rec, pre, fadeRec, fadePre, recRun, offset);

		phase = cutfade[0];
		tr = cutfade[1];
		snd = cutfade[2];
		[phase,tr].poll;

		Out.ar(0,snd);

	}).send(s);
	s.sync;
	b=Buffer.alloc(s,s.sampleRate*1,1,{ arg buf;
		x=Synth("softcut",[\buf,buf,\rec,1,\recRun,1,\pre,0.5,\trig_in,1,\start,0,\end,0.25]);
	});
	s.sync;

});
)

// is blank?
b.plot