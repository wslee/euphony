# Euphony
Euphony: a probabilistic model-guided program synthesizer

## Build (tested on Linux)
```sh
$ ./build
$ . bin/setenv
```

## Reproducing the experimental results in the paper
```sh
# Run the experiments
$ ./artifact [string | bitvec | circuit] [--timeout <sec> (default: 3600)] [--memory <GB> (default: 16)]
# Table 4,5,6
$ ./artifact [string | bitvec | circuit] --timeout 3600
# Table 4,5,6 without EUSOLVER
$ ./artifact [string | bitvec | circuit] --timeout 3600 --only_euphony
# Figure 8
$ ./artifact [string | bitvec | circuit] --timeout 3600 --only_euphony --strategy [pcfg | uniform | pcfg_uniform]
```

## Reproducing Table 7 (comparison between Euphony and FlashFill)
### Running Euphony
```sh
$ ./artifact string_flashfill --timeout 600 --only_euphony [--memory <GB> (default: 16)]
```
### Running FlashFill
1. Modify the first line in "bin/run.ps1" to set an output directory. 
2. Launch Windows PowerShell and run the PowerShell script "bin/run.ps1".

## Run Euphony on a single SyGus file
```sh
$ ./bin/run_[string | bitvec | circuit] [a SyGuS input file]
# For example
$ ./bin/run_string benchmarks/string/test/exceljet1.sl
```
