set T := { 1 .. 5 };
set W := { 0 .. 5 };

# Demanda y costo de cada periodo
param d[T] := <1> 10, <2> 10, <3> 10, <4> 10, <5> 10;
param c[T] := <1> 8, <2> 9, <3> 7, <4> 11, <5> 12;

var x[T] >= 0;
var s[W] >= 0;

minimize fobj: sum <t> in T: (c[t] * x[t] + 1.5 * s[t]);

subto defstock: forall <t> in T:
   s[t] == s[t-1] + x[t] - d[t];

subto maxprod: forall <t> in T:
   x[t] <= 17;

subto maxstock: forall <t> in T:
   s[t] <= 12;

subto minstock: forall <t> in T:
   s[t] >= 4;

subto stockinicial: s[0] == 0;