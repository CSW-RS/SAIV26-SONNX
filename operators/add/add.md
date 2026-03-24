# Contents
- **Add** operator for type [real](#real)
- **Add** operator for types [float16, float32, double](#float)
- **Add** operator for types [int8, int16, int32, int64, uint8, uint16, uint32, uint64](#int)

Based on ONNX documentation [Add version 14](https://onnx.ai/onnx/operators/onnx__Add.html).

---

<a id="real"></a>
# **Add** (real, real)

## Signature
$C = \textbf{Add}(A, B)$

where:
- $A$: first operand of the addition  
- $B$: second operand of the addition  
- $C$: result of the element-wise addition of $A$ to $B$
 

## Restrictions

[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **Add** operator.


## Informal specification

Operator **Add** adds input tensors $A$ and $B$ element-wise and stores the result in output tensor $C$. Each element $C[i]$ is the result of Adding $A[i]$ by $B[i]$ where $i$ is a [tensor index](../common/definitions.md#tensor_index).

The mathematical definition of the operator is given hereafter.


For any [tensor index](./../common/definitions.md#tensor_index) $i$:

$$
C[i] = A[i] + B[i]
$$

The effect of the operator is illustrated on the following examples:

---

### Example 1 (1D tensors)

```math
A = \begin{bmatrix} 6.1 & 9.5 & 35.7 \end{bmatrix}
```

```math
B = \begin{bmatrix} 2 & 3 & 4 \end{bmatrix}
```

```math
C = A + B = \begin{bmatrix} 8.1 & 12.5 & 39.7 \end{bmatrix}
```

---

## Error conditions
No error condition.

## Inputs

### $\text{A}$: `real tensor`
Tensor $A$ is the first operand of the addition.

#### Constraints

 - `[C1]` <a id="R1"></a> Shape consistency
   - Statement: Tensors $A$, $B$ and $C$ must have the same shape. 

 
### $\text{B}$: `real tensor`
Tensor $B$ is the second operand of the addition.

#### Constraints

 - `[C1]` Shape consistency
   -  Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R1) on tensor $A$.

## Outputs

### $\text{C}$: `real tensor`

Tensor $C$ is the element-wise result of $A$ Added by $B$.

#### Constraints

 - `[C1]` Shape consistency
   - Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R1) on tensor $A$.


## Attributes

The $\textbf{Add}$ operator has no attribute.

## Formal specification

[See Why3 specification](./formal/add.mlw).

## Numerical Accuracy
*(To be completed)*

---

<a id="float"></a>
# **Add** (float, float)
where float is in {float16, float, double}

## Signature

Definition of operator $\textbf{Add}$ signature:

$C = \textbf{Add}(A, B)$

where

 - $A$: first operand tensor
 - $B$: second operand  tensor
 - $C$: output tensor, result of element-wise addition of $A$ to $B$
 
## Restrictions

[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **Add** operator.

## Informal specification

Operator **Add** adds input tensors $A$ and $B$ element-wise according to IEEE 754 floating-point semantics, placing the result in output tensor $C$. Each element $C[i]$ is computed as follows:


For any [tensor index](./../common/definitions.md#tensor_index) $i$:

$$
C[i] = A[i] + B[i]
$$

---

### Example 1 (2D tensors)

```math
A = \begin{bmatrix} 3.0 & 4.5 \\ 16.0 & 1.0 \\ 25.5 & 24.25 \end{bmatrix}
\quad
B = \begin{bmatrix} 3.0 & 2.0 \\ 4.0 & 0.0 \\ 5.0 & 4.0 \end{bmatrix}
```

```math
C = A + B = \begin{bmatrix} 6.0 & 6.5 \\ 20.0 & 1.0 \\ 30.5 & 28.25 \end{bmatrix}
```
### Error conditions
No error condition.

## Inputs

### $\text{A}$: `floating-point tensor`
Tensor $A$ is the first operand of the addition.

#### Constraints

- `[C1]` <a id="R2"></a> Shape consistency
  - Statement: Tensors $A$, $B$ and $C$ must have the same shape. 

### $\text{B}$: `floating-point tensor`
Tensor $B$ is the second operand of the addition.

#### Constraints
 - `[C1]` Shape consistency
   -  Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R2) on tensor $A$.

## Outputs

### $\text{C}$: `floating-point tensor`

Tensor $C$ is the element-wise result of $A$ Added to $B$.

#### Constraints

 - `[C1]` Shape consistency
   -  Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R2) on tensor $A$.

## Attributes

The $\text{Add}$ operator has no attribute.

## Formal specification

This formalization doesnt take into account the special values of the floating-point numbers and the rounding modes.

[See Why3 specification](./formal/add.mlw).

## Numerical Accuracy

*(To be completed)*

---

<a id="int"></a>

# **Add** (int, int)
where int is in {int8, int16, int32, int64, uint8, uint16, uint32, uint64}.

## Signature
Definition of operator $\textbf{Add}$ signature:

 $C = \textbf{Add}(A,B)$

 where
 - $A$: first operand of the addition
 - $B$: second operand of the addition
 - $C$: result of the element-wise addition of $A$ to $B$
 
## Restrictions
[General restrictions](./../common/general_restrictions.md) are applicable.

No specific restrictions apply to the **Add** operator.

## Informal specification

Operator **Add** adds input tensors $A$ and $B$ element-wise and stores the result in output tensor $C$. Each element $C[i]$ is the result of Adding $A[i]$ by $B[i]$ where $i$ is a [tensor index](../common/definitions.md#tensor_index).

The integer addition is performed as follows (considering that all tensors have the same type):

For unsigned values (type `uintn`):
$$C[i]=\left\{ 
  \begin{array}{ c l }
    A[i] + B[i]- k.2^{n} & \quad \textrm{if }  A[i] + B[i] > 2^{n}-1 \\
   A[i] + B[i] & \quad \textrm{otherwise}
  \end{array}
\right.$$

with $k \in N$ such that $0 \le A[i] + B[i]- k.2^{n} < 2^n$

For signed values (type `intn`):
$$C[i]=\left\{ 
  \begin{array}{ c l }
    A[i] + B[i]- k_1.2^{n} & \quad \textrm{if }  A[i] + B[i] > 2^{n-1}-1 \\
   A[i] + B[i] + k_2.2^{n} & \quad \textrm{if } A[i] + B[i] < -2^{n-1} \\
   A[i] + B[i] & \quad \textrm{otherwise}
  \end{array}
\right\}.$$

with 

$k_1 \in N$ such that $xxx \le A[i] + B[i]-k_1.2^{n} < 2^n$

$k_2 \in N$ such that $xxx \le A[i] + B[i]+k.2^{n} > -2^{n-1}$


### Example 1 (1D uint8 tensors)

```math
A = \begin{bmatrix} 6 & 200 & 35 \end{bmatrix}
\quad
B = \begin{bmatrix} 3 & 100 & 5 \end{bmatrix}
```
```math
C = \begin{bmatrix} 9 & 44 & 40 \end{bmatrix}
```

### Example 1 (1D int8 tensors)

```math
A = \begin{bmatrix} -6 & 100 & -100  \end{bmatrix}
\quad
B = \begin{bmatrix} -3 & 100 & -100  \end{bmatrix}
```
```math
C = \begin{bmatrix} -9 & -56 & 56  \end{bmatrix}
```

## Error conditions
- According to the definition, the result of the addition differs from the value that would be expected in $N$ (for unsigned) or $Z$ (for signed) when under- or overflow occur.

## Inputs

### $\text{A}$: `integer tensor`

Tensor $A$ is the first operand of the addition.

#### Constraints
This section gives all constraints applicable to the input.

 - `[C1]` <a id="R3"></a> Shape consistency;
   - Statement: Tensors $A$, $B$ and $C$ must have the same shape.


### $\text{B}$: `integer tensor`

Tensor $B$ is the second operand of the addition.

#### Constraints

 - `[C1]` Shape consistency
   -  Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R3) on tensor $A$.

## Outputs

### $\text{C}$: `integer tensor`

Tensor $C$ is the element-wise result of $A$ Added to $B$.

#### Constraints

 - `[C1]` Shape consistency
   -  Statement: see constraint [<b><span style="font-family: 'Courier New', monospace">[C1]</span></b>](#R3) on tensor $A$.

## Attributes

The $\textbf{Add}$ operator has no attribute.

## Formal specification
*(To be completed.)*

## Numerical Accuracy
*(To be completed.)*
