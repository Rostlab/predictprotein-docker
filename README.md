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

Although only the packages and data models necessary for its proper functioning have been installed, the produced Docker image will be larger than 12GB (!) in size, which doesn't include the necessary databases needed.

## The Produced Docker Image License Is Now AFL-3.0

**By using this sofware, you agree and are bound to the terms in the [Academic Free License ("AFL") v. 3.0](https://opensource.org/licenses/AFL-3.0).**

## Requirements

Other than being able to run a Docker image, it is absolutely necessary that you have the [PredictProtein Database](http://www.rostlab.org/services/ppmi/download_file?format=gzip&file_to_download=db) downloaded.

To download this database manually or using a terminal/CLI:

`wget -O rostlab-data.txz "http://www.rostlab.org/services/ppmi/download_file?format=gzip&file_to_download=db"`

*These files are automatically generated near the end of each month.*

Don't do anything with the file just yet - [futher instructions are below](#predictprotein-database-installation).

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
$ mkdir -p /var/tmp/pp-data/config
$ mkdir -p /var/tmp/pp-data/ppcache/{ppcache-data,results-retrieve,rost_db,sequence-submit}
```

When bind-mounted using the `docker run` command as later documented, the following directories on the Docker host will contain the following data, which will remain even after an erased or shutdown container:

* `/var/tmp/pp-data/config`                   - *(optional)* configuration files affecting how predictprotein runs inside of the container. Necessary if you plan on using [MySQL result storage](#additional-result-data-using-an-external-mysql-instance)
* `/var/tmp/pp-data/method-data/loctree3      - *(optional)* data files used for loctree3 algorithm. Including this directory will override the already-included loctree3 data files.
* `/var/tmp/pp-data/method-data/metastudent   - *(optional)* data files used for metastudent algorithm. Including this directory will override the already-included metastudent data files.
* `/var/tmp/pp-data/ppcache/ppcache-data`     - **(required)** predictprotein cache (ppcache) where computed results are stored, indexed by computed hash
* `/var/tmp/pp-data/ppcache/results-retrieve` - *(optional)* may be used, when bind mountd, to retrieve a result set from the cache (see ppc_fetch)
* `/var/tmp/pp-data/ppcache/rost_db`          - **(required)** rost_db (internal to Rostlab) or PPMI databases
* `/var/tmp/pp-data/ppcache/sequence-submit`  - *(optional)* may be used, when bind mounted, to submit sequences using a file

*Note*: any sub-directories that you create on the Docker host under `/var/tmp/pp-data/ppcache/`, will *hide* existing directories in the Docker container when `/var/tmp/pp-data/ppcache` on the Docker host is bind-mounted to the Docker container on `/mnt/ppcache`.

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
$ tar -Jxvf rostlab-data.txz
$ rm -f rostlab-data.txz
```
## LocTree3 and MetaStudent Data Files

Included in the Dockerfile are commands to download and install LocTree3 and MetaStudent data files in to the resulting Docker image, that are necessary for these methods to run. They have been included to ease the requirements, configuration, and installation for the end-user (you).

### LocTree3

LocTree3 uses a script that is contained within its package, to download and install its necessary data files, called from the Dockerfile. It installs these data files in the directory `/usr/share/loctree2-data` in the image.

If you would like to inspect, change, or update these data files, and have [created the Docker host data and configuration file directories](#create-docker-host-data-and-configuration-file-directories-for-predictprotein), as documented above, you could bind-mount `/var/tmp/pp-data/method-data/loctree3` to `/usr/share/loctree2-data`.

### MetaStudent

MetaStudent is downloaded, extracted, compiled, and installed using commands from within the Dockerfile to `/usr/share/metastudent-data` in the image, since there is no included script within its package.

MetaStudent data may be downloaded from [ftp://rostlab.org/metastudent](ftp://rostlab.org/metastudent). If you would like to inspect, change, or update these data files, and have [created the Docker host data and configuration file directories](#create-docker-host-data-and-configuration-file-directories-for-predictprotein), as documented above, you could bind-mount `/var/tmp/pp-data/method-data/metastudent` to `/usr/share/metastudent-data`.

If you like to use a different version than what is used in this Dockerfile. You may refer to the Dockerfile for the commands used to accomplish a change of Metastudent data files; however, at this time, there are no planned updates for MetaStudent data files. 

## The predictprotein Cache

By default, the Docker container is configured to utilize the predictprotein caching manager to store results, just like on Rostlab servers and for the predictprotein.org website.

The predictprotein cache management will translate a submitted sequence in to a 40-character hash, which is used for storing and referencing the protein on the cache-root of the file system, in the format:
```
(hash chars 1 & 2)/(hash chars 3 & 4)/(hash chars 1-40)/<result files>
```

Within this directory, you'll find all of the results (`<result files>`) produced by the each of the methods that predictprotein uses, with the filenames in the format:
```
query.<method>[<.sub-method>]
```

The predictprotein cache location in the container may be changed by defining a different path in the `ppcacherc` configuration, after bind-mounting the configuration directory.

## Running predictprotein... (Examples Please!)

The following are some examples to help you get an idea of how predictprotein work in its Docker-ized form, using the directory tree as described in [Create Docker host data and configuration file directories for predictprotein](#create-docker-host-data-and-configuration-file-directories-for-predictprotein)

### To get help about the command
By default, running the Docker container will produce the help information for the predictprotein command, just like running `predictprotein --help`:

```shell
$ docker run --rm predictprotein
```

**Note:** specifying the option `--rm` will automatically remove the container when it exits. The default is false. In this example, it's used just because we're calling the help information.

### Submitting a protein sequence entered on the command line, running all available methods, overwriting any pre-existing cached results

```shell
$ docker run \
  --mount type=bind,source=/var/tmp/pp-data/ppcache,target=/mnt/ppcache \
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
/var/tmp/pp-data/ppcache/ppcache-data/9f/1f/9f1f3a0595e02af5594bcc34b4cff8ec065fbc8f
```

Items to note:
* The bind mount-point may be changed by changing the Docker host path in the `--mount` option of the `docker run` command
* Refer to [The predictprotein cache](#the-predictprotein-cache) regarding file and path naming conventions and configuration possibilities

### Submitting a file containing a protein sequence or fasta-formatted data, running all available methods, overwriting any pre-existing cached results

```shell
$ docker run \
  --mount type=bind,source=/var/tmp/pp-data/ppcache,target=/mnt/ppcache \
  predictprotein \
  predictprotein \
  --seqfile /mnt/ppcache/sequence-submit/my_sequence.fasta \
  --force-cache-store \
  --target all \
  --target optional
```
Items to note:
* The option `--seqfile` allows you to specify a FASTA amino acid sequence file; if `-` is given, standard input is read; however, you must **make sure** to use the `-it` option of the `docker run` command (for an interactive terminal) 
* The path used in `--seqfile` is the location **inside of the Docker container**, not the Docker host. On the Docker host, in this example, the location you'd put the file would be `/var/tmp/pp-data/ppcache/sequence-submit`

### Did you know - how predictprotein is run on predictprotein.org

Before this Docker image is introduced, I (@karl), thought it would be a good idea to let those who would like to use this Dockerized version of predictprotein know, what options we at [predictprotein.org](https://predictprotein.org), use to generate result files.

Here's our "super secret recipe" for generating results:

```shell
  predictprotein \
        --bigblastdb     /mnt/ppcache/rost_db/data/big/big \
        --big80blastdb   /mnt/ppcache/rost_db/data/big/big_80 \
        --swissblastdb   /mnt/ppcache/rost_db/data/swissprot/uniprot_sprot \
        --pfam2db        /mnt/ppcache/rost_db/data/pfam_legacy/Pfam_ls \
        --pfam3db        /mnt/ppcache/rost_db/data/pfam/Pfam-A.hmm \
        --prositedat     /mnt/ppcache/rost_db/data/prosite/prosite.dat \
        --prositeconvdat /mnt/ppcache/rost_db/data/prosite/prosite_convert.dat \
        --spkeyidx       /mnt/ppcache/rost_db/data/swissprot/keyindex_loctree.txt \
        --sequence <USER-ENTERED SEQUENCE> \
        --force-cache-store \
        --target all \
        --target optional 
 ```

So, now you can run it just like we do, and reproduce the same results as [predictprotein.org](https://predictprotein.org)!

## Changing Default Configuration Files

By default, the Docker container will look in `/etc/docker-predictprotein` (inside its container), for the configuration files needed to run.

**Note**: every time the Docker container is run, a check is done to make sure all of the necessary configuration files exist in their expected location within the container, `/etc/docker-predictprotein`. Missing configuration files are automatically created, copied from the Docker container directory `/var/tmp/config/` to `/etc/docker-predictprotein`

If you would like to access the configuration files, or to enable [MySQL services](#additional-result-data-using-an-external-mysql-instance), you'll need to bind-mount from your Docker host, to the Docker container at `/etc/docker-predictprotein`:

```shell
$ docker run \
  --mount type=bind,source=/var/tmp/pp-data/ppcache,target=/mnt/ppcache \
  --mount type=bind,source=/var/tmp/pp-data/config,target=/etc/docker-predictprotein \
  predictprotein \
  predictprotein \
  --sequence MFRTKRSALVRRLWRSRAPGGNSR \
  --force-cache-store \
  --target all \
  --target optional
```

In this example, the `/var/tmp/pp-data/config` directory is bind-mounted to `/etc/docker-predictprotein` in the Docker container. The directory on the Docker host will hide the mountpoint on the Docker container while the bind-mount is active. Therefore, if `/var/tmp/pp-data/config` is empty or is missing any necessary configuration files, and the previous example is run, the Docker container will first copy all of the default configuration files to that location, before running the predictprotein command, or any command sent to the container.

With this in mind, if you edit any of the configuration files, their state will be maintained regardless if the container is stopped or erased. Multiple running container instances of the Docker image may also bind-mount to this directory to use the same configuration.

Lastly, if you then decide not to bind-mount the configuration directory to the Docker host, the configuration files in the container will not be hidden by the bind-mount, and therefore be used.

### Initializing or resetting configuration files to their defaults

In the case that you would like to reset all configuration files to the defaults contained within the Docker image, no matter what configuration files already exist, you may execute the following Docker run command:

```shell
$ docker run --rm -it predictprotein init
```

**Note**: you'll need to use the `-it` option, since the command will ask you to confirm overwriting any existing configuration files you may have.

## Additional Result Data Using an External MySQL Instance

In addition to the result files stored in the [predictprotein cache](#the-predictprotein-cache), predictprotein also can store additional result data in various tables within an external MySQL instance. This was not included within the Docker image in order to keep size and resource usage down to a minimum, while allowing the user the possiblity of tuning their MySQL server to their liking.

### Adjusting predictprotein configuration files

You can enable the MySQL services predictprotein offers, by [changing values in two of the default configuration files](#changing-default-configuration-files), namely:

* `ppcache-my.cnf` - MySQL connection information, following the same syntax as a user-defined my.cnf file
* `ppcacherc` - the predictprotein cache configuration file

In `ppcache-my.cnf`, you must enter the details necessary to connect to your MySQL instance.

In `ppcacherc`, all you have to do is *uncomment* one line (i.e.. don't change the path or filename):
```
# mysql_read_default_file=/etc/ppcache/my.cnf
```

**Note**: when the `mysql_read_default_file` setting is not defined, no MySQL connections are attempted by predictprotein. If it's defined, near the end of the predictprotein run, it will attempt to connect to the MySQL instance defined in the `ppcache-my.cnf` file on the Docker host, writing additional result data to the database tables.

### Creating a dedicated MySQL user and database

Once you're logged in to your MySQL instance, you'll need to create a database named `ppres`, and the host, username, and password chosen should be entered in to the `ppcache-my.cnf` file.

```shell
# mysql

mysql> CREATE DATABASE ppres;
mysql> GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, 
       EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE ON `ppres`.* TO '<PPCACHEUSER>'@'<CLIENTIP>' 
       IDENTIFIED BY '<PPCACHEPASS>';  
```

### Creating MySQL database tables

In order to successfully write data to the database, the proper MySQL database table structure needs to be set up. Assuming you're using the directory tree as described in [Create Docker host data and configuration file directories for predictprotein](#create-docker-host-data-and-configuration-file-directories-for-predictprotein), and have at least [run the container one time](#changing-default-configuration-files) or [initialized the configuration files](#initializing-or-resetting-configuration-files-to-their-defaults), the following command will create all of the necessary MySQL tables:

```shell
# mysql -u root -p ppres < /var/tmp/pp-data/config/ppres_tables_mysql.sql
```
Now, as long as the `mysql_read_default_file` setting in `ppcacherc` is uncommented, additional predictprotein result data will be created in the `ppres` database of the configured MySQL instance.

## License

This project is licensed under our [Academic Software License Agreement](https://rostlab.org/owiki/index.php/Academic_Software_License_Agreement).

## Citation

Please refer to [https://www.predictprotein.org/](https://www.predictprotein.org/).
