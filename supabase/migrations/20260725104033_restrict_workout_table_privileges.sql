revoke all on table public.workouts from anon, authenticated;
revoke all on table public.exercises from anon, authenticated;
revoke all on table public.exercise_sets from anon, authenticated;

grant select, insert, update, delete
  on table public.workouts, public.exercises, public.exercise_sets
  to authenticated;

revoke all on sequence public.workouts_id_seq from anon, authenticated;
revoke all on sequence public.exercises_id_seq from anon, authenticated;
revoke all on sequence public.exercise_sets_id_seq from anon, authenticated;

grant usage, select
  on sequence public.workouts_id_seq,
              public.exercises_id_seq,
              public.exercise_sets_id_seq
  to authenticated;
