Require Import PerformanceExperiments.Harness.
Require Export PerformanceExperiments.rewrite_repeated_app_common.

Definition args_of_size (s : size) : list nat
  := match s with
     | Sanity => seq 1 3
     | SuperFast => List.map (fun x => x * 50) (seq 1 8)
     | Fast => seq 1 100 ++ List.map (fun x => x * 10) (seq 1 40)
     | Medium => []
     | Slow => []
     | VerySlow => []
     end.

Ltac time_solve_goal0 n :=
  wrap_abstract_tac ltac:(fun _ => time "autorewrite" autorewrite with rew_fg; reflexivity).
Ltac time_solve_goal1 n :=
  wrap_abstract_tac ltac:(fun _ => time "rewrite!" rewrite !fg; reflexivity).

Ltac run0 sz := Harness.runtests args_of_size default_describe_goal mkgoal redgoal time_solve_goal0 sz.
Ltac run1 sz := Harness.runtests args_of_size default_describe_goal mkgoal redgoal time_solve_goal1 sz.

(*
Goal True.
  run0 Fast.
 *)