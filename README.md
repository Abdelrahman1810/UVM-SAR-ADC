# UVM-SAR-ADC

This repository contains a **Universal Verification Methodology (UVM)** testbench for verifying a **Successive Approximation Register Analog-to-Digital Converter (SAR-ADC)** design. The project showcases a complete functional verification environment using industry-standard UVM practices.

> [!IMPORTANT]
> The RTL design files for the SAR-ADC RTL are sourced externally and are not created by me, done by [UVM AMS TEAM](https://docs.google.com/document/d/1hYTKV5uwAwiOqRAxozzYEXZuelAb0_p5_eVgXfvsk0M/edit?usp=sharing). This repository focuses only on the verification environment using UVM.

## 🧪 Project Description

The goal of this project is to verify a SAR-ADC RTL design using a fully layered UVM testbench. The testbench is structured to enable:

- Stimulus generation and randomized testing
- Transaction-level modeling
- Scoreboarding and coverage collection
- Reusability and scalability for future analog/digital mixed-signal designs

---

## 🧠 Test Strategy

This project supports different modes of running tests:

- **Single Test Run**: Runs one UVM test to verify a specific scenario or feature.
- **Multiple Test Run (Sequential)**: Runs multiple tests one after another. Useful for batch verification and regression.
- **Multiple Test Run (Parallel)**: Runs multiple UVM tests concurrently to speed up simulation time and improve runtime efficiency, especially for long test regressions or large test suites.

<!-- > 💡 **Note:** Running tests in **parallel** significantly enhances simulation performance by reducing the overall execution time compared to running them sequentially. -->

> [!NOTE]
> Running tests in **parallel** significantly enhances simulation performance by reducing the overall execution time compared to running all sequences in single test or running multiple test sequentially.
---

##  UVM hierarchy

```sh
└── UVM-SAR-ADC/
    ├── UVM/
    │   ├── interface
    │   │   └── AES_intf.sv
    │   ├── objects
    │   │   ├── configration
    │   │   │   └── configration.sv
    │   │   ├── sequenceItem
    │   │   │   └── sequenceItem.sv
    │   │   └── sequences
    │   │       ├── main_sequence.sv
    │   │       ├── rst_sequence.sv
    │   │       ├── mode1_sequence.sv
    │   │       ├── mode2_sequence.sv
    │   │       ├── mode3_sequence.sv
    │   │       └── mode4_sequence.sv
    │   ├── shared_pkg
    │   │   └── shared_pkg.sv
    │   └── testbench_top
    │       ├── test
    │       │   ├── env
    │       │   │   ├── env.sv
    │       │   │   ├── agent
    │       │   │   │   ├── agent.sv
    │       │   │   │   ├── monitor
    │       │   │   │   │   └── monitor.sv
    │       │   │   │   ├── driver
    │       │   │   │   │   └── driver.sv
    │       │   │   │   └── sequencer
    │       │   │   │       └── sequencer.sv
    │       │   │   ├── scoreboard
    │       │   │   │   └── scoreboard.sv
    │       │   │   └── subscriber
    │       │   │       └── subscriber.sv
    │       │   └── test.sv
    │       └── top.sv
    ├── SAR_ADC_RTL/
    │   ├── ...
    │   ├── ...
    │   └── ...
    ├── Reports/
    │   └── ...
    ├── Simulation/
    │   ├── Windows/
    │   │       ├── Makefile
    │   │       ├── extracted.py
    │   │       ├── run_tests_parallel.bat
    │   │       ├── run_MultiTest_Parallel.tcl
    │   │       ├── run_MultiTest_Sequential.tcl
    │   │       ├── run_SingleTest.tcl
    │   │       └── srcfiles_dms.f
    │   └── Linux/`InProgress`
    │   │       ├── Makefile
    │   │       ├── extracted.py
    │   │       ├── run_SingleTest.tcl
    │   │       ├── run_MultiTest_Sequential.tcl
    │   │       ├── run_tests_parallel.sh
    │   │       ├── run_MultiTest_Parallel.tcl
    │   │       └── srcfiles_dms.f
    ├── transcripts/
    │   └── ...
    └── UCDB_files/
        └── ...
```



## 🔧 Prerequisites

To run this project, you will need:

- **SystemVerilog Simulator** (e.g., [QuestaSim](https://eda.sw.siemens.com/en-US/ic/questa/))
- **UVM Library** (usually comes with simulator or install separately)
- A Unix-like environment for using Makefile (Linux, macOS, or WSL on Windows)

## ▶️ How to Run Windows

1. Clone the repository:
   ```bash
    git clone https://github.com/Abdelrahman1810/UVM-SAR-ADC.git
    cd UVM-SAR-ADC
    ```

### Single Test
- Method1: `without GUI`

    open cmd:
   ```bash
   make sim_single_test
    ```
- Method2: `GUI` 

    open QuestaSim and open transcript tab:
   ```bash
   do run_SingleTest.tcl
    ```

### Multi Tests Sequential
- Method1: `without GUI`

    open cmd:
   ```bash
   make sim_single_test
    ```
- Method2: `GUI`

    open QuestaSim and open transcript tab:
    ```bash
    vsim.exe -do run_MultiTest_Sequential.tcl
    ```

### Multi Tests Parallel
-   open cmd:
    ```bash
    make sim_parallel
    ```


---

## ▶️ How to Run Linux

1. Clone the repository:
   ```bash
    git clone https://github.com/Abdelrahman1810/UVM-SAR-ADC.git
    cd UVM-SAR-ADC
    ```

### Single Test
- Method1: `without GUI`

    open cmd:
   ```bash
   make sim_single_test
    ```
- Method2: `GUI` 

   ```bash
   vsim -do run_SingleTest.tcl
    ```

### Multi Tests Sequential
- Method1: `without GUI`

    open terminal:
   ```bash
   make sim_single_test
    ```
- Method2: `GUI`

    open QuestaSim and open transcript tab:
    ```bash
    vsim -do run_MultiTest_Sequential.tcl
    ```

### Multi Tests Parallel
-   open terminal:
    ```bash
    sudo chmod +x sim_parallel.sh
    ./sim_parallel.sh
    ```


---

## 🧑‍💻Contributing
If you find any issues or have suggestions for improvement, feel free to submit a pull request or open an issue in the repository. Contributions are always welcome!

---

## Contact info 💜
<a href="https://linktr.ee/A_Hassanen" target="_blank">
  <img align="left" alt="Linktree" width="180px" src="https://app.ashbyhq.com/api/images/org-theme-wordmark/b3f78683-a307-4014-b236-373f18850e2c/d54b020a-ff53-455a-9d52-c90c0f4f2081.png" />
</a> 
<br>
<br>
