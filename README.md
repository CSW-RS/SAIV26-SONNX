# SAIV26

This repository serves as the companion artifact for a paper submitted to the SAIV'26 Symposium.

This work is a specific and concrete fork of a much broader initiative called [SONNX](https://github.com/ericjenn/working-groups/tree/ericjenn-srpwg-wg1/safety-related-profile/sonnx), whose goal is to develop a **safe profile for Machine Learning**, based on the [ONNX](https://onnx.ai/) framework. While the SONNX project covers the full scope of building a verified ML inference stack, this repository focuses on a well-defined subset of operators and presents the formal verification methodology and results discussed in the paper.

---

## Repository Structure

The repository is organized into two main directories:

```
SAIV26/
├── tensor/                      # Core tensor library (shared across all operators)
│   ├── code/                    # Extracted C code (ctensor, cindex)
│   ├── drivers/                 # Why3 extraction drivers (.drv)
│   └── tensor/                  # Why3 formal specifications (.mlw)
│
|── operators/                   # Neural network operator specifications
|   ├── add/                     # Addition
|       ├── code/                # C operator extracted code
|       ├── formal/              # Why3 formal specifications (.mlw)
|       └── add.md               # Informal specification (Markdown)
|   ├── sigmoid/                 
|       ├── code/                
|       ├── formal/              
|       └── sigmoid.md           
|   ├── (...)                    # Other operators
|   └── general_definitions      # General definitions
|
└── networks/                    # Network specifications
    ├── logisticRegression.md    # Logistic regression informal specification
    └── logisticRegression.mlw   # Logistic regression formal specification
```
---

## Informal Specification

Each operator has a Markdown document (e.g., `add.md`, `conv.md`, `matmul.md`) that serves as its **informal specification**. These documents provide a description of the operator at three levels of detail: **textual, mathematical, and example-based**. 

It also presents the operator's **inputs** and **attributes**, whose restrictions are explicitly specified according both to the ONNX specification and to the SONNX profile.

These specifications are written for human consumption and serve as the reference from which the formal specifications are derived.

---
## Formal Specification

The formal specifications are written in [Why3](https://www.why3.org/) (`.mlw` files) and follow a **two-level architecture**: an abstract level and a concrete level.

### Abstract Level

The abstract level defines the **mathematical semantics** of each operator.

It neglects implementation details and focuses on mirroring the descriptions presented at the informal spec.

### Concrete Level

The concrete level provides an **imperative implementation** that operates on C-compatible data structures (`ctensor`) and is proven to refine the abstract specification.

Implementation details and design choices are made explicit at this level, and it serves as the basis for code extraction.

---

## Foundation Modules — Tensors

Provides the core definitions for the formalization.

Thsese modules include:

- `tensor.mlw` — Provides the abstract tensor model, including its properties and constructors.

- `layout.mlw` — Provides row-major layout to reason about multi-dimensional indices.

- `libtensor.mlw` — Provides the concrete `ctensor` structure.

- `libvector.mlw` — Provides reasoning on arrays boundaries.

- `std.mlw` — Provides standard mathematical definitions, reasoning on arrays accesses and the creation of the `float` datatype.

## Running the Proofs

### Prerequisites

To replicate the proofs you should have the following tools installed (please take into consideration that the solvers and Why3 versions are important to ensure the proofs can be replayed without issues):

- [Why3](https://www.why3.org/) - version 1.8.0

- SMT solvers:

    - [Alt-Ergo](https://alt-ergo.ocamlpro.com/) - version 2.6.2

    - [CVC4](https://cvc4.github.io/getting-started.html) - version 1.8

    - [CVC5](https://cvc5.github.io/docs/latest/installation/installation.html) - version 1.2.1

    - [Z3](https://github.com/Z3Prover/z3) - version 4.13.4

### Verifying a `.mlw` File

To open a `.mlw` file in the Why3 IDE and inspect/replay its proofs:

```bash
# From the operator's formal/ directory, e.g. Add operator:
cd operators/add/formal

# Launch the Why3 IDE
why3 ide -L ../../../tensor/tensor add.mlw
```

The path that follows the `-L` flag points to the directory containing the foundation modules (e.g., `tensor.mlw`, `layout.mlw`, etc.) that are required to load the operator's specification.

The IDE will load the file, display all proof obligations (goals), and show the status of each goal proved because proofs are already uploaded in the folder `operators/add/formal/add`.

To replay a given operator proofs you can either launch the IDE and select the command *Reset Proofs* under the *Tools* menu, or you can delete the `add` folder (`operators/add/formal/add`) and re-run the command.

**Note:** When replaying proofs, you may need to increase the solver timeout. This can be configured in Why3 under *File > Preferences*, and then applying the desired solver to the corresponding verification condition (VC). Additionally, some proofs rely on specific transformations and instantiations applied through the Why3 IDE. To successfully replay these proofs, the same transformations must be reapplied. The required transformations are recorded in the `why3session.xml` file located in the proof folder of each operator.

### Code Extraction

To extract C code from the Why3 specifications, you need to configure the Why3 loadpath.

To do this, locate your `why3.conf` file and add the following path to the loadpath section:
```
"/absolute/path/to/saiv/tensor/tensor"
```

Replace `/absolute/path/to/` with the actual path to the repository on your system.

Once the loadpath is configured, you can extract C code using the Makefiles available in each operator's `formal/` directory and in the tensor module.

To perform the extraction:

```bash
# Navigate to the formal directory of an operator or the tensor module
cd tensor/tensor/        # For the tensor library
# or
cd operators/add/formal/ # For a specific operator

# Run the extraction
make
```

The extraction process removes any existing `code/` directory and generates C code from the Why3 modules using the configured drivers. For the tensor library, this includes modules such as `libvector.CIndex`, `libtensor.CTensor`, and `libtensor.CTensorInt64`.

The generated C files are then compiled with `gcc` to verify syntactic correctness, and all output files are listed for inspection in the `code/` directory.

To clean generated files:

```bash
make clean
```
