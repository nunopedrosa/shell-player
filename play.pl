#!/usr/bin/perl
use strict;
use List::Util 'shuffle';
use Cwd;

sub play_dir {
    my ($dir)=@_;
    $dir= "." if (not $dir);
    chdir($dir);
    #print "$CWD\n";
    my @files= shuffle(<"*">);
    foreach my $music (@files) {
        if (-d $music) {
            play_dir($music);
        }
        next if (not -f $music);
        next if (not $music=~/\.mp3/);
        my ($name)=($music=~/.*?(\D.*\s.\s.*-)/);
        print " \"".cwd()."/$music\"\n";
        my $res=`say "Playing next, $name"`;
        $res=`afplay "$music"`;
        $res=`say "This was $name"`;
    }
    chdir("..") if (not $dir eq '.');
    return;
}

play_dir($ARGV[0]);

