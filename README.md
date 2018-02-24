# Euphony
Euphony: a probabilistic model-guided program synthesizer

## Build (tested on Linux)
```sh
$ ./build
$ . bin/setenv
```

## Reproduce the experiments in the paper
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

## Run Euphony on a single SyGus file
```sh
$ ./bin/run_[string | bitvec | circuit] [a SyGuS input file]
# For example
$ ./bin/run_string benchmarks/string/test/exceljet1.sl
```
