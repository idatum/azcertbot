# Split name from DNS zone.
# Example input: www.east.example.com
#         output: www.east example.com

BEGIN {
  FS = "."
}
{
  # subname
  for (n = NF - 1; n >= 2; n--) {
    if (n < NF - 1) {
      printf "."
    }
    printf "%s", $(NF - n)
  }
  # zone
  printf " %s.%s", $(NF - 1), $(NF)
 
  print ""
}
