# Requirements:
#   Python 2.6:
#     Should already be installed on newer Ubuntus.
#   biopython:
#     Installation:
#       For Ubuntu: sudo aptitude install python-biopython
#   cap3:
#     Installation:
#       Download from here: http://seq.cs.iastate.edu/cap3.html
#       Extract to e.g. /opt/CAP3
#       Edit cap3_path in this file to point to the cap3 binary

# constructs have many clones
# clones have many traces

# == _init_traces_ ==
#
# This method reads the trace files.
#
# for each ab1 file, the ref_id and clone_id are found
# e.g. for: 
#   pFAB2102.12_QB3809_2011-07-28_H04.ab1
#       ^^^^ ^^
#    ref_id   clone_id
#
#   sometimes there is no clone id, in which case it is set to 1
#
# a new construct is instantiated for each ref id
#   saved in sequencing.constructs[] with ref_id as the key and an empty sequence
#
# a new clone is instantiated to sequencing.constructs[ref_id].clones[clone_id]
#
# the ab1 parser is used to retrieve the quality and sequence from the ab1 file
# using the get_trim method from the abi_parser library
# and this information is saved to:
#
#   sequencing.constructs[ref_id].clones[clone_id].traces[id]
# 
# where id is the filename minus the ".ab1".

# == _init_ref ==
#
# This method reads the reference sequences.
# 
# A big csv file of all biofab reference sequences is read in.
# For each reference sequence, if a construct exists, the construct
# is updated with the reference sequence and annotations are added
#

# == analyse ==
#
# Does actual analyses.
#
# construct.get_boundaries
#   clone.write_fasta
#   clone.align
#   clone.analyse_aln
#   clone.write_aln
# construct.set_validity

# == construct.get_boundaries ==
#
# TODO

# == clone.write_fasta ==
#
# Writes a fasta file withe the reference sequence as the first entry
# and the sequence of each trace as a subsequent entry

# == clone.align ==
#
# Uses cap3_to_alns to call the cap3 binary.

# == cap3_to_alns ==
#
# Runs the cap3 binary on the fasta files created by clone.write_fasta
# and uses the parse_cap3 library to parse the output.
# 
# The output of cap3_to_alns is an array for BioPython MultipleSeqAlignment objects


# == clone.analyse_aln ==
#
# TODO


# == clone.write_aln ==
#
# Writes an HTML file for each alignment


# == reorganize ==
#
# re-organizes output files and delete temporary files
#
# TODO

# == output_better ==
#
# Writes HTML output.


# where the sequence to be checked starts and stops
starts = ['ACCCTATCAGCTGCGTGCTT']
stops = ['ctttctgcgtttata']

# NOTE: file is missing.
oligo_path = '/home/juul/biofab/sftp/Dropbox_50gig/BIOFAB/Wet Lab/Data/Sequencing/sequencing_oligos.csv'

# If no mapping csv file is supplied, the mapping is extracted from filenames
mapping_path = ''

# The ab1 trace files from the sequencing company
trace_path = '/home/juul/biofab/rails/app/python/seq_checker/traces'

# whether or not all check must be reported (logical: True/False)
exhaustive = True

# a regular expression to parse the name of the file
# first () should match the ref id
# second () is optional and should match clone id
# if second () is not included, or matches an empty string, the clone id will be 1
parse_phrase = '(\d+)\.(\d+)'

# if output_folder is set to '', then trace_path is used for output
# setting output to something else doesn't work
output_folder = ''

html_output_folder = '/home/juul/biofab/rails/public/seq_checker'

# A list of all biofab reference sequences
ref_path = '/home/juul/biofab/sftp/Dropbox_50gig/BIOFAB/Wet Lab/Data/pFAB-pOUT/pFAB.csv'

# Features to use for annotation
feat_path = '/home/juul/biofab/sftp/Dropbox_50gig/BIOFAB/Wet Lab/APE/Features/Default_Features.txt'

# Location of the cap3 program
cap3_path = '/opt/CAP3/cap3'
