#!/bin/bash
result=""
productIds=$1
for productId in $(echo $productIds | sed "s/,/ /g")
do
    printf "Checking product: $productId\n";
    #URL="http://localhost/?go=$productId";
    URL="http://www.kohls.com/search.jsp?search=$productId&submit-search=web-regular";

    updatedURL=$URL
    count=0
    while :
    do
        updatedURL=`curl -Ls -o /dev/null -w %{url_effective} "$URL"`
	   if [ "$URL" == "$updatedURL" ]; then
    	    printf "sleeping for 2 second\n"
	        sleep 2;
	        count=$(expr "$count" + 1)
	        echo "COUNT:$count"
	            if [ $count -eq 10 ]; then
	                echo "invalid product id:$productId\n"
	                break;
	             fi
       else 
            printf "Effective url for product id $productId is:\n $updatedURL"
            break;
       fi
    done
    
done
