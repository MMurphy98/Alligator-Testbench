# Alligator Boostrapped Switch Testbench

The repository for testing code and measurement results of Alligator Boostrapped Switch.

---

```mermaid
graph LR
A[Measurements] --> B1[功能性测试]
A --> B2[性能测试]

B1 --> C1[Track / Always on]
B1 --> C2[Track & Hold]

```

## Stage1

Tracking Mode，enable信号保持高电位，开关Always On; 
  

## SingleToDifferentialTest

用于测试单端转差分电路电路的性能；