# Sequenciais: Registradores e Contadores

### 23.01
- Implementar um banco de registradores composto por 8 registradores, cada um com 16 bits.
  - Desenvolver o seguinte projeto:
    - Registrador.vhdl 
      - Contém o registrador, permitindo leitura ou escrita.
    - EntidadePrincipal.vhdl
      - Chama registrador, permitindo fazer leitura ou escrita.
  
### 23.02
- Simular o contador assíncrono decrescente descrito no `Exemplo 1`, para um clock com um período de 40 ns.
- Implementar contador assíncrono crescente de 2 bits e simular, considerando um clock de 40 ns.
- Implementar contador assíncrono crescente/decrescente de 2 bits e simular para um clock de 40 ns.

### 23.03

- Implementar o seguinte contador síncrono crescente/decrescente de palavras binárias de 4 bits:
  - Simular para um clock de 40 ns, considerando as seguintes situações:
    1. Contagem crescente (durante 3 pulsos do clock)
    2. Contagem decrescente (durante 1 pulso do clock)
    3. Parar a contagem (durante 2 pulsos do clock)
    4. Contagem crescente (durante 2 pulsos do clock)
