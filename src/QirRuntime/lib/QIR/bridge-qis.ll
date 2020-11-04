; Copyright (c) Microsoft Corporation. All rights reserved.
; Licensed under the MIT License.

; The __quantum__qis__* definitions should be automatically generated by QIR, depending on the specific target.
; However, for simulator targets we provide an optional simple bridge that covers commonly used intrinsics. 

;=======================================================================================================================
; QIR types
;
%Array = type opaque
%Callable = type opaque
%Qubit = type opaque
%Range = type { i64, i64, i64 }
%Result = type opaque
%String = type opaque
%TupleHeader = type { i32 }
%Pauli = type {i2}

;=======================================================================================================================
; Native types
; NB: there is no overloading at IR level, so a call/invoke will be made even
; if the definition of the function mismatches the declaration of the arguments.
; It means we could declare here the bridge's C-functions using QIR types
; and avoid bitcasts. However, it seems prudent to be more explicit about
; what's going on and declare the true signatures, as generated by Clang.
;
%class.QUBIT = type opaque
%class.RESULT = type opaque
%"struct.QirArray" = type opaque
%"struct.QirCallable" = type opaque
%"struct.QirRange" = type { i64, i64, i64 }
%"struct.QirString" = type opaque
%"struct.QirTupleHeader" = type { i32 }

;===============================================================================
; declarations of the native methods this bridge delegates to
;
declare double @quantum__qis__intAsDouble(i64)
declare void @quantum__qis__cnot(%class.QUBIT*, %class.QUBIT*)
declare void @quantum__qis__h(%class.QUBIT*)
declare %class.RESULT* @quantum__qis__measure(%"struct.QirArray"*, %"struct.QirArray"*)
declare %class.RESULT* @quantum__qis__mz(%class.QUBIT*)
declare void @quantum__qis__rx(double, %class.QUBIT*)
declare void @quantum__qis__ry(double, %class.QUBIT*)
declare void @quantum__qis__rz(double, %class.QUBIT*)
declare void @quantum__qis__s(%class.QUBIT*)
declare void @quantum__qis__t(%class.QUBIT*)
declare void @quantum__qis__x(%class.QUBIT*)
declare void @quantum__qis__y(%class.QUBIT*)
declare void @quantum__qis__z(%class.QUBIT*)



;===============================================================================
; quantum.qis namespace implementations
;
define double @__quantum__qis__intAsDouble(i64 %i)
{
  %d = call double @quantum__qis__intAsDouble(i64 %i)
  ret double %d
}

define void @__quantum__qis__cnot(%Qubit* %.qc, %Qubit* %.qt) {
  %qc = bitcast %Qubit* %.qc to %class.QUBIT*
  %qt = bitcast %Qubit* %.qt to %class.QUBIT*
  call void @quantum__qis__cnot(%class.QUBIT* %qc, %class.QUBIT* %qt)
  ret void
}

define void @__quantum__qis__h(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__h(%class.QUBIT* %q)
  ret void
}

define %Result* @__quantum__qis__measure(%Array* %.paulis, %Array* %.qubits) {
  %paulis = bitcast %Array* %.paulis to %"struct.QirArray"*
  %qubits = bitcast %Array* %.qubits to %"struct.QirArray"*
  %r = call %class.RESULT* @quantum__qis__measure(%"struct.QirArray"* %paulis, %"struct.QirArray"* %qubits)
  %.r = bitcast %class.RESULT* %r to %Result*
  ret %Result* %.r
}

define %Result* @__quantum__qis__mz(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  %r = call %class.RESULT* @quantum__qis__mz(%class.QUBIT* %q)
  %.r = bitcast %class.RESULT* %r to %Result*
  ret %Result* %.r
}

define void @__quantum__qis__s(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__s(%class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__t(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__t(%class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__rx(double %.theta, %Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__rx(double %.theta, %class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__ry(double %.theta, %Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__ry(double %.theta, %class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__rz(double %.theta, %Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__rz(double %.theta, %class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__x(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__x(%class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__y(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__y(%class.QUBIT* %q)
  ret void
}

define void @__quantum__qis__z(%Qubit* %.q) {
  %q = bitcast %Qubit* %.q to %class.QUBIT*
  call void @quantum__qis__z(%class.QUBIT* %q)
  ret void
}
