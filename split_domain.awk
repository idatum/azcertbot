# Split name from DNS zone.
# Example input: www.east.example.com
#         output: www.east example.com

BEGIN {
    RS = " ";
    FS = ".";
}
{
    if (NF < 2) {
        printf "Invalid domain: %s\n", $0;
        exit 2;
    }
    # subname
    for (n = NF - 1; n >= 2; --n) {
        if (n < NF - 1) {
            printf FS;
        }
        printf $(NF - n);
    }
    if (NF > 2) {
        printf " ";
    }
    # zone
    zone = sprintf ("%s%s%s", $(NF - 1), FS, $NF);
    printf zone;
}