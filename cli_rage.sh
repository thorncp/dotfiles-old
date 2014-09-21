anger_aliases=(
  fu
  fuu
  fuuu
  ffu
  ffuu
  ffuuu
  fffu
  fffuu
  fffuuu
  fuck
  shit
  omg
  wtf
  zomg
)

intrigue_aliases=(
  huh
  wow
  neat
  holy
  wat
  hmm
  hmmm
  hmmmm
)

cli_rage_anger() {
  responses=(
    "yo, calm down"
    "fffffffuuuuuuuuuuuu"
    "whoa buddy!"
  )

  echo ${responses[$((RANDOM%${#responses[@]}))]}
}

cli_rage_intrigue() {
  responses=(
    "how about that"
    "indeed"
    "i'll be damned"
    "huh indeed"
  )

  echo ${responses[$((RANDOM%${#responses[@]}))]}
}

for a in "${anger_aliases[@]}"
do
  alias $a=cli_rage_anger
done

for a in "${intrigue_aliases[@]}"
do
  alias $a=cli_rage_intrigue
done
