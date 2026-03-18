# Contents
- **MatMul** operator for type [(real,real)](#real)
- **MatMul** operator for types [(float,float)](#float)
  - where `float` in { float16, float32, float64}

Based on ONNX documentation [MatMul version 13](https://onnx.ai/onnx/operators/onnx__MatMul.html).

<a id="real"></a>
# **MatMul** (real, real)

# Signature
$Y = \textbf{MatMul}(A, B)$

where:
- $A$: left-side input tensor
- $B$: right-side input tensor
- $Y$: output tensor

## Restrictions
[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **MatMul** operator.

## Informal specification

Operator **MatMul** computes the tensor operation equivalent to a matrix multiplication. 

The mathematical definition of the operator is given hereafter for a bidimensional tensors.

$$     
  Y = AB  
$$


$$
     \begin{bmatrix}
         Y_{00} & Y_{01} & \cdots & Y_{0c_B}\\
         Y_{10} & Y_{11} & \cdots & Y_{1c_B}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         Y_{l_A0} & Y_{l_A1} & \cdots & Y_{l_Ac_B} 
     \end{bmatrix}
      =
     \begin{bmatrix}
         A_{00} & A_{01} & \cdots & A_{0c_A}\\
         A_{10} & A_{11} & \cdots & A_{1c_A}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         A_{l_A0} & A_{l_A1} & \cdots & A_{l_Ac_A} 
     \end{bmatrix}
     \begin{bmatrix}
         B_{00} & B_{01} & \cdots & B_{0c_B}\\
         B_{10} & B_{11} & \cdots & B_{1c_B}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         B_{l_B0} & B_{l_B1} & \cdots & B_{l_Bc_B} 
     \end{bmatrix}
$$

$$
  \forall i \in [0, l_A], \forall j \in [0, c_B] \quad Y_{ij} = \sum_{k=0}^{n-1} A_{ik}B_{kj}
$$

Where
- $l_A = dA_0 - 1$
- $c_A = dA_1 - 1$
- $l_B = dB_0 - 1$
- $c_B = dB_1 - 1$
- $n = dA_1 = dB_0$

### Example 1

$$
  A = \begin{bmatrix}
        1 & 2 \\
        3 & 4
  \end{bmatrix}
$$

$$
B = \begin{bmatrix}
      5 & 6 \\
      7 & 8
  \end{bmatrix}
$$

$$
Y = \begin{bmatrix}
      19 & 22 \\
      43 & 50
\end{bmatrix}
$$

### Example 2
$$
A = \begin{bmatrix}
      1 & 2 \\
      3 & 4 \\
      5 & 6
  \end{bmatrix}
$$

$$
B = \begin{bmatrix}
      7 & 8 & 9 \\
      10 & 11 & 12
  \end{bmatrix}
$$

$$
Y = \begin{bmatrix}
      27 & 30 & 33 \\
      61 & 68 & 75 \\
      95 & 106 & 117
\end{bmatrix}
$$

## Error conditions

No error conditions.

## Attributes

Operator **MatMul** has no attributes.

## Inputs 

### $\text{A}$: `tensor real`

Tensor $A$ is the left-side input tensor.

#### Constraints

- `[C1]` <a id="CA1r"></a> Number of spatial axes of tensor $A$
  - Statement: The number of spatial axes of tensor $A$ is 2.

- `[C2]` <a id="CA2r"></a> Consistency of $A$ and $B$ shapes  
  - Statement:  $dA_1=dB_0$
  - Rationale: Application of the mathematical definition of matrix multiplication.

- `[C3]` <a id="CA3r"></a> Consistency of $A$ and $Y$ shapes
  - Statement: $dY_0=dA_0$
  - Rationale: Application of the mathematical definition of matrix multiplication.

### $\text{B}$: `tensor real`

Tensor $B$ is the right-side input tensor.

#### Constraints

- `[C1]` <a id="CB1r"></a> Number of spatial axes of tensor $B$
  - Statement: The number of spatial axes of tensor $B$ is 2.
  
- `[C2]` <a id="CB2r"></a> Consistency of $A$ and $B$ shapes  
  - Statement: See constraint [<b><span style="font-family: 'Courier New', monospace">[C2]</span></b>](#CA2r) on tensor $A$.

- `[C3]` <a id="CB3r"></a> Consistency of $B$ and $Y$ shapes
  - Statement: $dY_1=dB_1$
  - Rationale: Application of the mathematical definition of matrix multiplication.

## Outputs 

### $\text{Y}$: `tensor real`

Tensor $Y$ is the output tensor.

#### Constraints

- `[C1]` <a id="CY1r"></a> Number of spatial axes of tensor $Y$
  - Statement: The number of spatial axes of tensor $Y$ is 2.

- `[C2]` <a id="CY2r"></a> Consistency of $A$, $B$ and $Y$ shapes
  - See constraint [<b><span style="font-family: 'Courier New', monospace">[C3]</span></b>](#CA3r) on tensor $A$ and see constraint [<b><span style="font-family: 'Courier New', monospace">[C3]</span></b>](#CB3r) on tensor $B$.

## Formal specification
[See Why3 specification](./formal/matmul.mlw).

## Numerical Accuracy
*(To be completed)*


<a id="float"></a>
# **MatMul** (float, float)

where float is in {float16, float32, float64}

# Signature
$Y = \textbf{MatMul}(A, B)$
where
- $A$: left-side input tensor
- $B$: right-side input tensor
- $Y$: output tensor


## Restrictions

[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **MatMul** operator.

## Informal specification

Operator **MatMul** computes the tensor operation equivalent to a matrix multiplication. 

The mathematical definition of the operator is given hereafter for a bidimensional tensors.

$$     
  Y = AB  
$$


$$
     \begin{bmatrix}
         Y_{00} & Y_{01} & \cdots & Y_{0c_B}\\
         Y_{10} & Y_{11} & \cdots & Y_{1c_B}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         Y_{l_A0} & Y_{l_A1} & \cdots & Y_{l_Ac_B} 
     \end{bmatrix}
      =
     \begin{bmatrix}
         A_{00} & A_{01} & \cdots & A_{0c_A}\\
         A_{10} & A_{11} & \cdots & A_{1c_A}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         A_{l_A0} & A_{l_A1} & \cdots & A_{l_Ac_A} 
     \end{bmatrix}
     \begin{bmatrix}
         B_{00} & B_{01} & \cdots & B_{0c_B}\\
         B_{10} & B_{11} & \cdots & B_{1c_B}\\ 
         \vdots & \vdots & \ddots & \vdots\\ 
         B_{l_B0} & B_{l_B1} & \cdots & B_{l_Bc_B} 
     \end{bmatrix}
$$

$$
  \forall i \in [0, l_A], \forall j \in [0, c_B] \quad Y_{ij} = \sum_{k=0}^{n-1} A_{ik}B_{kj}
$$

Where
- $l_A = dA_0 - 1$
- $c_A = dA_1 - 1$
- $l_B = dB_0 - 1$
- $c_B = dB_1 - 1$
- $n = dA_1 = dB_0$

### Example 1
$$
A = \begin{bmatrix}
      1.0 & 2.0 \\
      3.0 & 4.0
  \end{bmatrix}
$$

$$
B = \begin{bmatrix}
      5.0 & 6.0 \\
      7.0 & 8.0
  \end{bmatrix}
$$

$$
Y = \begin{bmatrix}
      19.0 & 22.0 \\
      43.0 & 50.0
\end{bmatrix}
$$

### Example 2
$$
A = \begin{bmatrix}
      \infty & -\infty & NaN \\
      NaN & \infty & -\infty \\
  \end{bmatrix}
$$

$$
B = \begin{bmatrix}
      1.0 & 2.0 \\
      4.0 & 5.0 \\
      7.0 & 8.0
  \end{bmatrix}
$$

$$
Y = \begin{bmatrix}
      NaN & NaN \\
      NaN & NaN
\end{bmatrix}
$$

### Example 3

$$
A = \begin{bmatrix}
      \infty & \infty \\
      NaN & \infty \\
  \end{bmatrix}
$$

$$
B = \begin{bmatrix}
      1.0 & 2.0 & 3.0 & 4.0 \\
      4.0 & 5.0 & 6.0 & 7.0 \\
  \end{bmatrix}
$$

$$
Y = \begin{bmatrix}
      \infty & \infty & \infty & \infty \\
      NaN & NaN & NaN & NaN
    \end{bmatrix}

$$

## Error conditions

No error conditions.

## Attributes

Operator **MatMul** has no attributes.

## Inputs 

### $\text{A}$: `floating-point tensor`

Tensor $A$ is the left-side input tensor.

#### Constraints

- `[C1]` <a id="C1Af"></a> Number of spatial axes of tensor $A$
  - Statement: The number of spatial axes of tensor $A$ is 2.

- `[C2]` <a id="C2Af"></a> Consistency of $A$ and $B$ shapes  
  - Statement:  $dA_1=dB_0$
  - Rationale: Application of the mathematical definition of matrix multiplication.

- `[C3]` <a id="C3Af"></a> Consistency of $A$ and $Y$ shapes
  - Statement: $dY_0=dA_0$
  - Rationale: Application of the mathematical definition of matrix multiplication.

### $\text{B}$: `floating-point tensor`

Tensor $B$ is the right-side input tensor.

#### Constraints

- `[C1]` <a id="C1Bf"></a> Number of spatial axes of tensor $B$
  - Statement: The number of spatial axes of tensor $B$ is 2.
  
- `[C2]` <a id="C2Bf"></a> Consistency of $A$ and $B$ shapes  
  - Statement: See constraint [<b><span style="font-family: 'Courier New', monospace">[C2]</span></b>](#C2Af) on tensor $A$.

- `[C3]` <a id="C3Bf"></a> Consistency of $B$ and $Y$ shapes
  - Statement: $dY_1=dB_1$
  - Rationale: Application of the mathematical definition of matrix multiplication.

## Outputs 

### $\text{Y}$: `floating-point tensor`

Tensor $Y$ is the output tensor.

#### Constraints

- `[C1]` <a id="C1Yf"></a> Number of spatial axes of tensor $Y$
  - Statement: The number of spatial axes of tensor $Y$ is 2.

- `[C2]` <a id="C2Yf"></a> Consistency of $A$, $B$ and $Y$ shapes
  - See constraint [<b><span style="font-family: 'Courier New', monospace">[C3]</span></b>](#C3Af) on tensor $A$ and see constraint [<b><span style="font-family: 'Courier New', monospace">[C3]</span></b>](#C3Bf) on tensor $B$.

## Formal specification
[See Why3 specification](./formal/matmul.mlw).

## Numerical Accuracy
*(To be completed)*