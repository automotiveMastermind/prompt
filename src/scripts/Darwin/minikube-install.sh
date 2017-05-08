#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'minikube-install'
fi

minikube-install() {
    echo "Installing minikube..."
    brew update
    brew install docker-machine-driver-xhyve kubernetes-cli Caskroom/cask/minikube

    echo "Setting ownership of docker-machine-driver-xhyve: you will be prompted for your password..."
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

    echo "Configuring minikube to use xhyve..."
    minikube config set vm-driver xhyve

    echo "Starting minikube..."
    minikube start --insecure-registry localhost:5000

    echo "Using docker environment from minikube..."
    eval $(minikube docker-env)

    echo "Install the docker registry into kubernetes..."
    kubectl apply -f local/kube-registry.yml
}