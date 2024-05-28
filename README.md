# Desafio Docker Go

## Enunciado
Esse desafio é muito empolgante principalmente se você nunca trabalhou com a linguagem Go!
Você terá que publicar uma imagem no docker hub. Quando executarmos:

`docker run <seu-user>/fullcycle`

Temos que ter o seguinte resultado: Full Cycle Rocks!!

Se você perceber, essa imagem apenas realiza um print da mensagem como resultado final, logo, vale a pena dar uma conferida no próprio site da Go Lang para aprender como fazer um "olá mundo".

Lembrando que a Go Lang possui imagens oficiais prontas, vale a pena consultar o Docker Hub.

3) A imagem de nosso projeto Go precisa ter menos de 2MB =)

Dica: No vídeo de introdução sobre o Docker quando falamos sobre o sistema de arquivos em camadas, apresento uma imagem "raiz", talvez seja uma boa utilizá-la.

Suba o projeto em um repositório Git remoto e coloque o link da imagem que subiu no Docker Hub.

Compartilhe o link do repositório do Git remoto para corrigirmos seu projeto.

Divirta-se!

## Solução

### Docker multi-stage build

- Permite mais de uma declaração `FROM`, cada uma representando um estado no Dockerfile.
- Assim, é possível que cada imagem fique responsável por uma determinada tarefa.
- Além disso, é possível compartilhar dados entre diferentes estados de build, possibilitando que um estado construa a aplicação e o outro copie apenas os componentes necessário para a aplicação executar.
- O resultado obtido é uma imagem menor e mais otimizada, sabendo que é feito a separação do ambiente de build para o de tempo de execução.

### Dockerfile
```
FROM golang:1.22.3-alpine3.18 AS builder

WORKDIR /app

COPY . .

RUN go build hello.go

CMD [ "./hello" ]
```

### Dockerfile.prod
```
FROM golang:1.22.3-alpine3.18 AS builder

WORKDIR /app

COPY . .

RUN go build hello.go

FROM scratch

WORKDIR /app

COPY --from=builder /app /app

CMD [ "./hello" ]
```

## Comparação entre o tamanho final das imagens
| Imagem                  | Tamanho (MB) |
| ----------------------- | ------------ |
| hello-go                | 259MB        |
| ruancrysthian/fullcycle | 1.92MB       |

## Build
```
docker build -t ruancrysthian/fullcycle . -f Dockerfile.prod
```

## Run
```
docker run ruancrysthian/fullcycle
```

## Docker Hub
https://hub.docker.com/repository/docker/ruancrysthian/fullcycle/general 