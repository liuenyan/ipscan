#!/usr/bin/perl -w

use strict;
use warnings;

my $regexp_ip='\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
my $data_dir="./data/";

opendir(my $dh, $data_dir) || die "can't open $data_dir: $!\n";
my @files=readdir($dh);
closedir($dh);

for (@files){

    open(my $fh,"<",$data_dir.$_) || die "can't open $_: $!\n";
    while(<$fh>){
        if(/^Nmap scan report for ($regexp_ip)$/){
            print "$1\t\n";
        }elsif(/^Nmap scan report for (.*) \(($regexp_ip)\)$/){
            print "$2\t$1\n";
        }
    }
    
    close($fh);
}

