#!/usr/bin/perl -w
use strict;
use warnings;
my $dir = $ARGV[0];
$dir or die;
chdir $dir or die;
my @files = glob("*");
my $mtime = (stat $files[0])[9];
foreach my $file (sort @files) {
    print "file: $file, ";
    my $ret;
    $ret = utime $mtime, $mtime, ($file);
    print "mtime: $mtime (".($ret==1?"ok":"fail").") ";
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isDST) = localtime $mtime;
    my $timeForSetFile = sprintf("%02d/%02d/%04d %02d:%02d:%02d", $mon + 1, $mday, $year + 1900, $hour, $min, $sec);
    $ret = system("/usr/bin/SetFile", "-d", $timeForSetFile, $file);
    print "ctime: $timeForSetFile (".($ret==0?"ok":"fail").")\n";
    $mtime++;
}
