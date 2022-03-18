# Euphony
Euphony: a probabilistic model-guided program synthesizer

## Build (tested on Linux)
```sh
$ ./build
$ . bin/setenv
```

## Learning a PHOG model from training data
```sh
$ bin/run_phog_learner [filename for PHOG] [training instances]
```
Here, "training instaces" are just SyGuS problems along with solutions. 
Any functions defined in a SyGuS formulation are regarded as solutions of the SyGuS problem and used for learning. 
For example, at the bottom of ```benchmarks/string/train/bikes.sl```, you can see a function definition 
```
(define-fun f_1 ((name String)) String (str.substr name 0 (- (str.len name) 3)))
```
which will be regarded as a solution of the problem of ```bikes.sl```.  
 
### Example. Learning a PHOG for the STRING domain
```sh
$ bin/run_phog_learner phog_str benchmarks/string/train/*.sl
```
You will be able to see file ```phog_str``` generated. You can use the PHOG to guide the search as follow:
```sh
$ bin/run_with_new_phog phog_str benchmarks/string/test/phone-5.sl 
```
which will be much fater than solving using EUSolver (```bin/run_string_eusolver```) 
In a similar manner, you can learn PHOGs for the BITVEC and CIRCUIT domains as well 
using ```benchmarks/bitvec/train/*.sl``` and ```benchmarks/circuit/train/*.sl```

### Choosing hyper-parameters
There are parameters that should be properly determined for learning. 
On the top of ```bin/run_phog_learner```, you can find several variables. 
Increasing ```lambda_val``` can avoid overfitting. 
By increasing values of ```max_iter*``` and ```pool_size```, you can put more computing resources for learning better models. 

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
## Run N-Grams
N-gram models have been trained in the experimental/[domain] folder. To run artifact on one of these ngram files, use the --ngram=True flag. For example
```./artifact string --timeout 3600 --only_euphony --ngram=True```