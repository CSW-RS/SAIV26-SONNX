# Contents

- **Flatten** operator for type [real](#real)
- **Flatten** operator for type [bool, string, float16, float32, float64, int2, int4, int8, int16, int32, int64, uint2, uint4, uint8, uint16, uint32, uint64](#types)

Based on ONNX documentation [Flatten version 25](https://onnx.ai/onnx/operators/onnx__Flatten.html).

<a id="real"></a>
# **Flatten** (real)

## Signature
$Y = \textbf{Flatten}(X)$

where:
- $input$ : input tensor (denoted by $X$) 
- $output$ : output tensor (denoted by $Y$)

## Restrictions
[General Restrictions](../general_restrictions.md) are applicable

No specific restrictions apply to the **Flatten** operator.

## Informal specification

Operator **Flatten** reshapes the input tensor $X$ into a 2D matrix $Y$. The first dimension of $Y$ is determined by the product of the dimensions of $X$ from the start up to (but not including) the specified $\text{axis}$. The second dimension of $Y$ is determined by the product of the dimensions of $X$ from the specified $\text{axis}$ to the end.

$$\text{dY}_{0} = \prod_{i=0}^{\text{axis'}-1} \text{dX}_{i}$$
$$\text{dY}_{1} = \prod_{i=\text{axis'}}^{rX-1} \text{dX}_{i}$$

Note that the product over an empty range/interval is defined to be 1. That means:
- If $\text{axis'} = 0$, then $\text{dY}_{0} = 1$

- If $\text{axis'} = rX$, then $\text{dY}_{1} = 1$

Where 
- $i$ is a dimension index

- $\text{axis'}$  is the normalized $\text{axis}$ and is calculated as follows:
   
   $$\begin{cases}
      \text{axis'} = \text{axis} & \text{if } \text{axis} \geq 0 \\
      \text{axis'} = \text{axis} + rX & \text{if } \text{axis} < 0
    \end{cases}$$


Flatten operation can be expressed as:

$$Y[i_0, i_1, \ldots, i_{rY-1}] = X[\displaystyle index \left(offset([i_0, i_1, \ldots, i_{rY-1}], Y_{\mathit{shape}}), X_{\mathit{shape}}\right)] $$
 
Where:

- $ n \in [0, rY - 1]$

- $i_n \in [0, dY_n - 1]$
 
- $X_{\mathit{shape}}$ is the shape of the input tensor $X$

- $Y_{\mathit{shape}}$ is the shape of the output tensor $Y$

- $\text{offset}$ is defined [here](../common/definitions).

- $\text{index}$ is defined [here](../common/definitions).

### Example 1

```math
X = \begin{bmatrix} 
  \begin{bmatrix} 0 & 1 & 2 & 3 \\ 4 & 5 & 6 & 7 \\ 8 & 9 & 10 & 11 \end{bmatrix} 
  \begin{bmatrix} 12 & 13 & 14 & 15 \\ 16 & 17 & 18 & 19 \\ 20 & 21 & 22 & 23 \end{bmatrix}
\end{bmatrix}
```

```math
\text{axis} = 0
```

```math
Y = \begin{bmatrix}\begin{bmatrix} 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 & 21 & 22 & 23 \end{bmatrix}\end{bmatrix}
```
### Example 2

```math
X = \begin{bmatrix} 
  \begin{bmatrix} 0 & 1 & 2 & 3 \\ 4 & 5 & 6 & 7 \\ 8 & 9 & 10 & 11 \end{bmatrix} 
  \begin{bmatrix} 12 & 13 & 14 & 15 \\ 16 & 17 & 18 & 19 \\ 20 & 21 & 22 & 23 \end{bmatrix}
\end{bmatrix}
```

```math
\text{axis} = 1
```

```math
Y =  
  \begin{bmatrix} 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 \\
12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 & 21 & 22 & 23 \end{bmatrix}

```
### Example 3

```math
X = \begin{bmatrix} 
  \begin{bmatrix} 0 & 1 & 2 & 3 \\ 4 & 5 & 6 & 7 \\ 8 & 9 & 10 & 11 \end{bmatrix} 
  \begin{bmatrix} 12 & 13 & 14 & 15 \\ 16 & 17 & 18 & 19 \\ 20 & 21 & 22 & 23 \end{bmatrix}
\end{bmatrix}
```
```math
\text{axis} = 2
```
```math
Y = \begin{bmatrix}
  \begin{bmatrix} 0 & 1 & 2 & 3\end{bmatrix} \begin{bmatrix}  4 & 5 & 6 & 7 \end{bmatrix} \begin{bmatrix}  8 & 9 & 10 & 11 \end{bmatrix} \begin{bmatrix}  12 & 13 & 14 & 15 \end{bmatrix} \begin{bmatrix}  16 & 17 & 18 & 19 \end{bmatrix} \begin{bmatrix}  20 & 21 & 22 & 23 \end{bmatrix}
\end{bmatrix}
```

## Error conditions
No error condition

## Inputs

### $\text{X}$: `real tensor`
Tensor $X$ is the input tensor to be flattened.

### Constraints

 - `[C1]` <a id="C1ra"></a> Consistency between the shape of tensor $X$ and attribute $\text{axis}$
   - Statement: $rX \geq \text{axis}$
   
   - Rationale: Ensures that the specified $\text{axis}$ is valid for the given tensor rank.
 
## Attributes

### $\text{axis}$: `integer`
The axis starting from which the input tensor will be flattened into the second dimension of the output.

### Constraints
 - `[C1]` <a id="C1ra"></a> Consistency between the shape of tensor $X$ and attribute $\text{axis}$
    - Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#C1ra) on tensor $X$.

 - `[C2]` <a id="C2ra"></a> Value domain
    - Statement: $\text{axis} \in [-rX, rX]$
    - Rationale: Ensures that the attribute $\text{axis}$ is a valid axis for tensor $X$

## Outputs

### $\text{Y}$: `real tensor`
Tensor $Y$ is the flattened output tensor.

### Constraints

 - `[C1]` Shape consistency
   - Statement: The shape of tensor $Y$ is $(dY_0, dY_1)$, where:
     - $dY_0 = \prod_{i=0}^{\text{axis}-1} dX_i$

     - $dY_1 = \prod_{i=\text{axis}}^{rX-1} dX_i$
   
   Where 
   - $dX_i$ is the size of dimension $i$ of tensor $X$
## Formal specification
 
[See Why3 specification](./formal/flatten.mlw).

## Numerical Accuracy

The $\textbf{Flatten}$ operator does not introduce any numerical error. Hence, for all valid indices the output values are exactly equal to the corresponding input values.


<a id="types"></a>
# **Flatten** (type)
Where type in in { bool, string, float16, float32, float64, int2, int4, int8, int16, int32, int64, uint2, uint4, uint8, uint16, uint32, uint64 }

See specification for [real](#real).

