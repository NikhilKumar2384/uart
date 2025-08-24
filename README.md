UART Transmitter and Receiver (Verilog)
📌 Overview

This project implements a Universal Asynchronous Receiver Transmitter (UART) in SystemVerilog, including both Transmitter (TX) and Receiver (RX) modules, along with a baud rate generator.

UART is a widely used serial communication protocol that enables full-duplex data transfer with configurable baud rates.
This project is designed and tested on EDA Playground.

🔧 Features

✅ UART Transmitter (TX) – serializes 8-bit parallel data and sends it bit by bit.

✅ UART Receiver (RX) – receives serialized data and reconstructs 8-bit parallel data.

✅ Baud Rate Generator – generates ticks for precise baud timing (configurable).

✅ Loopback Test – TX output directly connected to RX input to validate end-to-end data transfer.
