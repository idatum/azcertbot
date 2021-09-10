# Split domain list into -d parameters for certbot.
# Example input: www.example.com,example.com
#         output: -d www.example.com -d example.com

BEGIN {
    FS=" ";
    OFS="";
    RS=",";
    ORS="";
}

{
    if (NR > 1) {
        printf " ";
    }
    printf "-d %s", $1;
}