

if __name__ == "__main__":
    import pickle
    import sys

    if len(sys.argv) < 4:
        print('%s [input phog1] [input phog2] [output phog]' % sys.argv[0])
        exit(-1)

    rettype2mle1_file = sys.argv[1]
    rettype2mle2_file = sys.argv[2]
    output_file = sys.argv[3]

    statFile = open(rettype2mle1_file, 'rb')
    rettype2mle1 = pickle.load(statFile)
    statFile = open(rettype2mle2_file, 'rb')
    rettype2mle2 = pickle.load(statFile)

    print('Mle 1 : ', [key for key in rettype2mle1])
    print('Mle 2 : ', [key for key in rettype2mle2])

    rettype2mle = {**rettype2mle1, **rettype2mle2}
    print('Result : ', [key for key in rettype2mle])


    with open(output_file, 'wb') as f:
        pickle.dump(rettype2mle, f)