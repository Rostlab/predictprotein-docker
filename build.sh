#!/bin/sh

# 20221011 TAK
# This script downloads the necessary files for building the predictprotein Docker image
# since the packages result in the git repository being too large for free plans on 
# various well-known public repositories such as GitHub, Bitbucket and Gitlab

# Default values
VERSION="1.2.0"
NAME_PACKAGE="package_${VERSION}.tar.gz"
URL_PACKAGE="https://rostlab.org/public/predictprotein-docker/package/${NAME_PACKAGE}"

# Override defaults in this file
. $(pwd)/.envvars

# Check if necessary package directory exists
if [ ! -d package/system ]; then
  echo "Necessary system build packages not found."
  # Directory package/system doesn't exist, see if the package archive exists;
  # If not, attempt to download it.
  if [ ! -f ${NAME_PACKAGE} ]; then
    echo "Attempting to download and extract packages archive '${NAME_PACKAGE}'..."
    if command -v wget &> /dev/null; then
      wget -c ${URL_PACKAGE} -O - | tar -xz
      echo "Done."
    elif command -v curl &> /dev/null; then
      curl ${URL_PACKAGE} | tar -xz
      echo "Done."
    else
      echo "Error!"
      echo "Unable to download necessary package files for Dockerfile build. You need to install either 'wget' or 'curl'."
      echo "Alternatively, you can manually download the necssary file to the currentl directory from: ${URL_PACKAGE}"
      exit 1
    fi
  else
    # Here if the package/system directory doesn't exist, but the package archive does.
    # Possible if archive is manually downloaded, for example
    echo -n "Extracting ${NAME_PACKAGE}..."
    tar -xzf ${NAME_PACKAGE}
    echo "Done."
    # Do not keep the package archive; otherwise, it will end up in our build context adding unecessary size.
    echo -n "Removing ${NAME_PACKAGE}..."
    rm ${NAME_PACKAGE}
    echo "Done."
  fi
fi

# We're here if the package/system directory exists
# Make sure package archive is removed
if [ -f ${NAME_PACKAGE} ]; then
  rm ${NAME_PACKAGE}
fi
if command -v docker &> /dev/null; then
  echo "Attempting to build docker image, predictprotein-docker:${VERSION} from Dockerfile."
  docker build -t predictprotein .
  if [ $? -eq 0 ]; then
    echo "Finished! You may now use the 'docker run' command to start a Docker container."
    echo "Please refer to the predictprotein-docker README.md and docker-run documentation for usage information."
  else
    echo "There was an error building the Docker image! If you can't resolve the problem on your own, please"
    echo "contact us, providing abdequate information in order to assist you, at help@predictprotein.org"
    exit 1
  fi
fi

exit 0
