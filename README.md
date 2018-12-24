# docker-riscv-tools

[riscv-tools](https://github.com/riscv/riscv-tools) のUbuntuのDocker イメージファイル作成用リポジトリ

## 前提条件

* Dockerをインストールしている事
* 10GB程度の空き領域がある事

## 使い方

以下のコマンドを実行し、Dockerイメージを作成します。

```bash
$ git clone https://github.com/horie-t/docker-riscv-tools.git
$ cd docker-riscv-tools
$ sudo docker build -t riscv-tools:latest ./
```

イメージ作成後に、コンテナを実行します。

```bash
$ sudo docker run -it --name risc-v-dev riscv-tools:latest 
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
sudo docker start -i risc-v-dev
```

上記の方法では、ホストマシンとファイルを共有できないので不便です。ファイルを共有するには、 `-v` オプションを追加します。
ホスト側のディレクトリ(ここでは /home/horie-t/risc-v_work )は予め作成しておく必要があります。

```
sudo docker run -it --name risc-v-dev -v /home/horie-t/risc-v_work:/root/risc-v_work riscv-tools:latest
```

その他のDockerの使い方は、Dockerのドキュメントを参照ください。

## DockerHub

DockerHubで、Dockerイメージを公開しないのは、ライセンス表記が面倒だからです。 (^_^);
