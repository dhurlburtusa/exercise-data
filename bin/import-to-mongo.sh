#!/usr/bin/env bash

mongoimport --db my-workouts --collection exercise-equipment --drop --jsonArray --file ./exercise_equipment.json
mongoimport --db my-workouts --collection exercise-forces --drop --jsonArray --file ./exercise_forces.json
mongoimport --db my-workouts --collection exercise-levels --drop --jsonArray --file ./exercise_levels.json
mongoimport --db my-workouts --collection exercise-mechanics --drop --jsonArray --file ./exercise_mechanics.json
mongoimport --db my-workouts --collection exercise-types --drop --jsonArray --file ./exercise_types.json
mongoimport --db my-workouts --collection muscle-groups --drop --jsonArray --file ./muscle_groups.json
mongoimport --db my-workouts --collection exercises --drop --jsonArray --file ./exercises-abc.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-abd.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-add.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-bcp.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-chs.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-clv.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-frr.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-glt.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-hms.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-lts.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-lwb.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-mdb.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-nck.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-qdr.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-shl.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-trc.json
mongoimport --db my-workouts --collection exercises --jsonArray --file ./exercises-trp.json
