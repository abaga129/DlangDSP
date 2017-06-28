module ddsp.util.functions;

import std.math;
import core.stdc.stdlib;
import std.conv : emplace;

float floatToDecibel(float value) nothrow @nogc
{
  return 20 * log(value);  
}

float dedibelToFloat(float value) nothrow @nogc
{
  return pow(10, value/20);
}

float msToSamples(float ms, float sampleRate) nothrow @nogc
{
  return ms * (sampleRate / 1000);
}

float samplesToMs(float samples, float sampleRate) nothrow @nogc
{
  return samples / (1000 / sampleRate);
}

float lagrpol(float[] arrX, float [] arrY, int order, float input)
{
  float sum = 0;
  for(int i = 0; i < order; ++i)
  {
    float Lg = 1.0f;
    for(int j = 0; j < order; ++j)
    {
      if (i != j)
        Lg *= (input - arrX[j])/(arrX[i] - arrX[j]);
    }
    sum += Lg * arrY[i];
  }
  return sum;
}

unittest
{
  import std.stdio;

  float[] x = [1,3,5,12];
  float[] y = [6,3,2,8];

  writefln("Functions test..");
  writefln("x: %s", x);
  writefln("y: %s", y);
  writefln("Lagrange x = 11.999: %s", lagrpol(x, y, 4, 11.999));
}