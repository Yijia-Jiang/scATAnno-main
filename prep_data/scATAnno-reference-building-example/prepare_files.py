import pandas as pd
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--inputFile', help="Read in peak bed file")
parser.add_argument('--outputFile', help="Output spikein file required for reference building")
args = parser.parse_args()
bedfile=args.inputFile
outfile=args.outputFile

# bedfile="adult_peaks_promoters.bed"
# outfile="spikein_fragment_adult_promoters.tsv"

peaks = pd.read_table(bedfile, header = None)
peaks=peaks.iloc[:,0:3]

peaks.columns = ["chr", "start", "end"]
min_start = peaks.groupby(["chr"])["start"].min()
max_end = peaks.groupby(["chr"])["end"].max()

peak_ranges = pd.merge(min_start, max_end, left_index=True, right_index=True)

peak_ranges["cell"] = "spike-in"
peak_ranges["read"] = 1

peak_ranges.to_csv(outfile, header=None,  sep = '\t')

