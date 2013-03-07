#!/usr/bin/perl

print "content-type: text/html \n\n";

# DEFINE A HASH
%coins = ( "Quarter" , 25,
           "Dime" ,    10,
           "Nickel",    5 );

# SET UP THE TABLE
print "<table>";
print "<th>Keys</th><th>Values</th>";

# EXECUTE THE WHILE LOOP
while (($key, $value) = each(%coins)){
     print "<tr><td>".$key."</td>";
     print "<td>".$value."</td></tr>";
}
print "</table>";