# FiveM-dist-calc-perf-testing

A resource for testing the performance of four different types of distance calculations for FiveM:
- `#(vecA - vecB)`
- `v.x^2 + v.y^2 + v.z^2` 
- `Vdist`
- `Vdist2`

## Results
| **Code**                                                 | **Iterations** | **Mean Time** | **Mean ops/sec**  |
|----------------------------------------------------------|----------------|---------------|-------------------|
| `local D = #(vecA - vecB)`                               | 5x @ 10mil     | 447.6ms       | ~22,388.4 ops/sec |
| `local v = vecA - vecB; local D = v.x^2 + v.y^2 + v.z^2` | 5x @ 10mil     | 726.0ms       | ~13,783.8 ops/sec |
| `local D = Vdist(a[1], a[2], a[3], b[1], b[2], b[3])`    | 5x @ 10mil     | 1682.0ms      | ~5,950.4 ops/sec  |
| `local D = Vdist2(a[1], a[2], a[3], b[1], b[2], b[3])`   | 5x @ 10mil     | 1635.0ms      | ~6,139.4 ops/sec  |


## License
Licensed under the MIT license, do whatever you please with it.