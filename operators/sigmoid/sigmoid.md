# Contents

- **Sigmoid** operator for type [real](#real)
- **Sigmoid** operator for types [float16, float, double](#float)

Based on ONNX documentation [Sigmoid version 13](https://onnx.ai/onnx/operators/onnx__Sigmoid.html).

<a id="real"></a>
# **Sigmoid** (real)

## Signature
$Y = \textbf{Sigmoid}(X)$

where:
- $X$: Input tensor
- $Y$: Sigmoid of $X$



## Restrictions

[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **Sigmoid** operator.

## Informal specification

The **Sigmoid** operator computes the element-wise  sigmoid of the input tensor $X$.

The mathematical definition of the operator is given hereafter.

For any [tensor index](./../common/definitions.md#tensor_index) $i$:

$$
Y[i] = \frac{1}{1 + e^{-X[i]}}
$$

The effect of the operator is illustrated on the following examples.

### Example 1

```math
X = \begin{bmatrix} 0 & 1 & -1 \end{bmatrix}
```

```math
Y \approx  \begin{bmatrix} 0.5 & 0.73105860 & 0.26894143 \end{bmatrix}
```

### Example 2

```math
X = \begin{bmatrix}
  -2 & 0 \\
  1  & 2  \\
  -4 & 4
\end{bmatrix}
```

```math
Y \approx  \begin{bmatrix}
  0.11920291 & 0.5       \\
  0.73105860 & 0.88079709 \\
  0.01798624 & 0.98201376
\end{bmatrix}
```

## Error conditions

No error condition.

## Attributes

Operator **Sigmoid** has no attribute.

## Inputs

### $\text{X}$: `real tensor`

Input tensor.

#### Constraints

- `[C1]` <a id="C1rx"></a> Shape consistency  
  - Statement: $X$ and $Y$ shall have the same shape.

## Outputs

### $\text{Y}$: `real tensor`

Sigmoid of tensor $X$.

#### Constraints

- `[C1]` <a id="C1ry"></a> Shape consistency  
  - Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#C1rx) on tensor $X$.

## Formal specification
 
[See Why3 specification](./formal/sigmoid.mlw).

<a id="float"></a>
# **Sigmoid** (float)
where float is in {float16, float, double}

## Signature

$Y = \textbf{Sigmoid}(X)$

where:
- $X$: Input tensor
- $Y$: Sigmoid of $X$

## Restrictions

[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **Sigmoid** operator.

## Informal specification

The **Sigmoid** operator computes the element-wise logistic sigmoid of the input tensor $X$ according to IEEE 754 floating-point semantics.

The mathematical definition of the operator is given hereafter.

For any [tensor index](./../common/definitions.md#tensor_index) $i$:


$$
Y[i] =
\begin{cases}
\text{0.0} & \text{if } X[i]=\text{-inf} \\
\text{1.0} & \text{if } X[i]=\text{inf} \\
\text{NaN} & \text{if } X[i]=\text{NaN} \\

1 / (1 + e^{-X[i]}) & \text{otherwise}   \\
\end{cases}
$$


The effect of the operator is illustrated on the following examples.

### Example 1

```math
X = \begin{bmatrix} 0 & 1 & -1 \end{bmatrix}
```

```math
Y \approx  \begin{bmatrix} 0.5 & 0.73105860 & 0.26894143 \end{bmatrix}
```

### Example 2

```math
X = \begin{bmatrix}
  -2 & 0 \\
  1  & 2  \\
  -4 & 4
\end{bmatrix}
```

```math
Y \approx  \begin{bmatrix}
  0.11920291 & 0.5       \\
  0.73105860 & 0.88079709 \\
  0.01798624 & 0.98201376
\end{bmatrix}
```


### Example 3

```math
X = \begin{bmatrix}
  \text{+inf} & \text{NaN} & \text{-inf}
\end{bmatrix}
```

```math
Y \approx  \begin{bmatrix}
  1.0 & \text{NaN} & 0.0
\end{bmatrix}
```

## Error conditions

No error condition.

## Attributes

Operator **Sigmoid** has no attribute.

## Inputs

### $\text{X}$: `floating-point tensor`

Input tensor.

#### Constraints

- `[C1]` <a id="C1fx"></a> Shape consistency  
  - Statement: $X$ and $Y$ shall have the same shape.

## Outputs

### $\text{Y}$: `floating-point tensor`

Sigmoid of tensor $X$.

#### Constraints

- `[C1]` <a id="C1fy"></a> Shape consistency  
  - Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#C1fx) on tensor $X$.

## Formal specification

This formalization doesnt take into account the special values of the floating-point numbers and the rounding modes.

[See Why3 specification](./formal/sigmoid.mlw).

## Numeric accuracy

[See the numeric accuracy note](./sigmoid_acc.md).
