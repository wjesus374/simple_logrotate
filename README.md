# Alternative Logrotate

Script para rotacionar logs grandes

Ambos os scripts são utilizados para rotacionar logs de determinado diretório.

O *smartlogrotate.sh* rotaciona o log quebrando em pequenas partes, util quando não há muito espaço para rotacionar o log inteiro.

O *slogrotate.sh* é um script mais simples para copiar e rotacionar o log.

Obs: Dependendo do fluxo de gravação do arquivo de log, alguns dados poderão se perder no processo, use por sua conta e risco.
