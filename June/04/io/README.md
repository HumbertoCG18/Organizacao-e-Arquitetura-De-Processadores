# Atividade Prática: Controle de Gaveta de CD/DVD com Interrupção e Polling

## Arquivos

- `cd_tray_signal.c`: versão com controle via sinal (`kill -USR1 <PID>`)
- `cd_tray_key.c`: versão com controle via teclado (Enter ou espaço)
- `Makefile`: automação da compilação

## Compilação

```bash
make
```

## Execução

### Versão com Sinal

```bash
./cd_tray_signal
# Em outro terminal:
kill -USR1 <PID>
```

### Versão com Tecla

```bash
./cd_tray_key
# Pressione Enter ou espaço para alternar a gaveta
# Pressione q para sair
```