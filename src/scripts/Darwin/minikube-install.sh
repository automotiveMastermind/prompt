#!/usr/bin/env bash

if [ ! -z "${PROMPT_DEBUG:-}" ]; then
    echo 'minikube-install'
fi

minikube-install() {
    echo "Installing docker-machine-driver-xhyve..."
    brew update
    brew install docker-machine-driver-xhyve

    echo "Setting ownership of docker-machine-driver-xhyve: you will be prompted for your password..."
    chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

    echo "Installing minikube..."
    brew install Caskroom/cask/minikube

    echo "Configuring minikube to use xhyve..."
    minikube config set vm-driver xhvye

    if [ ! -f /usr/local/bin/kubectl ]; then
        echo "Downloading kubectl..."
        curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.5.3/bin/darwin/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/
    fi
}