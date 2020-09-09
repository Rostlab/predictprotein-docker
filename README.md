[[_TOC_]]

# predictprotein Docker
---

The Docker image this creates is the exact version that runs on our cluster at [Rostlab](https://rostlab.org/) and the official [PredictProtein website](https://open.predictprotein.org/) hosted at the [Luxembourg Centre for Systems Biomedicine](https://wwwfr.uni.lu/lcsb) by [ELIXIR-LU](https://elixir-luxembourg.org/), the Luxembourgish node of ELIXIR, the European infrastructure for life science information.

In an effort to preserve the current (as of 2020-09-08) version of predictprotein, including all of the methods it uses, this Dockerfile and its supporting packages, configuration files, and scripts, have been created, which will allow predictprotein to be able to be run from any current and (hopefully) future Docker-supported operating system.

The produced Docker image will also include the suite of `pp-cache-mgr` utilities, which store, fetch, and manage predictprotein results which are stored in a hashed-indexed cache.
These utilities include:
* `ppc_configtest` - PredictProtein cache config file sanity check
* `ppc_fetch`      - fetch results from PredictProtein cache
* `ppc_hash`       - print PredictProtein result hash
* `ppc_lock`       - lock a cache slot
* `ppc_store`      - store results into PredictProtein cache

Although only the packages and data models necessary for its proper functioning have been installed, the produced Docker image will be larger than 10GB (!) in size, which doesn't include the necessary databases needed.

## Requirements

Other than being able to run a Docker image, it is absolutely necessary that you have the [PredictProtein Database](http://www.rostlab.org/services/ppmi/download_file?format=gzip&file_to_download=db) downloaded.

To download this database manually or using a terminal/CLI:

`wget -O rostlab-data.txz "http://www.rostlab.org/services/ppmi/download_file?format=gzip&file_to_download=db"`

*These files are automatically generated near the end of each month.*

Don't do anything with the file just yet - futher instructions are below.

## Building the Docker Image 

After you've cloned this repository, you should be able to in to its directory, and run:

```shell
$ export DOCKER_BUILDKIT=1
$ docker build -t predictprotein .
```

See [Build images with BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/) for more information about Docker BuildKit.

**This will take a long time** - Go grab a coffee, a snack, a walk in the park, or repair a hole in a sock (or two).

## Docker Host File Access

### Background information
By default, the Docker image is configured to have access to certain directories, all of which exist inside the image. These locations may be modified by adjusting the default configuration files.

However, in order for predictprotein to properly run, and for you to have access to your results, the running Docker container will need **at least** access to:

* the PredictProtein database downloaded earlier
* storage for computed results, which predictprotein will produce

This requires using [Docker bind mounts](https://docs.docker.com/storage/bind-mounts/) that bind-mount a directory from the Docker host to the Docker predictprotein container, which is configured on the command line, when running a container for the first time.

### Create Docker host data and configuration file directories for predictprotein

Here we'll use `/var/tmp/pp-data/` as our base directory for our bind mounts to the predictprotein Docker container. Adjust accordingly for your installation.

```shell
$ mkdir -p /var/tmp/pp-data/configs
$ mkdir -p /var/tmp/pp-data/ppcache/{ppcache-data,results-retrieve,rost_db,sequence-submit}
```

When bind-mounted using the `docker run` command as later documented, the following directories on the Docker host will contain the following data, which will remain even after an erased or shutdown container:

* `/var/tmp/pp-data/configs`                  - *(optional)* configuration files affecting how predictprotein runs inside of the container. Necessary if you plan on using MySQL result storage
* `/var/tmp/pp-data/ppcache/ppcache-data`     - **(required)** predictprotein cache (ppcache) where computed results are stored, indexed by computed hash.
* `/var/tmp/pp-data/ppcache/results-retrieve` - *(optional)* may be used, when bind mountd, to retrieve a result set from the cache (see ppc_fetch)
* `/var/tmp/pp-data/ppcache/rost_db`          - **(required)** rost_db (internal to Rostlab) or PPMI databases
* `/var/tmp/pp-data/ppcache/sequence-submit`  - *(optional)* may be used, when bind mounted, to submit sequences using a file

## PredictProtein Database Installation

The PredictProtein Database provided by [Rostlab](https://rostlab.org) is a monthly compilation, of which some are run through [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi), of various publicly available protein databases:
* [Swiss-Prot](https://www.uniprot.org/)
* [TrEMBL](https://www.uniprot.org/)
* [PDB](https://www.rcsb.org/)
* [UniRef50](https://www.uniprot.org/help/uniref)

You should have already downloaded the file `rostlab-data.txz`. If not see [Requirements](#requirements).

```shell
$ mv rostlab-data.txz /var/tmp/pp-data/ppcache/rost_db
$ cd /var/tmp/pp-data/ppcache/rost_db
$ xz -d rostlab-data.txz
$ tar xvf rostlab-data.tar
$ rm -f rostlab-data.tar
```

## Running predictprotein... (Examples Please!)

The following are some examples to help you get an idea of how predictprotein work in its Docker-ized form.

### To get help about the command
By default, running the Docker container will produce the help information for the predictprotein command, just like running `predictprotein --help`:

```shell
$ docker run --rm predictprotein
```

**Note:** specifying the option `--rm` will automatically remove the container when it exits. The default is false. In this example, it's used just because we're calling the help information.

### Using a protein sequence entered on the command line, running all available methods, overwriting any pre-existing cached results

```shell
$ docker run \
  --mount type=bind,source=/opt/docker/Development/pp_mounts/ppcache,target=/mnt/ppcache \
  predictprotein \
  predictprotein \
  --sequence MFRTKRSALVRRLWRSRAPGGNSR \
  --force-cache-store \
  --target all \
  --target optional
```

Here, there are several extra options being used, which are described in detail viewing the predictprotein help:
* `--sequence` - the protein sequence to be submitted to predictprotein
* `--target all` and `--target optional` - specifies which methods should be run, in this case "all" standard, as well as optional methods; thus, all methods predictprotein has to offer
* `--force-cache-store` - predictprotein does not fetch anything from the cache but does store the results, completely replacing what was cached.

In this example, the computed results for this sequence, would be stored in the cache on the Docker host at the bind-mount location:

```shell
/opt/docker/Development/pp_mounts/ppcache/ppcache-data/9f/1f/9f1f3a0595e02af5594bcc34b4cff8ec065fbc8f
```

Items to note:
* The bind mount-point may be changed by changing the Docker host path in the `--mount` option of the `docker run` command
* The predictprotein cache location in the container may be changed by defining a different path in the `ppcacherc` configuration, after bind-mounting the configuration directory
* The predictprotein cache management will translate a submitted sequence in to a 40-character hash, which is used for storing and referencing the protein on the cache-root of the file system, in the format: \
`(hash chars 1 & 2)/(hash chars 3 & 4)/(hash chars 1-40)` \
Within this directory, you'll find all of the results produced by the each of the methods that predictprotein uses, with the filenames in the format: \
`query.<method>[<.sub-method>]`

... More to come!
