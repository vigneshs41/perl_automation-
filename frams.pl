
=pod

sub remove_common_letters {
    my ($name1, $name2) = @_;
    my %common_letters;
    my @name1_letters = split('', $name1);
    my @name2_letters = split('', $name2);
    
    foreach my $letter (@name1_letters) {
        $common_letters{$letter} = 1 if grep { $_ eq $letter } @name2_letters;
    }
    
    $name1 =~ s/[@{[join('', keys %common_letters)]}]//g;
    $name2 =~ s/[@{[join('', keys %common_letters)]}]//g;
    
    my $common_removed = join('', keys %common_letters);
    
    return ($name1, $name2, $common_removed);
}


sub find_last_letter_meaning {
    my ($word, $total_count) = @_;
    my $index = 0;
    my @removed_letters;
    
    while (length($word) > 1) {
        $index = ($index + $total_count - 1) % length($word);
        my $removed_letter = substr($word, $index, 1);
        push @removed_letters, $removed_letter;
        substr($word, $index, 1) = '';
    }
    
    return ($word, \@removed_letters);
}

sub main {
    print "Enter the first name: ";
    my $name1 = uc(<STDIN>);
    chomp($name1);
    
    print "Enter the second name: ";
    my $name2 = uc(<STDIN>);
    chomp($name2);
    
    
    $name1 =~ s/\s+//g; # Remove spaces from name1
    $name2 =~ s/\s+//g; # Remove spaces from name2
    
    my ($new_name1, $new_name2, $common_removed) = remove_common_letters($name1, $name2);
    my $total_count = length($new_name1) + length($new_name2);
    
    my $word = "FRAMES";
    my ($last_letter, $removed_letters) = find_last_letter_meaning($word, $total_count);
    
    my %meanings = (
        'F' => 'Friend',
        'R' => 'Relationship',
        'A' => 'Affection',
        'M' => 'Marriage',
        'E' => 'Enemey',
        'S' => 'Sister'
    );
    
    print "Common letters removed: $common_removed\n";
    print "Remaining letters: $new_name1$new_name2\n";
    print "Total count: $total_count\n";
    
    my $round = 1;
    foreach my $letter (@$removed_letters) {
        print "Round $round: Removed letter '$letter' (Represents: $meanings{$letter})\n";
        $round++;
    }
    
    print "The last letter '$last_letter' represents: $meanings{$last_letter}\n";
}

main();


=cut

sub remove_common_letters {
    my ($name1, $name2) = @_;

    # Remove spaces and convert names to uppercase
    $name1 =~ s/\s+//g;
    $name2 =~ s/\s+//g;
    $name1 = uc($name1);
    $name2 = uc($name2);

    my %common_letters;

    foreach my $letter (split('', $name1)) {
        $common_letters{$letter}++ if index($name2, $letter) >= 0;
    }

    my $new_name1 = '';
    my $new_name2 = '';

    foreach my $letter (split('', $name1)) {
        $new_name1 .= $letter unless $common_letters{$letter};
    }

    foreach my $letter (split('', $name2)) {
        $new_name2 .= $letter unless $common_letters{$letter};
    }

    my $common_removed = join('', keys %common_letters);

    return ($new_name1, $new_name2, $common_removed);
}



sub find_last_letter_meaning {
    my ($word, $total_count) = @_;
    my $index = 0;
    my @removed_letters;
    
    while (length($word) > 1) {
        $index = ($index + $total_count - 1) % length($word);
        my $removed_letter = substr($word, $index, 1);
        push @removed_letters, $removed_letter;
        substr($word, $index, 1) = '';
    }
    
    return ($word, \@removed_letters);
}

sub main {
    print "Enter the first name: ";
    my $name1 = uc(<STDIN>);
    chomp($name1);
    
    #print "Enter the name2 file name: ";
    #my $file_name = <STDIN>;
    #chomp($file_name);
    
    my $file_name = "/home/vignesh/Documents/fun_perl/fun_name_list.txt";
    
    open my $file, '<', $file_name or die "Cannot open $file_name: $!";
    
    open my $output_file, '>', 'output/output_file.txt' or die "Cannot open output_file.txt: $!";
    
    my %meanings = (
        'F' => 'Friend',
        'R' => 'Relationship',
        'A' => 'Affection',
        'M' => 'Marriage',
        'E' => 'Enemy',
        'S' => 'Sister'
    );
    
    while (my $name2 = <$file>) {
        chomp($name2);
        
        # Before common letter removal
#print "Before common letter removal:\n";
#print "Name1: $name1\n";
#print "Name2: $name2\n";
     print $output_file "boy: $name1\n";
     print $output_file "girl: $name2\n";

my ($new_name1, $new_name2, $common_removed) = remove_common_letters($name1, $name2);

# After common letter removal
#print "After common letter removal:\n";
#print "New Name1: $new_name1\n";
#print "New Name2: $new_name2\n";
#print "Common Letters Removed: $common_removed\n";

        my $total_count = length($new_name1) + length($new_name2);
        
        my $word = "FRAMES";
        my ($last_letter, $removed_letters) = find_last_letter_meaning($word, $total_count);
        
        #print $output_file "boy: $new_name1\n";
        #print $output_file "girl: $new_name2\n";
        print $output_file "Common letters removed: $common_removed\n";
        print $output_file "Remaining letters: $new_name1$new_name2\n";
        print $output_file "Total count: $total_count\n";
        
        my $round = 1;
        foreach my $letter (@$removed_letters) {
            print $output_file "Round $round: Removed letter '$letter' (Represents: $meanings{$letter})\n";
            $round++;
        }
        
        print $output_file "The last letter '$last_letter' represents: $meanings{$last_letter}\n";
        
        print $output_file "\n"; # Empty space before the next output
    }
    
    close $file;
    close $output_file;
}

main();

