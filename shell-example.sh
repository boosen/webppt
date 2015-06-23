#!/bin/bash

set -e
[ -x `pwd`/shell-example.sh ] || exit 0

trap "" 1 2 3
date=`date +%d/%m/%y`
user=`whoami`
host=`hostname`

susy_cache_clear()
{
    php=`which php`
    cache_command=/var/www/susy.mdpi.com/app/console
    if [ $# -gt 0 -a $1 = "no-debug"]
    then
        $php $cache_command cache:clear --no-debug
    else
        $php $cache_command cache:clear
    fi
}

while :
do
cat <<menu
-------------------------------------------------
 $user          $host           $date
-------------------------------------------------
        1:susy.mdpi.com
        2:view process info
        3:view user info
        h:help
        q:quit
-------------------------------------------------
menu

echo -en "please input choice [1,2,3,h,q]:"
read choice
case $choice in
1)
    while :
    do
        cat <<susy
*************************************************
 $user          $host           $date
*************************************************
        1:go suda-bundle
        2:clear cache
        0:back
*************************************************
susy
        echo -e "please input choice[1, 2, 0]"
        read susymenu
        case $susymenu in
        1)
            cd /var/www/susy.mdpi.com/vendor/mdpi/suda-bundle/MDPI/SudaBundle
            ;;
        2)
            susy_cache_clear no-debug
            ;;
        0)
            break;;
        *)
            echo -e "input error! please input again!"
            continue
            ;;
        esac
    done
    ;;
2)
    ps aux|sort -m|head -10
    ;;
3)
    who
    ;;
H|h)
    cat <<menu_help
select1 "change font color" can alert current UI's color
select1 "view ps info" can view ps info
select1 "view user info" can view user info
menu_help
;;
Q|q)
exit 0
;;
*)
    echo -e "input error! please input again!"
    continue
    ;;
esac
done