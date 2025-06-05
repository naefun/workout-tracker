workouts
[DONE] workout started -> create workout database entry (PK: id, start time, created at)
[DONE] workout ended -> update workout database entry (end time)

exercises
[DONE] exercise started -> create exercise database entry (PK: id, FK: workout id, start time, created at, name)
[DONE] exercises ended -> update exercise database entry (end time)

exercise sets
[DONE] exercise set created -> create exercise set database entry (PK: id, FK: exercise id, created at, reps, weight)
exercise set deleted -> delete exercise set database entry (PK: id)
