(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
(*
This is the CoMMfoc package. For the notebook that generated this package file and additional documentaion, see https://github.com/CoMMfoc/CoMMfoc
*)


(* ::Input::Initialization:: *)
BeginPackage["CoMMfoc`"];


(* ::Input::Initialization:: *)
$CoMMfocVersion::usage="$CoMMfocVersion prints the current version of the RB-SFA package in use and its timestamp.";
$CoMMfocTimestamp::usage="$CoMMfocTimestamp prints the timestamp of the current version of the RB-SFA package.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
$CoMMfocVersion:="CoMMfoc v0.1, "<>$CoMMfocTimestamp;


(* ::Input::Initialization:: *)
$CoMMfocTimestamp="Tue 6 Oct 2020 16:18:18";
End[];


(* ::Input::Initialization:: *)
$CoMMfocDirectory::usage="$CoMMfocDirectory is the directory where the current RB-SFA package instance is located.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
With[{softLinkTestString=StringSplit[StringJoin[ReadList["! ls -la "<>StringReplace[$InputFileName,{" "->"\\ "}],String]]," -> "]},
If[Length[softLinkTestString]>1,(*Testing in case $InputFileName is a soft link to the actual directory.*)
$CoMMfocDirectory=StringReplace[DirectoryName[softLinkTestString[[2]]],{" "->"\\ "}],
$CoMMfocDirectory=StringReplace[DirectoryName[$InputFileName],{" "->"\\ "}];
]];
End[];


(* ::Input::Initialization:: *)
$CoMMfocCommit::usage="$CoMMfocCommit returns the git commit log at the location of the RB-SFA package if there is one.";
$CoMMfocCommit::OS="$CoMMfocCommit has only been tested on Linux.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
$CoMMfocCommit:=(If[$OperatingSystem!="Unix",Message[$CoMMfocCommit::OS]];
StringJoin[Riffle[ReadList["!cd "<>$CoMMfocDirectory<>" && git log -1",String],{"\n"}]]);
End[];


(* ::Input::Initialization:: *)
SolidHarmonicS::usage="SolidHarmonicS[l,m,x,y,z] calculates the solid harmonic \!\(\*SubscriptBox[\(S\), \(lm\)]\)(x,y,z)=\!\(\*SuperscriptBox[\(r\), \(l\)]\)\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(x,y,z).

SolidHarmonicS[l,m,{x,y,z}] does the same.";
Begin["`Private`"];
SolidHarmonicS[\[Lambda]_Integer,\[Mu]_Integer,x_,y_,z_]/;\[Lambda]>=Abs[\[Mu]]:=Sqrt[(2 \[Lambda]+1)/(4 \[Pi])] Sqrt[Gamma[\[Lambda]-Abs[\[Mu]]+1]/Gamma[\[Lambda]+Abs[\[Mu]]+1]] 2^-\[Lambda] (-1)^((\[Mu]-Abs[\[Mu]])/2)*
If[Rationalize[\[Mu]]==0,1,(x+Sign[\[Mu]]I y)^Abs[\[Mu]]]*
Sum[
(-1)^(\[Mu]+k) Binomial[\[Lambda],k] Binomial[2 \[Lambda]-2 k,\[Lambda]] Pochhammer[\[Lambda]-Abs[\[Mu]]-2 k+1,Abs[\[Mu]]] *
If[TrueQ[Pochhammer[\[Lambda]-Abs[\[Mu]]-2 k+1,Abs[\[Mu]]]==0],1,
If[Rationalize[k]==0,1,(x^2+y^2+z^2)^k]If[Rationalize[\[Lambda]-Abs[\[Mu]]-2 k]==0,1,z^(\[Lambda]-Abs[\[Mu]]-2 k)]
]
,{k,0,Quotient[\[Lambda],2]}]
SolidHarmonicS[\[Lambda]_Integer,\[Mu]_Integer,{x_,y_,z_}]/;\[Lambda]>=Abs[\[Mu]]:=SolidHarmonicS[\[Lambda],\[Mu],x,y,z]
End[];


(* ::Input::Initialization:: *)
AnalyticalBesselJ::usage="AnalyticalBesselJ[m,{x,y,z}] gives the analytical form of the spherical Bessel function, \!\(\*SubscriptBox[\(aj\), \(m\)]\)(r)=\!\(\*SubscriptBox[\(j\), \(m\)]\)(r)/\!\(\*SuperscriptBox[\(r\), \(m\)]\).";

Begin["`Private`"];
AnalyticalBesselJ[m_,{x_?NumericQ,y_?NumericQ,z_?NumericQ}]:=SphericalBesselJ[Abs[m],Sqrt[x^2+y^2+z^2]]/(x^2+y^2+z^2)^(Abs[m]/2)
AnalyticalBesselJ[m_,{x_?NumericQ,y_?NumericQ,z_?NumericQ}/;(x^2+y^2+z^2==0||x^2+y^2+z^2==0.)]:=1/(2m+1)!!

Derivative[0,{1,0,0}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)x AnalyticalBesselJ[m+1,{x,y,z}]
Derivative[0,{0,1,0}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)y AnalyticalBesselJ[m+1,{x,y,z}]
Derivative[0,{0,0,1}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)z AnalyticalBesselJ[m+1,{x,y,z}]

End[];


(* ::Input::Initialization:: *)
Multipole\[CapitalLambda]::usage="Multipole\[CapitalLambda][l,m,{x,y,z}] calculates the multipole function \!\(\*SubscriptBox[\(\[CapitalLambda]\), \(l, m\)]\)(x,y,z)=4\!\(\*SuperscriptBox[\(\[Pi]i\), \(l\)]\)\!\(\*SubscriptBox[\(j\), \(l\)]\)(r)\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])=4\!\(\*SuperscriptBox[\(\[Pi]i\), \(l\)]\)\!\(\*SubscriptBox[\(aj\), \(l\)]\)(r)\!\(\*SubscriptBox[\(S\), \(lm\)]\)(x,y,z).";

Begin["`Private`"];

Multipole\[CapitalLambda][l_,m_,{x_,y_,z_}]:=4\[Pi] I^l AnalyticalBesselJ[l,{x,y,z}]SolidHarmonicS[l,m,x,y,z]

End[];


(* ::Input::Initialization:: *)
UnitE::usage="UnitE[s] gives the unit vectors \!\(\*SubscriptBox[\(e\), \(s\)]\) for s=-1,0,1, equal to (1,-i,0)/\!\(\*SqrtBox[\(2\)]\), (0,0,1) and (1,i,0)/\!\(\*SqrtBox[\(2\)]\), respectively.";

Begin["`Private`"];
UnitE[s:(1|-1)]:=1/Sqrt[2] {1,s I,0}
UnitE[0]:={0,0,1}
End[];


(* ::Input::Initialization:: *)
PolarizationVElectric::usage="PolarizationVElectric[v,f[x,y,z],{x,y,z}] gives the electric-type polarization operator \!\(\*SubsuperscriptBox[\(V\), \(r\), \((E)\)]\)(v,f)=\[Del]\[Times](\[Del]\[Times](v f)) for a vector v and a scalar function f.
PolarizationVElectric[v,f] gives the functional form of \!\(\*SubsuperscriptBox[\(V\), \(r\), \((E)\)]\)(v,f). The vector v can be a fixed object or an explicit Function object.";
PolarizationVMagnetic::usage="PolarizationVMagnetic[v,f[x,y,z],{x,y,z}] gives the magnetic-type polarization operator \!\(\*SubsuperscriptBox[\(V\), \(r\), \((M)\)]\)(v,f)=-i\[Del]\[Times](v f) for a vector v and a scalar function f.
PolarizationVMagnetic[v,f] gives the functional form of \!\(\*SubsuperscriptBox[\(V\), \(r\), \((M)\)]\)(v,f). The vector v can be a fixed object or an explicit Function object.";
PolarizationVHelicity::usage="PolarizationVHelicity[\[Sigma],f[x,y,z],{x,y,z}] gives the helicity-type polarization operator \!\(\*SubsuperscriptBox[\(V\), \(r\), \((\[PlusMinus])\)]\)(f)=\!\(\*SubsuperscriptBox[\(V\), \(r\), \((E)\)]\)(\!\(\*SubscriptBox[\(e\), \(\[PlusMinus]\)]\),f)\[PlusMinus]\!\(\*SubsuperscriptBox[\(iV\), \(r\), \((M)\)]\)(\!\(\*SubscriptBox[\(e\), \(\[PlusMinus]\)]\),f) for a helicity \[Sigma]=\[PlusMinus]1 and a scalar function f.
PolarizationVHelicity[\[Sigma],f] gives the functional form of \!\(\*SubsuperscriptBox[\(V\), \(r\), \((\[PlusMinus])\)]\)(f).";

Begin["`Private`"];

PolarizationVElectric[vector_,scalarFunction_,variables_]:=Curl[Curl[Times[vector,scalarFunction],variables],variables]
PolarizationVMagnetic[vector_,scalarFunction_,variables_]:=-I Curl[Times[vector,scalarFunction],variables]
PolarizationVHelicity[s:(1|-1),scalarFunction_,variables_]:=PolarizationVElectric[UnitE[s],scalarFunction,variables]+I s PolarizationVMagnetic[UnitE[s],scalarFunction,variables]

PolarizationVElectric[vector_,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[vector,scalarFunction[x,y,z],{x,y,z}]
]]
]
PolarizationVElectric[vector_Function,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[vector[x,y,z],scalarFunction[x,y,z],{x,y,z}]
]]
]

PolarizationVMagnetic[vector_,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVMagnetic[vector,scalarFunction[x,y,z],{x,y,z}]
]]
]
PolarizationVMagnetic[vector_Function,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVMagnetic[vector[x,y,z],scalarFunction[x,y,z],{x,y,z}]
]]
]

PolarizationVHelicity[s:(1|-1),scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[UnitE[s],scalarFunction[x,y,z],{x,y,z}]+I s PolarizationVMagnetic[UnitE[s],scalarFunction[x,y,z],{x,y,z}]
]]
]

End[];


(* ::Input::Initialization:: *)
CFnormTEM::usage="CFnormTEM[l,m,q] returns the normalization integral \[Integral]|\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])\!\(\*SuperscriptBox[\(|\), \(2\)]\)\!\(\*SuperscriptBox[\(e\), \(2  q\\\ cos \((\[Theta])\)\)]\)sin(\[Theta]\!\(\*SuperscriptBox[\()\), \(2\)]\)d\[CapitalOmega] for the TEM complex-focus fields.";

\[Alpha]TEM::usage="\[Alpha]TEM[l,m,q] returns the normalization constant CFnormTEM[l,m,q\!\(\*SuperscriptBox[\(]\), \(\(-1\)/2\)]\) for the TEM complex-focus fields.";

Begin["`Private`"];
\[Alpha]TEM[l_,m_,q_]:=CFnormTEM[l,m,q]^(-1/2)

CFnormTEM[l_,m_,q_]:=Block[{qInt},
CFnormTEM[l,m,qInt_]=Simplify[Integrate[SphericalHarmonicY[l,m,\[Theta],\[Phi]]SphericalHarmonicY[l,-m,\[Theta],\[Phi]]Exp[2qInt Cos[\[Theta]]](Sin[\[Theta]])^2 Sin[\[Theta]],{\[Theta],0,\[Pi]},{\[Phi],0,2\[Pi]}]];
CFnormTEM[l,m,q]
]
CFnormTEM[l_,m_,0]:=CFnormTEM[l,m,0]=Limit[CFnormTEM[l,m,q],q->0]
End[];


(* ::Input::Initialization:: *)
(*This cell is auto-generated. Any changes will be over-ridden if the cell above is evaluated.*)
Begin["`Private`"];
CFnormTEM[0,0,q_]:=(2*q*Cosh[2*q] - Sinh[2*q])/(4*q^3)
CFnormTEM[1,-1,q_]:=(18*q*Cosh[2*q] - 3*(3 + 4*q^2)*Sinh[2*q])/(8*q^5)
CFnormTEM[1,0,q_]:=(6*q*(3 + q^2)*Cosh[2*q] - 3*(3 + 5*q^2)*Sinh[2*q])/(4*q^5)
CFnormTEM[1,1,q_]:=(18*q*Cosh[2*q] - 3*(3 + 4*q^2)*Sinh[2*q])/(8*q^5)
CFnormTEM[2,-2,q_]:=(45*(2*q*(15 + 4*q^2)*Cosh[2*q] - 3*(5 + 8*q^2)*Sinh[2*q]))/(64*q^7)
CFnormTEM[2,-1,q_]:=(15*(18*q*(5 + 2*q^2)*Cosh[2*q] - (45 + 78*q^2 + 8*q^4)*Sinh[2*q]))/(16*q^7)
CFnormTEM[2,0,q_]:=(5*(2*q*(405 + 180*q^2 + 8*q^4)*Cosh[2*q] - (405 + 720*q^2 + 104*q^4)*Sinh[2*q]))/(32*q^7)
CFnormTEM[2,1,q_]:=(15*(18*q*(5 + 2*q^2)*Cosh[2*q] - (45 + 78*q^2 + 8*q^4)*Sinh[2*q]))/(16*q^7)
CFnormTEM[2,2,q_]:=(45*(2*q*(15 + 4*q^2)*Cosh[2*q] - 3*(5 + 8*q^2)*Sinh[2*q]))/(64*q^7)
CFnormTEM[3,-3,q_]:=(105*(10*q*(21 + 8*q^2)*Cosh[2*q] - (105 + 180*q^2 + 16*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,-2,q_]:=(315*(2*q*(210 + 95*q^2 + 4*q^4)*Cosh[2*q] - (210 + 375*q^2 + 56*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,-1,q_]:=(21*(6*q*(2625 + 1300*q^2 + 96*q^4)*Cosh[2*q] - (7875 + 64*q^2*(225 + 42*q^2 + q^4))*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,0,q_]:=(7*(2*q*(15750 + 8025*q^2 + 684*q^4 + 8*q^6)*Cosh[2*q] - (15750 + 29025*q^2 + 5784*q^4 + 200*q^6)*Sinh[2*q]))/(32*q^9)
CFnormTEM[3,1,q_]:=(21*(6*q*(2625 + 1300*q^2 + 96*q^4)*Cosh[2*q] - (7875 + 64*q^2*(225 + 42*q^2 + q^4))*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,2,q_]:=(315*(2*q*(210 + 95*q^2 + 4*q^4)*Cosh[2*q] - (210 + 375*q^2 + 56*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,3,q_]:=(105*(10*q*(21 + 8*q^2)*Cosh[2*q] - (105 + 180*q^2 + 16*q^4)*Sinh[2*q]))/(64*q^9)
End[];


(* ::Input::Initialization:: *)
CFnormQuasiCircular::usage="CFnormQuasiCircular[l,m,q] returns the normalization integral \[Integral]|\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])\!\(\*SuperscriptBox[\(|\), \(2\)]\)\!\(\*SuperscriptBox[\(e\), \(2  q\\\ cos \((\[Theta])\)\)]\)(1+cos(\[Theta])\!\(\*SuperscriptBox[\()\), \(2\)]\)d\[CapitalOmega] for the quasi-circular complex-focus fields.";

\[Alpha]QC::usage="\[Alpha]QC[l,m,q] returns the normalization constant CFnormQuasiCircular[l,m,q\!\(\*SuperscriptBox[\(]\), \(\(-1\)/2\)]\) for the quasi-circular complex-focus fields.";

Begin["`Private`"];
\[Alpha]QC[l_,m_,q_]:=CFnormQuasiCircular[l,m,q]^(-1/2)

CFnormQuasiCircular[l_,m_,q_]:=Block[{qInt},
CFnormQuasiCircular[l,m,qInt_]=Simplify[Integrate[SphericalHarmonicY[l,m,\[Theta],\[Phi]]SphericalHarmonicY[l,-m,\[Theta],\[Phi]]Exp[2qIntCos[\[Theta]]](1+Cos[\[Theta]])^2 Sin[\[Theta]],{\[Theta],0,\[Pi]},{\[Phi],0,2\[Pi]}]];
CFnormQuasiCircular[l,m,q]
]
CFnormQuasiCircular[l_,m_,0]:=CFnormQuasiCircular[l,m,0]=Limit[CFnormQuasiCircular[l,m,q],q->0]
End[];


(* ::Input::Initialization:: *)
(*This cell is auto-generated. Any changes will be over-ridden if the cell above is evaluated.*)
Begin["`Private`"];
CFnormQuasiCircular[0,0,q_]:=(-1 + E^(4*q)*(1 - 4*q + 8*q^2))/(8*E^(2*q)*q^3)
CFnormQuasiCircular[1,-1,q_]:=(-3*(3*(1 + q) + E^(4*q)*(-3 + 9*q - 12*q^2 + 8*q^3)))/(16*E^(2*q)*q^5)
CFnormQuasiCircular[1,0,q_]:=(3*(-3 - 3*q - q^2 + E^(4*q)*(3 - 9*q + 13*q^2 - 12*q^3 + 8*q^4)))/(8*E^(2*q)*q^5)
CFnormQuasiCircular[1,1,q_]:=(-3*(3*(1 + q) + E^(4*q)*(-3 + 9*q - 12*q^2 + 8*q^3)))/(16*E^(2*q)*q^5)
CFnormQuasiCircular[2,-2,q_]:=(15*(-3*(15 + 20*q + 8*q^2) + E^(4*q)*(45 - 120*q + 144*q^2 - 96*q^3 + 32*q^4)))/(128*E^(2*q)*q^7)
CFnormQuasiCircular[2,-1,q_]:=(-15*(45 + 60*q + 30*q^2 + 6*q^3 + E^(4*q)*(-45 + 120*q - 150*q^2 + 114*q^3 - 56*q^4 + 16*q^5)))/(32*E^(2*q)*q^7)
CFnormQuasiCircular[2,0,q_]:=(5*(-405 - 4*q*(135 + 2*q*(36 + q*(9 + q))) + E^(4*q)*(405 + 8*q*(-135 + q*(171 + q*(-135 + q*(73 + 4*q*(-7 + 2*q))))))))/(64*E^(2*q)*q^7)
CFnormQuasiCircular[2,1,q_]:=(-15*(45 + 60*q + 30*q^2 + 6*q^3 + E^(4*q)*(-45 + 120*q - 150*q^2 + 114*q^3 - 56*q^4 + 16*q^5)))/(32*E^(2*q)*q^7)
CFnormQuasiCircular[2,2,q_]:=(15*(-3*(15 + 20*q + 8*q^2) + E^(4*q)*(45 - 120*q + 144*q^2 - 96*q^3 + 32*q^4)))/(128*E^(2*q)*q^7)
CFnormQuasiCircular[3,-3,q_]:=(-525*(42 + q*(63 + 4*q*(9 + 2*q))) - 105*E^(4*q)*(-210 + q*(525 + 8*q*(-75 + 2*q*(25 + 2*(-5 + q)*q)))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,-2,q_]:=(105*(-3*(210 + q*(315 + q*(195 + 60*q + 8*q^2))) + E^(4*q)*(630 + q*(-1575 + q*(1845 + 8*q*(-165 + 2*q*(39 + 2*(-6 + q)*q)))))))/(128*E^(2*q)*q^9)
CFnormQuasiCircular[3,-1,q_]:=(-63*(5250 + q*(7875 + 4*q*(1275 + 2*q*(225 + 4*q*(11 + q))))) - 21*E^(4*q)*(-15750 + q*(39375 + 16*q*(-2925 + q*(2175 + 4*q*(-279 + 2*q*(51 + q*(-13 + 2*q))))))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,0,q_]:=(-55125*(2 + 3*q) - 7*q^2*(15525 + 4*q*(1425 + 2*q*(153 + q*(18 + q)))) + 7*E^(4*q)*(15750 + q*(-39375 + q*(47025 + 8*q*(-4425 + q*(2328 + q*(-894 + q*(253 - 52*q + 8*q^2))))))))/(64*E^(2*q)*q^9)
CFnormQuasiCircular[3,1,q_]:=(-63*(5250 + q*(7875 + 4*q*(1275 + 2*q*(225 + 4*q*(11 + q))))) - 21*E^(4*q)*(-15750 + q*(39375 + 16*q*(-2925 + q*(2175 + 4*q*(-279 + 2*q*(51 + q*(-13 + 2*q))))))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,2,q_]:=(105*(-3*(210 + q*(315 + q*(195 + 60*q + 8*q^2))) + E^(4*q)*(630 + q*(-1575 + q*(1845 + 8*q*(-165 + 2*q*(39 + 2*(-6 + q)*q)))))))/(128*E^(2*q)*q^9)
CFnormQuasiCircular[3,3,q_]:=(-525*(42 + q*(63 + 4*q*(9 + 2*q))) - 105*E^(4*q)*(-210 + q*(525 + 8*q*(-75 + 2*q*(25 + 2*(-5 + q)*q)))))/(256*E^(2*q)*q^9)
End[];


(* ::Input::Initialization:: *)
ComplexFocusHelicityE::usage="ComplexFocusHelicityE[l,m,\[Sigma],{x,y,z},q] gives the complex-focus field of helicity type, with complex-focus parameter q, angular momentum numbers l,m and helicity \[Sigma]=\[PlusMinus]1.";
ComplexFoxusElectricE::usage="ComplexFoxusElectricE[l,m,v,{x,y,z},q] gives the complex-focus field of electric type, with complex-focus parameter q, angular momentum numbers l,m and seed polarization vector v.";
ComplexFocusMagneticE::usage="ComplexFocusMagneticE[l,m,v,{x,y,z},q] gives the complex-focus field of magnetic type, with complex-focus parameter q, angular momentum numbers l,m and seed polarization vector v.";

Begin["`Private`"];
ComplexFocusHelicityE[l_,m_,s:(1|-1),{x_,y_,z_},q_]:=Block[{xInt,yInt,zInt,qInt},
ComplexFocusHelicityE[l,m,s,{xInt_,yInt_,zInt_},qInt_]=Simplify[PolarizationVHelicity[s,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I qInt}],{xInt,yInt,zInt}]];
ComplexFocusHelicityE[l,m,s,{x,y,z},q]
]
ComplexFoxusElectricE[l_,m_,vector_,{x_,y_,z_},q_]:=Block[{xInt,yInt,zInt,qInt},
ComplexFoxusElectricE[l,m,vector,{xInt_,yInt_,zInt_},qInt_]=Simplify[PolarizationVElectric[vector,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I qInt}],{xInt,yInt,zInt}]];
ComplexFoxusElectricE[l,m,vector,{x,y,z},q]
]
ComplexFocusMagneticE[l_,m_,vector_,{x_,y_,z_},q_]:=Block[{xInt,yInt,zInt,qInt},
ComplexFocusMagneticE[l,m,vector,{xInt_,yInt_,zInt_},qInt_]=Simplify[PolarizationVMagnetic[vector,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I qInt}],{xInt,yInt,zInt}]];
ComplexFocusMagneticE[l,m,vector,{x,y,z},q]
]
End[];


(* ::Input::Initialization:: *)
EndPackage[];


(* ::Input::Initialization:: *)
DistributeDefinitions["CoMMfoc`"];
