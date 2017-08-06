Set Warnings "-notation-overridden".

Require Import Coq.Bool.Bool.

Require Import Category.Lib.
Require Import Category.Theory.Functor.

Require Import Solver.Lib.
Require Import Solver.Expr.
Require Import Solver.Denote.
Require Import Solver.Normal.

Generalizable All Variables.

Section Normal.

Context {C : Category}.

Variable objs : obj_idx -> C.
Variable arrs : ∀ f : arr_idx, option (∃ x y, objs x ~{C}~> objs y).

Theorem arrowsD_sound {p dom cod f} :
  arrowsD objs arrs dom cod (arrows p) = Some f ->
  ∃ f', f ≈ f' ∧ termD objs arrs dom cod p = Some f'.
Proof.
  unfold termD, arrowsD.
  generalize dependent cod.
  induction p; simpl; intros; repeat equalities; simpl_eq.
  - firstorder.
  - firstorder.
  - destruct (arrowsD_work _ _ _ (arrows p1 ++ arrows p2)) eqn:?;
    [|discriminate].
    destruct s; equalities.
    inversion H; subst; clear H.
Admitted.

Lemma arrowsD_apply dom cod (f g : Term) :
  list_beq Eq_eqb (arrows f) (arrows g) = true ->
  arrowsD objs arrs dom cod (arrows f) ||| false = true ->
  arrowsD objs arrs dom cod (arrows f) = arrowsD objs arrs dom cod (arrows g) ->
  termD objs arrs dom cod f ≈ termD objs arrs dom cod g.
Proof.
  intros.
  destruct (arrowsD objs arrs dom cod (arrows f)) eqn:?; [|discriminate].
  destruct (arrowsD_sound Heqo), p.
  rewrite e0; clear e0.
  red.
  symmetry in H1.
  apply arrowsD_sound in H1.
  equalities.
  rewrite e1.
  rewrite <- e0, <- e.
  reflexivity.
Qed.

Lemma exprAD_sound (e : Expr) : exprAD objs arrs e -> exprD objs arrs e.
Proof.
  induction e; simpl; intros; intuition auto.
    admit.
  destruct (termD objs _ _ _ f) eqn:?,
           (termD objs _ _ _ g) eqn:?; try contradiction.
  admit.
  admit.
Abort.

End Normal.
