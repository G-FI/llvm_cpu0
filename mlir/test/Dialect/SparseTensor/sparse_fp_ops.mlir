// NOTE: Assertions have been autogenerated by utils/generate-test-checks.py
// RUN: mlir-opt %s -sparsification | FileCheck %s

#SV = #sparse_tensor.encoding<{ dimLevelType = [ "compressed" ] }>

#trait1 = {
  indexing_maps = [
    affine_map<(i) -> (i)>,  // a
    affine_map<(i) -> (i)>   // x (out)
  ],
  iterator_types = ["parallel"],
  doc = "x(i) = OP a(i)"
}

#trait2 = {
  indexing_maps = [
    affine_map<(i) -> (i)>,  // a
    affine_map<(i) -> (i)>,  // b
    affine_map<(i) -> (i)>   // x (out)
  ],
  iterator_types = ["parallel"],
  doc = "x(i) = a(i) OP b(i)"
}

#traitc = {
  indexing_maps = [
    affine_map<(i) -> (i)>,  // a
    affine_map<(i) -> (i)>   // x (out)
  ],
  iterator_types = ["parallel"],
  doc = "x(i) = a(i) OP c"
}

// CHECK-LABEL:   func @abs(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_2:.*]] = constant 0 : index
// CHECK:           %[[VAL_3:.*]] = constant 1 : index
// CHECK:           %[[VAL_4:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xf64>
// CHECK:           %[[VAL_7:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_8:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_2]]] : memref<?xindex>
// CHECK:           %[[VAL_9:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_10:.*]] = %[[VAL_8]] to %[[VAL_9]] step %[[VAL_3]] {
// CHECK:             %[[VAL_11:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_10]]] : memref<?xindex>
// CHECK:             %[[VAL_12:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_10]]] : memref<?xf64>
// CHECK:             %[[VAL_13:.*]] = absf %[[VAL_12]] : f64
// CHECK:             memref.store %[[VAL_13]], %[[VAL_7]]{{\[}}%[[VAL_11]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_14:.*]] = memref.tensor_load %[[VAL_7]] : memref<32xf64>
// CHECK:           return %[[VAL_14]] : tensor<32xf64>
func @abs(%arga: tensor<32xf64, #SV>,
          %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait1
     ins(%arga: tensor<32xf64, #SV>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %x: f64):
        %0 = absf %a : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @ceil(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_2:.*]] = constant 0 : index
// CHECK:           %[[VAL_3:.*]] = constant 1 : index
// CHECK:           %[[VAL_4:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xf64>
// CHECK:           %[[VAL_7:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_8:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_2]]] : memref<?xindex>
// CHECK:           %[[VAL_9:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_10:.*]] = %[[VAL_8]] to %[[VAL_9]] step %[[VAL_3]] {
// CHECK:             %[[VAL_11:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_10]]] : memref<?xindex>
// CHECK:             %[[VAL_12:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_10]]] : memref<?xf64>
// CHECK:             %[[VAL_13:.*]] = ceilf %[[VAL_12]] : f64
// CHECK:             memref.store %[[VAL_13]], %[[VAL_7]]{{\[}}%[[VAL_11]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_14:.*]] = memref.tensor_load %[[VAL_7]] : memref<32xf64>
// CHECK:           return %[[VAL_14]] : tensor<32xf64>
// CHECK:         }
func @ceil(%arga: tensor<32xf64, #SV>,
           %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait1
     ins(%arga: tensor<32xf64, #SV>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %x: f64):
        %0 = ceilf %a : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @floor(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_2:.*]] = constant 0 : index
// CHECK:           %[[VAL_3:.*]] = constant 1 : index
// CHECK:           %[[VAL_4:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xf64>
// CHECK:           %[[VAL_7:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_8:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_2]]] : memref<?xindex>
// CHECK:           %[[VAL_9:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_10:.*]] = %[[VAL_8]] to %[[VAL_9]] step %[[VAL_3]] {
// CHECK:             %[[VAL_11:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_10]]] : memref<?xindex>
// CHECK:             %[[VAL_12:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_10]]] : memref<?xf64>
// CHECK:             %[[VAL_13:.*]] = floorf %[[VAL_12]] : f64
// CHECK:             memref.store %[[VAL_13]], %[[VAL_7]]{{\[}}%[[VAL_11]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_14:.*]] = memref.tensor_load %[[VAL_7]] : memref<32xf64>
// CHECK:           return %[[VAL_14]] : tensor<32xf64>
// CHECK:         }
func @floor(%arga: tensor<32xf64, #SV>,
            %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait1
     ins(%arga: tensor<32xf64, #SV>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %x: f64):
        %0 = floorf %a : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @neg(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_2:.*]] = constant 0 : index
// CHECK:           %[[VAL_3:.*]] = constant 1 : index
// CHECK:           %[[VAL_4:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_2]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xf64>
// CHECK:           %[[VAL_7:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_8:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_2]]] : memref<?xindex>
// CHECK:           %[[VAL_9:.*]] = memref.load %[[VAL_4]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_10:.*]] = %[[VAL_8]] to %[[VAL_9]] step %[[VAL_3]] {
// CHECK:             %[[VAL_11:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_10]]] : memref<?xindex>
// CHECK:             %[[VAL_12:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_10]]] : memref<?xf64>
// CHECK:             %[[VAL_13:.*]] = negf %[[VAL_12]] : f64
// CHECK:             memref.store %[[VAL_13]], %[[VAL_7]]{{\[}}%[[VAL_11]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_14:.*]] = memref.tensor_load %[[VAL_7]] : memref<32xf64>
// CHECK:           return %[[VAL_14]] : tensor<32xf64>
// CHECK:         }
func @neg(%arga: tensor<32xf64, #SV>,
          %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait1
     ins(%arga: tensor<32xf64, #SV>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %x: f64):
        %0 = negf %a : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @add(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64>,
// CHECK-SAME:              %[[VAL_2:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_3:.*]] = constant 32 : index
// CHECK:           %[[VAL_4:.*]] = constant 0 : index
// CHECK:           %[[VAL_5:.*]] = constant true
// CHECK:           %[[VAL_6:.*]] = constant 1 : index
// CHECK:           %[[VAL_7:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_4]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_8:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_4]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_9:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_10:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_11:.*]] = memref.buffer_cast %[[VAL_2]] : memref<32xf64>
// CHECK:           %[[VAL_12:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_4]]] : memref<?xindex>
// CHECK:           %[[VAL_13:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_6]]] : memref<?xindex>
// CHECK:           %[[VAL_14:.*]]:2 = scf.while (%[[VAL_15:.*]] = %[[VAL_12]], %[[VAL_16:.*]] = %[[VAL_4]]) : (index, index) -> (index, index) {
// CHECK:             %[[VAL_17:.*]] = cmpi ult, %[[VAL_15]], %[[VAL_13]] : index
// CHECK:             scf.condition(%[[VAL_17]]) %[[VAL_15]], %[[VAL_16]] : index, index
// CHECK:           } do {
// CHECK:           ^bb0(%[[VAL_18:.*]]: index, %[[VAL_19:.*]]: index):
// CHECK:             %[[VAL_20:.*]] = memref.load %[[VAL_8]]{{\[}}%[[VAL_18]]] : memref<?xindex>
// CHECK:             %[[VAL_21:.*]] = cmpi eq, %[[VAL_20]], %[[VAL_19]] : index
// CHECK:             scf.if %[[VAL_21]] {
// CHECK:               %[[VAL_22:.*]] = memref.load %[[VAL_9]]{{\[}}%[[VAL_18]]] : memref<?xf64>
// CHECK:               %[[VAL_23:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:               %[[VAL_24:.*]] = addf %[[VAL_22]], %[[VAL_23]] : f64
// CHECK:               memref.store %[[VAL_24]], %[[VAL_11]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:             } else {
// CHECK:               scf.if %[[VAL_5]] {
// CHECK:                 %[[VAL_25:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:                 memref.store %[[VAL_25]], %[[VAL_11]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:               } else {
// CHECK:               }
// CHECK:             }
// CHECK:             %[[VAL_26:.*]] = cmpi eq, %[[VAL_20]], %[[VAL_19]] : index
// CHECK:             %[[VAL_27:.*]] = addi %[[VAL_18]], %[[VAL_6]] : index
// CHECK:             %[[VAL_28:.*]] = select %[[VAL_26]], %[[VAL_27]], %[[VAL_18]] : index
// CHECK:             %[[VAL_29:.*]] = addi %[[VAL_19]], %[[VAL_6]] : index
// CHECK:             scf.yield %[[VAL_28]], %[[VAL_29]] : index, index
// CHECK:           }
// CHECK:           scf.for %[[VAL_30:.*]] = %[[VAL_31:.*]]#1 to %[[VAL_3]] step %[[VAL_6]] {
// CHECK:             %[[VAL_32:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_30]]] : memref<32xf64>
// CHECK:             memref.store %[[VAL_32]], %[[VAL_11]]{{\[}}%[[VAL_30]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_33:.*]] = memref.tensor_load %[[VAL_11]] : memref<32xf64>
// CHECK:           return %[[VAL_33]] : tensor<32xf64>
// CHECK:         }
func @add(%arga: tensor<32xf64, #SV>,
          %argb: tensor<32xf64>,
          %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait2
     ins(%arga, %argb: tensor<32xf64, #SV>, tensor<32xf64>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %b: f64, %x: f64):
        %0 = addf %a, %b : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @sub(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64>,
// CHECK-SAME:              %[[VAL_2:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_3:.*]] = constant 32 : index
// CHECK:           %[[VAL_4:.*]] = constant 0 : index
// CHECK:           %[[VAL_5:.*]] = constant true
// CHECK:           %[[VAL_6:.*]] = constant 1 : index
// CHECK:           %[[VAL_7:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_4]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_8:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_4]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xindex>
// CHECK:           %[[VAL_9:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>> to memref<?xf64>
// CHECK:           %[[VAL_10:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_11:.*]] = memref.buffer_cast %[[VAL_2]] : memref<32xf64>
// CHECK:           %[[VAL_12:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_4]]] : memref<?xindex>
// CHECK:           %[[VAL_13:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_6]]] : memref<?xindex>
// CHECK:           %[[VAL_14:.*]]:2 = scf.while (%[[VAL_15:.*]] = %[[VAL_12]], %[[VAL_16:.*]] = %[[VAL_4]]) : (index, index) -> (index, index) {
// CHECK:             %[[VAL_17:.*]] = cmpi ult, %[[VAL_15]], %[[VAL_13]] : index
// CHECK:             scf.condition(%[[VAL_17]]) %[[VAL_15]], %[[VAL_16]] : index, index
// CHECK:           } do {
// CHECK:           ^bb0(%[[VAL_18:.*]]: index, %[[VAL_19:.*]]: index):
// CHECK:             %[[VAL_20:.*]] = memref.load %[[VAL_8]]{{\[}}%[[VAL_18]]] : memref<?xindex>
// CHECK:             %[[VAL_21:.*]] = cmpi eq, %[[VAL_20]], %[[VAL_19]] : index
// CHECK:             scf.if %[[VAL_21]] {
// CHECK:               %[[VAL_22:.*]] = memref.load %[[VAL_9]]{{\[}}%[[VAL_18]]] : memref<?xf64>
// CHECK:               %[[VAL_23:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:               %[[VAL_24:.*]] = subf %[[VAL_22]], %[[VAL_23]] : f64
// CHECK:               memref.store %[[VAL_24]], %[[VAL_11]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:             } else {
// CHECK:               scf.if %[[VAL_5]] {
// CHECK:                 %[[VAL_25:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:                 %[[VAL_26:.*]] = negf %[[VAL_25]] : f64
// CHECK:                 memref.store %[[VAL_26]], %[[VAL_11]]{{\[}}%[[VAL_19]]] : memref<32xf64>
// CHECK:               } else {
// CHECK:               }
// CHECK:             }
// CHECK:             %[[VAL_27:.*]] = cmpi eq, %[[VAL_20]], %[[VAL_19]] : index
// CHECK:             %[[VAL_28:.*]] = addi %[[VAL_18]], %[[VAL_6]] : index
// CHECK:             %[[VAL_29:.*]] = select %[[VAL_27]], %[[VAL_28]], %[[VAL_18]] : index
// CHECK:             %[[VAL_30:.*]] = addi %[[VAL_19]], %[[VAL_6]] : index
// CHECK:             scf.yield %[[VAL_29]], %[[VAL_30]] : index, index
// CHECK:           }
// CHECK:           scf.for %[[VAL_31:.*]] = %[[VAL_32:.*]]#1 to %[[VAL_3]] step %[[VAL_6]] {
// CHECK:             %[[VAL_33:.*]] = memref.load %[[VAL_10]]{{\[}}%[[VAL_31]]] : memref<32xf64>
// CHECK:             %[[VAL_34:.*]] = negf %[[VAL_33]] : f64
// CHECK:             memref.store %[[VAL_34]], %[[VAL_11]]{{\[}}%[[VAL_31]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_35:.*]] = memref.tensor_load %[[VAL_11]] : memref<32xf64>
// CHECK:           return %[[VAL_35]] : tensor<32xf64>
// CHECK:         }
func @sub(%arga: tensor<32xf64, #SV>,
          %argb: tensor<32xf64>,
          %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait2
     ins(%arga, %argb: tensor<32xf64, #SV>, tensor<32xf64>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %b: f64, %x: f64):
        %0 = subf %a, %b : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @mul(
// CHECK-SAME:              %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:              %[[VAL_1:.*]]: tensor<32xf64>,
// CHECK-SAME:              %[[VAL_2:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_3:.*]] = constant 0 : index
// CHECK:           %[[VAL_4:.*]] = constant 1 : index
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_3]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_3]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_7:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_8:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_9:.*]] = memref.buffer_cast %[[VAL_2]] : memref<32xf64>
// CHECK:           %[[VAL_10:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           %[[VAL_11:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_4]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_12:.*]] = %[[VAL_10]] to %[[VAL_11]] step %[[VAL_4]] {
// CHECK:             %[[VAL_13:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_12]]] : memref<?xindex>
// CHECK:             %[[VAL_14:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_12]]] : memref<?xf64>
// CHECK:             %[[VAL_15:.*]] = memref.load %[[VAL_8]]{{\[}}%[[VAL_13]]] : memref<32xf64>
// CHECK:             %[[VAL_16:.*]] = mulf %[[VAL_14]], %[[VAL_15]] : f64
// CHECK:             memref.store %[[VAL_16]], %[[VAL_9]]{{\[}}%[[VAL_13]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_17:.*]] = memref.tensor_load %[[VAL_9]] : memref<32xf64>
// CHECK:           return %[[VAL_17]] : tensor<32xf64>
// CHECK:         }
func @mul(%arga: tensor<32xf64, #SV>,
          %argb: tensor<32xf64>,
          %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %0 = linalg.generic #trait2
     ins(%arga, %argb: tensor<32xf64, #SV>, tensor<32xf64>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %b: f64, %x: f64):
        %0 = mulf %a, %b : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

// CHECK-LABEL:   func @divbyc(
// CHECK-SAME:                 %[[VAL_0:.*]]: tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>,
// CHECK-SAME:                 %[[VAL_1:.*]]: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
// CHECK:           %[[VAL_2:.*]] = constant 2.000000e+00 : f64
// CHECK:           %[[VAL_3:.*]] = constant 0 : index
// CHECK:           %[[VAL_4:.*]] = constant 1 : index
// CHECK:           %[[VAL_5:.*]] = sparse_tensor.pointers %[[VAL_0]], %[[VAL_3]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_6:.*]] = sparse_tensor.indices %[[VAL_0]], %[[VAL_3]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_7:.*]] = sparse_tensor.values %[[VAL_0]] : tensor<32xf64, #sparse_tensor.encoding<{{{.*}}}>>
// CHECK:           %[[VAL_8:.*]] = memref.buffer_cast %[[VAL_1]] : memref<32xf64>
// CHECK:           %[[VAL_9:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_3]]] : memref<?xindex>
// CHECK:           %[[VAL_10:.*]] = memref.load %[[VAL_5]]{{\[}}%[[VAL_4]]] : memref<?xindex>
// CHECK:           scf.for %[[VAL_11:.*]] = %[[VAL_9]] to %[[VAL_10]] step %[[VAL_4]] {
// CHECK:             %[[VAL_12:.*]] = memref.load %[[VAL_6]]{{\[}}%[[VAL_11]]] : memref<?xindex>
// CHECK:             %[[VAL_13:.*]] = memref.load %[[VAL_7]]{{\[}}%[[VAL_11]]] : memref<?xf64>
// CHECK:             %[[VAL_14:.*]] = divf %[[VAL_13]], %[[VAL_2]] : f64
// CHECK:             memref.store %[[VAL_14]], %[[VAL_8]]{{\[}}%[[VAL_12]]] : memref<32xf64>
// CHECK:           }
// CHECK:           %[[VAL_15:.*]] = memref.tensor_load %[[VAL_8]] : memref<32xf64>
// CHECK:           return %[[VAL_15]] : tensor<32xf64>
// CHECK:         }
func @divbyc(%arga: tensor<32xf64, #SV>,
           %argx: tensor<32xf64> {linalg.inplaceable = true}) -> tensor<32xf64> {
  %c = constant 2.0 : f64
  %0 = linalg.generic #traitc
     ins(%arga: tensor<32xf64, #SV>)
    outs(%argx: tensor<32xf64>) {
      ^bb(%a: f64, %x: f64):
        %0 = divf %a, %c : f64
        linalg.yield %0 : f64
  } -> tensor<32xf64>
  return %0 : tensor<32xf64>
}

