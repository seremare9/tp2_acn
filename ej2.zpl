# Grupo: Chen, Giralt Font, Marelli, Tagle Zorraquín

# SETS

# Parciales
set P := { read "cursos.dat" as "<1s>" };

# Aulas que requiere cada parcial
param a[P] := read "cursos.dat" as "<1s> 2n";

# Conjunto de pares en conflicto
set E := { read "estudiantes-en-comun.dat" as "<1s,2s>" };

# Días válidos según enunciado
set D := {1,2,3,4,5,9,10,11,12};

# Turnos
set T := {9,12,15,18};

# Capacidad de aulas
param CAP := 75;

# VARIABLES

# x[p,d,t] = 1 si p se programa en día d y turno t
var x[P * D * T] binary;

# y[p] = 1 si el parcial p se programa en algún slot
var y[P] binary;

# OBJETIVO
maximize Programados:
    sum <p> in P: y[p];

# RESTRICCIONES

# Cada parcial se programa a lo sumo una vez
subto UnaVez:
    forall <p> in P:
        sum <d,t> in D * T: x[p,d,t] == y[p];

# Conflictos: dos parciales incompatibles no pueden compartir mismo slot
subto Conflictos:
    forall <p,q> in E:
        forall <d,t> in D * T:
            x[p,d,t] + x[q,d,t] <= 1;

# NUEVA RESTRICCIÓN: impedir que haya estudiantes rindiendo tres parciales un mismo día
subto MaxParcialesDia:
    forall <i,j,k,d> in P * P * P * D with <i,j> in E and <i,k> in E and <j,k> in E:
        sum <t> in T: (x[i,d,t] + x[j,d,t] + x[k,d,t]) <= 2;

# Capacidad de aulas por slot
subto Aulas:
    forall <d,t> in D * T:
        sum <p> in P: a[p] * x[p,d,t] <= CAP;