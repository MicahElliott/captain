#! /bin/zsh

# Quickly run test NSs utilizing existing nrepl connection
# Run typically from a git hook, filters for clj files that were changed in commit
# Requires REP to be installed: https://github.com/eraserhd/rep

# https://ask.clojure.org/index.php/12136/how-to-connect-to-nrepl-server-using-the-clojure-command-line
# clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version "0.5.3"}}}' -m nrepl.cmdline -c --host 127.0.0.1 --port 36387

# https://stackoverflow.com/a/24337705/326516
# (clojure.test/run-tests 'crawlingchaos.domain.installer.disbursements-test)

whence -p rep >/dev/null || {
    echo "Please install rep to run fast tests connected to your nrepl:"
    echo "https://github.com/eraserhd/rep\n\n"
    exit 0
}

log=cljtest.log

# For each NS file that changed, find if corresponding test NS exists, and run it.
# for f in src/clj/crawlingchaos/domain/installer/*.clj; do
# https://stackoverflow.com/a/41876600/326516
# for f in ${(M)@:#*.clj} ; do # filter to only clj files
for f in ${(m)@:#*_test.clj} ; do # filter to only non-test clj files
    testfile=$(sed -r -e 's:^src/clj:test/clj:' -e 's/.clj$//' <<< $f )"_test.clj"
    echo "Preparing to test src file: $f"
    if [[ -f $testfile ]]; then
        # Convert file path to NS
        n=$(echo $f |sed -r -e 's:^src/clj/::' -e 's/\.clj$//' -e 's^/^.^g' -e 's/_/-/g')
        # Reload NS and test NS, and run them!
        rep "(require '${n} :reload) (require '${n}-test :reload) (clojure.test/run-tests '${n}-test)" >$log
        # rep "(clojure.tools.namespace.repl/refresh) (clojure.test/run-tests '${n}-test)" >$log
        if ! grep '0 failures, 0 errors.' $log; then cat $log; exit 1; fi
    else
        echo "WARN: Missing test file for src: $testfile"
    fi
done

# Clean up log file
# rm $log
