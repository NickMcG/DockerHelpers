# Phoenix Setup

This set of scripts is for bootstrapping Phoenix without having Elixir installed on your machine.

## 1) Build the docker image

In the directory that you cloned this to, run the following docker command: `docker build -t phoenix-setup:local .`.
This will create the docker image and tag it as `phoenix-setup:local`

### Build-time arguments

There are 2 build-time arguments: EXVERS and PHXVERS. These determine the version of Elixir and Phoenix that will be used, respectively.
The dockerfile has defaults for these 2 arguments, so you don't need to specify them. But, if you want, you can override them without
modifying the dockerfile, you can use the `--build-arg` flag. For example, `docker build --build-arg EXVERS=1.9 -t phoenix-setup:local .`
would use the elixir:1.9 docker image as the base image.

## 2) Run the docker image

There are 2 options here:
1. In whatever directory you want to create the Phoenix directory, you can drop the `phoenix-setup.ps1` file and run it with a parameter for the
project name (for example, `.\phoenix-setup.ps1 example_project` will create a Phoenix project in the directory with a name of example_project).
2. You can run the following command `docker run --rm -e PHXNAME=$name $directory:/var/output phoenix-setup:local` where 
$name is the name of you want to use for the Phoenix project and $directory is the path you want the folder to be created.

In both cases, there are optional run-time arguments, which will be discussed below.

### Run-time arguments

For possible flags, take a look at: [https://hexdocs.pm/phx_new/Mix.Tasks.Phx.New.html#module-examples](Hex documentation for phx.new).
Those are the possible flags that `mix phx.new` allows for, which are what you can specify to either the docker image or the PowerShell script.

For the docker image, you pass them as environment variables to the image. The ADD_ARGS environment variable is how you would pass them along. For example,
if you didn't want webpack (`--no-webpack`) or ecto (`--no-ecto`), you could run this docker command:
`docker run --rm -e PHXNAME=try_again -e ADD_ARGS="--no-webpack --no-ecto" -v $directory:/var/output phoenix-setup:local`

In other words, just you build up the list of additional flags, and specify them as `-e ADD_ARGS="{flags}"`.

For the powershell script, it works a little differently. The way it works is that any parameter added to the script gets concatenated
together to make the ADD_ARGS. For example, if you ran `.\phoenix-setup.ps1 --no-webpack --no-ecto`, then it would generate Phoenix without
webpack or ecto.