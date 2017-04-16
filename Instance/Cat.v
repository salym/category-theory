Require Import Category.Lib.
Require Export Category.Theory.Category.
Require Export Category.Theory.Functor.
Require Export Category.Theory.Natural.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Set Shrink Obligations.
Set Implicit Arguments.

Program Instance Cat : Category := {
  ob      := Category;
  hom     := @Functor;
  id      := @Identity;
  compose := @functor_comp
}.
Next Obligation.
  unfold functor_comp.
  intros ?? HA ?? HB ?; simpl.
  unfold functor_equiv in *.
  destruct (HA (x0 X0)).
  destruct (HB X0).
  eapply {| to := fmap to0 ∘ to
          ; from := from ∘ fmap from0 |}.
  Unshelve.
  - rewrite <- comp_assoc.
    rewrite (comp_assoc to).
    rewrite iso_to_from; cat.
    rewrite <- fmap_comp.
    rewrite iso_to_from0; cat.
  - rewrite <- comp_assoc.
    rewrite (comp_assoc (fmap from0)).
    rewrite <- fmap_comp.
    rewrite iso_from_to0; cat.
Defined.
Next Obligation.
  unfold functor_equiv; intros.
  unfold functor_comp; cat.
Qed.
Next Obligation.
  unfold functor_equiv; intros.
  unfold functor_comp; cat.
Qed.
Next Obligation.
  unfold functor_equiv; intros.
  unfold functor_comp; cat.
Qed.

Program Instance Termi : Category := {
  ob      := unit;
  hom     := fun _ _ => unit;
  homset  := fun _ _ => {| equiv := eq |};
  id      := fun _ => tt;
  compose := fun _ _ _ _ _ => tt
}.
Next Obligation. destruct f; reflexivity. Defined.
Next Obligation. destruct f; reflexivity. Defined.

Program Instance Fini `(C : Category) : C ⟶ Termi := {
  fobj := fun _ => tt;
  fmap := fun _ _ _ => id
}.
Next Obligation. repeat intros; auto. Defined.

Program Instance Ini : Category := {
  ob  := Empty_set;
  hom := fun _ _ => Empty_set;
  homset := fun _ _ => {| equiv := eq |}
}.
Next Obligation. destruct f. Defined.

Program Instance Init `(C : Category) : Ini ⟶ C.
Next Obligation. destruct H. Defined.
Next Obligation. destruct X. Defined.
Next Obligation. destruct X. Qed.
Next Obligation. destruct X. Qed.

Require Import Category.Structure.Terminal.

Program Instance Cat_Terminal : @Terminal Cat := {
  One := Termi;
  one := Fini
}.
Next Obligation. econstructor; intros; cat. Defined.

Require Import Category.Structure.Initial.

Program Instance Cat_Initial : @Initial Cat := {
  Zero := Ini;
  zero := Init
}.
Next Obligation.
  unfold functor_equiv; intros; destruct X.
Defined.