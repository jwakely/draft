#!/usr/bin/awk -f

/(begin|end){itemdescr}|\\rowsep|\\capsep|\\rSec/ {
  constraints=0
  mandates=0
  expects=0
  effects=0
  ensures=0
  throws=0
}

/\\constraints/ {
  if (constraints++)
    printf "%s:%d: Two \\constraints\n", FILENAME, FNR
  if (mandates)
    printf "%s:%d: \\constraints after \\mandates\n", FILENAME, FNR
  if (expects)
    printf "%s:%d: \\constraints after \\expects\n", FILENAME, FNR
  if (effects)
    printf "%s:%d: \\constraints after \\effects\n", FILENAME, FNR
  if (ensures)
    printf "%s:%d: \\constraints after \\ensures\n", FILENAME, FNR
  if (throws)
    printf "%s:%d: \\constraints after \\throws\n", FILENAME, FNR
}

/\\mandates/ {
  if (mandates++)
    printf "%s:%d: Two \\mandates\n", FILENAME, FNR
  if (expects)
    printf "%s:%d: \\mandates after \\expects\n", FILENAME, FNR
  if (effects)
    printf "%s:%d: \\mandates after \\effects\n", FILENAME, FNR
  if (ensures)
    printf "%s:%d: \\mandates after \\ensures\n", FILENAME, FNR
  if (throws)
    printf "%s:%d: \\mandates after \\throws\n", FILENAME, FNR
}

/\\expects/ {
  ++expects
  if (effects)
    printf "%s:%d: \\expects after \\effects\n", FILENAME, FNR
  if (ensures)
    printf "%s:%d: \\expects after \\ensures\n", FILENAME, FNR
  if (throws)
    printf "%s:%d: \\expects after \\throws\n", FILENAME, FNR
}

/\\effects/ {
  effects++
  if (ensures)
    printf "%s:%d: \\effects after \\ensures\n", FILENAME, FNR
  if (throws)
    printf "%s:%d: \\effects after \\throws\n", FILENAME, FNR
}

/\\ensures/ {
  ensures++
  if (throws)
    printf "%s:%d: \\ensures after \\throws\n", FILENAME, FNR
}

/\\throws/ {
  throws++
}
