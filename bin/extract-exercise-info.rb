require 'json'
require 'titleize'

RESULTS_URLS = [
  'http://www.bodybuilding.com/exercises/list/muscle/selected/abdominals',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/abductors',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/adductors',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/biceps',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/calves',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/chest',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/forearms',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/glutes',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/hamstrings',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/lats',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/lower-back',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/middle-back',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/neck',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/quadriceps',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/shoulders',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/traps',
  'http://www.bodybuilding.com/exercises/list/muscle/selected/triceps',
]

ABDOMINALS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/34-sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/ab-crunch-machine',
  'http://www.bodybuilding.com/exercises/detail/view/name/ab-roller',
  'http://www.bodybuilding.com/exercises/detail/view/name/advanced-kettlebell-windmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/air-bike',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternate-heel-touchers',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-ab-rollout',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-ab-rollout-on-knees',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-rollout-from-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-side-bend',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-knee-hip-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/bosu-ball-cable-crunch-with-side-bends',
  'http://www.bodybuilding.com/exercises/detail/view/name/bosu-ball-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/bottoms-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/butt-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-judo-flip',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-reverse-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-russian-twists',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-seated-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-tuck-reverse-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/cocoons',
  'http://www.bodybuilding.com/exercises/detail/view/name/cross-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/cross-body-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/crunch-hands-overhead',
  'http://www.bodybuilding.com/exercises/detail/view/name/crunch-legs-on-exercise-ball',
  'http://www.bodybuilding.com/exercises/detail/view/name/crunches',
  'http://www.bodybuilding.com/exercises/detail/view/name/dead-bug',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-oblique-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-reverse-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-kettlebell-windmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-side-bend',
  'http://www.bodybuilding.com/exercises/detail/view/name/elbow-to-knee',
  'http://www.bodybuilding.com/exercises/detail/view/name/exercise-ball-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/exercise-ball-pull-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/flat-bench-leg-pull-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/flat-bench-lying-leg-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/frog-sit-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/gorilla-chincrunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/hanging-leg-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/hanging-oblique-knee-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/hanging-pike',
  'http://www.bodybuilding.com/exercises/detail/view/name/jackknife-sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/janda-sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-figure-8',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-pass-between-the-legs',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-windmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneehip-raise-on-parallel-bars',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-cable-crunch-with-alternating-oblique-twists',
  'http://www.bodybuilding.com/exercises/detail/view/name/landmine-180s',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-pull-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/lower-back-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/medicine-ball-full-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/medicine-ball-rotational-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/oblique-cable-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/oblique-crunches',
  'http://www.bodybuilding.com/exercises/detail/view/name/oblique-crunches-on-the-floor',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-high-pulley-cable-side-bends-',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-medicine-ball-slam',
  'http://www.bodybuilding.com/exercises/detail/view/name/otis-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/pallof-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/pallof-press-with-rotation',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-3-touch-motion-russian-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-facing-planks-with-alternating-high-five',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-hanging-knee-raise-with-manual-resistance',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-hanging-knee-raise-with-throw-down',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-lying-leg-raise-with-lateral-throw-down',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-lying-leg-raise-with-throw-down',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-resistance-standing-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-side-to-side-russian-twist-pass',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-sit-up-with-high-five',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-target-sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/plank',
  'http://www.bodybuilding.com/exercises/detail/view/name/plate-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/press-sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/rope-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/russian-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/scissor-kick',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-barbell-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-flat-bench-leg-pull-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-leg-tucks',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-overhead-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-scissor-kick',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-bridge',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-jackknife',
  'http://www.bodybuilding.com/exercises/detail/view/name/sit-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/sledgehammer-swings',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-hip-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/spell-caster',
  'http://www.bodybuilding.com/exercises/detail/view/name/spider-crawl',
  'http://www.bodybuilding.com/exercises/detail/view/name/stability-ball-pike-with-knee-tuck',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-cable-lift',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-cable-wood-chop',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-lateral-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-rope-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/stomach-vacuum',
  'http://www.bodybuilding.com/exercises/detail/view/name/straight-legged-hip-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/suitcase-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/supine-one-arm-overhead-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/supine-two-arm-overhead-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-fallout',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-pike',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-reverse-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/toe-touchers',
  'http://www.bodybuilding.com/exercises/detail/view/name/torso-rotation',
  'http://www.bodybuilding.com/exercises/detail/view/name/tuck-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/waiters-carry',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-ball-side-bend',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-crunches',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-sit-ups-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-suitcase-crunch',
  'http://www.bodybuilding.com/exercises/detail/view/name/wind-sprints',
]

ABDUCTORS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/clam',
  'http://www.bodybuilding.com/exercises/detail/view/name/fire-hydrant',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-circle',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-circles-prone',
  'http://www.bodybuilding.com/exercises/detail/view/name/iliotibial-tract-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/it-band-and-glute-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-band-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-crossover',
  'http://www.bodybuilding.com/exercises/detail/view/name/monster-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-hip-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/thigh-abductor',
  'http://www.bodybuilding.com/exercises/detail/view/name/windmills',
]

ADDUCTORS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/adductor',
  'http://www.bodybuilding.com/exercises/detail/view/name/adductorgroin-',
  'http://www.bodybuilding.com/exercises/detail/view/name/band-hip-adductions',
  'http://www.bodybuilding.com/exercises/detail/view/name/carioca-quick-step',
  'http://www.bodybuilding.com/exercises/detail/view/name/groin-and-back-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/groiners-',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-bound-',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-box-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-cone-hops',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-bent-leg-groin',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-leg-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-lying-groin-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/thigh-adductor',
]

BICEPS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/alternate-hammer-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternate-incline-dumbbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-curls-lying-against-an-incline',
  'http://www.bodybuilding.com/exercises/detail/view/name/biceps-curl-to-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/brachialis-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-hammer-curls-rope-attachment',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-preacher-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-ez-bar-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-ez-bar-curl-with-band',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-standing-barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/concentration-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/cross-body-hammer-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/drag-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-alternate-bicep-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-bicep-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-prone-incline-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/ez-bar-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/flexor-incline-dumbbell-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/hammer-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/high-cable-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-hammer-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-inner-biceps-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-cable-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-close-grip-bar-curl-on-high-pulley',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-high-bench-barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-supine-dumbbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-bicep-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-preacher-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-dumbbell-preacher-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-cable-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/preacher-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/preacher-hammer-dumbbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-barbell-preacher-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-cable-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-plate-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-biceps',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-close-grip-concentration-barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-dumbbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-dumbbell-inner-biceps-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/spider-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-biceps-cable-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-biceps-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-concentration-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-reverse-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-inner-biceps-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-one-arm-cable-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-one-arm-dumbbell-curl-over-incline-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/two-arm-dumbbell-preacher-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-standing-barbell-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/zottman-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/zottman-preacher-curl',
]

CALVES_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/ankle-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/anterior-tibialis-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/balance-board',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-seated-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-press-on-the-leg-press-machine',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-raise-on-a-dumbbell',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-raises-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-stretch-elbows-against-wall',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-stretch-hands-against-wall',
  'http://www.bodybuilding.com/exercises/detail/view/name/calves-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/donkey-calf-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-seated-one-leg-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/foot-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/knee-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/peroneals-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/peroneals-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/posterior-tibialis-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/rocking-standing-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-calf-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-reverse-calf-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-barbell-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-calf-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-calf-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-gastrocnemius-calf-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-soleus-and-achilles-stretch',
]

CHEST_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/around-the-worlds',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-bench-press-medium-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-bench-press-wide-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-guillotine-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-incline-bench-press-medium-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/behind-head-chest-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-press-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-press-with-short-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-arm-dumbbell-pullover',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/bosu-ball-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/butterfly',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-crossover',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-iron-cross',
  'http://www.bodybuilding.com/exercises/detail/view/name/chain-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-and-front-of-shoulder-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-push-multiple-response',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-push-single-response',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-push-from-3-point-stance',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-push-with-run-release',
  'http://www.bodybuilding.com/exercises/detail/view/name/chest-stretch-on-stability-ball',
  'http://www.bodybuilding.com/exercises/detail/view/name/clock-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-hands-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/cross-over-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-barbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-dumbbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-dumbbell-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-smith-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/diamond-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/dips-chest-version',
  'http://www.bodybuilding.com/exercises/detail/view/name/dive-bomber-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/drop-push',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-bench-press-with-neutral-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/dynamic-chest-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/elbows-back',
  'http://www.bodybuilding.com/exercises/detail/view/name/extended-range-one-arm-kettlebell-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/flat-bench-cable-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/forward-drag-with-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-raise-and-pullover',
  'http://www.bodybuilding.com/exercises/detail/view/name/hammer-grip-incline-db-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/hand-release-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/heavy-bag-thrust',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-cable-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-cable-flye',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-bench-with-palms-facing-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-flyes-with-a-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-dumbbell-press-reverse-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up-depth-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up-medium',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up-reverse-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up-wide',
  'http://www.bodybuilding.com/exercises/detail/view/name/isometric-chest-squeezes',
  'http://www.bodybuilding.com/exercises/detail/view/name/isometric-wipers',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-over-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-decline-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-incline-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/low-cable-crossover',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/medicine-ball-chest-pass',
  'http://www.bodybuilding.com/exercises/detail/view/name/medicine-ball-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/neck-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-dumbbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-flat-bench-dumbbell-flye',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/plyo-kettlebell-pushups',
  'http://www.bodybuilding.com/exercises/detail/view/name/plyo-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-up-to-side-plank',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-up-wide',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-ups-with-feet-elevated',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-ups-with-feet-on-an-exercise-ball',
  'http://www.bodybuilding.com/exercises/detail/view/name/pushups',
  'http://www.bodybuilding.com/exercises/detail/view/name/pushups-close-and-wide-hand-positions',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-to-side-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-cable-crossover',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-decline-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-incline-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/staggered-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-cable-chest-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/straight-arm-dumbbell-pullover',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-chest-fly',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/svend-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-barbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-decline-barbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-decline-barbell-pullover',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-hands-push-up',
]

FOREARMS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/bottoms-up-clean-from-the-hang-position',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lying-pronation',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lying-supination',
  'http://www.bodybuilding.com/exercises/detail/view/name/farmers-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/finger-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-forearm-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/palms-down-dumbbell-wrist-curl-over-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/palms-down-wrist-curl-over-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/palms-up-barbell-wrist-curl-over-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/palms-up-dumbbell-wrist-curl-over-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-farmers-walk-competition',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-suitcase-carry-competition',
  'http://www.bodybuilding.com/exercises/detail/view/name/plate-pinch',
  'http://www.bodybuilding.com/exercises/detail/view/name/rickshaw-carry',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-dumbbell-palms-down-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-dumbbell-palms-up-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-one-arm-dumbbell-palms-down-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-one-arm-dumbbell-palms-up-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-palm-up-barbell-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-palms-down-barbell-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-two-arm-palms-up-low-pulley-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-olympic-plate-hand-squeeze',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-palms-up-barbell-behind-the-back-wrist-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/suitcase-dumbbell-carry',
  'http://www.bodybuilding.com/exercises/detail/view/name/wrist-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/wrist-roller',
  'http://www.bodybuilding.com/exercises/detail/view/name/wrist-rotations-with-straight-bar',
]

GLUTES_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/ankle-on-the-knee',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-glute-bridge',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-hip-thrust',
  'http://www.bodybuilding.com/exercises/detail/view/name/butt-lift-bridge',
  'http://www.bodybuilding.com/exercises/detail/view/name/downward-facing-balance',
  'http://www.bodybuilding.com/exercises/detail/view/name/flutter-kicks',
  'http://www.bodybuilding.com/exercises/detail/view/name/glute-bridge-hamstring-walkout',
  'http://www.bodybuilding.com/exercises/detail/view/name/glute-kickback',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-extension-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-lift-with-band',
  'http://www.bodybuilding.com/exercises/detail/view/name/knee-across-the-body',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-jump-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-lift',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-glute',
  'http://www.bodybuilding.com/exercises/detail/view/name/neck-bridge-supine',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-knee-to-chest',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-legged-cable-kickback',
  'http://www.bodybuilding.com/exercises/detail/view/name/physioball-hip-bridge',
  'http://www.bodybuilding.com/exercises/detail/view/name/piriformis-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/pull-through',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-glute',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-glute-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-glute-bridge-',
  'http://www.bodybuilding.com/exercises/detail/view/name/step-up-with-knee-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-hip-thrust',
]

HAMSTRINGS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/9090-hamstring',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-hang-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-leg-swing',
  'http://www.bodybuilding.com/exercises/detail/view/name/ball-leg-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/band-good-morning',
  'http://www.bodybuilding.com/exercises/detail/view/name/band-good-morning-pull-through',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/box-jump-multiple-response',
  'http://www.bodybuilding.com/exercises/detail/view/name/box-skip',
  'http://www.bodybuilding.com/exercises/detail/view/name/chair-leg-extended-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-kettlebell-alternating-hang-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/floor-glute-ham-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-box-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-leg-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/glute-ham-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/good-morning',
  'http://www.bodybuilding.com/exercises/detail/view/name/good-morning-off-pins',
  'http://www.bodybuilding.com/exercises/detail/view/name/hamstring-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/hamstring-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/hang-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/hang-snatch-below-knees',
  'http://www.bodybuilding.com/exercises/detail/view/name/hanging-bar-good-morning',
  'http://www.bodybuilding.com/exercises/detail/view/name/high-kick',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-stretch-with-twist',
  'http://www.bodybuilding.com/exercises/detail/view/name/hurdle-hops',
  'http://www.bodybuilding.com/exercises/detail/view/name/inchworm',
  'http://www.bodybuilding.com/exercises/detail/view/name/intermediate-groin-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-dead-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-hang-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-one-legged-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/knee-to-chest',
  'http://www.bodybuilding.com/exercises/detail/view/name/knee-tuck-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-up-hamstring-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/linear-3-part-start-technique',
  'http://www.bodybuilding.com/exercises/detail/view/name/linear-acceleration-wall-drill',
  'http://www.bodybuilding.com/exercises/detail/view/name/lunge-pass-through',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-hamstring',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-leg-curls',
  'http://www.bodybuilding.com/exercises/detail/view/name/moving-claw-series-',
  'http://www.bodybuilding.com/exercises/detail/view/name/muscle-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/natural-glute-ham-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-swings',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-open-palm-kettlebell-clean-',
  'http://www.bodybuilding.com/exercises/detail/view/name/open-palm-kettlebell-clean-',
  'http://www.bodybuilding.com/exercises/detail/view/name/platform-hamstring-slides',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-clean-from-blocks',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-stairs',
  'http://www.bodybuilding.com/exercises/detail/view/name/prone-manual-hamstring',
  'http://www.bodybuilding.com/exercises/detail/view/name/prowler-sprint',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-band-sumo-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-hyperextension',
  'http://www.bodybuilding.com/exercises/detail/view/name/romanian-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/romanian-deadlift-from-deficit',
  'http://www.bodybuilding.com/exercises/detail/view/name/romanian-deadlift-with-dumbbells',
  'http://www.bodybuilding.com/exercises/detail/view/name/romanian-deadlift-with-kettlebell',
  'http://www.bodybuilding.com/exercises/detail/view/name/runners-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-band-hamstring-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-floor-hamstring-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-hamstring',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-hamstring-and-calf-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-leg-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-balance-',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-hang-power-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-stiff-legged-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-pull',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-hamstring-and-calf-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-leg-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-toe-touches',
  'http://www.bodybuilding.com/exercises/detail/view/name/stiff-legged-barbell-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/stiff-legged-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/stiff-legged-dumbbell-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/sumo-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/sumo-deadlift-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/sumo-deadlift-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/sumo-squat-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-leg-curl',
  'http://www.bodybuilding.com/exercises/detail/view/name/the-straddle',
  'http://www.bodybuilding.com/exercises/detail/view/name/upper-back-leg-grab',
  'http://www.bodybuilding.com/exercises/detail/view/name/vertical-swing',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-stance-stiff-legs',
  'http://www.bodybuilding.com/exercises/detail/view/name/worlds-greatest-stretch',
]

LATS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/assisted-chin-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/band-assisted-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-arm-barbell-pullover',
  'http://www.bodybuilding.com/exercises/detail/view/name/burpee-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-incline-pushdown',
  'http://www.bodybuilding.com/exercises/detail/view/name/catch-and-overhead-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/chair-lower-back-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/chin-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-front-lat-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/dynamic-back-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/elevated-cable-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/full-range-of-motion-lat-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/gironda-sternum-chins',
  'http://www.bodybuilding.com/exercises/detail/view/name/kipping-muscle-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-high-pulley-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-single-arm-high-pulley-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/latissimus-dorsi-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-iso-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/london-bridges',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-assisted-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/muscle-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/negative-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/neutral-grip-pull-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-against-wall',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-lat-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-handed-hang',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-lat',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-slam',
  'http://www.bodybuilding.com/exercises/detail/view/name/pullups',
  'http://www.bodybuilding.com/exercises/detail/view/name/rockers-pullover-to-press-straight-bar',
  'http://www.bodybuilding.com/exercises/detail/view/name/rocky-pull-upspulldowns',
  'http://www.bodybuilding.com/exercises/detail/view/name/rope-climb',
  'http://www.bodybuilding.com/exercises/detail/view/name/rope-straight-arm-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/shotgun-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-to-side-chins',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-lying-floor-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/straight-arm-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/underhand-cable-pulldowns',
  'http://www.bodybuilding.com/exercises/detail/view/name/v-bar-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/v-bar-pullup',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-pull-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-lat-pulldown',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-pulldown-behind-the-neck',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-grip-rear-pull-up',
]

LOWER_BACK_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/atlas-stone-trainer',
  'http://www.bodybuilding.com/exercises/detail/view/name/atlas-stones',
  'http://www.bodybuilding.com/exercises/detail/view/name/axle-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/cat-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/childs-pose',
  'http://www.bodybuilding.com/exercises/detail/view/name/crossover-reverse-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/dancers-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/deadlift-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/deadlift-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/deficit-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/hug-a-ball',
  'http://www.bodybuilding.com/exercises/detail/view/name/hug-knees-to-chest',
  'http://www.bodybuilding.com/exercises/detail/view/name/hyperextensions-back-extensions',
  'http://www.bodybuilding.com/exercises/detail/view/name/hyperextensions-with-no-hyperextension-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/keg-load',
  'http://www.bodybuilding.com/exercises/detail/view/name/lower-back-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-flat-bench-back-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-flat-bench-back-extension-with-hold',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-supermans-with-alternating-high-five',
  'http://www.bodybuilding.com/exercises/detail/view/name/pelvic-tilt-into-bridge',
  'http://www.bodybuilding.com/exercises/detail/view/name/pyramid',
  'http://www.bodybuilding.com/exercises/detail/view/name/rack-pull-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/rack-pulls',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-band-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-back-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-good-mornings',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-pelvic-tilt',
  'http://www.bodybuilding.com/exercises/detail/view/name/stiff-leg-barbell-good-morning',
  'http://www.bodybuilding.com/exercises/detail/view/name/superman',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-ball-hyperextension',
]

MIDDLEBACK_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-kettlebell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-renegade-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-barbell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-one-arm-long-bar-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-two-arm-long-bar-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-two-dumbbell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-two-dumbbell-row-with-palms-in',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-mid-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-incline-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-bench-pull',
  'http://www.bodybuilding.com/exercises/detail/view/name/inverted-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/inverted-row-with-straps',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-high-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-cambered-barbell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-t-bar-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/man-maker',
  'http://www.bodybuilding.com/exercises/detail/view/name/middle-back-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/middle-back-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/mixed-grip-chin',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-chin-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-dumbbell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-long-bar-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-facing-feet-elevated-side-plank-with-band-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-facing-plank-with-band-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/partner-facing-side-plank-with-band-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/pendlay-rown',
  'http://www.bodybuilding.com/exercises/detail/view/name/plate-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-grip-bent-over-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/rhomboids-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-cable-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-one-arm-cable-pulley-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-landmine-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-bent-over-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/spinal-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/straight-bar-bench-mid-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/t-bar-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/t-bar-row-with-handle',
  'http://www.bodybuilding.com/exercises/detail/view/name/two-arm-kettlebell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/upper-back-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/yates-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/yates-row-reverse-grip',
]

NECK_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/chin-to-chest-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/isometric-neck-exercise-front-and-back',
  'http://www.bodybuilding.com/exercises/detail/view/name/isometric-neck-exercise-sides',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-face-down-plate-neck-resistance',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-face-up-plate-neck-resistance',
  'http://www.bodybuilding.com/exercises/detail/view/name/neck-bridge-prone',
  'http://www.bodybuilding.com/exercises/detail/view/name/neck-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-head-harness-neck-resistance',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-neck-stretch',
]

QUADRICEPS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/alien-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/all-fours-quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternate-leg-diagonal-bound',
  'http://www.bodybuilding.com/exercises/detail/view/name/backward-drag',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-full-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-hack-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-reverse-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-side-split-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-squat-to-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-squat-to-a-box',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-step-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-thruster',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-walking-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/bear-crawl-sled-drags-',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-sprint',
  'http://www.bodybuilding.com/exercises/detail/view/name/bicycling',
  'http://www.bodybuilding.com/exercises/detail/view/name/bicycling-stationary',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-reverse-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/bodyweight-walking-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/bosu-ball-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/box-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/box-squat-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/box-squat-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/burpee',
  'http://www.bodybuilding.com/exercises/detail/view/name/burpee-over-barbell',
  'http://www.bodybuilding.com/exercises/detail/view/name/butt-kicks',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-deadlifts',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-hip-adduction',
  'http://www.bodybuilding.com/exercises/detail/view/name/car-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/chair-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-from-blocks',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-pull-',
  'http://www.bodybuilding.com/exercises/detail/view/name/conans-wheel',
  'http://www.bodybuilding.com/exercises/detail/view/name/defensive-slide',
  'http://www.bodybuilding.com/exercises/detail/view/name/depth-jump-leap',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-leg-butt-kick',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-goblet-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lunges',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-overhead-squat-',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-rear-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-seated-box-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-side-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-squat-to-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-step-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-walking-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/elevated-back-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/elliptical-trainer',
  'http://www.bodybuilding.com/exercises/detail/view/name/fast-kick-with-arm-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/fast-skipping',
  'http://www.bodybuilding.com/exercises/detail/view/name/feet-jack',
  'http://www.bodybuilding.com/exercises/detail/view/name/football-up-down',
  'http://www.bodybuilding.com/exercises/detail/view/name/forward-band-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/frankenstein-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/freehand-jump-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/frog-hops',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-barbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-barbell-squat-to-a-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-cone-hops-or-hurdle-hops',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-squat-bodybuilder',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-squat-clean-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-squat-push-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-squats-with-two-kettlebells',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-to-back-squat-with-belt',
  'http://www.bodybuilding.com/exercises/detail/view/name/goblet-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/hack-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/hang-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/hang-clean-below-the-knees',
  'http://www.bodybuilding.com/exercises/detail/view/name/heaving-snatch-balance',
  'http://www.bodybuilding.com/exercises/detail/view/name/high-knee-jog',
  'http://www.bodybuilding.com/exercises/detail/view/name/hip-flexion-with-band',
  'http://www.bodybuilding.com/exercises/detail/view/name/ice-skater',
  'http://www.bodybuilding.com/exercises/detail/view/name/intermediate-hip-flexor-and-quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/iron-crosses-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/jefferson-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/jerk-dip-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/jog-in-place',
  'http://www.bodybuilding.com/exercises/detail/view/name/jogging-treadmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/jump-lunge-to-feet-jack',
  'http://www.bodybuilding.com/exercises/detail/view/name/jump-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/jumping-jacks',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-curtsy-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-pistol-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-sumo-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-hip-flexor',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-speed-step',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-extensions',
  'http://www.bodybuilding.com/exercises/detail/view/name/leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/linear-depth-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/looking-at-ceiling',
  'http://www.bodybuilding.com/exercises/detail/view/name/lunge-sprint',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-machine-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-prone-quadriceps',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/mountain-climbers',
  'http://www.bodybuilding.com/exercises/detail/view/name/narrow-stance-hack-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/narrow-stance-leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/narrow-stance-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/olympic-squat-',
  'http://www.bodybuilding.com/exercises/detail/view/name/on-your-side-quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/on-your-back-quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-half-locust',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-leg-barbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-overhead-kettlebell-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-side-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/pistol-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/plie-dumbbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/pop-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-jerk-',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-snatch-from-blocks',
  'http://www.bodybuilding.com/exercises/detail/view/name/quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/quadriceps-smr',
  'http://www.bodybuilding.com/exercises/detail/view/name/quick-leap',
  'http://www.bodybuilding.com/exercises/detail/view/name/rear-leg-raises',
  'http://www.bodybuilding.com/exercises/detail/view/name/recumbent-bike',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-band-box-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-band-power-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/rickshaw-deadlift-',
  'http://www.bodybuilding.com/exercises/detail/view/name/rocket-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/rope-jumping',
  'http://www.bodybuilding.com/exercises/detail/view/name/rowing-stationary',
  'http://www.bodybuilding.com/exercises/detail/view/name/running-treadmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/sandbag-load',
  'http://www.bodybuilding.com/exercises/detail/view/name/scissors-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-hop-sprint',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-lunge',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-standing-long-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-to-side-box-shuffle',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-overhead-kettlebell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-butt-kick',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-push-off',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-dumbbell-overhead-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-cone-sprint-drill',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-box-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-high-box-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-hop-progression',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-lateral-hop',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-leg-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-skater-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-squat-to-box',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-leg-stride-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/sit-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/skating',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-drag-harness',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-push',
  'http://www.bodybuilding.com/exercises/detail/view/name/slide-jump-shot',
  'http://www.bodybuilding.com/exercises/detail/view/name/slow-jog',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-pistol-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-single-leg-split-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-balance-',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-from-blocks',
  'http://www.bodybuilding.com/exercises/detail/view/name/speed-box-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/speed-squats',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-squat-with-dumbbells',
  'http://www.bodybuilding.com/exercises/detail/view/name/split-squat-with-kettlebells',
  'http://www.bodybuilding.com/exercises/detail/view/name/square-hop',
  'http://www.bodybuilding.com/exercises/detail/view/name/squat-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/squat-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/squat-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/squat-with-plate-movers',
  'http://www.bodybuilding.com/exercises/detail/view/name/squats-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/stairmaster',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-elevated-quad-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-hip-flexors',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-long-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/star-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/step-mill',
  'http://www.bodybuilding.com/exercises/detail/view/name/stride-jump-crossover',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-split-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/tire-flip',
  'http://www.bodybuilding.com/exercises/detail/view/name/trail-runningwalking',
  'http://www.bodybuilding.com/exercises/detail/view/name/trap-bar-deadlift',
  'http://www.bodybuilding.com/exercises/detail/view/name/trap-bar-jump',
  'http://www.bodybuilding.com/exercises/detail/view/name/vertical-mountain-climber',
  'http://www.bodybuilding.com/exercises/detail/view/name/walking-high-knees',
  'http://www.bodybuilding.com/exercises/detail/view/name/walking-lunge-with-overhead-weight',
  'http://www.bodybuilding.com/exercises/detail/view/name/walking-treadmill',
  'http://www.bodybuilding.com/exercises/detail/view/name/wall-ball-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/wall-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-jump-squat-',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-sissy-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-stance-barbell-squat',
  'http://www.bodybuilding.com/exercises/detail/view/name/wide-stance-leg-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/yoke-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/zercher-squats',
]

SHOULDERS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-cable-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-deltoid-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/alternating-kettlebell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/anti-gravity-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/arm-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/arnold-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/axle-clean-and-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/back-flyes-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/backward-medicine-ball-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/band-pull-apart',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-front-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-incline-shoulder-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-rear-delt-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/battling-ropes',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-dumbbell-rear-delt-raise-with-head-on-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/bent-over-low-pulley-side-lateral',
  'http://www.bodybuilding.com/exercises/detail/view/name/bradfordrocky-presses',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-internal-rotation',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-rear-delt-fly',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-rope-rear-delt-rows',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-seated-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/car-drivers',
  'http://www.bodybuilding.com/exercises/detail/view/name/chair-upper-body-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/circus-bell',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-and-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-and-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/crucifix',
  'http://www.bodybuilding.com/exercises/detail/view/name/cuban-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-kettlebell-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-kettlebell-push-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/double-kettlebell-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-clean-and-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-incline-shoulder-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lying-one-arm-rear-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-lying-rear-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-one-arm-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-one-arm-upright-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-rear-delt-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-scaption',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-squat-to-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/elbow-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/external-rotation',
  'http://www.bodybuilding.com/exercises/detail/view/name/external-rotation-with-band',
  'http://www.bodybuilding.com/exercises/detail/view/name/external-rotation-with-cable',
  'http://www.bodybuilding.com/exercises/detail/view/name/face-pull',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-cable-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-dumbbell-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-incline-dumbbell-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-plate-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/front-two-dumbbell-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/half-kneeling-dumbbell-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/hand-stand-push-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/handstand-push-ups',
  'http://www.bodybuilding.com/exercises/detail/view/name/internal-rotation-with-band',
  'http://www.bodybuilding.com/exercises/detail/view/name/iron-cross',
  'http://www.bodybuilding.com/exercises/detail/view/name/jerk-balance',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-arnold-press-',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-pirate-ships',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-seated-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-seesaw-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-thruster',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-turkish-get-up-lunge-style',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-turkish-get-up-squat-style',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-arm-drill-',
  'http://www.bodybuilding.com/exercises/detail/view/name/landmine-linear-jammer',
  'http://www.bodybuilding.com/exercises/detail/view/name/lateral-raise-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/log-lift',
  'http://www.bodybuilding.com/exercises/detail/view/name/low-pulley-row-to-neck',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-one-arm-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-rear-delt-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-shoulder-military-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/medicine-ball-scoop-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-incline-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-clean-and-jerk-',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-military-press-to-the-side',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-para-press-',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-push-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-split-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-kettlebell-split-snatch-',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-side-laterals',
  'http://www.bodybuilding.com/exercises/detail/view/name/power-partials',
  'http://www.bodybuilding.com/exercises/detail/view/name/punches',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-press-behind-the-neck',
  'http://www.bodybuilding.com/exercises/detail/view/name/rack-delivery',
  'http://www.bodybuilding.com/exercises/detail/view/name/return-push-from-stance',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-flyes-with-external-rotation',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-machine-flyes',
  'http://www.bodybuilding.com/exercises/detail/view/name/round-the-world-shoulder-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-barbell-military-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-bent-over-rear-delt-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-cable-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-front-deltoid',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-side-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/see-saw-press-alternating-side-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/shoulder-circles',
  'http://www.bodybuilding.com/exercises/detail/view/name/shoulder-press-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/shoulder-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/shoulder-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-lateral-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-laterals-to-front-raise-',
  'http://www.bodybuilding.com/exercises/detail/view/name/side-wrist-pull',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-dumbbell-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/single-arm-linear-jammer',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-overhead-backward-walk',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-reverse-flye',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-incline-shoulder-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-one-arm-upright-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-overhead-shoulder-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-grip-behind-the-neck-overhead-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-alternating-dumbbell-press-',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-barbell-press-behind-neck',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-bradford-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-press-',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-straight-arm-front-delt-raise-above-head',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-front-barbell-raise-over-head',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-low-pulley-deltoid-raise',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-military-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-palm-in-one-arm-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-palms-in-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-two-arm-overhead-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/straight-raises-on-incline-bench',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-back-fly',
  'http://www.bodybuilding.com/exercises/detail/view/name/tall-muscle-snatch',
  'http://www.bodybuilding.com/exercises/detail/view/name/two-arm-kettlebell-clean',
  'http://www.bodybuilding.com/exercises/detail/view/name/two-arm-kettlebell-jerk',
  'http://www.bodybuilding.com/exercises/detail/view/name/two-arm-kettlebell-military-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/upright-barbell-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/upward-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/wall-walk',
]

TRAPS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/barbell-shrug-behind-the-back',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-shrugs',
  'http://www.bodybuilding.com/exercises/detail/view/name/calf-machine-shoulder-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/clean-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/kettlebell-sumo-high-pull',
  'http://www.bodybuilding.com/exercises/detail/view/name/leverage-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/scapular-pull-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-behind-the-back-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-upright-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/snatch-shrug',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-upright-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/upright-cable-row',
  'http://www.bodybuilding.com/exercises/detail/view/name/upright-row-with-bands',
]

TRICEPS_DETAIL_URLS = [
  'http://www.bodybuilding.com/exercises/detail/view/name/band-skull-crusher',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-dips',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-press-powerlifting',
  'http://www.bodybuilding.com/exercises/detail/view/name/bench-press-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/board-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/body-tricep-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/body-up',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-incline-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-lying-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-one-arm-tricep-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/cable-rope-overhead-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/chain-handle-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-barbell-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-dumbbell-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-ez-bar-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/close-grip-push-up-off-of-a-dumbbell',
  'http://www.bodybuilding.com/exercises/detail/view/name/cobra-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-close-grip-bench-to-skull-crusher',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/decline-ez-bar-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/dip-machine',
  'http://www.bodybuilding.com/exercises/detail/view/name/dips-triceps-version',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-one-arm-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/dumbbell-tricep-extension-pronated-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/ez-bar-skullcrusher',
  'http://www.bodybuilding.com/exercises/detail/view/name/floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/floor-press-with-chains',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-barbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/incline-push-up-close-grip',
  'http://www.bodybuilding.com/exercises/detail/view/name/jm-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/jm-press-with-bands',
  'http://www.bodybuilding.com/exercises/detail/view/name/kneeling-cable-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/low-cable-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-close-grip-barbell-triceps-extension-behind-the-head',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-close-grip-barbell-triceps-press-to-chin',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-dumbbell-tricep-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/lying-triceps-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/machine-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-floor-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-pronated-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/one-arm-supinated-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/overhead-triceps',
  'http://www.bodybuilding.com/exercises/detail/view/name/parallel-bar-dip',
  'http://www.bodybuilding.com/exercises/detail/view/name/pin-presses',
  'http://www.bodybuilding.com/exercises/detail/view/name/push-ups-close-triceps-position',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-band-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-grip-triceps-pushdown',
  'http://www.bodybuilding.com/exercises/detail/view/name/reverse-triceps-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/ring-dips',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-bent-over-one-arm-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-bent-over-two-arm-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/seated-triceps-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/sled-overhead-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/smith-machine-close-grip-bench-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/speed-band-overhead-triceps',
  'http://www.bodybuilding.com/exercises/detail/view/name/speed-band-pushdown',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-bent-over-one-arm-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-bent-over-two-arm-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-low-pulley-one-arm-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-one-arm-dumbbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-overhead-barbell-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/standing-towel-triceps-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/supine-chest-throw',
  'http://www.bodybuilding.com/exercises/detail/view/name/suspended-triceps-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/tate-press',
  'http://www.bodybuilding.com/exercises/detail/view/name/tricep-dumbbell-kickback',
  'http://www.bodybuilding.com/exercises/detail/view/name/tricep-side-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-overhead-extension-with-rope',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-plank-extension',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-pushdown',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-pushdown-rope-attachment',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-pushdown-v-bar-attachment',
  'http://www.bodybuilding.com/exercises/detail/view/name/triceps-stretch',
  'http://www.bodybuilding.com/exercises/detail/view/name/weighted-bench-dip',
]

DETAIL_URLS_LUT = {
  'abd' => ABDOMINALS_DETAIL_URLS,
  'abc' => ABDUCTORS_DETAIL_URLS,
  'add' => ADDUCTORS_DETAIL_URLS,
  'bcp' => BICEPS_DETAIL_URLS,
  'clv' => CALVES_DETAIL_URLS,
  'chs' => CHEST_DETAIL_URLS,
  'frr' => FOREARMS_DETAIL_URLS,
  'glt' => GLUTES_DETAIL_URLS,
  'hms' => HAMSTRINGS_DETAIL_URLS,
  'lts' => LATS_DETAIL_URLS,
  'lwb' => LOWER_BACK_DETAIL_URLS,
  'mdb' => MIDDLEBACK_DETAIL_URLS,
  'nck' => NECK_DETAIL_URLS,
  'qdr' => QUADRICEPS_DETAIL_URLS,
  'shl' => SHOULDERS_DETAIL_URLS,
  'trp' => TRAPS_DETAIL_URLS,
  'trc' => TRICEPS_DETAIL_URLS,
}

EQUIPMENT_CODE_LUT = {
  'bands' => 'bnd',
  'barbell' => 'brb',
  'body only' => 'bdo',
  'cable' => 'cbl',
  'dumbbell' => 'dmb',
  'e-z curl bar' => 'ezb',
  'exercise ball' => 'exb',
  'foam roll' => 'fmr',
  'kettlebells' => 'ktt',
  'machine' => 'mch',
  'medicine ball' => 'mdb',
  'none' => 'nn',
  'other' => 'oth',
}

FORCE_CODE_LUT = {
  'pull' => 'pll',
  'push' => 'psh',
  'static' => 'stt',
  'n/a' => 'na',
}

LEVEL_CODE_LUT = {
  'beginner' => 'b',
  'intermediate' => 'i',
  'expert' => 'e',
}

MECHANICS_CODE_LUT = {
  'compound' => 'cmp',
  'isolation' => 'iso',
  'n/a' => 'na',
}

MUSCLE_GROUP_CODE_LUT = {
  'abs' => 'abd',
  'abdominals' => 'abd',
  'abductors' => 'abc',
  'adductors' => 'add',
  'biceps' => 'bcp',
  'calves' => 'clv',
  'chest' => 'chs',
  'forearms' => 'frr',
  'glutes' => 'glt',
  'hamstrings' => 'hms',
  'lats' => 'lts',
  'lower back' => 'lwb',
  'lower-back' => 'lwb',
  'middle back' => 'mdb',
  'middle-back' => 'mdb',
  'neck' => 'nck',
  'quadriceps' => 'qdr',
  'shoulders' => 'shl',
  'traps' => 'trp',
  'triceps' => 'trc',
}

TYPE_CODE_LUT = {
  'cardio' => 'crd',
  'olympic weightlifting' => 'olw',
  'plyometrics' => 'plm',
  'powerlifting' => 'pwr',
  'strength' => 'str',
  'stretching' => 'stt',
  'strongman' => 'stn',
}


def extract_detail_urls_from(results_url)
  require 'nokogiri'
  require 'open-uri'
  require 'set'
  detail_urls = Set.new
  doc = Nokogiri::HTML(open(results_url))

  doc.css('.exerciseName > h3 > a').each do |node|
    href = node['href']
    detail_urls.add href
  end

  return detail_urls
end

def assert_url_accessible(url)
  begin
      some_code
  rescue
       handle_error
  ensure
      this_code_is_always_executed
  end
end

def extract_exercise_hash_from(details_url)
  require 'nokogiri'
  require 'open-uri'

  exercise_hash = {}
  exercise_hash['id'] = nil
  exercise_hash['name'] = nil
  exercise_hash['aliases'] = []
  exercise_hash['desc'] = ''
  exercise_hash['equip_code'] = nil
  exercise_hash['force_code'] = nil
  exercise_hash['level_code'] = nil
  exercise_hash['link_detailed'] = nil
  exercise_hash['link_summary'] = nil
  exercise_hash['mechs_code'] = nil
  exercise_hash['main_mscl_grp_code'] = nil
  exercise_hash['other_mscl_grp_codes'] = []
  exercise_hash['type_code'] = nil

  doc = Nokogiri::HTML(open(details_url))

  doc.css('#exerciseDetails h1').each do |node|
    exercise_hash['name'] = node.text.strip
  end

  doc.css('#exerciseDetails p label').each do |node|
    aliases_csv = node.text.strip

    aliases = aliases_csv.split(',')
    aliases.map! { |item| item.titleize }
    aliases.uniq!
    aliases.sort!

    exercise_hash['aliases'] = aliases
  end

  doc.css('#exerciseDetails .row').each do |node|
    text = node.text.strip.downcase

    if text.start_with? 'type:'
      type = text.sub('type:', '').strip
      type_code = TYPE_CODE_LUT[type]
      unless type_code.nil?
        exercise_hash['type_code'] = type_code
      else
        puts "Unexpected type: #{type}"
        puts "\t#{details_url}"
      end
    elsif text.start_with? 'main muscle worked:'
      mscl_grp = text.sub('main muscle worked:', '').strip
      mscl_grp_code = MUSCLE_GROUP_CODE_LUT[mscl_grp]
      unless mscl_grp_code.nil?
        exercise_hash['main_mscl_grp_code'] = mscl_grp_code
      else
        puts "Unexpected muscle group: #{mscl_grp}"
        puts "\t#{details_url}"
      end
    elsif text.start_with? 'other muscles:'
      other_mscl_grp_csv = text.sub('other muscles:', '').strip
      other_mscl_grp_codes = []
      other_mscl_grp_csv.split(',').each do |other_mscl_grp|
        other_mscl_grp = other_mscl_grp.strip
        mscl_grp_code = MUSCLE_GROUP_CODE_LUT[other_mscl_grp]
        unless mscl_grp_code.nil?
          other_mscl_grp_codes << mscl_grp_code
        else
          puts "Unexpected other muscle group: #{other_mscl_grp}"
          puts "\t#{details_url}"
        end
      end
      exercise_hash['other_mscl_grp_codes'] = other_mscl_grp_codes
    elsif text.start_with? 'equipment:'
      equipment = text.sub('equipment:', '').strip
      equip_code = EQUIPMENT_CODE_LUT[equipment]
      unless equip_code.nil?
        exercise_hash['equip_code'] = equip_code
      else
        puts "Unexpected equipment: #{equipment}"
        puts "\t#{details_url}"
      end
    elsif text.start_with? 'mechanics type:'
      mechanics = text.sub('mechanics type:', '').strip
      mechs_code = MECHANICS_CODE_LUT[mechanics]
      unless mechs_code.nil?
        exercise_hash['mechs_code'] = mechs_code
      else
        puts "Unexpected mechanics: #{mechanics}"
        puts "\t#{details_url}"
      end
    elsif text.start_with? 'level:'
      level = text.sub('level:', '').strip
      level_code = LEVEL_CODE_LUT[level]
      unless level_code.nil?
        exercise_hash['level_code'] = level_code
      else
        puts "Unexpected level: #{level}"
        puts "\t#{details_url}"
      end
      exercise_hash['link_detailed'] = details_url
      summary_url = details_url.sub 'detail/view', 'main/popup'
      exercise_hash['link_summary'] = summary_url
    elsif text.start_with? 'force:'
      force = text.sub('force:', '').strip
      force_code = FORCE_CODE_LUT[force]
      unless force_code.nil?
        exercise_hash['force_code'] = force_code
      else
        puts "Unexpected force: #{force}"
        puts "\t#{details_url}"
      end
    elsif text.start_with? 'location:'
    elsif text.start_with? 'sport:'
    elsif text.start_with? 'your rating:'
    else
      puts "Unexpected text: #{text}"
      puts "\t#{details_url}"
    end
  end

  # Ensure other_mscl_grp_codes doesn't contain the mscl_grp_code:
  mscl_grp_code = exercise_hash['main_mscl_grp_code']
  unless mscl_grp_code.nil?
    other_mscl_grp_codes = exercise_hash['other_mscl_grp_codes']
    other_mscl_grp_codes.delete(mscl_grp_code)
  end
  other_mscl_grp_codes.uniq!
  other_mscl_grp_codes.sort!

  return exercise_hash
end


##
#
def test_extract_exercise_hash_from()
  exercise_hash = extract_exercise_hash_from('http://www.bodybuilding.com/exercises/detail/view/name/34-sit-up')
  puts exercise_hash
end


##
# Prints all detail URLs grouped by muscle groups to the console.
#
def generate_detail_urls_from_results_urls
  RESULTS_URLS.each do |results_url|
    puts results_url
    detail_urls = extract_detail_urls_from results_url
    detail_urls.each do |detail_url|
      puts "  '#{detail_url}',"
    end
    puts
  end
end


##
#
def generate_grouped_exercise_files
  muscle_group_codes = ['abd', 'abc', 'add', 'bcp', 'clv', 'chs', 'frr', 'glt', 'hms', 'lts', 'lwb', 'mdb', 'nck', 'qdr', 'shl', 'trp', 'trc']

  muscle_group_codes.each do |muscle_group_code|
    puts "\tStarted muscle group #{muscle_group_code} at #{Time.new}"

    exercise_hashes = []
    detail_urls = DETAIL_URLS_LUT[muscle_group_code]
    detail_urls.each do |detail_url|
      exercise_hash = extract_exercise_hash_from detail_url
      exercise_hashes.push exercise_hash
    end
    exercises_json = JSON.pretty_generate exercise_hashes
    exercises_file = File.new "exercises-#{muscle_group_code}.json", 'w'
    exercises_file.write exercises_json
    puts "\tFinished muscle group #{muscle_group_code} at #{Time.new}"
  end
end


##
#
def generate_exercise_files()
  RESULTS_URLS.each do |results_url|
    muscle_group = results_url.split(/\//).last
    muscle_group_code = MUSCLE_GROUP_CODE_LUT[muscle_group]

    puts "\tStarted muscle group #{muscle_group_code} at #{Time.new}"

    exercise_hashes = []
    detail_urls = extract_detail_urls_from results_url
    detail_urls.each do |detail_url|
      exercise_hash = extract_exercise_hash_from detail_url
      exercise_hashes.push exercise_hash
    end
    exercises_json = JSON.pretty_generate exercise_hashes
    exercises_file = File.new "exercises-#{muscle_group_code}.json", 'w'
    exercises_file.write exercises_json
    puts "\tFinished muscle group #{muscle_group_code} at #{Time.new}"
  end
end


puts "Started at #{Time.new}"
generate_exercise_files()
puts "Finished at #{Time.new}"
