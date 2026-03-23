# Operators available in this repository
operators := "add conv flatten matmul maxpool reshape sigmoid"

# Default prover for why3
prover := "alt-ergo"

# Colors
bold  := '\033[1m'
cyan  := '\033[36m'
red   := '\033[31m'
reset := '\033[0m'

# Operators that support C code extraction (have a Makefile in formal/)
extractable := "add conv flatten matmul reshape sigmoid"

# Run proofs for a given operator, or all operators if none is specified
prove operator="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{operator}}" = "all" ]; then
        for op in {{operators}}; do
            echo -e "--- Running proofs for: {{cyan}}{{bold}}$op{{reset}} (prover: {{red}}{{bold}}{{prover}}{{reset}})"
            (cd operators/$op/formal && why3 prove -P {{prover}} $op.mlw)
        done
    elif [ "{{operator}}" = "tensor" ]; then
        echo -e "--- Running proofs for: {{cyan}}{{bold}}tensor{{reset}} (prover: {{red}}{{bold}}{{prover}}{{reset}})"
        cd tensor/tensor && why3 prove -P {{prover}} tensor.mlw
    else
        echo -e "--- Running proofs for: {{cyan}}{{bold}}{{operator}}{{reset}} (prover: {{red}}{{bold}}{{prover}}{{reset}})"
        cd operators/{{operator}}/formal && why3 prove -P {{prover}} {{operator}}.mlw
    fi

# Extract C code for a given operator, or all operators if none is specified
extract operator="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{operator}}" = "all" ]; then
        echo -e "--- Extracting {{cyan}}{{bold}}tensor{{reset}}"
        (cd tensor/tensor && make lib)
        for op in {{extractable}}; do
            echo -e "--- Extracting: {{cyan}}{{bold}}$op{{reset}}"
            (cd operators/$op/formal && make lib)
        done
    elif [ "{{operator}}" = "tensor" ]; then
        echo -e "--- Extracting {{cyan}}{{bold}}tensor{{reset}}"
        cd tensor/tensor && make lib
    else
        echo -e "--- Extracting: {{cyan}}{{bold}}{{operator}}{{reset}}"
        cd operators/{{operator}}/formal && make lib
    fi

# Clean generated code for a given operator, or all operators if none is specified
clean operator="all":
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "{{operator}}" = "all" ]; then
        echo -e "--- Cleaning {{cyan}}{{bold}}tensor{{reset}}"
        (cd tensor/tensor && make clean)
        for op in {{extractable}}; do
            echo -e "--- Cleaning: {{cyan}}{{bold}}$op{{reset}}"
            (cd operators/$op/formal && make clean)
        done
    elif [ "{{operator}}" = "tensor" ]; then
        echo -e "--- Cleaning {{cyan}}{{bold}}tensor{{reset}}"
        cd tensor/tensor && make clean
    else
        echo -e "--- Cleaning: {{cyan}}{{bold}}{{operator}}{{reset}}"
        cd operators/{{operator}}/formal && make clean
    fi

# Verify a network model, or all models if none is specified
verify model="all":
    #!/usr/bin/env bash
    set -euo pipefail
    load_paths=""
    for op in {{operators}}; do
        load_paths="$load_paths -L ../operators/$op/formal"
    done
    if [ "{{model}}" = "all" ]; then
        for mlw in network/*.mlw; do
            m=$(basename $mlw .mlw)
            echo -e "--- Verifying: {{cyan}}{{bold}}$m{{reset}} (prover: {{red}}{{bold}}{{prover}}{{reset}})"
            (cd network && why3 prove -P {{prover}} $load_paths $(basename $mlw))
        done
    else
        echo -e "--- Verifying: {{cyan}}{{bold}}{{model}}{{reset}} (prover: {{red}}{{bold}}{{prover}}{{reset}})"
        cd network && why3 prove -P {{prover}} $load_paths {{model}}.mlw
    fi
