# Projeto-ALU
Projeto de uma ALU da matéria Projetos de Sistemas Digitais


Descrição para Repositório GitHub - Projeto de ALU 4 bits em VHDL
📌 Título do Projeto
Projeto de ALU (Unidade Lógica e Aritmética) em VHDL

🔍 Visão Geral
Este projeto implementa uma Unidade Lógica e Aritmética (ULA) em VHDL, capaz de realizar operações matemáticas e lógicas entre dois números de 4 bits. O sistema foi desenvolvido para ser implementado em uma FPGA, com entradas via switches e saídas em displays de 7 segmentos e LEDs. Capaz de executar as seguintes operações:

Operações Aritméticas:
-Soma (ADD)
-Subtração (SUB)
-Multiplicação (MUL) de 2 bits 

Operações Lógicas:
-AND bit a bit
-OR bit a bit
-NOT (negação)

Comparação:
-Igual (EQU)
-Maior (GRT)
-Menor (LST)

A ALU é controlada por um sinal de 3 bits (ALUOp) que seleciona a operação desejada e gera flags de status (Zero, Overflow, CarryOut).

🛠️ Estrutura do Projeto
O projeto é organizado em componentes modulares, incluindo:
-somador_completo - Somador de dois bits
-somador_4bits.vhd - Somador ripple-carry para operações de ADD/SUB
-multiplicador.vhd - Multiplicador de 2 bits (saída em 4 bits)
-comparador_4bits.vhd - Comparador com saídas EQU, GRT e LST
-components_package.vhd - Package com declaração de todos os componentes
-projeto_ALU.vhd - Arquivo principal que integra todos os módulos

🎯 Funcionalidades
✅ Suporte a 8 operações (definidas por ALUOp)
✅ Sinais de status (Zero, Overflow, CarryOut)
✅ Comparação de números (EQU, GRT, LST)


