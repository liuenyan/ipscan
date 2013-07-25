#!/usr/bin/perl -w

use strict;
use warnings;

my $regexp_ip='\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
my @ip_list;

open(IPLIST ,"<", "ip_test.txt");

while (<IPLIST>){
    if($_=~/^($regexp_ip)\s+($regexp_ip)\s+(\S+)\s+(\S*)/){

        my @start=split(/\./,$1);
        my @stop=split(/\./,$2);
        my @range;

        for(my $i=0;$i<4;$i++){
            if($start[$i]==$stop[$i]){
                $range[$i]=$start[$i];
            }else{
                $range[$i]=$start[$i]."-".$stop[$i];
            }
        }

        my $range=join("\.",@range);
        push(@ip_list,$range);
    }
}

close(IPLIST);

print "#!/bin/sh\n\n";

for(@ip_list){
    my $command="nmap -sP $_ > data/nmap_$_.txt";
    print "$command\n";
}

printf "\n";

