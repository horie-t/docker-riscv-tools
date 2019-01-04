# docker-riscv-tools

[riscv-tools](https://github.com/riscv/riscv-tools) のUbuntuのDocker イメージファイル作成用リポジトリです。

## Docker imageの使い方

### 前提条件

* Dockerをインストールしている事  
Dockerのインストール方法については、 [こちら](http://docs.docker.jp/engine/installation/#docker)などを参照。
* 1.3GB程度の空き領域がある事(riscv-toolsのソース・コードを見たい場合は、9GB程度必要)

### コンテナの実行

[Linuxの場合]

```bash
# ソースコードなしの場合
$ sudo docker run -it --name riscv-tools horie135/riscv-tools-no-src:19.01
# ソースコードありの場合。ソースコードは、 /opt/riscv/riscv-tools にあります。
$ sudo docker run -it --name riscv-tools horie135/riscv-tools:19.01
```

コンテナ実行後に、「Hello World!」をコンパイル、実行するには以下のようにします。

```
root@64cec9c90ac5:~# cat <<END > hello.c
> #include <stdio.h>
> int main(void)
> { 
>   printf("Hello world!\n");
>   return 0;
> }
> END
root@64cec9c90ac5:~# riscv64-unknown-elf-gcc -o hello hello.c && spike pk hello
Hello world!
```

コンテナを終了するには、exitを実行します。

```bash
root@64cec9c90ac5:~# exit
```

コンテナを再開するには、`start` を実行します。
```bash
sudo docker start -i riscv-tools
```

### ホストマシンとのファイルの共有

上記の方法では、ホストマシンとファイルを共有できないので不便です。ファイルを共有するには、 `-v` オプションを追加します。
ホスト側のディレクトリ(ここでは /home/horie-t/risc-v_work )は予め作成しておく必要があります。

```
sudo docker run -it --name riscv-tools -v /home/horie-t/risc-v_work:/root/risc-v_work riscv-tools-no-src:19.04
```

その他のDockerの使い方は、Dockerのドキュメントを参照ください。

## Docker Imageの作成方法

以下のコマンドを実行し、Dockerイメージを作成します。

```bash
$ git clone https://github.com/horie-t/docker-riscv-tools.git
$ cd docker-riscv-tools
$ sudo docker build -t riscv-tools:latest ./
```

